Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264846AbUDWPoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264846AbUDWPoo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 11:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264854AbUDWPon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 11:44:43 -0400
Received: from c-67-172-209-82.client.comcast.net ([67.172.209.82]:55300 "EHLO
	skarpsey.home.lan") by vger.kernel.org with ESMTP id S264846AbUDWPoL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 11:44:11 -0400
Message-ID: <32946.163.179.143.101.1082731449.squirrel@skarpsey.dyndns.org>
Date: Fri, 23 Apr 2004 09:44:09 -0500 (CDT)
Subject: 3c59x transmit error
From: "Kelledin" <kelledin+LKML@skarpsey.dyndns.org>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Cc: becker@scyld.com
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a 3com 3C905 (Boomerang) that's having some problems under kernel
2.4.21.

When the 3c59x module is first loaded after boot, it works fine.  When I
unload it, though, I can't reload it and have it work; I have to reboot
the machine to get the card working again.

The second time I try to load it, the module loads, but I get the
following messages in my logs:

Apr 23 09:14:13 gleipnir kernel: 3c59x: Donald Becker and others.
www.scyld.com/network/vortex.html
Apr 23 09:14:13 gleipnir kernel: See Documentation/networking/vortex.txt
Apr 23 09:14:13 gleipnir kernel: 00:0a.0: 3Com PCI 3c905 Boomerang
100baseTx at 0xe400. Vers LK1.1.16
Apr 23 09:14:13 gleipnir kernel:  00:60:97:d6:18:67, IRQ 18
Apr 23 09:14:13 gleipnir kernel:   product code 4848 rev 00.0 date 04-26-97
Apr 23 09:14:13 gleipnir kernel:   Internal config register is 102001b,
transceivers 0xe040.
Apr 23 09:14:13 gleipnir kernel:   64K word-wide RAM 1:1 Rx:Tx split,
autoselect/10baseT interface.
Apr 23 09:14:13 gleipnir kernel:   Enabling bus-master transmits and
whole-frame receives.
Apr 23 09:14:13 gleipnir kernel: 00:0a.0: scatter/gather enabled. h/w
checksums disabled
Apr 23 09:14:13 gleipnir kernel: eth0: Dropping NETIF_F_SG since no
checksum feature.
Apr 23 09:14:13 gleipnir kernel: eth0:  Filling in the Rx ring.
Apr 23 09:14:13 gleipnir kernel: eth0: first available media type: MII
Apr 23 09:14:13 gleipnir kernel: eth0: Initial media type MII.
Apr 23 09:14:13 gleipnir kernel: eth0: MII #0 status ffff, link partner
capability ffff, info1 0010, setting half-duplex.
Apr 23 09:14:13 gleipnir kernel: eth0: vortex_up() InternalConfig 0162001b.
Apr 23 09:14:13 gleipnir kernel: eth0: vortex_up() irq 18 media status 8802.
Apr 23 09:14:13 gleipnir kernel: eth0: interrupt, status ec03, latency 3
ticks.
Apr 23 09:14:13 gleipnir kernel: eth0: In interrupt loop, status ec03.
Apr 23 09:14:13 gleipnir kernel: boomerang_interrupt->boomerang_rx
Apr 23 09:14:13 gleipnir kernel: boomerang_rx(): status ec03
Apr 23 09:14:13 gleipnir kernel: Receiving packet size 60 status 803c.
Apr 23 09:14:13 gleipnir kernel:  Rx error: status 00.
Apr 23 09:14:13 gleipnir last message repeated 3 times
Apr 23 09:14:13 gleipnir kernel: eth0: vortex_error(), status=0xec03
Apr 23 09:14:13 gleipnir kernel: eth0: Host error, FIFO diagnostic
register 2000.
Apr 23 09:14:13 gleipnir kernel: eth0: PCI bus error, bus status 00b00029
Apr 23 09:14:13 gleipnir kernel: eth0: first available media type: MII
Apr 23 09:14:13 gleipnir kernel: eth0: Initial media type MII.
Apr 23 09:14:13 gleipnir kernel: eth0: MII #0 status ffff, link partner
capability ffff, info1 0010, setting half-duplex.
Apr 23 09:14:13 gleipnir kernel: eth0: vortex_up() InternalConfig 0162001b.
Apr 23 09:14:13 gleipnir kernel: eth0: vortex_up() irq 18 media status 8802.
Apr 23 09:14:13 gleipnir kernel: eth0: exiting interrupt, status e000.
Apr 23 09:14:16 gleipnir kernel: eth0: Media selection timer tick
happened, MII.
Apr 23 09:14:16 gleipnir kernel: dev->watchdog_timeo=500
Apr 23 09:14:16 gleipnir kernel: eth0: MII transceiver has status ffff.
Apr 23 09:14:16 gleipnir kernel: eth0: Media selection timer finished, MII.
Apr 23 09:14:22 gleipnir kernel: eth0: interrupt, status e205, latency 3
ticks.
Apr 23 09:14:22 gleipnir kernel: eth0: In interrupt loop, status e205.
Apr 23 09:14:22 gleipnir kernel: eth0: vortex_error(), status=0xe205
Apr 23 09:14:22 gleipnir kernel: eth0: Transmit error, Tx status register d0.
Apr 23 09:14:22 gleipnir kernel:   Flags; bus-master 1, dirty 1(1) current
1(1)
Apr 23 09:14:22 gleipnir kernel:   Transmit list 00000000 vs. c48ad240.
Apr 23 09:14:22 gleipnir kernel:   0: @c48ad200  length 8000002a status
8000002a
Apr 23 09:14:22 gleipnir kernel:   1: @c48ad240  length 00000000 status
00000000
Apr 23 09:14:22 gleipnir kernel:   2: @c48ad280  length 00000000 status
00000000
Apr 23 09:14:22 gleipnir kernel:   3: @c48ad2c0  length 00000000 status
00000000
Apr 23 09:14:22 gleipnir kernel:   4: @c48ad300  length 00000000 status
00000000
Apr 23 09:14:22 gleipnir kernel:   5: @c48ad340  length 00000000 status
00000000
Apr 23 09:14:22 gleipnir kernel:   6: @c48ad380  length 00000000 status
00000000
Apr 23 09:14:22 gleipnir kernel:   7: @c48ad3c0  length 00000000 status
00000000
Apr 23 09:14:22 gleipnir kernel:   8: @c48ad400  length 00000000 status
00000000
Apr 23 09:14:22 gleipnir kernel:   9: @c48ad440  length 00000000 status
00000000
Apr 23 09:14:22 gleipnir kernel:   10: @c48ad480  length 00000000 status
00000000
Apr 23 09:14:22 gleipnir kernel:   11: @c48ad4c0  length 00000000 status
00000000
Apr 23 09:14:22 gleipnir kernel:   12: @c48ad500  length 00000000 status
00000000
Apr 23 09:14:22 gleipnir kernel:   13: @c48ad540  length 00000000 status
00000000
Apr 23 09:14:22 gleipnir kernel:   14: @c48ad580  length 00000000 status
00000000
Apr 23 09:14:22 gleipnir kernel:   15: @c48ad5c0  length 00000000 status
00000000
Apr 23 09:14:22 gleipnir kernel: eth0: exiting interrupt, status e000.

At this point, I'm unable to ping anything, even machines on my local LAN,
until the system is rebooted (either cold or warm boot works).  I continue
to get similar messages about transmit errors, except that Tx status
register is 90 instead of d0.

My first instinct is to blame the driver--especially as it's only on the
second module load that problems occur.

(When replying, note that I'm subscribed to linux-kernel@, but not to
linux-net@.)

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does it still
cost four figures to fix?"
