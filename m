Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265579AbSJXR6N>; Thu, 24 Oct 2002 13:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265580AbSJXR6N>; Thu, 24 Oct 2002 13:58:13 -0400
Received: from [202.89.69.154] ([202.89.69.154]:28396 "EHLO manage.24online")
	by vger.kernel.org with ESMTP id <S265579AbSJXR6K>;
	Thu, 24 Oct 2002 13:58:10 -0400
Subject: 3Com Cardbus 3CXFE575CT IRQ Problems
From: Dionysius Wilson Almeida <dwilson@yenveedu.com>
To: vortex-bug@scyld.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Oct 2002 23:34:32 +0530
Message-Id: <1035482672.1957.82.camel@debianlap>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running Debian Woody with kernel 2.4.19 with cardbus and hotplug
support.  I've a 3Com 3CXFE575CT pcmcia card and I'm trying to get it to
work on my system. It seems that the card is unable to find a usable
IRQ.  I've disabled Plug-n-Play in the BIOS of my Sony VAIO PCG-FX140
Laptop but still the card is not able to get any usable IRQs. I also
booted with pci=biosirq but still no progress. Here's the message it
outputs to /var/log/messages.


Oct 24 19:11:40 debianlap kernel: Linux Kernel Card Services 3.1.22
Oct 24 19:11:40 debianlap kernel:   options:  [pci] [cardbus] [pm]
Oct 24 19:11:40 debianlap kernel: PCI: No IRQ known for interrupt pin A
of device 01:02.0.
Oct 24 19:11:40 debianlap kernel: PCI: No IRQ known for interrupt pin B
of device 01:02.1.
Oct 24 19:11:40 debianlap kernel: Yenta IRQ list 0498, PCI irq0
Oct 24 19:11:40 debianlap kernel: Socket status: 30000820
Oct 24 19:11:40 debianlap kernel: Yenta IRQ list 0098, PCI irq0
Oct 24 19:11:40 debianlap kernel: Socket status: 30000006
Oct 24 19:11:41 debianlap kernel: cs: cb_alloc(bus 2): vendor 0x10b7,
device 0x5257
Oct 24 19:11:41 debianlap kernel: PCI: Enabling device 02:00.0 (0000 ->
0003)
Oct 24 19:11:41 debianlap kernel: PCI: No IRQ known for interrupt pin A
of device 02:00.0.
Oct 24 19:11:41 debianlap /etc/hotplug/pci.agent: Setup 3c59x for PCI
slot 02:00.0
Oct 24 19:11:41 debianlap kernel: PCI: No IRQ known for interrupt pin A
of device 02:00.0.
Oct 24 19:11:41 debianlap kernel: 3c59x: Donald Becker and others.
www.scyld.com/network/vortex.html
Oct 24 19:11:41 debianlap kernel: 02:00.0: 3Com PCI 3CCFE575CT Tornado
CardBus at 0x4000. Vers LK1.1.16
Oct 24 19:11:41 debianlap kernel: PCI: Setting latency timer of device
02:00.0 to 64
Oct 24 19:11:41 debianlap kernel:  *** Warning: IRQ 0 is unlikely to
work! ***
Oct 24 19:11:41 debianlap kernel: cs: IO port probe 0x0c00-0x0cff:
clean.
Oct 24 19:11:41 debianlap kernel: cs: IO port probe 0x0800-0x08ff:
clean.
Oct 24 19:11:41 debianlap kernel: cs: IO port probe 0x0100-0x04ff:
excluding 0x4d0-0x4d7
Oct 24 19:11:41 debianlap /etc/hotplug/net.agent: invoke ifup eth1

Unfortunately the BIOS does not have any options to manually set IRQ for
the pcmica.  Also most times when the card is inserted, the system just
freezes (i.e. mouse, keyboard display just locks up) until i remove the 
card at which point every get back to normal.  This is really strange.

I'm also attaching the output of lspci -v just in case it's of any use
in resolving this issue.

lspci -v output :

00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and
Memory Controller Hub (rev 11)
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: bus master, fast devsel, latency 0
	Capabilities: [88] #09 [f205]

00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset
Graphics Controller] (rev 11) (prog-if 00 [VGA])
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 10
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Memory at f4000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [dc] Power Management version 2

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 03)
(prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f4100000-f41fffff

00:1f.0 ISA bridge: Intel Corp. 82801BAM ISA Bridge (LPC) (rev 03)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801BAM IDE U100 (rev 03) (prog-if
80 [Master])
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: bus master, medium devsel, latency 0
	I/O ports at 1800 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 03)
(prog-if 00 [UHCI])
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at 1820 [size=32]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 03)
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: medium devsel, IRQ 5
	I/O ports at 1810 [size=16]

00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 03)
(prog-if 00 [UHCI])
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 1840 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio
(rev 03)
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: bus master, medium devsel, latency 0, IRQ 5
	I/O ports at 1c00 [size=256]
	I/O ports at 1880 [size=64]

00:1f.6 Modem: Intel Corp. 82801BA/BAM AC'97 Modem (rev 03) (prog-if 00
[Generic])
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: medium devsel, IRQ 5
	I/O ports at 2400 [size=256]
	I/O ports at 2000 [size=128]

01:00.0 FireWire (IEEE 1394): Texas Instruments TSB43AA22 IEEE-1394
Controller (PHY/Link Integrated) (rev 02) (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at f4105000 (32-bit, non-prefetchable) [size=2K]
	Memory at f4100000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2

01:02.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: bus master, medium devsel, latency 168
	Memory at f4106000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001

01:02.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: Sony Corporation: Unknown device 80df
	Flags: bus master, medium devsel, latency 168
	Memory at f4107000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=01, secondary=06, subordinate=09, sec-latency=176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001

01:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet
Controller (rev 03)
	Subsystem: Intel Corp.: Unknown device 3013
	Flags: bus master, medium devsel, latency 66, IRQ 9
	Memory at f4104000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 3000 [size=64]
	Capabilities: [dc] Power Management version 2


I'll be grateful if some can help me in resolving this issue.
pcmcia-cs version is 3.2.1-1 and hotplug version is 0.0.20020826-1.

regards,

-Wilson


