Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317006AbSGCUSM>; Wed, 3 Jul 2002 16:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317059AbSGCUSL>; Wed, 3 Jul 2002 16:18:11 -0400
Received: from mail.cafes.net ([207.65.182.3]:28651 "EHLO mail.cafes.net")
	by vger.kernel.org with ESMTP id <S317006AbSGCUSK>;
	Wed, 3 Jul 2002 16:18:10 -0400
To: linux-kernel@vger.kernel.org
From: gphat@cafes.net
Subject: Large numbers of TCP resets
Date: Wed, 3 Jul 2002 20:15:53 GMT
X-Originating-IP: 67.105.23.117
Message-Id: <20020703201553.DE9FD68CB5EA@mail.cafes.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, the web-app at the company I work for started having problems load 
balancing.  This was traced back to a large number of tcp-resets being sent 
from the web servers to the clients.

Here's netstat output for one of the boxen:
    437761 active connections openings
    0 passive connection openings
    21 failed connection attempts
    0 connection resets received
    101 connections established
    140497907 segments received
    149967684 segments send out
    116610 segments retransmited
    111 bad segments received.
    1003306 resets sent

This box is running an apache/tomcat/jboss setup serving both HTTP and RMI 
requests.  The reset packets disrupt the load balancing method, as the load 
balancers think the reset means the connection can now be round-robined to the 
next machine.  This can be masked by using cookie-based balancing, but I am 
worried that we would be masking a problem.

Documentation concerning tuning buffers for network purposes say that 2.4 is 
good at auto-tuning, and that only /proc/sys/net/ipv4/tcp_wmem|tcp_rmem might 
need tweaking.

The kernel is 2.4.9-31smp from RedHat 7.2.  The cards are Intel 82557's.  There 
are two interfaces, with 1 for client access and 1 used for communication with 
the backend database.  (The ->client is the one we are worried about).

Any ideas on why the interfaces would be doing this?  The boxes served 1.6 
hits/sec average over last month for a total of about 10Gb.  Is there some 
tuning that needs to take place?

Thanks in advance.

Cory 'G'
Watson


