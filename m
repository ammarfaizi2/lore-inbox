Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSINNDh>; Sat, 14 Sep 2002 09:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316465AbSINNDh>; Sat, 14 Sep 2002 09:03:37 -0400
Received: from mail.rpi.edu ([128.113.22.40]:12928 "EHLO mail.rpi.edu")
	by vger.kernel.org with ESMTP id <S316342AbSINNDg>;
	Sat, 14 Sep 2002 09:03:36 -0400
Date: Sat, 14 Sep 2002 09:08:14 -0400 (EDT)
From: Hua Qin <qinhua@poisson.ecse.rpi.edu>
To: linux-kernel@vger.kernel.org
Subject: Linux client specweb test  hung
Message-ID: <Pine.GSO.4.10.10209140849340.11409-100000@poisson.ecse.rpi.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I think someone already have this discussion about this hung, but I did
not see some solutions about. Here is my test case:

1 Zeus web server: kernel 2.4.7-10
7 Specweb clients: kernel 2.2.16

After the client hang, I used netstat to see the connections, and found
some clients still keep the ESTABISHED connections, but there is no
connection on the server side.

I use tcpdump to look at how the server and clients to close the
connections. There are scenarios: 
1. The server send FIN first 
2. The client send  FIN first

If the server send  FIN first:
	client			server
	 <-----------FIN---------
	 ----------- ACK-------->
	 ----------- FIN-------->
	<------------ACK--------

If the client send the FIN first:

	client 			server
	--------------FIN-------->
	<-------------ACK--------
	
	or

	client			server
	-------------FIN--------->
	<------------FIN----------
	------------ACK---------->


The following is my guess:
When the iteration finishes everytime, if the FIN happeens to be sent from
the server side, the connection will closed correctly, if the FIN happens
to be sent from the client slide, the client will be hung. Is this
related to LAST-ACK issue?

Thanks!!
Hua

