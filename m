Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbVJEQHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbVJEQHG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbVJEQHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:07:06 -0400
Received: from web34407.mail.mud.yahoo.com ([66.163.178.156]:49747 "HELO
	web34407.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030201AbVJEQHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:07:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=nh+Lsf5VxufTWYmMrTOTY+M0+Vjqny3+F62ozxUx98aHleSHys/bu34HryWerg5QcQJf4Rq4c3CeMKkttNWGHeCNdvVRULCYfNF3TdyRJ4ssi+yjQE6xub9X+cdIlAH9eQFdP4uccpKgjPoLrv2dPslO4OXsiAI3XDA6tHGnRhw=  ;
Message-ID: <20051005160700.76629.qmail@web34407.mail.mud.yahoo.com>
Date: Wed, 5 Oct 2005 09:07:00 -0700 (PDT)
From: "R. Mayo" <rmayo100@yahoo.com>
Subject: IPv6 TCP server error, kernel version 2.6.11
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am attempting to write a simple TCP client-server
application that writes Traffic Class data into the
IPv6 header on the client side, and reads that data on
the server side.

My client side software works (the data is present in
the packets according to Ethereal), but on the server
side I'm getting a Kernel Panic.

This is basically the server code I'm using to read
the port (with error trapping removed):

s = socket (AF_INET6, SOCK_STREAM, 0);
bind (s, (struct sockaddr *)&srv_addr,
     sizeof(struct sockaddr_in6));
listen (s, 10);
setsockopt (s, IPPROTO_IPV6, IPV6_FLOWINFO,
     (void *)&on, sizeof(on));
acc_sock = accept (s, (struct sockaddr *)&cli_addr,
     (unsigned int *)&cli_addr_size);
printf ("Received Flowinfo = %032x\n",
     cli_addr.sin6_flowinfo);
size = recv (acc_sock, data, 100, 0);
close (acc_sock);
close (s);

When the code gets to the line that prints out the
received Traffic Class, the kernel panic occurs.  I
don't know if the problem lies in the OS (I'm using
kernel ver. 2.6.11, untainted) or if the steps in my
code are out of order, but I do know no crash occurs
if the setsockopt command is not present (Naturally, I
can't read the Traffic Class data in this case,
though.)

I'm not a Linux software development pro, so I don't
know how to capture the screen dump, but if that is
needed and someone can send me directions, I'll be
happy to comply.

Any suggestions,
Rich Mayo


		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
