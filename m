Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129344AbRCBRZp>; Fri, 2 Mar 2001 12:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129346AbRCBRZf>; Fri, 2 Mar 2001 12:25:35 -0500
Received: from balu.sch.bme.hu ([152.66.224.40]:41948 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S129344AbRCBRZ0>;
	Fri, 2 Mar 2001 12:25:26 -0500
Date: Fri, 2 Mar 2001 18:25:15 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Chaskiel M Grundman <cg2v+@andrew.cmu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: APIC error on CPU0 (UP APIC kernel)
In-Reply-To: <subjzA1z0001Q6c7QE@andrew.cmu.edu>
Message-ID: <Pine.GSO.4.30.0103021820520.13932-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having similar messages, about 2-3 per day.
So far I saw these variants:

APIC error on CPU0: 00(04)
APIC error on CPU0: 00(02)
APIC error on CPU0: 02(02)
APIC error on CPU0: 02(04)
APIC error on CPU0: 04(02)

This is a Abit VP6, with 1 Celeron 433(66).
(machine passes memtest).

What does this mean?

Note that everything seems to go on fine, no hangups etc.

Balazs Pozsar.


On Thu, 1 Mar 2001, Chaskiel M Grundman wrote:

> I have some single-processr Dell Poweredge 2450 servers that I'm trying
> to move to 2.4. They have been running 2.2 SMP kernels for a while with
> no problem (to take advantage of the supposed benefit of using the
> ioapic).
>
> 2.4 SMP kernels seem to work fine, but using a 2.4.1 or 2.4.2 UP kernel
> with CONFIG_X86_UP_IOAPIC does not. At some point before the real root
> filesystem is mounted, the system begins spewing
>
> APIC error on CPU0: 08(08)
>
> at a high rate and eventually either locks up, or is killed by the
> watchdog nmi (at which point control-alt-delete _works_)
>
> 2450's use a serverworks chipset. I don't know what other information
> might be useful...
>
> Here's an excerpt of the SMP 2.4.2 dmesg output, in case it's of any use:
>
> ENABLING IO-APIC IRQs
> ...changing IO-APIC physical APIC ID to 1 ... ok.
> ...changing IO-APIC physical APIC ID to 2 ... ok.
> Synchronizing Arb IDs.
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 1-0, 1-2, 1-3, 1-5, 1-10, 1-11, 1-13, 2-3, 2-8,
> 2-9, 2-10,
>  2-11, 2-12, 2-13 not connected.
> ..TIMER: vector=49 pin1=-1 pin2=0
> ...trying to set up timer (IRQ0) through the 8259..... (found pin 0) ...works.
> activating NMI Watchdog ... done.
> number of MP IRQ sources: 27.
> number of IO-APIC #1 registers: 16.
> number of IO-APIC #2 registers: 16.
> testing the IO APIC.......................
>
> IO APIC #1......
> .... register #00: 01000000
> .......    : physical APIC id: 01
> .... register #01: 000F0011
> .......     : max redirection entries: 000F
> .......     : IO APIC version: 0011
> .... register #02: 00000000
> .......     : arbitration: 00
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>  00 001 01  0    0    0   0   0    1    1    31
>  01 001 01  0    0    0   0   0    1    1    39
>  02 000 00  1    0    0   0   0    0    0    00
>  03 000 00  1    0    0   0   0    0    0    00
>  04 001 01  0    0    0   0   0    1    1    41
>  05 000 00  1    0    0   0   0    0    0    00
>  06 001 01  0    0    0   0   0    1    1    49
>  07 001 01  0    0    0   0   0    1    1    51
>  08 001 01  0    0    0   0   0    1    1    59
>  09 001 01  0    0    0   0   0    1    1    61
>  0a 000 00  1    0    0   0   0    0    0    00
>  0b 000 00  1    0    0   0   0    0    0    00
>  0c 001 01  0    0    0   0   0    1    1    69
>  0d 000 00  1    0    0   0   0    0    0    00
>  0e 001 01  0    0    0   0   0    1    1    71
>  0f 001 01  0    0    0   0   0    1    1    79
> IO APIC #2......
> .... register #00: 02000000
> .......    : physical APIC id: 02
> .... register #01: 000F0011
> .......     : max redirection entries: 000F
> .......     : IO APIC version: 0011
> .... register #02: 02000000
> .......     : arbitration: 02
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>  00 001 01  1    1    0   1   0    1    1    81
>  01 001 01  1    1    0   1   0    1    1    89
>  02 001 01  1    1    0   1   0    1    1    91
>  03 000 00  1    0    0   0   0    0    0    00
>  04 001 01  1    1    0   1   0    1    1    99
>  05 001 01  1    1    0   1   0    1    1    A1
>  06 001 01  1    1    0   1   0    1    1    A9
>  07 001 01  1    1    0   1   0    1    1    B1
>  08 000 00  1    0    0   0   0    0    0    00
>  09 000 00  1    0    0   0   0    0    0    00
>  0a 000 00  1    0    0   0   0    0    0    00
>  0b 000 00  1    0    0   0   0    0    0    00
>  0c 000 00  1    0    0   0   0    0    0    00
>  0d 000 00  1    0    0   0   0    0    0    00
>  0e 001 01  1    1    0   1   0    1    1    B9
>  0f 001 01  1    1    0   1   0    1    1    C1
> IRQ to pin mappings:
> IRQ1 -> 1
> IRQ4 -> 4
> IRQ6 -> 6
> IRQ7 -> 7
> IRQ8 -> 8
> IRQ9 -> 9
> IRQ12 -> 12
> IRQ14 -> 14
> IRQ15 -> 15
> IRQ16 -> 0
> IRQ17 -> 1
> IRQ18 -> 2
> IRQ20 -> 4
> IRQ21 -> 5
> IRQ22 -> 6
> IRQ23 -> 7
> IRQ30 -> 14
> IRQ31 -> 15
> .................................... done.
> calibrating APIC timer ...
> ..... CPU clock speed is 731.0440 MHz.
> ..... host bus clock speed is 132.9169 MHz.
> cpu: 0, clocks: 1329169, slice: 664584
> CPU0<T0:1329168,T1:664576,D:8,S:664584,C:1329169>
> Setting commenced=1, go go go
> PCI: PCI BIOS revision 2.10 entry at 0xfc79e, last bus=3
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: ServerWorks host bridge: last bus ff
> Unknown bridge resource 0: assuming transparent
> Unknown bridge resource 1: assuming transparent
> Unknown bridge resource 2: assuming transparent
> Unknown bridge resource 0: assuming transparent
> Unknown bridge resource 1: assuming transparent
> Unknown bridge resource 2: assuming transparent
> PCI: Discovered primary peer bus 02 [IRQ]
> PCI: Using IRQ router ServerWorks [1166/0200] at 00:0f.0
> PCI->APIC IRQ transform: (B0,I2,P0) -> 20
> PCI->APIC IRQ transform: (B0,I8,P0) -> 22
> PCI->APIC IRQ transform: (B2,I8,P0) -> 16
> [...]
> ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
> ServerWorks OSB4: chipset revision 0
> ServerWorks OSB4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x08b0-0x08b7, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0x08b8-0x08bf, BIOS settings: hdc:pio, hdd:pio
> hda: TOSHIBA CD-ROM XM-7002B, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> [...]
> VFS: Mounted root (ext2 filesystem).
> SCSI subsystem driver Revision: 1.00
> kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
> megaraid: v107 (December 22, 1999)
> megaraid: found 0x8086:0x1960: in 00:02.1
> scsi0 : Found a MegaRAID controller at 0xf8820000, IRQ: 20
> megaraid: [1.01:1p00] detected 1 logical drives
> [..]
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

