Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310224AbSDAGpq>; Mon, 1 Apr 2002 01:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310214AbSDAGp1>; Mon, 1 Apr 2002 01:45:27 -0500
Received: from ECE.CMU.EDU ([128.2.136.200]:55221 "EHLO ece.cmu.edu")
	by vger.kernel.org with ESMTP id <S310190AbSDAGpQ>;
	Mon, 1 Apr 2002 01:45:16 -0500
Date: Mon, 1 Apr 2002 01:45:15 -0500 (EST)
From: Nilmoni Deb <ndeb@ece.cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.18 exception/bug during cd read operation
In-Reply-To: <m1g0944ib9.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.3.96L.1020401012902.18816H-100000@d-alg.ece.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have scsi emulation (for ide cd-rw drive) and supermount is enabled.
I am using the ext3 filesystem. The kernel gave an error message after it
failed to copy a file from a cd-r media onto the hard disk. This problem
occured only for that particular cd-r media. Other cd's were read just
fine. Fortunately, there was no system crash.

The interesting part of the error message is :

ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
isofs_read_level3_size: More than 100 file sections ?!?, aborting...
isofs_read_level3_size: inode=45152 ino=54536
isofs_read_level3_size: More than 100 file sections ?!?, aborting...
isofs_read_level3_size: inode=45244 ino=54628
 I/O error: dev 0b:01, sector 6616
ISO 9660 Extensions: Microsoft Joliet Level 1
ISOFS: changing to secondary root
kernel BUG at super.c:255!
invalid operand: 0000
CPU:    0
EIP:    0010:[<d007ca61>]    Not tainted
EFLAGS: 00013286
eax: 0000001b   ebx: c37a2700   ecx: c0262520   edx: 00002be1
esi: c774dde0   edi: 00000000   ebp: cac65764   esp: ce3b7e54
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 1904, stackpage=ce3b7000)
Stack: d0089937 000000ff c016dec9 ce2e8000 ce3b7e9c 00000000 00000003
ce1d9000 
       00000003 ce1d9000 d00898b1 d00898bb d00898c5 c016ab8b d008abc0
c37a2701 
       d0089b3e cf19bc00 d007cbb6 cf19bc00 c37a2700 00000000 c774dde0
00000000 
Call Trace: [<d0089937>] [<c016dec9>] [<d00898b1>] [<d00898bb>]
[<d00898c5>] 
   [<c016ab8b>] [<d008abc0>] [<d0089b3e>] [<d007cbb6>] [<d007cdc8>]
[<c013dda0>] 
   [<d00898b1>] [<d00898bb>] [<d00898c5>] [<d0087d7a>] [<c013d42d>]
[<c013e648>] 
   [<c0133d64>] [<c013d2af>] [<c01340a6>] [<c0106f23>] 

Code: 0f 0b 59 5b 8b 46 20 8b 58 10 85 db 74 1b 8b 03 85 c0 75 13 
 <6>VFS: busy inodes on changed media.





Here is the complete dmesg output:

Linux version 2.4.18-6mdk (quintela@bi.mandrakesoft.com) (gcc version 2.96 20000731 (Mandrake Linux 8.2 2.96-0.76mdk)) #1 Fri Mar 15 02:59:08 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f7f0000 (usable)
 BIOS-e820: 000000000f7f0000 - 000000000f7f3000 (ACPI NVS)
 BIOS-e820: 000000000f7f3000 - 000000000f800000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
hm, page 0f7f0000 reserved twice.
On node 0 totalpages: 63472
zone(0): 4096 pages.
zone(1): 59376 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=341 devfs=mount hdc=ide-scsi hdd=ide-scsi
ide_setup: hdc=ide-scsi
ide_setup: hdd=ide-scsi
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 751.334 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1497.49 BogoMIPS
Memory: 247320k/253888k available (1170k kernel code, 6180k reserved, 332k data, 260k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU: AMD Duron(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb380, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Disabling VIA memory write queue: [55] 28->08
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd
VFS: Diskquotas version dquot_6.5.0 initialized
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD200EB-00BHF0, ATA DISK drive
hdb: WDC WD400EB-11CPF0, ATA DISK drive
hdc: LITE-ON LTR-16102B, ATAPI CD/DVD-ROM drive
hdd: ATAPI CDROM, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=2434/255/63, UDMA(33)
hdb: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
 /dev/ide/host0/bus0/target1/lun0: p1 p2 < p5 p6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Uncompressing......done.
Freeing initrd memory: 134k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Journalled Block Device driver loaded
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 260k freed
Real Time Clock Driver v1.10e
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,65), internal journal
Adding Swap: 248968k swap-space (priority -1)
Adding Swap: 248968k swap-space (priority -2)
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: LTR-16102B        Rev: OS08
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor:           Model: ATAPI CDROM       Rev: 120N
  Type:   CD-ROM                             ANSI SCSI revision: 02
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,70), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
MSDOS FS: IO charset iso8859-1
MSDOS FS: Using codepage 850
8139too Fast Ethernet driver 0.9.24
PCI: Found IRQ 11 for device 00:0a.0
eth0: RealTek RTL8139 Fast Ethernet at 0xd00a5000, 00:50:ba:40:39:58, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139B'
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 03:23:39 Mar 15 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 9 for device 00:07.2
PCI: Sharing IRQ 9 with 00:07.3
usb-uhci.c: USB UHCI at I/O 0xc400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 9 for device 00:07.3
PCI: Sharing IRQ 9 with 00:07.2
usb-uhci.c: USB UHCI at I/O 0xc800, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport_pc: Via 686A parallel port: io=0x378
eth0: Setting 100mbps half-duplex based on auto-negotiated partner ability 40a1.
Via 686a audio driver 1.9.1
PCI: Found IRQ 10 for device 00:07.5
PCI: Sharing IRQ 10 with 00:07.6
PCI: Sharing IRQ 10 with 00:0b.0
ac97_codec: AC97 Audio codec, id: 0x4943:0x4511 (ICE1232)
via82cxxx: board #1 at 0xCC00, IRQ 10
Enabled Via MIDI
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 2x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
cdrom: open failed.
loop: loaded (max 8 devices)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
isofs_read_level3_size: More than 100 file sections ?!?, aborting...
isofs_read_level3_size: inode=45152 ino=54536
isofs_read_level3_size: More than 100 file sections ?!?, aborting...
isofs_read_level3_size: inode=45244 ino=54628
scsi0: ERROR on channel 0, id 0, lun 0, CDB: Request Sense 00 00 00 40 00 
Info fld=0x6ac (nonstd), Current sd0b:00: sense key Medium Error
Additional sense indicates Unrecovered read error
 I/O error: dev 0b:00, sector 6600
ISO 9660 Extensions: Microsoft Joliet Level 1
ISOFS: changing to secondary root
cdrom: open failed.
cdrom: open failed.
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
isofs_read_level3_size: More than 100 file sections ?!?, aborting...
isofs_read_level3_size: inode=45152 ino=54536
isofs_read_level3_size: More than 100 file sections ?!?, aborting...
isofs_read_level3_size: inode=45244 ino=54628
 I/O error: dev 0b:01, sector 6744
VFS: busy inodes on changed media.
VFS: busy inodes on changed media.
sr1: CDROM not ready.  Make sure there is a disc in the drive.
cdrom: open failed.
VFS: busy inodes on changed media.
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
isofs_read_level3_size: More than 100 file sections ?!?, aborting...
isofs_read_level3_size: inode=45152 ino=54536
isofs_read_level3_size: More than 100 file sections ?!?, aborting...
isofs_read_level3_size: inode=45244 ino=54628
 I/O error: dev 0b:01, sector 6744
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
isofs_read_level3_size: More than 100 file sections ?!?, aborting...
isofs_read_level3_size: inode=45152 ino=54536
cdrom: open failed.
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
isofs_read_level3_size: More than 100 file sections ?!?, aborting...
isofs_read_level3_size: inode=45152 ino=54536
isofs_read_level3_size: More than 100 file sections ?!?, aborting...
isofs_read_level3_size: inode=45244 ino=54628
scsi0: ERROR on channel 0, id 0, lun 0, CDB: Request Sense 00 00 00 40 00 
Info fld=0x6ac (nonstd), Current sd0b:00: sense key Medium Error
Additional sense indicates Unrecovered read error
 I/O error: dev 0b:00, sector 6744
cdrom: open failed.
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
isofs_read_level3_size: More than 100 file sections ?!?, aborting...
isofs_read_level3_size: inode=45152 ino=54536
isofs_read_level3_size: More than 100 file sections ?!?, aborting...
isofs_read_level3_size: inode=45244 ino=54628
 I/O error: dev 0b:01, sector 6616
ISO 9660 Extensions: Microsoft Joliet Level 1
ISOFS: changing to secondary root
kernel BUG at super.c:255!
invalid operand: 0000
CPU:    0
EIP:    0010:[<d007ca61>]    Not tainted
EFLAGS: 00013286
eax: 0000001b   ebx: c37a2700   ecx: c0262520   edx: 00002be1
esi: c774dde0   edi: 00000000   ebp: cac65764   esp: ce3b7e54
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 1904, stackpage=ce3b7000)
Stack: d0089937 000000ff c016dec9 ce2e8000 ce3b7e9c 00000000 00000003 ce1d9000 
       00000003 ce1d9000 d00898b1 d00898bb d00898c5 c016ab8b d008abc0 c37a2701 
       d0089b3e cf19bc00 d007cbb6 cf19bc00 c37a2700 00000000 c774dde0 00000000 
Call Trace: [<d0089937>] [<c016dec9>] [<d00898b1>] [<d00898bb>] [<d00898c5>] 
   [<c016ab8b>] [<d008abc0>] [<d0089b3e>] [<d007cbb6>] [<d007cdc8>] [<c013dda0>] 
   [<d00898b1>] [<d00898bb>] [<d00898c5>] [<d0087d7a>] [<c013d42d>] [<c013e648>] 
   [<c0133d64>] [<c013d2af>] [<c01340a6>] [<c0106f23>] 

Code: 0f 0b 59 5b 8b 46 20 8b 58 10 85 db 74 1b 8b 03 85 c0 75 13 
 <6>VFS: busy inodes on changed media.

