Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270348AbSISIDz>; Thu, 19 Sep 2002 04:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270373AbSISIDy>; Thu, 19 Sep 2002 04:03:54 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:19402 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S270348AbSISICZ>; Thu, 19 Sep 2002 04:02:25 -0400
Message-ID: <20020919080602.2986.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Thu, 19 Sep 2002 16:06:02 +0800
Subject: [chatroom benchmark version 1.0.1] Results
X-Originating-Ip: 194.185.48.246
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
yesterday I played a bit with the chatroom benchmark.
I don't want to discuss about number (you are the right people to do that, not me).

--- What is the chat bench ---
Usage: chat_c ip_addr [num_rooms] [num_messages] [server_port]

       ip_addr:		server ip address that the client connects to.
       [num_rooms]:	the number of chat rooms.
			default is 10.
       [num_messages]:	the number of messages sent by each chat room member.
			default is 100.	
       [port]:		server port number the client connects to.
			default is 9999.

This benchmark includes both a client and server.  The benchmark is
modeled after a chat room.  This benchmark will create a lot of threads,
tcp connections, and send and receive a lot of messages.  The client side
of the benchmark will report the number of messages sent per second.

The number of chat rooms and messages will control the workload.
The default number of chat rooms is 10.
The default number of messages is 100.  The size of each message is 100 bytes.
Both of these parameters are specified on the client side.

(1) Each chat room has 20 users.
(2) 10 chat rooms represents 20*10 or 200 users.
(3) For each user in the chat room, the client will make a connection
    to the server.
(4) 10 chat rooms will create 10*20 or 200 connections between the client
    and server.
(5) For each user (or connection) in the chat room, 1 'send' thread is created
    and 1 'receive' thread is created.
(6) 10 chat rooms will create 10*20*2 or 400 client threads and 400 server
    threads for a total of 800 threads.
(7) Each client 'send' thread will send the specified number of messages
    to the server.
(8) For 10 chat rooms and 100 messages, the client will send 10*20*100 or
    20,000 messages.  The server 'receive' thread will receive the
    corresponding number of messages.
(9) The chat room server will echo each of the messages back to the other
    users in the chat room.
(10) For 10 chat rooms and 100 messages, the server 'send' thread will send
     10*20*100*19 or 380,000 messages.  The client 'receive' thread will
     receive the corresponding number of messages.
(11) The client will report the message throughput at the end of the test.
(12) The server loops and accepts another start message from the client.

What I did:
Boot in single mode with apm off
./chat_s 127.0.0.1 &
./chat_c 127.0.0.1 30 1000 9999

And now the results:
2.4.19-ck7.results:Average throughput : 55928 messages per second
2.4.19.results:Average throughput : 44851 messages per second
2.5.33.results:Average throughput : 59522 messages per second
2.5.34.results:Average throughput : 62941 messages per second
2.5.36.results:Average throughput : 60858 messages per second

2.4.19-ck7 is preemption ON
2.5.33 and 2.5.34 are preemption ON
2.5.36 is preemption OFF (Robert, 2.5.36 with preemption ON oops at boot)

Ciao,
            Paolo


-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
