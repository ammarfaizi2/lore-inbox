Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSFTQjr>; Thu, 20 Jun 2002 12:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSFTQjP>; Thu, 20 Jun 2002 12:39:15 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:33039 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S315259AbSFTQhv>; Thu, 20 Jun 2002 12:37:51 -0400
Message-ID: <3D120584.10908@loewe-komp.de>
Date: Thu, 20 Jun 2002 18:40:36 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Via C3 and VT8605 [ProSavage PM133]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have problems with a ETX Module that has

Via C3 processor
S3 twister (savage) graphics
Realtek 8139 Ethernet
USB in VT82C686 [Apollo Super South]

external Tvia CyberPro 5050 (combined video+audio)


I got messages on bootup:

<7>CPU: Before vendor init, caps: 00803035 80803035 00000000, vendor = 5
<6>CPU: L1 I Cache: 64K (32 bytes/line), D cache 64K (32 bytes/line)
<6>CPU: L2 Cache: 64K (32 bytes/line)
<7>CPU: After vendor init, caps: 00803135 80803035 00000000 00000000
<7>CPU:     After generic, caps: 00803135 80803035 00000000 00000000
<7>CPU:             Common caps: 00803135 80803035 00000000 00000000
<4>CPU: Centaur VIA Samuel 2 stepping 03
[...]
<4>PCI: PCI BIOS revision 2.10 entry at 0xfb200, last bus=1
<4>PCI: Using configuration type 1
<4>PCI: Probing PCI hardware
<3>Unknown bridge resource 0: assuming transparent
<6>PCI: Using IRQ router VIA [1106/0686] at 00:07.0


Can anybody enlighten me what "unknown bridge resource [012]" means?

The Realtek is working fine until I load the trident cyberpro driver.
After that I think the IRQ routing is f*ed up.

On our custom hardware (with CyberPro5050) really strange things happen -
among them the board reboots heavily.

My theorie so far:

The audio part of the cyberpro is a bus master. If enabled and used
weird things happen inside the chipset - IRQ routes get broken
(reconfigured). I also checked with an external powersupply because
I thought that could be the cause.. no luck :-(

A NIC (davicom) on the external PCI bus works fine.
The usb-uhci driver moans about the second USB Hub with something like
"possibly broken cable" (that is not connected at all I think).

We use 2.4.9-ac3+e2compr+  also tried with 2.4.16 - anything changed
since then with the pci bridge quirks? (will check that for myself)

lspci -v shows:

00:00.0 Host bridge: VIA Technologies, Inc. VT8605 [ProSavage PM133]
         Subsystem: VIA Technologies, Inc. VT8605 [ProSavage PM133]
         Flags: bus master, medium devsel, latency 0
         Memory at d8000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 2.0
         Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8605 [PM133 AGP] (prog-if 00 [Normal decode])
         Flags: bus master, 66Mhz, medium devsel, latency 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         Memory behind bridge: dc000000-ddffffff
         Prefetchable memory behind bridge: d0000000-d7ffffff
         Capabilities: [80] Power Management version 2

00:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
         Flags: bus master, medium devsel, latency 32, IRQ 11
         I/O ports at d000 [size=256]
         Memory at e0000000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
         Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
         Flags: bus master, stepping, medium devsel, latency 0
         Capabilities: [c0] Power Management version 2

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
         Subsystem: VIA Technologies, Inc. Bus Master IDE
         Flags: bus master, medium devsel, latency 32
         I/O ports at d400 [size=16]
         Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a) (prog-if 00 [UHCI])
         Subsystem: Unknown device 0925:1234
         Flags: bus master, medium devsel, latency 32, IRQ 10
         I/O ports at d800 [size=32]
         Capabilities: [80] Power Management version 2

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
         Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
         Flags: medium devsel
         Capabilities: [68] Power Management version 2

00:08.0 VGA compatible controller: Intergraphics Systems CyberPro 5000 (rev 01) (prog-if 00 [VGA])
         Subsystem: Unknown device 0280:7000
         Flags: bus master, VGA palette snoop, medium devsel, latency 32, IRQ 11
         Memory at de000000 (32-bit, non-prefetchable) [size=16M]
         Expansion ROM at <unassigned> [disabled] [size=64K]

00:08.1 Multimedia audio controller: Intergraphics Systems CyberPro 5050 (rev 01)
         Subsystem: Unknown device 028f:7000
         Flags: bus master, medium devsel, latency 32, IRQ 11
         Memory at e0001000 (32-bit, non-prefetchable) [size=4K]
         I/O ports at e000 [size=256]

00:09.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10 MBit (rev 31)
         Subsystem: Unknown device 3030:5032
         Flags: bus master, medium devsel, latency 32, IRQ 15
         I/O ports at e400 [size=256]
         Memory at e0002000 (32-bit, non-prefetchable) [size=256]
         Expansion ROM at <unassigned> [disabled] [size=256K]
         Capabilities: [50] Power Management version 1

01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8d01 (rev 02) (prog-if 00 [VGA])
         Flags: 66Mhz, medium devsel
         Memory at dd000000 (32-bit, non-prefetchable) [disabled] [size=512K]
         Memory at d0000000 (32-bit, prefetchable) [disabled] [size=128M]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [dc] Power Management version 2
         Capabilities: [80] AGP version 2.0



