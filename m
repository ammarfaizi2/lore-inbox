Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTEQDnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 23:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTEQDnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 23:43:25 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:38816 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S261188AbTEQDnW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 23:43:22 -0400
Date: Fri, 16 May 2003 20:56:12 -0700
From: Jeffrey Baker <jwbaker@acm.org>
To: linux-kernel@vger.kernel.org
Subject: Re: HD DMA disabled in 2.4.21-rc2, works fine in 2.4.20
Message-ID: <20030517035612.GA543@noodles>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same problem on VIA chipset.  IDE DMA is disabled in
2.4.21-rc2 but works fine otherwise:

root@noodles /etc # hdparm -d 1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)

root@noodles /etc # lspci -v
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System Contr
ller (rev 13)
        Flags: bus master, medium devsel, latency 32
        Memory at f0000000 (32-bit, prefetchable) [size=64M]
        Memory at f7005000 (32-bit, prefetchable) [size=4K]
        I/O ports at a000 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP Bridge (p
rog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: f4000000-f5ffffff
        Prefetchable memory behind bridge: e8000000-efffffff

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40
)
        Subsystem: ABIT Computer Corp. KG7-Lite Mainboard
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master 
IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
        Flags: bus master, medium devsel, latency 32
        I/O ports at a400 [size=16]
        Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 15
        I/O ports at a800 [size=32]
        Capabilities: [80] Power Management version 2

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 15
        I/O ports at ac00 [size=32]
        Capabilities: [80] Power Management version 2

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Flags: medium devsel, IRQ 5
        Capabilities: [68] Power Management version 2

00:08.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
        Subsystem: Adaptec AHA-2904/Integrated AIC-7850
        Flags: bus master, medium devsel, latency 32, IRQ 15
        I/O ports at b000 [disabled] [size=256]
        Memory at f7008000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 1

00:09.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at b400 [disabled] [size=256]
        Memory at f7004000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 05)
        Subsystem: Creative Labs CT4760 SBLive!
        Flags: bus master, medium devsel, latency 32, IRQ 15
        I/O ports at b800 [size=32]
        Capabilities: [dc] Power Management version 1

00:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 05)
        Subsystem: Creative Labs Gameport Joystick
        Flags: bus master, medium devsel, latency 32
        I/O ports at bc00 [size=8]
        Capabilities: [dc] Power Management version 1

00:0d.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
        Subsystem: Kingston Technologies: Unknown device f002
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at c000 [size=256]
        Memory at f7006000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=256K]

00:0f.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 Controller (
Link) (prog-if 10 [OHCI])
        Subsystem: Procomp Informatics Ltd: Unknown device 8010
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at f7007000 (32-bit, non-prefetchable) [size=2K]
        Memory at f7000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 1

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon R100 QD [Radeon 7
200] (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Radeon AIW
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 32, IRQ 12
        Memory at e8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at 9000 [size=256]
        Memory at f5000000 (32-bit, non-prefetchable) [size=512K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

