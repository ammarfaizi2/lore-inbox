Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279581AbRKIHAT>; Fri, 9 Nov 2001 02:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279580AbRKIHAL>; Fri, 9 Nov 2001 02:00:11 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:3078 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S279570AbRKIHAH>; Fri, 9 Nov 2001 02:00:07 -0500
Subject: Re: Who sees "IRQ routing conflict" in dmesg?
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1 (Preview Release)
Date: 08 Nov 2001 22:49:25 -0800
Message-Id: <1005288566.32719.0.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am seeing IRQ routing conflict messages in my
messages log file.  So far, my devices are working
okay.  I haven't tested them all, yet, though.

This is information from testing 2.4.14. 

Here's the debug info given after enabling 
DEBUG=1 in pci-i386.h: 

PCI: BIOS32 Service Directory structure at 0xc00fdaa0 
PCI: BIOS32 Service Directory entry at 0xfdab0 
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01 
PCI: PCI BIOS revision 2.10 entry at 0xfdad1, last bus=1 
PCI: Using configuration type 1 
PCI: Probing PCI hardware 
PCI: IDE base address fixup for 00:07.1 
PCI: Scanning for ghost devices on bus 0 
PCI: Scanning for ghost devices on bus 1 
PCI: IRQ init 
PCI: Fetching IRQ routing table... OK  ret=14, size=128, map=0 
PCI: Using BIOS Interrupt Routing Table 
00:00 slot=00 0:00/def8 1:00/def8 2:00/def8 3:00/def8 
01:05 slot=06 0:56/def8 1:d6/def8 2:00/0000 3:00/0000 
00:07 slot=00 0:fe/4000 1:ff/8000 2:00/0000 3:d7/def8 
00:11 slot=01 0:56/def8 1:d6/def8 2:57/def8 3:d7/def8 
00:12 slot=02 0:d6/def8 1:57/def8 2:d7/def8 3:56/def8 
00:13 slot=03 0:57/def8 1:d7/def8 2:56/def8 3:d6/def8 
00:14 slot=04 0:d6/def8 1:57/def8 2:d7/def8 3:56/def8 
00:0f slot=05 0:56/def8 1:d6/def8 2:57/def8 3:d7/def8 
PCI: Using BIOS for IRQ routing 
PCI: IRQ fixup 
IRQ for 00:14.0:0 -> PIRQ d6, mask def8, excl 0000 -> newirq=0 ...
failed 
IRQ for 00:14.1:1 -> PIRQ 57, mask def8, excl 0000 -> newirq=0 ...
failed 
PCI: Allocating resources 
PCI: Resource f8000000-fbffffff (f=1208, d=0, p=0) 
PCI: Resource fc9ff000-fc9fffff (f=1208, d=0, p=0) 
PCI: Resource 0000cb00-0000cb0f (f=101, d=0, p=0) 
PCI: Resource febfe000-febfefff (f=200, d=0, p=0) 
PCI: Resource 0000f800-0000f8ff (f=101, d=0, p=0) 
PCI: Resource febff000-febfffff (f=200, d=0, p=0) 
PCI: Resource febfb000-febfbfff (f=200, d=0, p=0) 
PCI: Resource febfc000-febfcfff (f=200, d=0, p=0) 
PCI: Resource febfdf00-febfdfff (f=200, d=0, p=0) 
PCI: Resource 0000ff80-0000ff9f (f=101, d=0, p=0) 
PCI: Resource 0000fff0-0000fff7 (f=101, d=0, p=0) 
PCI: Resource 0000fc00-0000fc7f (f=101, d=0, p=0) 
PCI: Resource febfde80-febfdeff (f=200, d=0, p=0) 
PCI: Resource fd000000-fdffffff (f=200, d=0, p=0) 
PCI: Resource e8000000-efffffff (f=1208, d=0, p=0) 
PCI: Resource 0000ffe4-0000ffe7 (f=105, d=1, p=1) 
PCI: Sorting device list... 


cat /proc/interrupts 
           CPU0       
  0:    1287229          XT-PIC  timer
  1:       7420          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:       2968          XT-PIC  serial
  5:     340237          XT-PIC  Ricoh Co Ltd RL5c478, usb-ohci,
EMU10K1, ohci1394
  9:      25372          XT-PIC  acpi, eth0
 10:     116280          XT-PIC  Ricoh Co Ltd RL5c478 (#2), usb-ohci
 11:         14          XT-PIC  usb-ohci
 12:         22          XT-PIC  PS/2 Mouse
 14:     188012          XT-PIC  ide0
 15:         47          XT-PIC  ide1


Here's IRQ related info from dmesg: 

Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled 
IRQ for 00:14.1:1 -> PIRQ 57, mask def8, excl 0000 -> newirq=10 ->
assigning IRQ 10 ... OK 
PCI: Assigned IRQ 10 for device 00:14.1 
IRQ routing conflict for 00:11.2, have irq 9, want irq 10 
IRQ routing conflict for 00:13.0, have irq 9, want irq 10 
IRQ for 00:14.0:0 -> PIRQ d6, mask def8, excl 0000 -> newirq=5 ->
assigning IRQ 5 ... OK 
PCI: Assigned IRQ 5 for device 00:14.0 
PCI: Sharing IRQ 5 with 00:11.1 
PCI: Sharing IRQ 5 with 00:12.0 
Yenta IRQ list 0000, PCI irq10 
Yenta IRQ list 0000, PCI irq5 
IRQ for 02:00.0:0 -> not found in routing table 
IRQ for 00:07.4:3 -> PIRQ d7, mask def8, excl 0000 -> newirq=10 ->
assigning IRQ 10 ... OK 
PCI: Assigned IRQ 10 for device 00:07.4 
usb-ohci.c: USB OHCI at membase 0xd2868000, IRQ 10 
IRQ for 00:11.1:1 -> PIRQ d6, mask def8, excl 0000 -> newirq=5 ->
assigning IRQ 5 ... OK 
PCI: Assigned IRQ 5 for device 00:11.1 
PCI: Sharing IRQ 5 with 00:12.0 
PCI: Sharing IRQ 5 with 00:14.0 
usb-ohci.c: USB OHCI at membase 0xd286a000, IRQ 5 
IRQ for 00:11.0:0 -> PIRQ 56, mask def8, excl 0000 -> newirq=11 ->
assigning IRQ 11 ... OK 
PCI: Assigned IRQ 11 for device 00:11.0 
PCI: Sharing IRQ 11 with 00:0f.0 
PCI: Sharing IRQ 11 with 01:05.0 
usb-ohci.c: USB OHCI at membase 0xd286c000, IRQ 11 
IRQ for 00:0f.0:0 -> PIRQ 56, mask def8, excl 0000 -> newirq=11 ->
assigning IRQ 11 ... OK 
PCI: Assigned IRQ 11 for device 00:0f.0 
PCI: Sharing IRQ 11 with 00:11.0 
PCI: Sharing IRQ 11 with 01:05.0 
IRQ for 00:0f.0:0 -> PIRQ 56, mask def8, excl 0000 -> newirq=11 ->
assigning IRQ 11 ... OK 
PCI: Assigned IRQ 11 for device 00:0f.0 
PCI: Sharing IRQ 11 with 00:11.0 
PCI: Sharing IRQ 11 with 01:05.0 
IRQ for 00:13.0:0 -> PIRQ 57, mask def8, excl 0000 -> newirq=9 ->
assigning IRQ 9 ... OK 
PCI: Assigned IRQ 9 for device 00:13.0 
PCI: Sharing IRQ 9 with 00:11.2 
IRQ routing conflict for 00:14.1, have irq 10, want irq 9 
IRQ for 00:12.0:0 -> PIRQ d6, mask def8, excl 0000 -> newirq=5 ->
assigning IRQ 5 ... OK 
PCI: Assigned IRQ 5 for device 00:12.0 
PCI: Sharing IRQ 5 with 00:11.1 
PCI: Sharing IRQ 5 with 00:14.0 
emu10k1: EMU10K1 rev 7 model 0x8031 found, IO at 0xff80-0xff9f, IRQ 5 
IRQ for 02:00.0:0 -> not found in routing table
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[5]  MMIO=[11000000-11001000]  Max
Packet=[1024]
ohci1394_0: irq_handler: Bus reset requested


lspci -vx: 

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate]
System Controller (rev 25) 
Flags: bus master, medium devsel, latency 64 
Memory at f8000000 (32-bit, prefetchable) [size=64M] 
Memory at fc9ff000 (32-bit, prefetchable) [size=4K] 
I/O ports at ffe4 [disabled] [size=4] 
Capabilities: [a0] AGP version 1.0 
00: 22 10 06 70 06 01 10 22 25 00 00 06 00 40 80 00 
10: 08 00 00 f8 08 f0 9f fc e5 ff 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00 

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP
Bridge (rev 01) (prog-if 00 [Normal decode]) 
Flags: bus master, 66Mhz, medium devsel, latency 64 
Bus: primary=00, secondary=01, subordinate=01, sec-latency=64 
I/O behind bridge: 0000e000-0000efff 
Memory behind bridge: fca00000-feafffff 
Prefetchable memory behind bridge: e4800000-f48fffff 
00: 22 10 07 70 07 01 20 02 01 00 04 06 00 40 81 00 
10: 00 00 00 00 00 00 00 00 00 01 01 40 e1 e1 20 22 
20: a0 fc a0 fe 80 e4 80 f4 00 00 00 00 00 00 00 00 
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a 00 

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA
(rev 01) 
Flags: bus master, medium devsel, latency 0 
00: 22 10 08 74 0f 00 00 02 01 00 01 06 00 00 80 00 
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE
(rev 03) (prog-if 8a [Master SecP PriP]) 
Flags: bus master, medium devsel, latency 64 
I/O ports at cb00 [size=16] 
00: 22 10 09 74 05 00 00 02 03 8a 01 01 00 40 00 00 
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
20: 01 cb 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev
03) 
Flags: medium devsel 
00: 22 10 0b 74 00 00 80 02 03 00 80 06 00 16 00 00 
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] USB
(rev 06) (prog-if 10 [OHCI]) 
Flags: bus master, medium devsel, latency 16, IRQ 10 
Memory at febfe000 (32-bit, non-prefetchable) [size=4K] 
00: 22 10 0c 74 07 00 80 02 06 10 03 0c 08 10 00 00 
10: 00 e0 bf fe 00 00 00 00 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 04 00 50 

00:0f.0 SCSI storage controller: Adaptec AHA-2930CU (rev 03) 
Subsystem: Adaptec: Unknown device 3869 
Flags: bus master, medium devsel, latency 64, IRQ 11 
I/O ports at f800 [disabled] [size=256] 
Memory at febff000 (32-bit, non-prefetchable) [size=4K] 
Expansion ROM at febe0000 [disabled] [size=64K] 
Capabilities: [dc] Power Management version 1 
00: 04 90 60 38 16 01 90 02 03 00 00 01 08 40 00 00 
10: 01 f8 00 00 00 f0 bf fe 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 04 90 69 38 
30: 00 00 be fe dc 00 00 00 00 00 00 00 0b 01 04 04 

00:11.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
Subsystem: NEC Corporation USB 
Flags: bus master, medium devsel, latency 40, IRQ 11 
Memory at febfb000 (32-bit, non-prefetchable) [size=4K] 
Capabilities: [40] Power Management version 2 
00: 33 10 35 00 16 01 10 02 41 10 03 0c 08 28 80 00 
10: 00 b0 bf fe 00 00 00 00 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 33 10 35 00 
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 01 2a 

00:11.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
Subsystem: NEC Corporation USB 
Flags: bus master, medium devsel, latency 40, IRQ 5 
Memory at febfc000 (32-bit, non-prefetchable) [size=4K] 
Capabilities: [40] Power Management version 2 
00: 33 10 35 00 16 01 10 02 41 10 03 0c 08 28 00 00 
10: 00 c0 bf fe 00 00 00 00 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 33 10 35 00 
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 02 01 2a 

00:11.2 USB Controller: NEC Corporation: Unknown device 00e0 (rev 01)
(prog-if 20) 
Subsystem: NEC Corporation: Unknown device 00e0 
Flags: bus master, medium devsel, latency 64, IRQ 9 
Memory at febfdf00 (32-bit, non-prefetchable) [size=256] 
Capabilities: [40] Power Management version 2 
00: 33 10 e0 00 16 01 10 02 01 20 03 0c 08 40 00 00 
10: 00 df bf fe 00 00 00 00 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 33 10 e0 00 
30: 00 00 00 00 40 00 00 00 00 00 00 00 09 03 10 22 

00:12.0 Multimedia audio controller: Creative Labs SB Live! EMU10000
(rev 07) 
Subsystem: Creative Labs CT4831 SBLive! Value 
Flags: bus master, medium devsel, latency 64, IRQ 5 
I/O ports at ff80 [size=32] 
Capabilities: [dc] Power Management version 1 
00: 02 11 02 00 05 01 90 02 07 00 01 04 00 40 80 00 
10: 81 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 31 80 
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 02 14 

00:12.1 Input device controller: Creative Labs SB Live! (rev 07) 
Subsystem: Creative Labs Gameport Joystick 
Flags: bus master, medium devsel, latency 64 
I/O ports at fff0 [size=8] 
Capabilities: [dc] Power Management version 1 
00: 02 11 02 70 05 01 90 02 07 00 80 09 00 40 80 00 
10: f1 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 20 00 
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 00 00 

00:13.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 78) 
Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management
NIC 
Flags: bus master, medium devsel, latency 64, IRQ 9 
I/O ports at fc00 [size=128] 
Memory at febfde80 (32-bit, non-prefetchable) [size=128] 
Expansion ROM at febc0000 [disabled] [size=128K] 
Capabilities: [dc] Power Management version 2 
00: b7 10 00 92 17 01 10 02 78 00 00 02 08 40 00 00 
10: 01 fc 00 00 80 de bf fe 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 00 10 
30: 00 00 bc fe dc 00 00 00 00 00 00 00 09 01 0a 0a 

00:14.0 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 03) 
Flags: bus master, medium devsel, latency 168, IRQ 5 
Memory at 10000000 (32-bit, non-prefetchable) [size=4K] 
Bus: primary=00, secondary=02, subordinate=05, sec-latency=176 
Memory window 0: 10c00000-10fff000 (prefetchable) 
Memory window 1: 11000000-113ff000 
I/O window 0: 00004800-000048ff 
I/O window 1: 00004c00-00004cff 
16-bit legacy interface ports at 0001 
00: 80 11 78 04 07 00 10 02 03 00 07 06 00 a8 82 00 
10: 00 00 00 10 dc 00 00 22 00 02 05 b0 00 00 c0 10 
20: 00 f0 ff 10 00 00 00 11 00 f0 3f 11 00 48 00 00 
30: fc 48 00 00 00 4c 00 00 fc 4c 00 00 00 01 00 05 
40: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 

00:14.1 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 03) 
Flags: bus master, medium devsel, latency 168, IRQ 10 
Memory at 10001000 (32-bit, non-prefetchable) [size=4K] 
Bus: primary=00, secondary=06, subordinate=09, sec-latency=176 
Memory window 0: 10400000-107ff000 (prefetchable) 
Memory window 1: 10800000-10bff000 
I/O window 0: 00004000-000040ff 
I/O window 1: 00004400-000044ff 
16-bit legacy interface ports at 0001 
00: 80 11 78 04 07 00 10 02 03 00 07 06 00 a8 82 00 
10: 00 10 00 10 dc 00 00 02 00 06 09 b0 00 00 40 10 
20: 00 f0 7f 10 00 00 80 10 00 f0 bf 10 00 40 00 00 
30: fc 40 00 00 00 44 00 00 fc 44 00 00 00 02 80 05 
40: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 

01:05.0 VGA compatible controller: nVidia Corporation GeForce 256 DDR
(rev 10) (prog-if 00 [VGA]) 
Subsystem: VISIONTEK: Unknown device 000b 
Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11 
Memory at fd000000 (32-bit, non-prefetchable) [size=16M] 
Memory at e8000000 (32-bit, prefetchable) [size=128M] 
Expansion ROM at feaf0000 [disabled] [size=64K] 
Capabilities: [60] Power Management version 1 
Capabilities: [44] AGP version 2.0 
00: de 10 01 01 07 00 b0 02 10 00 00 03 00 40 00 00 
10: 00 00 00 fd 08 00 00 e8 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 45 15 0b 00 
30: 00 00 af fe 60 00 00 00 00 00 00 00 0b 01 05 01 

02:00.0 FireWire (IEEE 1394): NEC Corporation: Unknown device 00cd (rev
01) (prog-if 10 [OHCI]) 
Subsystem: Orange Micro: Unknown device 8011 
Flags: medium devsel, IRQ 5 
Memory at 11000000 (32-bit, non-prefetchable) [size=4K] 
Memory at 11001000 (32-bit, non-prefetchable) [size=256] 
Memory at 11001100 (32-bit, non-prefetchable) [size=256] 
Capabilities: [60] Power Management version 1 
00: 33 10 cd 00 02 00 90 02 01 10 00 0c 00 00 00 00 
10: 00 00 00 11 00 10 00 11 00 11 00 11 00 00 00 00 
20: 00 00 00 00 00 00 00 00 80 00 00 00 ee 12 11 80 
30: 00 00 00 00 60 00 00 00 00 00 00 00 05 01 00 00 

