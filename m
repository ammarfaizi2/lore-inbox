Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317376AbSGDIqc>; Thu, 4 Jul 2002 04:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317378AbSGDIqb>; Thu, 4 Jul 2002 04:46:31 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:19842 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S317376AbSGDIq2>; Thu, 4 Jul 2002 04:46:28 -0400
Message-Id: <200207040848.g648mrm03698@verdi.et.tudelft.nl>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
X-Exmh-Isig-CompType: repl
X-Exmh-Isig-Folder: linux-kernel
To: torvalds@transmeta.com (Linus Torvalds)
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: Cyrix IRQ routing is wrong? 
In-Reply-To: Your message of "Thu, 04 Jul 2002 00:36:27 -0000."
             <ag05ab$1gc$1@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Thu, 04 Jul 2002 10:48:53 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Linus wrote:
> I don't have any good "dump_pirq" dumps from Cyrix chips, so it's hard
> to get better guesses. People with Cyrix routers should probably send me
> (and cc Jeff Garzik) the output from dump_pirq _and_ the output from
> "lspci -vxxx ; cat /proc/interrupts" (the latter so that the actual
> mappings and the router entries are visible).

I just fell in the middle of this thread and don't exactly know what it's
all about.  but I do have a Geode base board available.  So here is my
info.  Please contact me if you want to know more !

	Greetings,
	Rob van Nieuwkerk

PS: anyone else seeing screen corruption in console/text mode with these
    boards ? (some chracters from before a screen update stay on the screen).


board:
------
Axiom Technology, SBC84510VEE, 3.5" Capa board, 300 MHz Geode


kernel:
-------
standard RH 7.3 update (2.4.18-5)


maybe relevant boot messages:
-----------------------------
Jul  4 10:03:35 ravel kernel: 8139too Fast Ethernet driver 0.9.24
Jul  4 10:03:35 ravel kernel: PCI: Found IRQ 11 for device 00:0e.0
Jul  4 10:03:35 ravel kernel: IRQ routing conflict for 00:0e.0, have irq 10, want irq 11
Jul  4 10:03:35 ravel kernel: eth0: RealTek RTL8139 Fast Ethernet at 0xc4869000, 00:60:e0:01:98:00, IRQ 10
Jul  4 10:03:35 ravel kernel: PCI: Assigned IRQ 5 for device 00:0f.0
Jul  4 10:03:35 ravel kernel: eth1: RealTek RTL8139 Fast Ethernet at 0xc486b000, 00:60:e0:01:97:ff, IRQ 5


dump_pirq output:
-----------------
Interrupt routing table found at address 0xfd9e0:
  Version 1.0, size 0x0050
  Interrupt router is device 00:12.0
  PCI exclusive interrupt mask: 0x0c20 [5,10,11]
  Compatible router: vendor 0x1078 device 0x0002

Device 00:0e.0 (slot 1): Ethernet controller
  INTA: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x04, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:0f.0 (slot 2): Ethernet controller
  INTA: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x04, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:13.0 (slot 0): USB Controller
  INTA: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Interrupt router at 00:12.0: CYRIX 5530 PCI-to-ISA bridge
  PIRQ (link 0x01): irq 11
  PIRQ (link 0x02): irq 10
  PIRQ (link 0x03): irq 5
  PIRQ (link 0x04): irq 5


cat /proc/cpuinfo:
------------------
processor       : 0
vendor_id       : CyrixInstead
cpu family      : 5
model           : 9
model name      : Geode(TM) Integrated Processor by National Semi
stepping        : 1
cpu MHz         : 300.681
cache size      : 16 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu tsc msr cx8 cmov mmx cxmmx
bogomips        : 599.65


cat /proc/interrupts:
---------------------
           CPU0       
  0:     239687          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
 10:       4651          XT-PIC  eth0
 11:        347          XT-PIC  usb-ohci
 14:      19932          XT-PIC  ide0
NMI:          0 
ERR:          0


lspci -vxxx:
------------
00:00.0 Host bridge: Cyrix Corporation PCI Master
	Flags: bus master, medium devsel, latency 0
00: 78 10 01 00 07 00 80 02 00 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 1e 14 00 c1 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at e000 [size=256]
	Memory at d1000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Vital Product Data
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 20 00 00
10: 01 e0 00 00 00 00 00 d1 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 20 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 60 c2 f7 00 00 00 00 00 00 00 00 00 00 00 00
60: 03 00 ff ff ff fe ff ff 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at e400 [size=256]
	Memory at d1001000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 20 00 00
10: 01 e4 00 00 00 10 00 d1 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 01 20 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 f7 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:12.0 ISA bridge: Cyrix Corporation 5530 Legacy [Kahlua] (rev 30)
	Flags: bus master, medium devsel, latency 0
00: 78 10 00 01 1f 00 80 02 30 00 01 06 04 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 81 50 ce 45 01 00 00 00 00 00 00 00 00 00 00 00
50: 7b 10 e8 0b 00 00 00 00 00 00 03 08 ab 55 01 00
60: 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 07 00 00 0e 00 00 00 00 00 00 01 08 00 00 01 00
90: 00 0c 10 f0 00 00 00 00 04 00 04 00 04 00 02 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 04 00 00 00
b0: 00 00 00 00 0c 02 a2 08 40 07 12 0c 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:12.1 Bridge: Cyrix Corporation 5530 SMI [Kahlua]
	Flags: medium devsel
	Memory at 40012000 (32-bit, non-prefetchable) [size=256]
00: 78 10 01 01 02 00 80 02 00 00 80 06 00 00 00 00
10: 00 20 01 40 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 7b 10 e8 0b 00 00 00 00 00 00 03 08 ab 55 01 00
60: 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 07 00 00 0e 00 00 00 00 00 00 01 08 00 00 01 00
90: 00 0c 10 f0 00 00 00 00 04 00 04 00 04 00 02 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 04 00 00 00
b0: 00 00 00 00 0c 02 a2 08 00 01 2e 0c 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:12.2 IDE interface: Cyrix Corporation 5530 IDE [Kahlua] (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 0
	I/O ports at f000 [size=16]
00: 78 10 02 01 05 00 80 02 00 80 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 7b 10 e8 0b 00 00 00 00 00 00 03 08 ab 55 01 00
60: 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 07 00 00 0e 00 00 00 00 00 00 01 08 00 00 01 00
90: 00 0c 10 f0 00 00 00 00 04 00 04 00 04 00 02 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 04 00 00 00
b0: 00 00 00 00 0c 02 a2 08 ef 04 9c 0c 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:12.3 Multimedia audio controller: Cyrix Corporation 5530 Audio [Kahlua]
	Flags: bus master, medium devsel, latency 0
	Memory at 40011000 (32-bit, non-prefetchable) [size=128]
00: 78 10 03 01 06 00 80 02 00 00 01 04 00 00 00 00
10: 00 10 01 40 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 7b 10 e8 0b 00 00 00 00 00 00 03 08 ab 55 01 00
60: 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 07 00 00 0e 00 00 00 00 00 00 01 08 00 00 01 00
90: 00 0c 10 f0 00 00 00 00 04 00 04 00 04 00 02 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 04 00 00 00
b0: 00 00 00 00 0c 02 a2 08 43 20 b0 0c 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:12.4 VGA compatible controller: Cyrix Corporation 5530 Video [Kahlua] (prog-if 00 [VGA])
	Subsystem: Cyrix Corporation: Unknown device 0001
	Flags: medium devsel
	Memory at 40800000 (32-bit, non-prefetchable) [size=8M]
00: 78 10 04 01 03 00 80 02 00 00 00 03 00 00 80 02
10: 00 00 80 40 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 78 10 01 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:13.0 USB Controller: Compaq Computer Corporation ZFMicro Chipset USB (rev 06) (prog-if 10 [OHCI])
	Subsystem: Compaq Computer Corporation ZFMicro Chipset USB
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at d1005000 (32-bit, non-prefetchable) [size=4K]
00: 11 0e f8 a0 07 00 80 02 06 10 03 0c 08 20 00 00
10: 00 50 00 d1 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e f8 a0
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 50
40: 00 00 0f 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
