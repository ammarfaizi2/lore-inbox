Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVCGRp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVCGRp0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 12:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVCGRp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 12:45:26 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:47778 "EHLO vana")
	by vger.kernel.org with ESMTP id S261194AbVCGRpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 12:45:07 -0500
Date: Mon, 7 Mar 2005 18:45:06 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: rmk+serial@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: XScale 8250 patches cause malfunction on AMD-8111
Message-ID: <20050307174506.GA9659@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I've just booted my new kernel, and I've noticed that my UARTs are now recognized
as XScale and not 16550A, and I could watch characters from parport0 line coming out
on monitor one after another, with 0.5 second spaces between them.

  I'll try to dig up what bit 6 in IER does on this chip, but it seems like that it is
enabling some thing we do not want to have enabled...  One thing which might make difference
is that I'm using serial console - but it worked without glitch before this change.

 serio: i8042 KBD port at 0x60,0x64 irq 1
 Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
-ttyS0 at I/O 0x3f8 (irq = 4) is a XScale
-ttyS1 at I/O 0x2f8 (irq = 3) is a XScale
-ttyS0 at I/O 0x3f8 (irq = 4) is a XScale
-ttyS1 at I/O 0x2f8 (irq = 3) is a XScale
-ttyS0 at I/O 0x3f8 (irq = 4) is a XScale
-ttyS1 at I/O 0x2f8 (irq = 3) is a XScale
+ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
+ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
+ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
+ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
+ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
+ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
 parport: PnPBIOS parport detected.
 parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]


ChangeSet@1.1982.111.1, 2005-03-04 21:19:20+00:00, gtj.member@com.rmk.(none)
  [ARM PATCH] 2472/1: Updates 8250.c to correctly detect XScale UARTs

  Patch from George Joseph

  Modifications to autoconfig_16550a to add a testcase
  to detect XScale UARTS.

  Signed-off-by: George Joseph
  Signed-off-by: Russell King


0000:00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
0000:00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
0000:00:07.5 Multimedia audio controller: Advanced Micro Devices [AMD] AMD-8111 AC97 Audio (rev 03)
0000:00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
0000:00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
0000:00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
0000:00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:02:07.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
0000:02:08.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
0000:02:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703X Gigabit Ethernet (rev 02)
0000:03:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
0000:03:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
0000:03:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
0000:03:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
0000:03:0b.0 Unknown mass storage controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
0000:03:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
0000:04:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-8151 System Controller (rev 14)
0000:04:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8151 AGP Bridge (rev 14)
0000:05:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01)
0000:05:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)

								Petr Vandrovec
