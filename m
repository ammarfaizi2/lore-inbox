Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <155479-17165>; Wed, 2 Dec 1998 18:19:36 -0500
Received: from cs.huji.ac.il ([132.65.16.10]:2908 "EHLO cs.huji.ac.il" ident: "SOCKWRITE-65") by vger.rutgers.edu with ESMTP id <156009-17165>; Wed, 2 Dec 1998 13:28:55 -0500
Date: Wed, 2 Dec 1998 22:36:45 +0200 (IST)
From: Oren Laadan <orenl@cs.huji.ac.il>
Message-Id: <199812022036.WAA29482@mos220.cs.huji.ac.il>
To: linux-kernel@vger.rutgers.edu, mj@atrey.karlin.mff.cuni.cz
Subject: [BUG] arp replies with BOOTP (nfsroot)
Sender: owner-linux-kernel@vger.rutgers.edu

Hi,

While trying to setup nfsroot with BOOTP protocol, we discovered a 
serious bug with incorrect ARP handling. [ Kernel:  2.1.129 ]

It appears that while the kenerl is waiting for a reply to a BOOTP
request sent earlier, it mishandles ARP requests. In particular,
it replies to every "arp who-has THIS_IP" with "THIS_IP is MY_NIC_ADDR":
that is, publish its own NIC address as matching EVERY local IP.

Effectively, this means it operates as a NIC proxy (well, it doesn't
really do anything but reply to ARP requests...).
As a result, other machines in the network become confused, eventually
leading to serious networking problems.

We suspect the problems is in net/ipv4/ipconfig.c:c_bootp_route_lookup()
(hooked during initialization instead of the default route lookup
function).

Any hints ?

Oren.

__________________________________________________________________________
                         ______   ____   ___  ___  _  __                  \
MOSIX Development Group  )  )  )  )   ) (  '   )   \ /      Oren Laadan    \
 The Hebrew University  /  /  /  /   /   \    /     /   orenl@cs.huji.ac.il \
 of Jerusalem,  Israel (     (  (___(  ___) _(_  __/ \_______________________)

     http://www.mosix.cs.huji.ac.il     


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
