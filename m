Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273115AbRIWCQ2>; Sat, 22 Sep 2001 22:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273102AbRIWCQT>; Sat, 22 Sep 2001 22:16:19 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:65419 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S273099AbRIWCQI>; Sat, 22 Sep 2001 22:16:08 -0400
Importance: Normal
Subject: Re: [PATCH] strict interface arp patch for Linux 2.4.2
To: Julian Anastasov <ja@ssi.bg>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OFF8C7D800.364E6389-ON85256AD0.00046061@raleigh.ibm.com>
From: "Allen Lau" <pflau@us.ibm.com>
Date: Sat, 22 Sep 2001 22:14:38 -0400
X-MIMETrack: Serialize by Router on D04NMS38/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 09/22/2001 10:16:24 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     Hello,

> > In this example, 1.1.1.11 2.2.2.22 are virtual ip's which can float
between
> > boxes and interfaces.
> > I want virtual ip 1.1.1.11 to be known to clients through eth0 node1
> > (2.2.2.22 eth1 node2). Node1 can redirect 1.1.1.11 traffic to eth0
node2.
> >               node1                              node2
> >           lo:1 1.1.1.11                       lo:1 1.1.1.11
> >           lo:2 2.2.2.22                       lo:2 2.2.2.22
> >
> >   eth0   1.1.1.1    eth1 2.2.2.1      eth0 1.1.1.2    eth1 2.2.2.2
> >   eth0:1 1.1.1.11                                   eth1:1 2.2.2.22
> >

arp_filter is not enough:
   with arp_filter enabled, both node 1 and 2 will answer to "who is 1.1.1.11?".

hidden patch + arp_filter:
   If the hidden and arp_filter patches can be applied on top of each other(?),
   one still has to be careful configuring the system.  In the example with
   loopback hidden, you'll notice that no one will answer "who is 1.1.1.11?".
   Further, arp_filter (which is based on routing) may have side effects from
   asymmetric routing, multiple nic's on same subnet, and default routes.

This example illustrates the problem and that the distributions does not have
enough to solve. In addition, I need something simpler for field deployment.
Strict_interface_arp I hope will provide the needed simplicity and control.

>    The question is why you want 2.2.2.1 to be advertised as source
> through eth0 ? May be your question is wrong and should contain eth1?
> inet_select_addr() obviously selects source IP from the device you
> request.

That's the "arp flux" problem which strict_interface_arp solves.
In Linux arp requests, it is possible for 2.2.2.1 eth1 node1 to be advertised
as source by eth0 node1. For illustration, eth0 is 10/100M and eth1 is gigabit.
It'll cause clients to redirect traffic for the gigabit to the 10/100M port.
It does not appear rp_filter can solve this.

Regards
Allen Lau
--
Julian Anastasov <ja@ssi.bg>



