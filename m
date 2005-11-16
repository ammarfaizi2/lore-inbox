Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbVKPJCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbVKPJCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 04:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbVKPJCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 04:02:05 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:43714 "HELO cstnet.cn")
	by vger.kernel.org with SMTP id S1030248AbVKPJCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 04:02:01 -0500
X-Originating-IP: [159.226.10.6]
Message-ID: <014a01c5ea8c$44788fc0$060ae29f@javaboy>
From: "jywang" <jywang@cnic.cn>
To: <linux-kernel@vger.kernel.org>
Subject: is there a bug in kernel?
Date: Wed, 16 Nov 2005 17:01:01 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i program a server and a client using tcp.
the client send a string to the server, and the server send the string back
when it received it.
all is ok before i set a srr option in the socket.

the lines i used below:

 char opt[7]={131, 7, 4, 192, 168, 1, 1};
 if(setsockopt(socket_descriptor, SOL_IP, IP_OPTIONS, opt, 7)) printf("error
find in set options!\n");


when this lines are inserted into my program, all packets are ok except the
last packet send back
because i monitor the link using libpcap.

it seems the string back ok, but can't be received by my program. the client
is waiting and waiting and ...

why?

my client program as below:
-------------
 socket_descriptor = socket(AF_INET, SOCK_STREAM, 0)) ;
 char opt[7]={131, 7, 4, 192, 168, 1, 1};
 if(setsockopt(socket_descriptor, SOL_IP, IP_OPTIONS, opt, 7)) printf("error
find in set options!\n");
connect(socket_descriptor, (void *)&pin, sizeof(pin)) == -1);
send(socket_descriptor, str, strlen(str)+1,0) == -1 );
recv(socket_descriptor, buf, 8192, 0) == -1) ;
---------------

my server progarm as below:
--------------
  sock_descriptor = socket(AF_INET, SOCK_STREAM, 0);
  bind(sock_descriptor, (struct sockaddr *)&sin, sizeof(sin)) == -1) ;
  listen(sock_descriptor, 20) == -1) ;
  while(1) {
        temp_sock_descriptor = accept(sock_descriptor, (struct sockaddr
*)&pin, &address_size);
        read(temp_sock_descriptor, buf, 16384, 0) == -1) ;
        printf("\nReceived from client: %s\n", buf);
        write(temp_sock_descriptor, buf, strlen(buf), 0) == -1) ;
    }
--------------







