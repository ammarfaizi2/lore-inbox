Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264950AbSLBFsr>; Mon, 2 Dec 2002 00:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264945AbSLBFsr>; Mon, 2 Dec 2002 00:48:47 -0500
Received: from h68-146-142-19.cg.shawcable.net ([68.146.142.19]:35456 "EHLO
	h68-146-142-19.localdomain") by vger.kernel.org with ESMTP
	id <S264950AbSLBFsk>; Mon, 2 Dec 2002 00:48:40 -0500
Subject: scsi-eide interrupt/ read errors with cdparanoia; CDROM works fine
	otherwise; dmesq included; 2.4.20
From: Kim Lux <lux@diesel-research.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1038808565.1397.12.camel@h68-146-142-19.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 01 Dec 2002 22:56:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people.


-> cdparanoia crashes frequently, generally unstable
-> problem thought to be ide-scsi interface, but that is getting ahead
of the issue.
-> cdda2wav worked well with same CDROM drive; it uses ATAPI interface
-> cdparanoia uses IDE-scsi interface
-> tried linking /dev/cdrom to /dev/sg0, /dev/hdd, makes no difference
-> turned off autorun
-> tried various BIOS options for the CDROM
-> cdparanoia version: 9.8-11 
-> Linux kernel version: 2.4.20 compiled with stock RH8 config minus
ATAPI CDROM support. 
-> checked cdparanoia for memory leaks and found none. 


I'm a linux newbie but experienced c/c++ developer.  What can I do to
help.  

BTW: I think you guys do one hell of a good job !!!!!!!!!!


cdparanoia output:

<paste begins>

[krlux@h68-146-142-19 bryan_adams]$ cdparanoia -svB
cdparanoia III release 9.8 (March 23, 2001)
(C) 2001 Monty <monty@xiph.org> and Xiphophorus

Report bugs to paranoia@xiph.org
http://www.xiph.org/paranoia/

Checking /dev/cdrom for cdrom...
        Testing /dev/cdrom for cooked ioctl() interface
                /dev/scd0 is not a cooked ioctl CDROM.
        Testing /dev/cdrom for SCSI interface
                generic device: /dev/sg0
                ioctl device: /dev/scd0

Found an accessible SCSI CDROM drive.
Looking at revision of the SG interface in use...
        SG interface version 3.1.24; OK.

CDROM model sensed sensed: CREATIVE CD2423E  NC102 1.02

Checking for SCSI emulation...
        Drive is ATAPI (using SCSI host adaptor emulation)

Checking for MMC style command set...
        Drive is MMC style
        DMA scatter/gather table entries: 256
        table entry size: 32768 bytes
        maximum theoretical transfer: 3566 sectors
        Setting default read size to 13 sectors (30576 bytes).

Verifying CDDA command set...
        Expected command set reads OK.

Table of contents (audio tracks only):
track        length               begin        copy pre ch
===========================================================
  1.    16295 [03:37.20]        0 [00:00.00]    no   no  2
  2.    18822 [04:10.72]    16295 [03:37.20]    no   no  2
  3.    28418 [06:18.68]    35117 [07:48.17]    no   no  2
  4.    15725 [03:29.50]    63535 [14:07.10]    no   no  2
  5.    16667 [03:42.17]    79260 [17:36.60]    no   no  2
  6.    14835 [03:17.60]    95927 [21:19.02]    no   no  2
  7.    11030 [02:27.05]   110762 [24:36.62]    no   no  2
  8.    16228 [03:36.28]   121792 [27:03.67]    no   no  2
  9.    14737 [03:16.37]   138020 [30:40.20]    no   no  2
 10.    17025 [03:47.00]   152757 [33:56.57]    no   no  2
 11.    17988 [03:59.63]   169782 [37:43.57]    no   no  2
 12.    23520 [05:13.45]   187770 [41:43.45]    no   no  2
 13.    21875 [04:51.50]   211290 [46:57.15]    no   no  2
TOTAL  233165 [51:48.65]    (audio only)

Ripping from sector       0 (track  1 [0:00.00])
          to sector  233164 (track 13 [4:51.49])

outputting to track01.cdda.wav

 (== PROGRESS == [   ++  ++  +               ++ | 016294 00 ] == :^D *
==)

outputting to track02.cdda.wav

 (== PROGRESS == [+ +++   +          +      + ++| 035116 00 ] == :^D *
==)

outputting to track03.cdda.wav

 (== PROGRESS == [++             +        ++  + | 063534 00 ] == :^D *
==)

outputting to track04.cdda.wav

 (== PROGRESS == [  + +  + +              +     | 079259 00 ] == :^D *
==)

outputting to track05.cdda.wav

 (== PROGRESS == [                              | 095926 00 ] == :^D *
==)

outputting to track06.cdda.wav

 (== PROGRESS == [                ++++ + ++     | 110761 00 ] == :^D *
==)

outputting to track07.cdda.wav

 (== PROGRESS == [               >              | 116188 00 ] == :-)  
==)
SCSI transport error: timeout waiting to read packet

scsi_read error: sector=116314 length=13 retry=0
                 Sense key: 0 ASC: 0 ASCQ: 0
                 Transport error: Error reading command from device
                 System error: Success

SCSI transport error: timeout waiting to write packet

scsi_read error: sector=116314 length=6 retry=1
                 Sense key: 0 ASC: 0 ASCQ: 0
                 Transport error: Error writing packet command to device
                 System error: Invalid argument
scsi_read error: sector=116314 length=13 retry=0
                 Sense key: 0 ASC: 0 ASCQ: 0
                 Transport error: Error reading command from device
                 System error: Success
sending SG SCSI reset... FAILED: EBUSY
scsi_read error: sector=116314 length=6 retry=1
                 Sense key: 0 ASC: 0 ASCQ: 0
                 Transport error: Error writing packet command to device
                 System error: Invalid argument
sending SG SCSI reset... FAILED: EBUSY
Clearing previously returned data from SCSI buffer

 (== PROGRESS == [               e      +    +  | 121791 00 ] == :^D *
==)

outputting to track08.cdda.wav

 (== PROGRESS == [           +                  | 138019 00 ] == :^D *
==)

outputting to track09.cdda.wav

 (== PROGRESS == [        +                  +  | 152756 00 ] == :^D *
==)

outputting to track10.cdda.wav

 (== PROGRESS == [ +    ++     + +           +  | 169781 00 ] == :^D *
==)

outputting to track11.cdda.wav

 (== PROGRESS == [  +                           | 187769 00 ] == :^D *
==)




dmesg output: 



[krlux@h68-146-142-19 krlux]$ dmesg
000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
512MB LOWMEM available.
On node 0 totalpages: 131072
zone(0): 4096 pages.
zone(1): 126976 pages.
zone(2): 0 pages.
Kernel command line: ro root=LABEL=/ hdd=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 1659.627 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3316.12 BogoMIPS
Memory: 516048k/524288k available (1236k kernel code, 7852k reserved,
452k data, 124k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff c1c3f9ff 00000000 00000000
CPU:             Common caps: 0383f9ff c1c3f9ff 00000000 00000000
CPU: AMD Athlon(tm) XP 2000+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router SIS [1039/0008] at 00:02.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT
SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 15
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS735
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y060L0, ATA DISK drive
hdd: CREATIVE CD2423E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c02f0d64, I/O limit 4095Mb (mask 0xffffffff)
hda: 120103200 sectors (61493 MB) w/2048KiB Cache, CHS=7476/255/63,
UDMA(33)
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 128k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 124k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
SiS router pirq escape (99)
SiS router pirq escape (99)
usb-ohci.c: USB OHCI at membase 0xe0848000, IRQ 10
usb-ohci.c: usb-00:02.3, Silicon Integrated Systems [SiS] 7001 (#2)
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
PCI: Found IRQ 5 for device 00:02.2
PCI: Sharing IRQ 5 with 00:0f.0
usb-ohci.c: USB OHCI at membase 0xe084a000, IRQ 5
usb-ohci.c: usb-00:02.2, Silicon Integrated Systems [SiS] 7001
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
Adding Swap: 1024120k swap-space (priority -1)
hub.c: new USB device 00:02.2-1, assigned address 2
: USB HID v1.10 Joystick [Logitech WingMan Attack 2] on usb2:2.0
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: CREATIVE  Model: CD2423E  NC102    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: Printer, Lexmark International Lexmark Optra S 1855
ip_tables: (C) 2000-2002 Netfilter core team
sis900.c: v1.08.06 9/24/2002
PCI: Assigned IRQ 5 for device 00:03.0
divert: allocating divert_blk for eth0
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xd800, IRQ 5, 00:07:95:31:18:04.
eth0: Media Link On 10mbps half-duplex
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: Printer, Lexmark International Lexmark Optra S 1855
lp0: using parport0 (polling).
lp0: console ready
Creative EMU10K1 PCI Audio Driver, version 0.20, 10:48:48 Nov 30 2002
PCI: Found IRQ 5 for device 00:0f.0
PCI: Sharing IRQ 5 with 00:02.2
emu10k1: EMU10K1 rev 7 model 0x8064 found, IO at 0xd400-0xd41f, IRQ 5
ac97_codec: AC97 Audio codec, id: EMC40(Unknown)
emu10k1: SBLive! 5.1 card detected
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 2x/20x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
scsi : aborting command due to timeout : pid 7675, scsi0, channel 0, id
0, lun 0 Request Sense 00 00 00 40 00
hdd: lost interrupt
hdd: lost interrupt
scsi : aborting command due to timeout : pid 7677, scsi0, channel 0, id
0, lun 0 Request Sense 00 00 00 40 00
hdd: lost interrupt
hdd: lost interrupt
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8558, scsi0, channel 0, id
0, lun 0 Request Sense 00 00 00 40 00
hdd: lost interrupt
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 8559, scsi0, channel 0, id
0, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
SCSI host 0 abort (pid 8559) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
hdd: lost interrupt
[krlux@h68-146-142-19 krlux]$
-- 
Kim Lux <lux@diesel-research.com>
