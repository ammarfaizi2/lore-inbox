Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBVBdZ>; Wed, 21 Feb 2001 20:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129381AbRBVBdE>; Wed, 21 Feb 2001 20:33:04 -0500
Received: from dfw-smtpout3.email.verio.net ([129.250.36.43]:50060 "EHLO
	dfw-smtpout3.email.verio.net") by vger.kernel.org with ESMTP
	id <S129170AbRBVBc4>; Wed, 21 Feb 2001 20:32:56 -0500
Message-ID: <3A931AD8.53FD2EA1@nospam.org>
Date: Tue, 20 Feb 2001 17:33:12 -0800
From: Tim Moore <notArealAddress@nospam.org>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19pre8+IDE i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.17 Lockup and ATA-66/100 forced bit set (WARNING)
In-Reply-To: <20010221173439.A3178@angus.foo.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've enabled the higher performance features for my ATA drive by getting
> 2.2.17, applying Andre Hendrick's IDE patch, adding: 
>   append="idebus=66 ide0=ata66"
> to lilo.conf. I was told that Alan's patches from here:
> should be used. Is this true if I used Andre's patch? Is the warning
> message in my bootlog anything to worry about? The board is an ABIT KT7A
> w/ KT133A chipset.

Alan = kernel, Andre = IDE.  2.2.18 (kernel) + ide.2.2.18.1221 (IDE
patch) + 2.2.19pre8 (kernel patch).  See samples below.

> Also, the machine locked up once (hard, couldn't connect via network). I
> am using the Matrox G450 beta driver with XF 4.0.2 though. Maybe that
> was the cause?

Ensoniq AudioPCI (ES1370) was problematic if I tried to assign IRQ5 on
the KA7 (hard trailess lockups, all IRQ's migrated to 10 or 11
regardless of config, digital audio ScreamOfAgony), whereas IRQ 3 worked
fine.  Similar experiements with Intel chipset boards P3B-F & BP6 suffer
no such issues so I assume it's VT82C686/ES1370 specific.

Abit KA7, 2.2.19pre8 + ide.2.2.18.1221
--------------------------------------
Linux version 2.2.19pre8+IDE (root@abit) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #6 Tue Feb 20 
01:14:30 PST 2001
USER-provided physical RAM map:
 USER: 0009f000 @ 00000000 (usable)
 USER: 1ff00000 @ 00100000 (usable)
Detected 800063 kHz processor.
ide_setup: idebus=33
ide_setup: ide0=ata66
ide_setup: ide1=ata66
Console: colour VGA+ 80x25
Calibrating delay loop... 1595.80 BogoMIPS
Memory: 517204k/524288k available (1116k kernel code, 412k reserved,
5508k data, 48k init)
Dentry hash table entries: 65536 (order 7, 512k)
Buffer cache hash table entries: 524288 (order 9, 2048k)
Page cache hash table entries: 131072 (order 7, 512k)
CPU: L1 I Cache: 64K  L1 D Cache: 64K
CPU: L2 Cache: 512K
CPU: AMD Athlon(tm) Processor stepping 02
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xfb4d0
PCI: Probing PCI hardware
...
Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VT 8371
 Chipset Core ATA-66
VP_IDE: ATA-66/100 forced bit set (WARNING)!!
Split FIFO Configuration:  8 Primary buffers, threshold = 1/2
                           8 Second. buffers, threshold = 1/2
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
ide0: VIA Bus-Master (U)DMA Timing Config Success
VP_IDE: ATA-66/100 forced bit set (WARNING)!!
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
ide1: VIA Bus-Master (U)DMA Timing Config Success
hda: IBM-DTLA-307020, ATA DISK drive
hdb: YAMAHA CRW4416E, ATAPI CDROM drive
hdc: IBM-DTLA-307020, ATA DISK drive
hdd: HP COLORADO 20GB, ATAPI TAPE drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: IBM-DTLA-307020, 19623MB w/1916kB Cache, CHS=2501/255/63, UDMA(66)
hdc: IBM-DTLA-307020, 19623MB w/1916kB Cache, CHS=39870/16/63, UDMA(66)
...
# lspci -v
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0391 (rev
02)
        Flags: bus master, medium devsel, latency 0
        Memory at d0000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8391 (prog-if
00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: d2000000-d3ffffff
        Prefetchable memory behind bridge: d4000000-d5ffffff
        Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
22)
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
10) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at d000
        Capabilities: [c0] Power Management version 2

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
        Flags: medium devsel
        Capabilities: [68] Power Management version 2


Generic Socket7, 2.2.19pre8 + ide.2.2.18.1221
---------------------------------------------
Linux version 2.2.19pre8+IDE (root@localhost.localdomain) (gcc version
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #3 Mon Feb 19 21:07:58
PST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0009f000 @ 00000000 (usable)
 BIOS-e820: 03f00000 @ 00100000 (usable)
Detected 166405 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 331.77 BogoMIPS
Memory: 63060k/65536k available (1044k kernel code, 412k reserved, 972k
data, 48k init)
Dentry hash table entries: 8192 (order 4, 64k)
Buffer cache hash table entries: 65536 (order 6, 256k)
Page cache hash table entries: 16384 (order 4, 64k)
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
Intel Pentium with F0 0F bug - workaround enabled.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb470
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: 00:38 [1106/0586]: Work around ISA DMA hangs (00)
Activating ISA DMA hang workarounds.
...
Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 2
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VT 82C585 Apollo VP1/VPX
 Chipset Core ATA-33
Split FIFO Configuration: 16 Primary buffers, threshold = 3/4
                           0 Second. buffers, threshold = 1/2
    ide0: BM-DMA at 0x6000-0x6007, BIOS settings: hda:DMA, hdb:DMA
ide0: VIA Bus-Master (U)DMA Timing Config Success
hda: IBM-DJNA-370910, ATA DISK drive
hdb: BCD-F520D CD-ROM, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: IBM-DJNA-370910, 8693MB w/1966kB Cache, CHS=1108/255/63, (U)DMA
...
# lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT82C585VP [Apollo VP1/VPX]
(rev 10)
        Flags: bus master, 66Mhz, medium devsel, latency 32

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA
[Apollo VP] (rev 02)
        Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
02) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at 6000
        Memory at e1020000 (32-bit, non-prefetchable)


-- 
timothymoore
   bigfoot
     com
