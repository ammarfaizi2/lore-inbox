Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbUBXRuz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbUBXRuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:50:55 -0500
Received: from CPE0080c8c9b431-CM014280010574.cpe.net.cable.rogers.com ([24.112.162.124]:527
	"EHLO stargate.coplanar.net") by vger.kernel.org with ESMTP
	id S262330AbUBXRtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:49:51 -0500
Message-ID: <403B8E94.6020107@coplanar.net>
Date: Tue, 24 Feb 2004 12:49:08 -0500
From: Jeremy Jackson <jerj@coplanar.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Torben Mathiasen <torben.mathiasen@hp.com>, linux-kernel@vger.kernel.org,
       linux-ide <linux-ide@vger.kernel.org>
Subject: Re: 2.4.23 IDE hang on boot with two single-channel controllers
References: <401538C6.5030609@coplanar.net> <200402180034.44917.bzolnier@elka.pw.edu.pl>
Content-Type: multipart/mixed;
 boundary="------------060408000809010703070609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060408000809010703070609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bartlomiej Zolnierkiewicz wrote:

>>I'm hoping to reach the maintainer of the Linux IDE driver for the
>>Compaq TriFlex controller.  I have a problem with this driver when used
>>with a Compaq Armada 7730MT while docked in the base station.
>>
>>The driver appears to only support one triflex controller, due to a
>>missing check (that other chipset drivers have) that should prevent it
>>from registering a /proc interface more than once.  The result is that
>>it hangs on boot in proc_ide_create() in an infinite loop.
> 
> 
> Please send outputs of 'lspci' and 'dmesg' commands.

Attached are lspci and dmesg output, _alone = old kernel on laptop only, 
and _dock_fix = patched kernel in base station.

 > Does this patch fixes hang?

The patch allows booting while docked, and I tested a CD-ROM in the base 
station - it works!

 > Does 'cat /proc/ide/triflex' produce sane output?

Other /proc files seem ok, except /proc/ide/triflex, which spews 
garbage.  ld-linux.so was in the output, so it seems to be just 
returning random memory contents.  Smells like a pointer problem.

But this is great progress!  Thanks so much for your efforts!

Regards,

Jeremy Jackson

--------------060408000809010703070609
Content-Type: text/plain;
 name="dmesg_alone.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_alone.txt"

Linux version 2.4.23-jerj1-586tsc (jjackson@thunderdome) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Thu Dec 18 00:29:07 EST 2003
BIOS-provided physical RAM map:
 BIOS-e801: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e801: 0000000000100000 - 0000000009000000 (usable)
144MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 36864
zone(0): 4096 pages.
zone(1): 32768 pages.
zone(2): 0 pages.
DMI not present.
ACPI: Unable to locate RSDP
Kernel command line: BOOT_IMAGE=23-586tsc ro ramdisk_blocksize=4096 root=/dev/evms/root
No local APIC present or hardware disabled
Initializing CPU#0
Detected 166.590 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 332.59 BogoMIPS
Memory: 137744k/147456k available (2359k kernel code, 9324k reserved, 1617k data, 152k init, 0k highmem)
kdb version 4.3 by Keith Owens, Scott Lurndal. Copyright SGI, All Rights Reserved
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Intel Pentium with F0 0F bug - workaround enabled.
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000
CPU:             Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Pentium MMX stepping 04
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xf740d, last bus=0
PCI: Using configuration type 1
tbxfroot-0324 [04] acpi_find_root_pointer: RSDP structure not found, AE_NOT_FOUND Flags=8
ACPI: System description tables not found
 tbxface-0084: *** Error: acpi_load_tables: Could not get RSDP, AE_NOT_FOUND
 tbxface-0134: *** Error: acpi_load_tables: Could not load tables: AE_NOT_FOUND
ACPI: Unable to load the System Description Tables
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: device 00:00.0 has unknown header type 7f, ignoring.
PCI: Ignoring BAR0-3 of IDE controller 00:0e.1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
BIOS EDD facility v0.09 2003-Jan-21, 1 devices found
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SGI XFS snapshot-2.4.23-2003-12-01_00:33_UTC with ACLs, debug enabled
SGI XFS Quota Management subsystem
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS02 at 0x03e8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 4096 blocksize
Intel(R) PRO/1000 Network Driver - version 5.2.20-k1
Copyright (c) 1999-2003 Intel Corporation.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
TRIFLEX: IDE controller at PCI slot 00:0e.1
TRIFLEX: chipset revision 3
TRIFLEX: not 100% native mode: will probe irqs later
PCI: Setting latency timer of device 00:0e.1 to 64
    ide0: BM-DMA at 0xb140-0xb147, BIOS settings: hda:DMA, hdb:DMA
hda: IBM-DCRA-22160, ATA DISK drive
hdb: COMPAQ CRD-S68P, ATAPI CD/DVD-ROM drive
blk: queue c0544e40, I/O limit 4095Mb (mask 0xffffffff)
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: 4233600 sectors (2168 MB) w/96KiB Cache, CHS=525/128/63, DMA
hdb: attached ide-cdrom driver.
hdb: ATAPI 8X CD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :   184.400 MB/sec
   32regs    :   182.400 MB/sec
   pII_mmx   :   256.000 MB/sec
   p5_mmx    :   304.800 MB/sec
raid5: using function: p5_mmx (304.800 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.7(28/03/2003)
device-mapper: 4.0.5-ioctl (2003-11-18) initialised: dm@uk.sistina.com
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 3206k freed
VFS: Mounted root (cramfs filesystem).
Mounted devfs on /dev
Mounted devfs on /dev
Freeing unused kernel memory: 152k freed
cdrom: open failed.
VFS: Can't find ext3 filesystem on dev device-mapper(254,8).
device-mapper: unknown block ioctl 0x5310
Unable to identify CD-ROM format.
XFS mounting filesystem device-mapper(254,8)
Ending clean XFS mount for filesystem: device-mapper(254,8)
Adding Swap: 262132k swap-space (priority -1)
Real Time Clock Driver v1.10e
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
SCSI subsystem driver Revision: 1.00
cdrom: open failed.
XFS mounting filesystem device-mapper(254,1)
Ending clean XFS mount for filesystem: device-mapper(254,1)
XFS mounting filesystem device-mapper(254,13)
Ending clean XFS mount for filesystem: device-mapper(254,13)
XFS mounting filesystem device-mapper(254,16)
Ending clean XFS mount for filesystem: device-mapper(254,16)
XFS mounting filesystem device-mapper(254,5)
Ending clean XFS mount for filesystem: device-mapper(254,5)
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Yenta IRQ list 0698, PCI irq11
Socket status: 30000006
Yenta IRQ list 0698, PCI irq11
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: excluding 0xc48-0xc4f 0xc68-0xc6f
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x83f 0x850-0x87f
cs: IO port probe 0x0100-0x04ff: excluding 0x100-0x107 0x220-0x22f 0x250-0x257 0x270-0x277 0x330-0x337 0x378-0x37f 0x388-0x38f 0x408-0x40f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
lp0: using parport0 (polling).
lp0: console ready
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth0: NE2000 Compatible: io 0x300, irq 3, mem 0xc98dc000, auto xcvr, hw_addr 08:00:5A:3A:FA:64

--------------060408000809010703070609
Content-Type: text/plain;
 name="dmesg_dock_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_dock_fix.txt"

Linux version 2.4.23-jerj1-586tsc (jjackson@thunderdome) (gcc version 2.95.4 20011002 (Debian prerelease)) #3 Tue Feb 24 12:11:39 EST 2004
BIOS-provided physical RAM map:
 BIOS-e801: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e801: 0000000000100000 - 0000000009000000 (usable)
144MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 36864
zone(0): 4096 pages.
zone(1): 32768 pages.
zone(2): 0 pages.
DMI not present.
ACPI: Unable to locate RSDP
Kernel command line: BOOT_IMAGE=triflex1 ro ramdisk_blocksize=4096 root=/dev/evms/root
No local APIC present or hardware disabled
Initializing CPU#0
Detected 166.588 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 332.59 BogoMIPS
Memory: 137744k/147456k available (2360k kernel code, 9324k reserved, 1617k data, 152k init, 0k highmem)
kdb version 4.3 by Keith Owens, Scott Lurndal. Copyright SGI, All Rights Reserved
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Intel Pentium with F0 0F bug - workaround enabled.
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000
CPU:             Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Pentium MMX stepping 04
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xf740d, last bus=0
PCI: Using configuration type 1
tbxfroot-0324 [04] acpi_find_root_pointer: RSDP structure not found, AE_NOT_FOUND Flags=8
ACPI: System description tables not found
 tbxface-0084: *** Error: acpi_load_tables: Could not get RSDP, AE_NOT_FOUND
 tbxface-0134: *** Error: acpi_load_tables: Could not load tables: AE_NOT_FOUND
ACPI: Unable to load the System Description Tables
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: device 00:00.0 has unknown header type 7f, ignoring.
PCI: Ignoring BAR0-3 of IDE controller 00:0e.1
PCI: Ignoring BAR0-3 of IDE controller 00:0f.1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
BIOS EDD facility v0.09 2003-Jan-21, 1 devices found
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SGI XFS snapshot-2.4.23-2003-12-01_00:33_UTC with ACLs, debug enabled
SGI XFS Quota Management subsystem
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS02 at 0x03e8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 4096 blocksize
Intel(R) PRO/1000 Network Driver - version 5.2.20-k1
Copyright (c) 1999-2003 Intel Corporation.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
TRIFLEX: IDE controller at PCI slot 00:0e.1
TRIFLEX: chipset revision 3
TRIFLEX: not 100% native mode: will probe irqs later
PCI: Setting latency timer of device 00:0e.1 to 64
    ide0: BM-DMA at 0xb140-0xb147, BIOS settings: hda:DMA, hdb:DMA
TRIFLEX: IDE controller at PCI slot 00:0f.1
TRIFLEX: chipset revision 3
TRIFLEX: not 100% native mode: will probe irqs later
PCI: Setting latency timer of device 00:0f.1 to 64
    ide1: BM-DMA at 0xb158-0xb15f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DCRA-22160, ATA DISK drive
hdb: COMPAQ CRD-S68P, ATAPI CD/DVD-ROM drive
blk: queue c0544e60, I/O limit 4095Mb (mask 0xffffffff)
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: 4233600 sectors (2168 MB) w/96KiB Cache, CHS=525/128/63, DMA
hdb: attached ide-cdrom driver.
hdb: ATAPI 8X CD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :   184.400 MB/sec
   32regs    :   182.400 MB/sec
   pII_mmx   :   256.400 MB/sec
   p5_mmx    :   305.600 MB/sec
raid5: using function: p5_mmx (305.600 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.7(28/03/2003)
device-mapper: 4.0.5-ioctl (2003-11-18) initialised: dm@uk.sistina.com
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 3206k freed
VFS: Mounted root (cramfs filesystem).
Mounted devfs on /dev
Mounted devfs on /dev
Freeing unused kernel memory: 152k freed
cdrom: open failed.
VFS: Can't find ext3 filesystem on dev device-mapper(254,8).
device-mapper: unknown block ioctl 0x5310
Unable to identify CD-ROM format.
XFS mounting filesystem device-mapper(254,8)
Ending clean XFS mount for filesystem: device-mapper(254,8)
Adding Swap: 262132k swap-space (priority -1)
Real Time Clock Driver v1.10e
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
SCSI subsystem driver Revision: 1.00
cdrom: open failed.
XFS mounting filesystem device-mapper(254,1)
Ending clean XFS mount for filesystem: device-mapper(254,1)
XFS mounting filesystem device-mapper(254,13)
Ending clean XFS mount for filesystem: device-mapper(254,13)
XFS mounting filesystem device-mapper(254,16)
Ending clean XFS mount for filesystem: device-mapper(254,16)
XFS mounting filesystem device-mapper(254,5)
Ending clean XFS mount for filesystem: device-mapper(254,5)
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Yenta IRQ list 0698, PCI irq11
Socket status: 30000010
Yenta IRQ list 0698, PCI irq11
Socket status: 30000006
Yenta IRQ list 0698, PCI irq11
Socket status: 30000006
Yenta IRQ list 0698, PCI irq11
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: excluding 0xc48-0xc4f 0xc68-0xc6f
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x83f 0x850-0x87f
cs: IO port probe 0x0100-0x04ff: excluding 0x100-0x107 0x200-0x207 0x220-0x22f 0x250-0x257 0x270-0x277 0x330-0x337 0x378-0x37f 0x388-0x38f 0x408-0x40f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth0: NE2000 Compatible: io 0x300, irq 3, mem 0xc98cb000, auto xcvr, hw_addr 08:00:5A:3A:FA:64
parport0: PC-style at 0x378 [PCSPP,EPP]
lp0: using parport0 (polling).
lp0: console ready

--------------060408000809010703070609
Content-Type: text/plain;
 name="lspci_alone.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci_alone.txt"

00:0c.0 CardBus bridge: Texas Instruments PCI1131 (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device b046
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 7fffe000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=176
	Memory window 0: 10000000-103ff000 (prefetchable)
	Memory window 1: 10400000-107ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0c.1 CardBus bridge: Texas Instruments PCI1131 (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device b046
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 7ffff000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=176
	Memory window 0: 10800000-10bff000 (prefetchable)
	Memory window 1: 10c00000-10fff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0d.0 VGA compatible controller: S3 Inc. 86cM65 [Aurora64V+] (rev 43) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at 40000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0e.0 ISA bridge: Compaq Computer Corporation MIS-L (rev 04)
	Subsystem: Compaq Computer Corporation MIS-L
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:0e.1 IDE interface: Compaq Computer Corporation Triflex Dual EIDE Controller (rev 03) (prog-if ea)
	Subsystem: Compaq Computer Corporation Triflex Dual EIDE Controller
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at b140 [size=16]


--------------060408000809010703070609
Content-Type: text/plain;
 name="lspci_dock_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci_dock_fix.txt"

00:0a.0 Network controller: Compaq Computer Corporation Integrated NetFlex-3/P (rev 10)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1000 [size=16]
	Region 1: Memory at 44000000 (32-bit, non-prefetchable) [size=16]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0c.0 CardBus bridge: Texas Instruments PCI1131 (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device b046
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 7fffe000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=176
	Memory window 0: 10000000-103ff000 (prefetchable)
	Memory window 1: 10400000-107ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0c.1 CardBus bridge: Texas Instruments PCI1131 (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device b046
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 7ffff000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=176
	Memory window 0: 10800000-10bff000 (prefetchable)
	Memory window 1: 10c00000-10fff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0d.0 VGA compatible controller: S3 Inc. 86cM65 [Aurora64V+] (rev 43) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at 40000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0e.0 ISA bridge: Compaq Computer Corporation MIS-L (rev 04)
	Subsystem: Compaq Computer Corporation MIS-L
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:0e.1 IDE interface: Compaq Computer Corporation Triflex Dual EIDE Controller (rev 03) (prog-if ea)
	Subsystem: Compaq Computer Corporation Triflex Dual EIDE Controller
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at b140 [size=16]

00:0f.0 ISA bridge: Compaq Computer Corporation MIS-E (rev 04)
	Subsystem: Compaq Computer Corporation MIS-E
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:0f.1 IDE interface: Compaq Computer Corporation Triflex Dual EIDE Controller (rev 03) (prog-if da)
	Subsystem: Compaq Computer Corporation Triflex Dual EIDE Controller
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at b150 [size=16]

00:10.0 CardBus bridge: Texas Instruments PCI1131 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 7fffc000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=176
	Memory window 0: 11000000-113ff000 (prefetchable)
	Memory window 1: 11400000-117ff000
	I/O window 0: 00005000-000050ff
	I/O window 1: 00005400-000054ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:10.1 CardBus bridge: Texas Instruments PCI1131 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 7fffd000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=176
	Memory window 0: 11800000-11bff000 (prefetchable)
	Memory window 1: 11c00000-11fff000
	I/O window 0: 00005800-000058ff
	I/O window 1: 00005c00-00005cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001


--------------060408000809010703070609--

