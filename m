Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263925AbRFJJkP>; Sun, 10 Jun 2001 05:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264513AbRFJJkF>; Sun, 10 Jun 2001 05:40:05 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:38063 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S263925AbRFJJjw>;
	Sun, 10 Jun 2001 05:39:52 -0400
Message-Id: <m1591h9-000OpFC@amadeus.home.nl>
Date: Sun, 10 Jun 2001 10:39:43 +0100 (BST)
From: arjan@fenrus.demon.nl
To: rmk@arm.linux.org.uk (Russell King)
Subject: Re: 3C905b partial  lockup in 2.4.5-pre5 and up to 2.4.6-pre1
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010610093838.A13074@flint.arm.linux.org.uk>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010610093838.A13074@flint.arm.linux.org.uk> you wrote:
> Is this a change of requirements for ethernet drivers?  Many other drivers
> do exactly the same (drop the first few packets while they're negotiating
> with a hub), unless they're using 10base2, even back to the days of 2.0
> kernels.

I think it would make sense, from the other sides perspective, to only return 
from the "up" function when you actually can send packets[1]. Sure, pump show
this most of all because it does

"up"
send DHCP req
wait
if failed "down"
	  wait
	  repeat


and that sucks if you always eat the first packets after an up...

xircom had this bug for a loooong time, 8139too just got it a few weeks ago
and, well, from an applications point of view expecting to be able to send
packets when the interface is up makes sense.

Applications like pump must be robust against "random" packetloss, and,
well, pump is. Just not against the "targeted" packetloss of loosing every
first few packets.

Greetings,
   Arjan van de Ven


[1] I know this is not always easy for the driverwrite. For one, xircom
    will eat every first few packets, so the driver would have to send a few
    fake packets to get going.
