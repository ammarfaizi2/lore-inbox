Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262905AbSKWLff>; Sat, 23 Nov 2002 06:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265246AbSKWLff>; Sat, 23 Nov 2002 06:35:35 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:38040 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S262905AbSKWLfe>; Sat, 23 Nov 2002 06:35:34 -0500
Date: Sat, 23 Nov 2002 12:42:42 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.2 networking, NET_BH latency
Message-ID: <20021123114242.GB3817@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I experience some odd behaviour when routing some network packets
on a 2.2(.18) kernel (with Ingo's low latency patch in case it 
matters).

Although there are probably bugs in the modifications we made
(a network card driver, some tweaks in the network core to deal
with several packet priorities etc), I'm not sure the behaviour
is directly due to a bug in our modifications or some synchronisation
issue we overlooked.

So, the network driver receives a packet, pushes it to the upper
layers (netif_rx), the packet does all its job in the network
layers (in the NET_BH bottom-half), it gets routed to another 
interface, and get send.

The problem is that the time of the treatment (measured as time
between the moments when the packet enters the box and exits it)
_always_ exceeds HZ (in fact it is between 1*HZ and 2*HZ). 

Is this normal ? 

Is this related to the scheduling of NET_BH ? In this case, is it
possible to schedule the bottom-half more often ?

It should be noted that, each time a packet is received by the
network card, the driver wakes up a process waiting in ioctl(), 
making it eligible. Could this have any influence on the above ?

In order to respect some minimum timing requirements, we took the
approach of increasing HZ. Since the net latency (at least in our
case) is directly related to the value of the tick, it works. But
maybe there is a better solution.

Thanks,

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
