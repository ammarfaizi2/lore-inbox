Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318305AbSG3Psu>; Tue, 30 Jul 2002 11:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318300AbSG3Psu>; Tue, 30 Jul 2002 11:48:50 -0400
Received: from 213-4-13-153.uc.nombres.ttd.es ([213.4.13.153]:18304 "EHLO
	teapot.home.test") by vger.kernel.org with ESMTP id <S318305AbSG3Pr4>;
	Tue, 30 Jul 2002 11:47:56 -0400
Subject: CardBus, PCI: Strange I/O ports assigned to CardBus bridge
From: Felipe Alfaro Solana <falfaro@borak.es>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 30 Jul 2002 17:45:08 +0200
Message-Id: <1028043908.1523.20.camel@teapot>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have bought a new 3Com 3CCFE575CT CardBus LAN adapter (3Com Megahertx,
using the 3c59x driver) and I have been having problems with it on my
Packard Bell (NEC) Chrom@ laptop: Every time I plug the card, the PCMCIA
subsystem complains that some resources were not allocated.

After some kernel hacking, I have found that, for no apparent reason, my
Linux kernel 2.4.18-3 (RH7.3) is assigning the following resources to my
CardBus bridge:

00:0c.0 CardBus bridge: Texas Instruments PCI4450 PC card Cardbus
Controller
        Subsystem: NEC Corporation: Unknown device 80b6
        Flags: bus master, medium devsel, latency 168, IRQ 10
        Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 000002c0-000002c3
        I/O window 1: 000002c0-000002c3
        16-bit legacy interface ports at 0001

00:0c.1 CardBus bridge: Texas Instruments PCI4450 PC card Cardbus
Controller
        Subsystem: NEC Corporation: Unknown device 80b6
        Flags: bus master, medium devsel, latency 168, IRQ 5
        Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 000002c0-000002c3
        I/O window 1: 000002c0-000002c3
        16-bit legacy interface ports at 0001

Whenever I plug in the 3Com card, the PCI driver complains that it
cannot allocate I/O ports 0x1000->0x2c3 for resource 0. When I plug in
the 3Com card, Linux tries to find usable, free I/O ports for the device
with a minimum base I/O port of 0x1000 (don't know where this number
comes from, but it's very familiar to me and I have seen it on the past
on my machine), but however, the CardBus bridge does only allow for
0x2c0->0x2c3. Thus the kernel complains when trying to allocate ports
0x1000->0x2c3 (the end port is lower than the starting port).

If I plug the card on Windows XP, the card is recognised and works OK
using the following resources:

	I/O ports 0xfc00-0xfcff
	IRQ 5
	Memory 0xffdfcf80-0xffdfcfff
	Memory 0xffdfcf00-0xffdfcfff

Curiously, I've been using an old Xircom CreditCard 10/100 PCMCIA card
with no trouble at all, and sometime ago, I also used a 3Com 3CXFEM656C
CardBus LAN+Modem. The only thing I had to do is just enable inclusion
of I/O ports 0x1000-0x1100 in /etc/pcmcia/config.opts, but now this
doesn't seem to work.

Does anyone have an idea of what's happening here? Why does the card
work on Windows XP, but not on linux? Why only 4 I/O ports
(0x2c0->0x2c3) are allocated for my CardBus bridge?

Help!

Sincerely,

   Felipe Alfaro Solana
   Newby Kernel hacker

