Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270765AbTHAOL4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 10:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270767AbTHAOL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 10:11:56 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:39068 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id S270765AbTHAOLy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 10:11:54 -0400
Subject: 2.6.0-test2: irq 18: nobody cared...Disabling irq #18 (i875P SATA)
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: ML-linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1059747024.2418.8.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-1) 
Date: 01 Aug 2003 16:10:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While booting 2.6.0-test2 on my i875P based PC I get the following:

<snip>
Adding 787176k swap on /dev/hda3.  Priority:-1 extents:1
irq 18: nobody cared!
Call Trace:
 [<c010cf76>] __report_bad_irq+0x2a/0x8b
 [<c010d060>] note_interrupt+0x6f/0x9f
 [<c010d38d>] do_IRQ+0x175/0x1a6
 [<c010884e>] default_idle+0x0/0x2d
 [<c010884e>] default_idle+0x0/0x2d
 [<c010b5c4>] common_interrupt+0x18/0x20
 [<c010884e>] default_idle+0x0/0x2d
 [<c010884e>] default_idle+0x0/0x2d
 [<c0108878>] default_idle+0x2a/0x2d
 [<c01088ee>] cpu_idle+0x39/0x42
 [<c0105000>] rest_init+0x0/0x65
 [<c035a83e>] start_kernel+0x191/0x1ca
 [<c035a403>] unknown_bootoption+0x0/0xff

handlers:
[<c01ef51c>] (ide_intr+0x0/0x1d4)
Disabling IRQ #18


IRQ 18 belongs to the SATA interface:

ide2 at 0xefe0-0xefe7,0xefae on irq 18

Funny thing is that the SATA drive is still usable while the irq
is disabled.

I also noticed that the interrupt count for IRQ 18 is still rather high
(as I mention in a previous mail):

           CPU0       CPU1
  0:     552358          0    IO-APIC-edge  timer
  2:          0          0          XT-PIC  cascade
  9:          0          0   IO-APIC-level  acpi
 14:      11122          0    IO-APIC-edge  ide0
 15:          1          0    IO-APIC-edge  ide1
 16:      42146          0   IO-APIC-level  uhci-hcd, nvidia
 17:          0          0   IO-APIC-level  Intel ICH5
 18:     100013      99992   IO-APIC-level  ide2
 19:      14627          0   IO-APIC-level  uhci-hcd
 20:          2          0   IO-APIC-level  ohci1394
 21:        530          0   IO-APIC-level  eth0
 23:          0          0   IO-APIC-level  ehci_hcd
NMI:          0          0
LOC:     552289     552628
ERR:          0
MIS:          4

Any solutions?

Cheers,

Jurgen	

