Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSI3WkT>; Mon, 30 Sep 2002 18:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261372AbSI3WkT>; Mon, 30 Sep 2002 18:40:19 -0400
Received: from pcp01178485pcs.shlb1201.mi.comcast.net ([68.60.228.127]:16549
	"EHLO hytron.hytron.net") by vger.kernel.org with ESMTP
	id <S261371AbSI3WkR>; Mon, 30 Sep 2002 18:40:17 -0400
Date: Mon, 30 Sep 2002 18:45:43 -0400 (EDT)
From: Darko <hytron@hytron.net>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with IO/APIC
Message-ID: <Pine.LNX.4.33.0209301832260.24035-100000@hytron.hytron.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone!

I am having some problems to get APIC to work. My system is running linux
kernel v2.4.19 compiled for uniprocessor with APIC enabled. The CPU is AMD
XP 1600+ and motherboard MSI with north bridge KT133A, and south bridge
VT82C686B). On VIA's web site, they show APIC integrated in the south
bridge. My BIOS offeres two features:
- Use APIC - this is enabled
- MPS version control for OS - this is set to 1.1, but it should not
effect in any way, since this is a uniprocessor sistem, right?

The system boots just fine, but I have same IRQs that are shared among
devices. Here is the /proc/interrupts
           CPU0
  0:      25475    IO-APIC-edge  timer
  1:          3    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
 10:       1153   IO-APIC-level  via82cxxx, eth0
 11:       2796   IO-APIC-level  ide2, ide3
 12:          0    IO-APIC-edge  PS/2 Mouse
 14:       2441    IO-APIC-edge  ide0
 15:       2879    IO-APIC-edge  ide1
NMI:          0
LOC:      25428
ERR:          0
MIS:          0

I am not sure if this means that it is currently using the APIC or not,
but I can never get IRQs 16-23 to get assigned to any of the cards. I
tried using pirq= , but still doesn't work Here is part from dmesg that
gives some info:

Linux version 2.4.20-pre8 (root@commodore) (gcc version 2.95.3 20010315
(release)) #4 Mon Sep 30 18:21:27 EDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
256MB LOWMEM available.
found SMP MP-table at 000f5ec0
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 1
Kernel command line: auto BOOT_IMAGE=Linux ro root=900 hda=4865,255,63
hdc=4865,255,63 hde=4865,255,63 pirq=5,11,10
ide_setup: hda=4865,255,63
ide_setup: hdc=4865,255,63
ide_setup: hde=4865,255,63
PIRQ redirection, working around broken MP-BIOS.
... PIRQ0 -> IRQ 5
... PIRQ1 -> IRQ 11
... PIRQ2 -> IRQ 10
Initializing CPU#0
Detected 1394.448 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2778.72 BogoMIPS
Memory: 256580k/262144k available (1361k kernel code, 5176k reserved, 593k
data, 96k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU: AMD Athlon(tm) XP 1600+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23
not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
......
......
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1394.4818 MHz.
..... host bus clock speed is 265.6156 MHz.
cpu: 0, clocks: 2656156, slice: 1328078
CPU0<T0:2656144,T1:1328064,D:2,S:1328078,C:2656156>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb240, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA southbridge workaround.
PCI: Enabling Via external APIC routing





Does anyone have any ideas what might be the problem? Thanks for all the
help!!!

Darko

