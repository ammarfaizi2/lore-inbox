Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264948AbTFYTM4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 15:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264952AbTFYTM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 15:12:56 -0400
Received: from atlas.williams.edu ([137.165.4.25]:43886 "EHLO
	atlas.williams.edu") by vger.kernel.org with ESMTP id S264948AbTFYTMe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 15:12:34 -0400
Date: Wed, 25 Jun 2003 15:26:44 -0400 (EDT)
From: Jeremy A Redburn <jredburn@wso.williams.edu>
Subject: Re: Problem detecting SATA drive in 2.4.21-ac2
In-reply-to: <20030625190425.GA6701@gtf.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.21.0306251515410.24753-100000@olga.williams.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about my earlier email -- I was rushed and didn't think through
things before posting.

My problem has slightly changed since my first post and I will explain as
best I can. In the BIOS (the motherboard is an Abit IS7 using Intel 865PE
chipset with ICH5) I have the option of setting the SATA device to act as
IDE3, IDE2, or IDE1 (note: all these numbers count from 1, not 0 as linux
does -- just subtract 1 for how they are identified in linux).

If I leave the two normal IDE controllers as IDE1 and IDE2 and the SATA as
IDE3, the system boots and detects the controller card:

ICH5-SATA: chipset revision 2
ICH5-SATA: 100% native mode on irq 11
    ide2: BM-DMA at 0xd000-0xd007, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xd008-0xd00f, BIOS settings: hdg:DMA, hdh:pio

And the drive:

hde: WDC WD360GD-00FNA0, ATA DISK drive

A few messages later, I get:

hde: attached ide-disk driver.

At this point the system freezes as far as I can tell and a hard reset is
required.

*However*, if I set the SATA to take over IDE2, it boots fine and the full
dmesg output follows:

Linux version 2.4.21-ac2 (root@ender) (gcc version 3.3 (Debian)) #1 Wed Jun 25 14:54:10 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 IntelR                     ) @ 0x000f7b90
ACPI: RSDT (v001 IntelR AWRDACPI 16944.11825) @ 0x1fff3000
ACPI: FADT (v001 IntelR AWRDACPI 16944.11825) @ 0x1fff3040
ACPI: MADT (v001 IntelR AWRDACPI 16944.11825) @ 0x1fff7a80
ACPI: DSDT (v001 INTELR AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
Kernel command line: auto BOOT_IMAGE=Linux ro root=301
Initializing CPU#0
Detected 2405.512 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4797.23 BogoMIPS
Memory: 516304k/524224k available (1122k kernel code, 7532k reserved, 437k data, 80k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
ACPI: Subsystem revision 20030522
PCI: PCI BIOS revision 2.10 entry at 0xfb730, last bus=2
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.2
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: Power Resource [PFAN] (off)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Intel(R) 865G chipset
agpgart: AGP aperture is 128M @ 0xe0000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5-SATA: IDE controller at PCI slot 00:1f.2
ICH5-SATA: chipset revision 2
ICH5-SATA: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 96147H8, ATA DISK drive
hdb: Hewlett-Packard DVD Writer 300, ATAPI CD/DVD-ROM drive
blk: queue c02c4e40, I/O limit 4095Mb (mask 0xffffffff)
hdc: WDC WD360GD-00FNA0, ATA DISK drive
    ACPI-0286: *** Error: No installed handler for fixed event [00000000]
blk: queue c02c529c, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 120060864 sectors (61471 MB) w/2048KiB Cache, CHS=7473/255/63, UDMA(100)
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 72303840 sectors (37020 MB) w/8192KiB Cache, CHS=4500/255/63, UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
 hdc: unknown partition table
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
reiserfs: checking transaction log (device 03:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 80k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 498004k swap-space (priority -1)
3C2000: 3Com Gigabit NIC Driver Version A09
Copyright (C) 2003 3Com Corporation.
Copyright (C) 2003 Marvell.
eth0: 3Com Gigabit LOM (3C940)
      PrefPort:A  RlmtMode:Check Link State
reiserfs: checking transaction log (device 03:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:05) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:06) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    scatter-gather:  enabled
lirc_dev: IR Remote Control driver registered, at major 61 
i2c-core.o: i2c core module
Linux video capture interface: v1.00
i2c-algo-bit.o: i2c bit algorithm module
bttv: driver version 0.7.104 loaded
bttv: using 4 buffers with 2080k (8320k total) for capture
bttv: Host bridge is Intel Corp. 82865G/PE/P Processor to I/O Controller
i2c-core.o: driver i2c ir driver registered.
PCI: Setting latency timer of device 00:1f.5 to 64
intel8x0: clocking to 48000

And the lspci output from my system:

00:00.0 Host bridge: Intel Corp.: Unknown device 2570 (rev 02)
00:01.0 PCI bridge: Intel Corp.: Unknown device 2571 (rev 02)
00:1d.0 USB Controller: Intel Corp.: Unknown device 24d2 (rev 02)
00:1d.1 USB Controller: Intel Corp.: Unknown device 24d4 (rev 02)
00:1d.2 USB Controller: Intel Corp.: Unknown device 24d7 (rev 02)
00:1d.3 USB Controller: Intel Corp.: Unknown device 24de (rev 02)
00:1d.7 USB Controller: Intel Corp.: Unknown device 24dd (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 24d0 (rev 02)
00:1f.2 IDE interface: Intel Corp.: Unknown device 24d1 (rev 02)
00:1f.3 SMBus: Intel Corp.: Unknown device 24d3 (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24d5 (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 If [Radeon 9000] (rev 01)
02:01.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 IEEE-1394a-2000 Controller (PHY/Link)
02:02.0 Ethernet controller: 3Com Corporation: Unknown device 1700 (rev 12)
02:07.0 Multimedia video controller: Internext Compression Inc: Unknown device 0016 (rev 01)

Thanks for any help you can provide -- and sorry once again about my
original message,
Jeremy Redburn

On Wed, 25 Jun 2003, Jeff Garzik wrote:

> On Wed, Jun 25, 2003 at 02:41:29PM -0400, Jeremy A Redburn wrote:
> > Hello,
> > 
> > I am using the latest 2.4-ac kernel (2.4.21-ac2) and trying to get support
> > for my WD Raptor SATA drive. The kernel detects the SATA controller just
> > fine and loads it as ide2 and ide3 -- but there is no detection of the
> > attached drive (which would presumably be hde). Anyone have any advice for
> > me?
> 
> It would help if you actually gave us details about your hardware,
> beyond what drive it is.  See the file REPORTING-BUGS in the kernel
> source for examples.  At a minimum, full lspci and dmesg output.
> 
> 	Jeff
> 
> 
> 
> 


