Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbTI1Vws (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 17:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbTI1Vws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 17:52:48 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:20679 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262774AbTI1Vwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 17:52:41 -0400
Date: Sun, 28 Sep 2003 17:52:40 -0400 (EDT)
From: Adam K Kirchhoff <adamk@voicenet.com>
X-X-Sender: <adamk@thorn.ashke.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: IDE problems with 2.6.0-test6
Message-ID: <Pine.LNX.4.33L2.0309281747380.18493-100000@thorn.ashke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I decided to make the trip into the land of 2.6 wiht the release of
2.6.0-test6.  Unfortunately, I'm having a hard time even getting it to
boot on my home machine...

It's a dual proc PIII (1 gig each), with 512 Megs RAM.  This is on a VIA
motherboard.  I have CONFIG_BLK_DEV_VIA82CXXX set to y in my kernel config
file, and this is the output from hdparm on /dev/hda:

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 79408/16/63, sectors = 80043264, start = 0

Basically, the kernel gets to the point where it's probing the ide chain
and examining the partition layout on /dev/hda, and it stalls with:

hda: max request size: 128KiB
hda: lost interrupt
hda: lost interrupt

The "hda: lost interrupt" just starts taking over.  The kernel continues
booting, but is *extremely* slow.  I've waited about 5 minutes, but
stopped since it wasn't done looking at the partition table.  Can anyone
shed some light?  I'm more than willing to answer any questions.

Here's the full output from the kernel:

Linux version 2.6.0-test6 (root@sorrow) (gcc version 3.2.3) #1 SMP Sun Sep 28 11:32:47 EDT 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000f0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 000000001fff0000 (usable)
 user: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 user: 000000001fff3000 - 0000000020000000 (ACPI data)
 user: 00000000fec00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f5660
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
ACPI: RSDP (v000 VIA694                                    ) @ 0x000f6930
ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: MADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff5680
ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ES7000: did not find Unisys ACPI OEM table!
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x0] trigger[0x0])
Enabling APIC mode:  Logical Cluster.  Using 1 I/O APICs, target cpus 3
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: root=/dev/hda7 video=radeon:1024x768-16@60 console=ttyS0 mem=524224K
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1002.212 MHz processor.
Console: colour VGA+ 80x25
Memory: 514176k/524224k available (2751k kernel code, 9300k reserved, 889k data, 196k init, 0k highmem)
Calibrating delay loop... 1970.17 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 731.04 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
Leaving ESR disabled.
Booting processor 1/1 eip 2000
CPU #1 not responding - cannot use it.
Error: only one processor found.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1002.0129 MHz.
..... host bus clock speed is 100.0212 MHz.
Starting migration thread for cpu 0
CPUS done 2
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb490, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=12, xclk=27500 from BIOS
radeonfb: probed DDR SGRAM 131072k videoram
radeonfb: ATI Radeon 8500 QL DDR SGRAM 128 MB
radeonfb: DVI port no monitor connected
radeonfb: CRT port CRT monitor connected
radeonfb_pci_register END
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
SGI XFS for Linux with large block numbers, no debug enabled
Initializing Cryptographic API
PCI: Enabling Via external APIC routing
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
pty: 256 Unix98 ptys configured
lp: driver loaded but no devices found
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
parport_pc: Via 686A parallel port: io=0x378
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:DMA
hda: Maxtor 5T040H4, ATA DISK drive
hda: IRQ probe failed (0xfffffdba)
hdb: Maxtor 6Y120L0, ATA DISK drive
hdb: IRQ probe failed (0xffdffdba)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdd: Pioneer DVD-ROM ATAPIModel DVD-120, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: lost interrupt
hda: lost interrupt

