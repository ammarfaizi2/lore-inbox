Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265877AbTGDIfZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 04:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265878AbTGDIfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 04:35:25 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:55313 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265877AbTGDIfD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 04:35:03 -0400
Message-ID: <3F054109.2050100@aitel.hist.no>
Date: Fri, 04 Jul 2003 10:55:37 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1 fails to boot due to APIC trouble, 2.5.73mm3 works.
References: <20030703023714.55d13934.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.74-mm1 dies very early during bootup due to some APIC trouble:
(written down by hand)
Posix conformance testing by UNIFIX
enabled Extint on cpu #0
ESR before enabling vector 00000000
ESR after enabling vector 00000000
Enabling IP-APIC IRQs
BIOS bug, IO-APIC #0 ID2 is already used!...
kernel panic: Max APIC ID exceeded!



Here is the corresponding log for 2.5.73mm3
(pasted from dmesg)
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
  IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-11, 2-17, 2-19 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 22.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178014
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0014
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
  00 000 00  1    0    0   0   0    0    0    00
  01 001 01  0    0    0   0   0    1    1    39
  02 001 01  0    0    0   0   0    1    1    31
  03 001 01  0    0    0   0   0    1    1    41
  04 001 01  0    0    0   0   0    1    1    49
  05 000 00  1    0    0   0   0    0    0    00
  06 001 01  0    0    0   0   0    1    1    51
  07 001 01  0    0    0   0   0    1    1    59
  08 001 01  0    0    0   0   0    1    1    61
  09 000 00  1    0    0   0   0    0    0    00
  0a 001 01  0    0    0   0   0    1    1    69
  0b 000 00  1    0    0   0   0    0    0    00
  0c 001 01  0    0    0   0   0    1    1    71
  0d 001 01  0    0    0   0   0    1    1    79
  0e 001 01  0    0    0   0   0    1    1    81
  0f 001 01  0    0    0   0   0    1    1    89
  10 001 01  1    1    0   1   0    1    1    91
  11 000 00  1    0    0   0   0    0    0    00
  12 001 01  1    1    0   1   0    1    1    99
  13 000 00  1    0    0   0   0    0    0    00
  14 001 01  1    1    0   1   0    1    1    A1
  15 001 01  1    1    0   1   0    1    1    A9
  16 001 01  1    1    0   1   0    1    1    B1
  17 001 01  1    1    0   1   0    1    1    B9

IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ10 -> 0:10
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ18 -> 0:18
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2390.3168 MHz.
..... host bus clock speed is 132.7952 MHz.
mtrr: v2.0 (20020519)


Seems the kernel wants to use APIC ID2, but
2.5.74 claims the BIOS used it up?



Some more APIC related info from 2.5.73mm3 dmesg:
511MB LOWMEM available.
found SMP MP-table at 000f5670
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 131056
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 126960 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
Intel MultiProcessor Specification v1.4
     Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 15:2 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1


lspci output, in case it matters:
00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS645DX Host & 
Memory & AGP Controller
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual 
PCI-to-PCI bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 04)
00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] 
SiS7012 PCI Audio Accelerator (rev a0)
00:03.0 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB 
Controller (rev 0f)
00:03.1 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB 
Controller (rev 0f)
00:03.2 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB 
Controller (rev 0f)
00:03.3 USB Controller: Silicon Integrated Systems [SiS] SiS7002 USB 2.0
00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
(rev 78)
00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY 
[Radeon 7000/VE]

This is a desktop P4 with 512M. The kernel is a UP kernel.

Helge Hafting

