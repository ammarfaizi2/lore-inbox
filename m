Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755705AbWKQQuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755705AbWKQQuF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWKQQuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:50:05 -0500
Received: from s131.mittwaldmedien.de ([62.216.178.31]:41756 "EHLO
	s131.mittwaldmedien.de") by vger.kernel.org with ESMTP
	id S933722AbWKQQt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:49:59 -0500
From: Holger Schurig <hs4233@mail.mn-solutions.de>
To: linux-kernel@vger.kernel.org
Subject: Bug? Need "pci=assign-busses" for AdvanTech PCM-9381
Date: Fri, 17 Nov 2006 17:50:19 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611171750.19728.hs4233@mail.mn-solutions.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an AdvanTech PCM-9381 board and noticed in dmesg that I should add
"pci=assign-busses" and report this to linux-kernel. Knowing nothing about
the underlying problem (and not even sure that there is a problem), I'm
just concur :-)

"lspci -t" show the same output with and without "pci=assign-busses", just
some numbers change. Here is a "diff -u" of the output of "dmesg" and
"lspci -t" for both cases:

--- dmesg.before	2006-11-17 17:43:30.000000000 +0100
+++ dmesg.after	2006-11-17 17:45:02.000000000 +0100
@@ -44,9 +44,9 @@
 Enabling APIC mode:  Flat.  Using 1 I/O APICs
 Using ACPI (MADT) for SMP configuration information
 Allocating PCI resources starting at 10000000 (gap: 0e000000:f0c00000)
-Detected 598.115 MHz processor.
+Detected 598.086 MHz processor.
 Built 1 zonelists.  Total pages: 56881
-Kernel command line: root=/dev/hdc1 ro vga=0x254 quiet
+Kernel command line: root=/dev/hdc1 ro vga=0x254 quiet pci=assign-busses
 mapped APIC to ffffd000 (fee00000)
 mapped IOAPIC to ffffc000 (fec00000)
 Enabling fast FPU save and restore... done.
@@ -65,7 +65,7 @@
       .data : 0xc02c1de7 - 0xc036f674   ( 694 kB)
       .text : 0xc0100000 - 0xc02c1de7   (1799 kB)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
-Calibrating delay using timer specific routine.. 1196.89 BogoMIPS (lpj=5984488)
+Calibrating delay using timer specific routine.. 1196.87 BogoMIPS (lpj=5984389)
 Mount-cache hash table entries: 512
 CPU: After generic identify, caps: a7e9fbbf 00000000 00000000 00000000 00000000 00000000 00000000
 CPU: L1 I cache: 32K, L1 D cache: 32K
@@ -92,8 +92,6 @@
 PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
 PCI: Firmware left 0000:01:0b.0 e100 interrupts enabled, disabling
 PCI: Transparent bridge - 0000:00:1e.0
-PCI: Bus #03 (-#06) is hidden behind transparent bridge #01 (-#03) (try 'pci=assign-busses')
-Please report the result to linux-kernel to fix this permanently
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
 ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12 14 15)
@@ -121,7 +119,7 @@
   IO window: 0000d400-0000d4ff
   PREFETCH window: 10000000-11ffffff
   MEM window: 16000000-17ffffff
-PCI: Bus 3, cardbus bridge: 0000:01:04.1
+PCI: Bus 6, cardbus bridge: 0000:01:04.1
   IO window: 0000dc00-0000dcff
   IO window: 00001000-000010ff
   PREFETCH window: 12000000-13ffffff
@@ -202,7 +200,6 @@
 Yenta: CardBus bridge found at 0000:01:04.1 [0000:0000]
 Yenta: ISA IRQ mask 0x0000, PCI irq 17
 Socket status: 30000820
-Yenta: Raising subordinate bus# of parent bus (#01) from #03 to #06
 pcmcia: parent PCI bridge I/O window: 0xd000 - 0xdfff
 cs: IO port probe 0xd000-0xdfff: clean.
 pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xe80fffff
@@ -257,7 +254,7 @@
 PCI: Setting latency timer of device 0000:00:1f.5 to 64
 input: AT Translated Set 2 keyboard as /class/input/input0
 intel8x0_measure_ac97_clock: measured 60001 usecs
-intel8x0: clocking to 56265
+intel8x0: clocking to 56243
 ALSA device list:
   #0: Intel 82801DB-ICH4 with ALC202 at 0xe8201000, irq 17
 TCP veno registered
@@ -273,8 +270,8 @@
 Time: tsc clocksource has been installed.
 Time: pit clocksource has been installed.
 Loaded prism54 driver, version 1.2
-PCI: Enabling device 0000:03:00.0 (0000 -> 0002)
-ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 17 (level, low) -> IRQ 17
+PCI: Enabling device 0000:06:00.0 (0000 -> 0002)
+ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 17 (level, low) -> IRQ 17
 ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
 input: TSC-10 DM as /class/input/input1
 usbcore: registered new interface driver usbtouchscreen
@@ -305,7 +302,7 @@
            +-1d.1
            +-1d.2
            +-1d.7
-           +-1e.0-[0000:01-06]--+-[0000:03]---00.0
+           +-1e.0-[0000:01-09]--+-[0000:06]---00.0
            |                    \-[0000:01]-+-04.0
            |                                +-04.1
            |                                \-0b.0
