Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263096AbTDVMKj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 08:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbTDVMKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 08:10:39 -0400
Received: from boden.synopsys.com ([204.176.20.19]:29893 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP id S263096AbTDVMKg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 08:10:36 -0400
Date: Tue, 22 Apr 2003 14:22:30 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: David Hinds <dahinds@users.sourceforge.net>
Cc: Thomas =?unknown-8bit?Q?Bogend=F6rfer?= 
	<tsbogend@alpha.franken.de>,
       linux-kernel@vger.kernel.org
Subject: 2.5.58+bk: ejecting a pcmcia card: sleeping function from illegal ctx
Message-ID: <20030422122230.GA12110@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to eject a PCMCIA card (WLinx 10/100, using pcnet driver)
from this notebook, and got the trace below.
No ill effects besides that noticed, but i didn't tried to
insert the card back, just shut down the system.

Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
 [<c01187e8>] __might_sleep+0x58/0x70
 [<c6a77e96>] +0x82/0x58c [pcmcia_core]
 [<c6a73193>] undo_irq+0x23/0x90 [pcmcia_core]
 [<c6a77e96>] +0x82/0x58c [pcmcia_core]
 [<c6a76328>] pcmcia_release_irq+0xb8/0xe0 [pcmcia_core]
 [<c6a8de30>] pcnet_release+0x0/0x80 [pcnet_cs]
 [<c6a77305>] CardServices+0x155/0x260 cmcia_core]
 [<c6a772f9>] CardServices+0x149/0x260 [pcmcia_core]
 [<c6a8de86>] pcnet_release+0x56/0x80 [pcnet_cs]
 [<c0122064>] run_timer_softirq+0xc4/0x1a0
 [<c011e459>] do_softirq+0xa9/0xb0
 [<c010ab65>] do_IRQ+0x125/0x150
 [<c01093a8>] common_interrupt+0x18/0x20
 [<c013d467>] do_wp_page+0x3f7/0x420
 [<c013e32d>] handle_mm_fault+0x10d/0x140
 [<c0115c2d>] do_page_fault+0x24d/0x4c0
 [<c0125df3>] sys_rt_sigaction+0xd3/0x100
 [<c01159e0>] do_page_fault+0x0/0x4c0
 [<c01093ed>] error_code+0x2d/0x40

The computer is Compaq Armada 1592DT.
00:11.0 CardBus bridge: Texas Instruments PCI1131 (rev 01)

Log messages before were:

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 15 for device 00:11.0
Yenta IRQ list 06b8, PCI irq15
Socket status: 30000006
PCI: Found IRQ 11 for device 00:11.1
PCI: Sharing IRQ 11 with 00:10.0
Yenta IRQ list 06b8, PCI irq11
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x100-0x107 0x220-0x22f 0x250-0x257 0x330-0x337 0x378-0x37f 0x388-0x38f 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth0: NE2000 (DL10022 rev 05): io 0x300, irq 3, hw_addr 00:E0:98:9F:89:31
eth0: found link beat
eth0: autonegotiation complete: 100baseT-FD selected
device eth0 entered promiscuous mode
device eth0 left promiscuous mode
Devices Resumed
Hw. address read/write mismap 0
Hw. address read/write mismap 1
Hw. address read/write mism`p 2
Hw. address read/write mismap 3
Hw. address read/write mismap 4
Hw. address read/write mismap 5


