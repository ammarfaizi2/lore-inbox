Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318510AbSHPQJe>; Fri, 16 Aug 2002 12:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318514AbSHPQJe>; Fri, 16 Aug 2002 12:09:34 -0400
Received: from mx2.airmail.net ([209.196.77.99]:61964 "EHLO mx2.airmail.net")
	by vger.kernel.org with ESMTP id <S318510AbSHPQJc>;
	Fri, 16 Aug 2002 12:09:32 -0400
Date: Fri, 16 Aug 2002 11:13:23 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Subject: Results with 2.4.20-pre2-ac3 and alim15x3 driver
Message-ID: <20020816161323.GA421@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The latest -ac release is the first in a while that I've been
able to boot without having to use "ide=nodma". I've yet to find
the magic flag in the BIOS configuration (or wherever it's located)
that will activate DMA for this machine. When booting off earlier
kernels, the machine would hang at the partition check with
DMA timeout errors. The 2.4.20-pre2-ac3 kernel doesn't need the
extra boot option, and is smart enough to not try and use DMA.

Here are snippets from /var/log/messages from 2.4.20-pre2-ac2 that
show what I had when booting with the "ide=nodma" flag ...

kernel: Linux version 2.4.20-pre2-ac2 (arth@debian) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Thu Aug 15 13:52:22 CDT 2002
kernel: BIOS-provided physical RAM map:
kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
kernel:  BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
kernel:  BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
kernel: 128MB LOWMEM available.
kernel: On node 0 totalpages: 32768
kernel: zone(0): 4096 pages.
kernel: zone(1): 28672 pages.
kernel: zone(2): 0 pages.
kernel: Kernel command line: BOOT_IMAGE=lnx-2.4.20p2ac2 ro root=301 pci=biosirq ide=nodma
kernel: ide_setup: ide=nodmaIDE: Prevented DMA
kernel: Initializing CPU#0
kernel: Detected 199.743 MHz processor.
kernel: Console: colour VGA+ 80x25
kernel: Calibrating delay loop... 398.95 BogoMIPS
kernel: POSIX conformance testing by UNIFIX
debian kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdb11, last bus=0
kernel: PCI: Using configuration type 1
kernel: PCI: Probing PCI hardware
kernel: PCI: Using BIOS Interrupt Routing Table
kernel: PCI: Using BIOS for IRQ routing
kernel: PCI: Hardcoded IRQ 14 for device 00:0b.0
kernel: Linux NET4.0 for Linux 2.4
kernel: Based upon Swansea University Computer Society NET3.039
kernel: Initializing RT netlink socket
kernel: Starting kswapd
kernel: pty: 256 Unix98 ptys configured
kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
kernel: ttyS03 at 0x02e8 (irq = 3) is a 16550A
kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
kernel: ALI15X3: IDE controller on PCI bus 00 dev 58
kernel: PCI: Hardcoded IRQ 14 for device 00:0b.0
kernel: ALI15X3: chipset revision 32
kernel: ALI15X3: not 100%% native mode: will probe irqs later
kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
kernel: hda: ST33232A, ATA DISK drive
kernel: hdb: ATAPI CDROM, ATAPI CD/DVD-ROM drive
kernel: hdc: FUJITSU MPD3084AT, ATA DISK drive
kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
kernel: ide1 at 0x170-0x177,0x376 on irq 15
kernel: hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
kernel: hda: task_no_data_intr: error=0x04 { DriveStatusError }
kernel: hda: 6303024 sectors (3227 MB) w/128KiB Cache, CHS=781/128/63
kernel: hdc: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=16383/16/63
kernel: Partition check:
kernel:  hda: hda1 hda2 < hda5 hda6 hda7 >
*** things would freeze here without the "ide=nodma" flag ***
kernel:  hdc: [PTBL] [1027/255/63] hdc1 hdc2 < hdc5 hdc6 > hdc3
kernel: NET4: Linux TCP/IP 1.0 for NET4.0
kernel: IP Protocols: ICMP, UDP, TCP, IGMP
kernel: IP: routing cache hash table of 1024 buckets, 8Kbytes
kernel: TCP: Hash tables configured (established 8192 bind 16384)
kernel: VFS: Mounted root (ext2 filesystem) readonly.
kernel: Freeing unused kernel memory: 208k freed
kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kernel: Adding Swap: 100764k swap-space (priority -1)
...

Here's 2.4.20-pre2-ac3 dmesg output ...


Linux version 2.4.20-pre2-ac3 (arth@debian) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Thu Aug 15 19:57:47 CDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
128MB LOWMEM available.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=lnx-2.4.20p2ac3 ro root=301 pci=biosirq
Initializing CPU#0
Detected 199.743 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 398.95 BogoMIPS
Memory: 127676k/131072k available (751k kernel code, 3008k reserved, 190k data, 200k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=15959 max_file_pages=0 max_inodes=0 max_dentries=15959
Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 008001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 008001bf 00000000 00000000 00000000
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000
CPU:             Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Pentium MMX stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfdb11, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using BIOS Interrupt Routing Table
PCI: Using BIOS for IRQ routing
PCI: Hardcoded IRQ 14 for device 00:0b.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS03 at 0x02e8 (irq = 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 58
PCI: Hardcoded IRQ 14 for device 00:0b.0
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
ALI15X3: simplex device: DMA disabled
ide0: ALI15X3 Bus-Master DMA disabled (BIOS)
ALI15X3: simplex device: DMA disabled
ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
hda: ST33232A, ATA DISK drive
hdb: ATAPI CDROM, ATAPI CD/DVD-ROM drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: FUJITSU MPD3084AT, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 6303024 sectors (3227 MB) w/128KiB Cache, CHS=781/128/63
hdc: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=16383/16/63
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
 hdc: [PTBL] [1027/255/63] hdc1 hdc2 < hdc5 hdc6 > hdc3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
....

More info about this machine ...

$ lspci -vv

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1531 [Aladdin IV] (rev b3)
	Subsystem: Acer Laboratories Inc. [ALi] M1531 [Aladdin IV]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32

00:02.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev b4)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0

00:05.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01) (prog-if 00 [VGA])
	Subsystem: S3 Inc. ViRGE/DX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at ebff0000 [disabled] [size=64K]

00:0b.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 20) (prog-if fa)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 14
	Region 0: [virtual] I/O ports at 01f0 [size=8]
	Region 1: [virtual] I/O ports at 03f4 [size=4]
	Region 2: [virtual] I/O ports at 0170 [size=8]
	Region 3: [virtual] I/O ports at 0374 [size=4]
	Region 4: I/O ports at ffa0 [size=16]

The IDE changes in -ac3 look like they're making the kernel even
better at dealing with older hardware.

Art Haas

-- 
They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
