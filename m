Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSFTOtd>; Thu, 20 Jun 2002 10:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314748AbSFTOtc>; Thu, 20 Jun 2002 10:49:32 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:23305 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S314707AbSFTOtc>; Thu, 20 Jun 2002 10:49:32 -0400
Date: Thu, 20 Jun 2002 10:45:08 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.4.19-pre 8390.c NETDEV WATCHDOG
Message-ID: <Pine.LNX.3.96.1020620103442.7127A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an old Athlon 1.4GHz system which must be able to speak 100baseT
and 10base2 (thinnet coax). For the 10base2 I have an SMC-Elite16 card,
and any attempt to transmit gives a NETDEV WATCH error and shows that the
interrupt did not come back (/proc/interrupts).

Related info:
- the system was working with the card using 2.2, but no 100baseT
- removing the 100baseT card makes no difference
- the card works with "the other operating system" in other systems
- working cards from other systems fail the same way
- SMC-Ultra cards fail the same way
- the wd.c and smc-ultra.c drivers share the 8290.c module
- the 8390 module is the only part using watchdog (dev->trans_start).
- I have tried all irg and io addresses, all work to the point that
  ifconfig can set the IP address, none function in xmit.

These are old cards, but still nominally supported. Upgrade of the 10base2
network is not affordable, lease requires all wires >6ft be run by union
electricians. If I could find a better supported card I'd buy one.

I realize there may be timing problems, I doubt many people are running
ten year old ISA cards in even a 1.4GHz system:-(

I looked at the code for several hours yesterday, tried a few printk's,
and I think the irq is not getting set up right, but it looks fine on the
screen.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

