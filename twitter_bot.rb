#!/usr/bin/ruby1.8

require 'rubygems'
require 'twitter'

#Parametros da API do Twitter
CONSUMERKEY=""
CONSUMERSECRET=""
OAUTHTOKEN=""
OAUTHTOKENSECRET=""

#Debug
f = File.open("/tmp/twitter.log","w")

#Listagem de usuários que o programa vai acompanhar
users = ["emanuelestrada", "dianaada", "dmtcllr", "edergoncalves","werhli","jtyska","vinicius_ah"]

#Padrão que o programa irá procurar nos últimos status dos usuários acima
pattern = /\#c3furg/

#Procura por um padrão no último status de um usuário e se encontrar, dá um retweet
def search_and_retwitt(user,pattern,connection,file)

  status = Twitter.user(user).status

#Debug
  file.puts user
  file.puts status.text

  if status.text =~ pattern
#Debug
    file.puts "Retweet: yes"
    connection.retweet(status.id)
  end
  
end

#Configura a conexão
Twitter.configure do |config|
  config.consumer_key = CONSUMERKEY
  config.consumer_secret = CONSUMERSECRET
  config.oauth_token = OAUTHTOKEN
  config.oauth_token_secret = OAUTHTOKENSECRET
end

#Cria a conexão
connection = Twitter::Client.new

#Percorre a listagem de usuários
users.each do |user|
  search_and_retwitt(user,pattern,connection,f)
end

#Debug
f.close
