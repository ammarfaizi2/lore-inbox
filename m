Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbTHTOQf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 10:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbTHTOQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 10:16:35 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:29190 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261976AbTHTOQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 10:16:32 -0400
Subject: Re: [OT] Connection tracking for IPSec
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew McGregor <andrew@indranet.co.nz>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <23600000.1061383792@ijir>
References: <1061378568.668.9.camel@teapot.felipe-alfaro.com>
	 <23600000.1061383792@ijir>
Content-Type: text/plain
Message-Id: <1061388988.3804.8.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 20 Aug 2003 16:16:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm starting with IPSec right now. To make it work, I must open up
> > protocols 50 and 51 to pass across my Linux firewalls, but I want to use
> > connection tracking much like I do when not using IPSec.
> >
> > For example,
> >
> > iptables -A INPUT -m state --state RELATED,ESTABLISHED
> 
> Hmm.  You can't do this if the end host does the ESP (AH is another 
> matter).  Ever.  If the ESP is working, the router can't tell what is 
> inside the packet; this is the whole point of IPSEC.  If you want this 
> functionality, you can only provide it on the end host, or else do the 
> IPSEC on the router.

Well, I'm using IPSec on two machines and both of them are end hosts.
They are *not* working as routers. My netfilter rules are:

Chain INPUT (policy DROP)
target     prot opt source      destination
ACCEPT     all  --  anywhere    anywhere   state RELATED,ESTABLISHED
ACCEPT     all  --  localhost.localdomain  anywhere

Chain FORWARD (policy DROP)
target     prot opt source               destination

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination

The problem is that if I enable IPSec on both machines by using manual,
preshared keys, no traffic will pass through both firewalls, as I need
to open up protocols 50 and 51 (AH and ESP).

The problem here is that opening up protocols 50 and 51, makes *any*
IPSec-protected traffic to pass the firewall, but I still want that any
traffic (IPSec-protected or not) be applied the connection-track
filters. For normal (no IPSec) traffic, an incoming packet is only
accepted if it belongs to a connection that was initiated locally. For
IPSec traffic, I just want the same. I don't want any kind of
IPSec-protected traffic to be able to pass through the firewall, only
traffic that belongs to a connection that was initiated locally on the
machine receiving it.

End note: an incoming packet should be accepted by the firewall if and
only if there is a corresponding connection (let it be TCP, UDP or ICMP)
that was first initiated locally on that machine. For example, for any
incoming TCP packet to traverse the firewall, first there must have been
a packet with the SYN flag that travelled in the opposite direction. I
want this to work for normal traffic (it does work now) and for
IPSec-protected traffic.

Did I explain it clearly?
Thanks again!

