Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132591AbRDETcL>; Thu, 5 Apr 2001 15:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132593AbRDETcB>; Thu, 5 Apr 2001 15:32:01 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:25572 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S132591AbRDETbp>; Thu, 5 Apr 2001 15:31:45 -0400
Message-ID: <3ACCC648.2849B9EC@coplanar.net>
Date: Thu, 05 Apr 2001 15:23:52 -0400
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Userspace TCP sequence number control?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

If there's a forum more specifically dedicated to 2.4 networking,
please point me in the right direction, otherwise please consider
the following.  (I'm on lkml so you don't need to CC: me)

Is there a way to set the sequence number sent in the SYN
response to an incoming connnection request (an incoming
SYN) to a specific value with listen()?

It may sound like a security risk, but consider the problem
of trying to do http load balancing using 2.4 netfilter,
(ie in kernel, packet/conntrack-based) but trying to maintain session
affinity
to a specific backend server.

Clearly, the load balancer must open a http (and thus TCP)
connection to determine the client that is connecting, in order
to determine which back-end server is already servicing
the user session.   Typically, from this point on, the load balancer
must just copy the data back and forth between the socket
connected to the client and another socket.  This could be
userspace or kernelspace, but it's copying either way.

What if the connection could be handed off via
DNAT *after* it had been established?  The load
balancer could establish a connection with the backend
server, posing as the client, setup an iptable entry
directing the client connection's packets to the
backend server, then close it's connection
(somehow without sending FIN)...

the (big) part missing is that the backend server's
sequence number will differ from the one used
by the load-balancer.  (whereas the load balancer
can just copy the last sequence number recieved
by the client)

Does this functionality exist already?  Or can
iptables re-write the sequence numbers ?
(Cisco's PIX does this to re-randomize them
for hosts inside firewall that have poor random
number generation)

Am I talking crazy talk already?
(I know I should research the tunneling
method more)

Regards,

Jeremy

