Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265539AbUFIE7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265539AbUFIE7V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 00:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265540AbUFIE7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 00:59:21 -0400
Received: from [132.216.18.132] ([132.216.18.132]:4998 "EHLO secure.ckut.ca")
	by vger.kernel.org with ESMTP id S265539AbUFIE7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 00:59:15 -0400
Date: Wed, 9 Jun 2004 00:58:23 -0400
From: Marc Heckmann <mh@nadir.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc2 0IDE "lost interrupt" messages on K8 board
Message-ID: <20040609045822.GA21455@nadir.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I recently put together an x86_64 system using an Asus K8V SE deluxe
board.

The system has 3 disks setup in a raid 5 array: 1 SATA (sata_promise)
and 2 PATA on the via controller (hda + hdc).

Under heavy write IO combined with heavy network IO (100 Mbit, samba
fileserving, large files) I get the following messages with 2.6.7-rc2:

hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt


This system freezes up for a few seconds when this happens.

The hda is an ATA-133 capable disk. 

Does anyone know how to fix this? Would passing "ide0=serialize
ide1=serialize" help? Would changing some BIOS settings help?

below is the output of lspci -v. I would really like to get this
solved as it is hindering production. I can also provide dmesg output
if needed. The system uses ACPI+APIC. thanks in advance.


00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge (rev 01)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a3
	Flags: bus master, 66Mhz, medium devsel, latency 8
	Memory at f8000000 (32-bit, prefetchable)
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Capabilities: <available only to root>

00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808a
	Flags: bus master, medium devsel, latency 64, IRQ 16
	Memory at f6400000 (32-bit, non-prefetchable)
	I/O ports at 7000 [size=128]
	Capabilities: <available only to root>

00:08.0 RAID bus controller: Promise Technology, Inc. PDC20378 (SATA150 TX) (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80f5
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 18
	I/O ports at 8000
	I/O ports at 7800 [size=16]
	I/O ports at 7400 [size=128]
	Memory at f6600000 (32-bit, non-prefetchable) [size=4K]
	Memory at f6500000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: <available only to root>

00:0a.0 Ethernet controller: Marvell Yukon Gigabit Ethernet 10/100/1000Base-T Adapter (rev 13)
	Subsystem: Asustek Computer, Inc.: Unknown device 811a
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 17
	Memory at f6800000 (32-bit, non-prefetchable) [size=f6700000]
	I/O ports at 8400 [size=256]
	Expansion ROM at 00020000 [disabled]
	Capabilities: <available only to root>

00:0c.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Flags: bus master, medium devsel, latency 64, IRQ 17
	I/O ports at a400 [size=f6b00000]
	Memory at f6c00000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 00020000 [disabled]
	Capabilities: <available only to root>

00:0d.0 VGA compatible controller: ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT] (rev 41) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT]
	Flags: bus master, stepping, medium devsel, latency 64
	Memory at f7000000 (32-bit, non-prefetchable) [size=f6e00000]
	I/O ports at e000 [size=256]
	Memory at f6f00000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 00020000 [disabled]

00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
	Subsystem: Asustek Computer, Inc. A7V600 motherboard
	Flags: bus master, medium devsel, latency 64, IRQ 20
	I/O ports at e800
	I/O ports at d800 [size=4]
	I/O ports at d400 [size=8]
	I/O ports at d000 [size=4]
	I/O ports at c800 [size=16]
	I/O ports at c400 [size=256]
	Capabilities: <available only to root>

00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc. A7V600 motherboard
	Flags: bus master, medium devsel, latency 32, IRQ 20
	I/O ports at fc00 [size=16]
	Capabilities: <available only to root>

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. A7V600 motherboard
	Flags: bus master, medium devsel, latency 64, IRQ 21
	I/O ports at a800 [size=32]
	Capabilities: <available only to root>

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. A7V600 motherboard
	Flags: bus master, medium devsel, latency 64, IRQ 21
	I/O ports at b000 [size=32]
	Capabilities: <available only to root>

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. A7V600 motherboard
	Flags: bus master, medium devsel, latency 64, IRQ 21
	I/O ports at b400 [size=32]
	Capabilities: <available only to root>

00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. A7V600 motherboard
	Flags: bus master, medium devsel, latency 64, IRQ 21
	I/O ports at b800 [size=32]
	Capabilities: <available only to root>

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc. A7V600 motherboard
	Flags: bus master, medium devsel, latency 64, IRQ 21
	Memory at f6d00000 (32-bit, non-prefetchable)
	Capabilities: <available only to root>

00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
	Subsystem: Asustek Computer, Inc. A7V600 motherboard
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: <available only to root>

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
	Subsystem: Asustek Computer, Inc. A7V600 motherboard (ADI AD1980 codec [SoundMAX])
	Flags: medium devsel, IRQ 22
	I/O ports at c000
	Capabilities: <available only to root>

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel
	Capabilities: <available only to root>

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel



