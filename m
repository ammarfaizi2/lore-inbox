Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264846AbTE1ThE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 15:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264848AbTE1ThE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 15:37:04 -0400
Received: from [213.191.34.242] ([213.191.34.242]:57734 "EHLO www.rentapacs.de")
	by vger.kernel.org with ESMTP id S264846AbTE1ThA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 15:37:00 -0400
Message-ID: <3ED512F8.3700891A@rentapacs.de>
Date: Wed, 28 May 2003 21:50:16 +0200
From: Michael Ulbrich <mul@rentapacs.de>
Organization: Rent a PACS GmbH - Multimediale Archive
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 - yenta, i82365 PCI / ISA irq problem
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

for quite some time now, I'm fiddling around with an annoying problem on
my Fujitsu-Siemens S6010 laptop together with a Dell TrueMobile 1150
WLAN mini PCI card (orinoco chipset). Searching both the pcmcia_cs and
orinoco mailing list archives pointed to a deeper, irq related problem.
Excuse me if this is still the wrong forum, but probably someone out
here may have some clue.

So here we go - Booting with in-kernel pcmcia gives the following
output:

...
pcmcia: Starting PCMCIA services:
kernel: Linux Kernel Card Services 3.1.22
kernel:   options:  [pci] [cardbus] [pm]
kernel: PCI: Found IRQ 11 for device 01:0a.0
kernel: PCI: Sharing IRQ 11 with 00:02.0
kernel: PCI: Sharing IRQ 11 with 00:1d.0
kernel: PCI: Found IRQ 11 for device 01:0a.1
kernel: PCI: Sharing IRQ 11 with 00:1f.3
kernel: PCI: Sharing IRQ 11 with 00:1f.5
kernel: PCI: Enabling device 01:0d.0 (0000 -> 0002) 
kernel: PCI: Found IRQ 11 for device 01:0d.0
kernel: PCI: Sharing IRQ 11 with 00:1f.1
kernel: Yenta IRQ list 06b8, PCI irq11
kernel: Socket status: 30000006
kernel: Yenta IRQ list 06b8, PCI irq11
network: Setting network parameters:  succeeded 
kernel: Socket status: 30000006
network: Bringing up interface lo:  succeeded
pcmcia: using yenta_socket instead of i82365
kernel: Yenta IRQ list 0000, PCI irq11
kernel: Socket status: 30000010
pcmcia: cardmgr[786]: watching 3 sockets
cardmgr[786]: watching 3 sockets
kernel: cs: IO port probe 0x0c00-0x0cff: clean.
kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f
0x400-0x407 0x4d0-0x4d7
kernel: cs: IO port probe 0x0a00-0x0aff: clean.
cardmgr[787]: starting, version is 3.2.4
kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
cardmgr[787]: socket 2: Orinoco or Intersil Prism 2 Wireless
pcmcia: done.
rc: Starting pcmcia:  succeeded
cardmgr[787]: executing: 'modprobe hermes'
cardmgr[787]: executing: 'modprobe orinoco'
cardmgr[787]: executing: 'modprobe orinoco_cs'
cardmgr[787]: executing: './network start eth0' 
...
kernel: NETDEV WATCHDOG: eth0: transmit timed out
kernel: eth0: Tx timeout! Resetting card. ALLOCFID=01f7,
TXCOMPLFID=0000, EVSTAT=8080
...
last message repeating

The same with in-kernel pcmcia disabled and pcmcia_cs as modules:

...
kernel: Linux PCMCIA Card Services 3.2.4
kernel:   kernel build: 2.4.20-RAP-LL-03 #18 Sun May 18 18:13:34 CEST
2003
kernel:   options:  [pci] [cardbus] [apm]  
kernel: Intel ISA/PCI/CardBus PCIC probe:
kernel: PCI: Found IRQ 11 for device 01:0a.0
kernel: PCI: Sharing IRQ 11 with 00:02.0
kernel: PCI: Sharing IRQ 11 with 00:1d.0
kernel: PCI: Found IRQ 11 for device 01:0a.1
kernel: PCI: Sharing IRQ 11 with 00:1f.3
kernel: PCI: Sharing IRQ 11 with 00:1f.5
kernel:   O2Micro OZ6933 rev 02 PCI-to-CardBus at slot 01:0a, mem
0x20000000
kernel:     host opts [0]: [pci only] [pci irq 11] [lat 168/176] [bus
2/2]
kernel:     host opts [1]: [pci only] [pci irq 11] [lat 168/176] [bus
3/3]
kernel:     PCI card interrupts, PCI status changes
kernel: PCI: Enabling device 01:0d.0 (0000 -> 0002) 
kernel: PCI: Found IRQ 11 for device 01:0d.0
kernel: PCI: Sharing IRQ 11 with 00:1f.1
kernel:   TI 1410 rev 01 PCI-to-CardBus at slot 01:0d, mem 0x20002000
kernel:     host opts [0]: [serial pci & irq] [pci irq 11] [lat 168/176]
[bus 4/4]
kernel:     PCI irq 11 test failed 
kernel:     ISA irqs (scanned) = none!<6>    *NO* card interrupts,
polling interval = 1000 ms
network: Setting network parameters:  succeeded 
pcmcia: cardmgr[764]: watching 3 sockets
cardmgr[764]: watching 3 sockets
cardmgr[765]: starting, version is 3.2.4
pcmcia: done.
rc: Starting pcmcia:  succeeded
kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
cardmgr[765]: socket 2: Orinoco or Intersil Prism 2 Wireless
...
cardmgr[765]: executing: 'modprobe hermes'
cardmgr[765]: executing: 'modprobe orinoco'
cardmgr[765]: executing: 'modprobe orinoco_cs'
kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f
0x3c0-0x3df 0x400-0x407 0x4d0-0x4d7
kernel: cs: IO port probe 0x0380-0x03bf: clean.
kernel: cs: IO port probe 0x03e0-0x03ff: clean.
kernel: cs: IO port probe 0x0408-0x04cf: clean.
kernel: cs: IO port probe 0x04d8-0x04ff: clean.
kernel: cs: IO port probe 0x0a00-0x0aff: clean.
kernel: cs: IO port probe 0x0c00-0x0cff: clean.
kernel: orinoco_cs: RequestIRQ: Resource in use
...

Well, in both cases three sockets are recognized and the WLAN card
behind the cardbus bridge on the mini PCI is also correctly detected,
but there seems to be a problem with either the shared PCI IRQ 11 or the
ISA IRQs of which none seems to be available for socket 2. I gave the
i82365 different irq_mode options, but this didn't change anything.

A removable PCMCIA WLAN (also orinoco based) in socket 0 works
perfectly. There is no physical slot for socket 1 on this laptop.

Here's lspci -v for the cardbus controllers:

...
01:0a.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev
02)
        Subsystem: Citicorp TTI: Unknown device 10e6
        Flags: bus master, stepping, slow devsel, latency 168, IRQ 11
        Memory at 20000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001

01:0a.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev
02)
        Subsystem: Citicorp TTI: Unknown device 10e6
        Flags: bus master, stepping, slow devsel, latency 168, IRQ 11
        Memory at 20001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=03, subordinate=03, sec-latency=176
        Memory window 0: 20c00000-20fff000 (prefetchable)
        Memory window 1: 21000000-213ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        16-bit legacy interface ports at 0001

...

01:0d.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 01)
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at 20002000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=04, subordinate=04, sec-latency=176
        Memory window 0: 21400000-217ff000 (prefetchable)
        Memory window 1: 21800000-21bff000
        I/O window 0: 00005000-000050ff
        I/O window 1: 00005400-000054ff
        16-bit legacy interface ports at 0001

I'd appreciate any hints on how to proceed from here and hopefully find
a solution.

TIA and best regards ... Michael Ulbrich
