Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271420AbTGXJvd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 05:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271425AbTGXJvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 05:51:33 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:18698 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S271422AbTGXJvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 05:51:24 -0400
Message-ID: <3F1FAFA9.9040109@superbug.demon.co.uk>
Date: Thu, 24 Jul 2003 11:06:33 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Kernel 2.6.0-test1: System hangs with hda dma failure.
Content-Type: multipart/mixed;
 boundary="------------050008090607040001080209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050008090607040001080209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This problem appears at any time during normal operation.
As you can see I have a CD-ROM.
If the ide cable is unplugged from the CD-ROM (on hdc) the problem never 
seems to happen.
If the ide cable is plugged into the CD-ROM (on hdc), the problem 
happens quite often, even it I never use the CD-ROM.

This is with kernel.org kernel 2.6.0-test1 without any patches.
If I use kernel 2.4.21, I have not seen these problems, but I have other 
problems with 2.4.21 so I cannot use it. E.g. In kernel 2.4.21, the NIC 
card does not receive any IRQs so therefore does not work. The system is 
a Dell Dimension 2400.
I cannot use any ALT-SYSRQ-T to output any stack trace, although the 
ALT-SYSRQ-T outputs properly when the fault is not present, i.e. before 
it hangs.

Has anyone seen this problem? The searches I did, did not result in any 
useful comments about my specific problem.
I am subscribed to linux-ide but not linux-kernel.

uname -a
Linux server 2.6.0-test1 #4 SMP Thu Jul 24 11:29:21 BST 2003 i686 GNU/Linux

Output to console screen, but not reaching log file: -

hda: dma_timer_expiry: dma status==0x20
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
hda: status timeout: status=0x80 {busy}

/* Then a slight delay */
hda: drive not ready for command

ide0: reset: success
/* Then a slight delay */
hda: dma_timer_expiry: dma status==0x21
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
hda: status timeout: status=0x80 {busy}

Details of ide setup from kern.log: -
Jul 23 16:40:48 server kernel: Uniform Multi-Platform E-IDE driver 
Revision: 7.00alpha2
Jul 23 16:40:48 server kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with ide
bus=xx
Jul 23 16:40:48 server kernel: ICH4: IDE controller at PCI slot 0000:00:1f.1
Jul 23 16:40:48 server kernel: ICH4: chipset revision 1
Jul 23 16:40:48 server kernel: ICH4: not 100%% native mode: will probe 
irqs later
Jul 23 16:40:48 server kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS 
settings: hda:DMA, hdb:pio
Jul 23 16:40:48 server kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS 
settings: hdc:DMA, hdd:pio
Jul 23 16:40:48 server kernel: hda: ST3120026A, ATA DISK drive
Jul 23 16:40:48 server kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul 23 16:40:48 server kernel: hdc: HL-DT-ST GCE-8481B, ATAPI CD/DVD-ROM 
drive
Jul 23 16:40:48 server kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul 23 16:40:48 server kernel: hda: max request size: 1024KiB
Jul 23 16:40:48 server kernel: hda: host protected area => 1
Jul 23 16:40:48 server kernel: hda: 234375000 sectors (120000 MB) 
w/8192KiB Cache, CHS=14589/255/63,
  UDMA(100)
Jul 23 16:40:48 server kernel:  hda: hda1 hda2 hda3 < hda5 hda6 hda7 >


Attached is output from "lspci -v"

--------------050008090607040001080209
Content-Type: text/plain;
 name="lspci-v"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-v"

00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 0160
	Flags: bus master, fast devsel, latency 0
	Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [e4] #09 [1105]

00:02.0 VGA compatible controller: Intel Corp. 82845G/GL [Brookdale-G] Chipset Integrated Graphics Device (rev 01) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 0160
	Flags: fast devsel, IRQ 16
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Memory at feb80000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [d0] Power Management version 1

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Dell Computer Corporation: Unknown device 0160
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at ff80 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Dell Computer Corporation: Unknown device 0160
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at ff60 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Dell Computer Corporation: Unknown device 0160
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at ff40 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: Dell Computer Corporation: Unknown device 0160
	Flags: bus master, medium devsel, latency 0, IRQ 23
	Memory at ffa80800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 81) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fe900000-feafffff

00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 01)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: Dell Computer Corporation: Unknown device 0160
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at ffa0 [size=16]
	Memory at feb7fc00 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 0160
	Flags: medium devsel, IRQ 17
	I/O ports at eda0 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 0160
	Flags: bus master, medium devsel, latency 0, IRQ 17
	I/O ports at ee00 [size=256]
	I/O ports at edc0 [size=64]
	Memory at feb7fa00 (32-bit, non-prefetchable) [size=512]
	Memory at feb7f900 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

01:04.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine] (rev 06)
	Subsystem: D-Link System Inc DFE-530TX rev A
	Flags: bus master, medium devsel, latency 64, IRQ 16
	I/O ports at df00 [size=128]
	Memory at fe9fdf80 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at fea00000 [disabled] [size=64K]

01:09.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 8127
	Flags: bus master, fast devsel, latency 64, IRQ 17
	Memory at fe9fe000 (32-bit, non-prefetchable) [size=8K]
	Expansion ROM at fea00000 [disabled] [size=16K]
	Capabilities: [40] Power Management version 2


--------------050008090607040001080209--

