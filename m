Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbTFXWEf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 18:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbTFXWEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 18:04:35 -0400
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:8452 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP id S262830AbTFXWEH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 18:04:07 -0400
Date: Wed, 25 Jun 2003 00:18:09 +0200
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] MS-6368L ACPI IRQ problem still in 2.4.21
Message-ID: <20030624221809.GA1805@alf.amelek.gda.pl>
References: <20030623221541.GA8096@alf.amelek.gda.pl> <20030623222311.GD25982@parcelfarce.linux.theplanet.co.uk> <20030624054612.GA20235@alf.amelek.gda.pl> <20030624112630.GB451@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030624112630.GB451@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 12:26:30PM +0100, Matthew Wilcox wrote:
> The ACPI code in 2.4.21 is something like 18 months old now.  It's
> basically unmaintainable.  Fortunately, 2.4.22 should have an ACPI update.

I've just tried 2.4.21 with the acpi-20030619-2.4.21 patch, and
it made things worse - Power button not working even if ACPI shares
an IRQ with other devices.  Also tried "pci=noacpi" as suggested
by the boot messages - didn't help, and RTL8139 stopped working too
(transmit timeouts).

Anyway, back to vanilla 2.4.21 for now (production machine, can't
experiment too much) with my "set IRQ9 as Legacy ISA" workaround -
see below for the relevant boot messages.

I've just found this message (with a patch), it was about ACPI IRQ
in a VAIO laptop - I'm wondering if this could be the same problem?

http://www.ussg.iu.edu/hypermail/linux/kernel/0201.2/0435.html

Thanks,
Marek


Linux version 2.4.21 (marekm@seler) (gcc version 2.95.4 20011002 (Debian prerelease)) #5 Fri Jun 20 21:27:08 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007df0000 (usable)
 BIOS-e820: 0000000007df0000 - 0000000007df3000 (ACPI NVS)
 BIOS-e820: 0000000007df3000 - 0000000007e00000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
125MB LOWMEM available.
found SMP MP-table at 000f6430
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 32240
zone(0): 4096 pages.
zone(1): 28144 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 1
Kernel command line: root=/dev/hda8 ro console=tty1 console=ttyS0,9600n8 panic=60 apm=off
Initializing CPU#0
Detected 1002.297 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1998.84 BogoMIPS
Memory: 123512k/128960k available (2312k kernel code, 5064k reserved, 874k data, 140k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel(R) Celeron(TM) CPU                1000MHz stepping 01
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
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 21.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  1    1    0   1   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  1    1    0   1   0    1    1    79
 0b 001 01  1    1    0   1   0    1    1    81
 0c 001 01  1    1    0   1   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
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
..... CPU clock speed is 1002.3204 MHz.
..... host bus clock speed is 100.2320 MHz.
cpu: 0, clocks: 1002320, slice: 501160
CPU0<T0:1002320,T1:501152,D:8,S:501160,C:1002320>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb530, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 11
PCI->APIC IRQ transform: (B0,I7,P3) -> 11
PCI->APIC IRQ transform: (B0,I7,P2) -> 12
PCI->APIC IRQ transform: (B0,I8,P0) -> 10
PCI->APIC IRQ transform: (B0,I9,P0) -> 5
PCI->APIC IRQ transform: (B0,I14,P0) -> 11
PCI->APIC IRQ transform: (B1,I0,P0) -> 10
PCI: Enabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
...
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1 C2
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
ACPI: Sleep Button (CM) found

