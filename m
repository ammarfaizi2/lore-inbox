Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbSKDHd1>; Mon, 4 Nov 2002 02:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263362AbSKDHd0>; Mon, 4 Nov 2002 02:33:26 -0500
Received: from 24-205-160-225.riv-eres.charterpipeline.net ([24.205.160.225]:14078
	"EHLO kubus.grambling.net") by vger.kernel.org with ESMTP
	id <S262449AbSKDHdZ>; Mon, 4 Nov 2002 02:33:25 -0500
Subject: Help needed with IRQ on Ali chipset
From: Jacek Pliszka <pliszka@physics.ucr.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200211011917.16978.landley@trommello.org>
References: <200210272017.56147.landley@trommello.org>
	<20021030085149.GA7919@codepoet.org>
	<200210300455.21691.dcinege@psychosis.com> 
	<200211011917.16978.landley@trommello.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 03 Nov 2002 23:39:36 -0800
Message-Id: <1036395576.19686.45.camel@kubus.grambling.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I am asking once more for help with IRQ setup for Cardbus controller on
ATI U1/Ali 1535+ chipset. This time with more exact information. This is
what I get:

lspci -v -s 00:0a.0 
00:0a.0 CardBus bridge: O2 Micro, Inc.: Unknown device 6972
        Subsystem: Hewlett-Packard Company: Unknown device 0024
        Flags: bus master, slow devsel, latency 32, IRQ 5
        Memory at 80000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=32
        Memory window 0: 81000000-81100000
        I/O window 0: 00003000-0000307f
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001

Which is consistent with Windows IRQ 5

But dump_pirq gives:
Interrupt routing table found at address 0xfdf10:
  Version 1.0, size 0x00d0
  Interrupt router is device 00:07.0
  PCI exclusive interrupt mask: 0x0000 []
  Compatible router: vendor 0x10b9 device 0x1533
....(skipped)

Device 00:0a.0 (slot 0): CardBus bridge
  INTA: link 0x06, irq mask 0x00a0 [5,7]

Device 00:12.0 (slot 0): Ethernet controller
  INTA: link 0x02, irq mask 0x0880 [7,11]

Device 00:0c.0 (slot 0): 
  INTA: link 0x03, irq mask 0x0658 [3,4,6,9,10]

Interrupt router at 00:07.0: AcerLabs Aladdin M1533 PCI-to-ISA bridge
  INT1 (link 1): irq 10
  INT2 (link 2): irq 11
  INT3 (link 3): unrouted
  INT4 (link 4): unrouted
  INT5 (link 5): unrouted
  INT6 (link 6): irq 11
  INT7 (link 7): irq 3
  INT8 (link 8): irq 5
  Serial IRQ: [enabled] [continuous] [frame=21] [pulse=12]

So INT6 instead of 5 gets 11 but it is not shown in lspci.

Could somebody, please, tell me what and where should be fixed
(I guess in pci-irq.c) to get it correct.

BR,

Jacek
