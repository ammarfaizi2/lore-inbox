Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272287AbTHRTRa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 15:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272286AbTHRTPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 15:15:49 -0400
Received: from math.ut.ee ([193.40.5.125]:60309 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S272313AbTHRTMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 15:12:46 -0400
Date: Mon, 18 Aug 2003 22:12:43 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
Message-ID: <Pine.GSO.4.44.0308182205400.17736-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried 2.6.0-test3 + todays BK on a Motorola Powerstack (Utah II, 300
MHz 604e). It's basically a PReP machine from Motorola.

2.4.22-rc2 works well. 2.6.0-test3+latest bk fails in 2 places.

1. Network interface is detected correctly but first ifconfig command
(even if it fails because of wrong arguments) hangs the machine. This is
with both tulip driver (new io+mmio or mmio or just plain pio, 3 modes
tried) and de4x5 driver (the card is a onboard 21140).

2. 2.4 detects full 64M of RAM, 2.6 detects only 32M of RAM.

The dmesgs are below. 2.4 has compiled-in ide (no drives), 2.6 has no
ide compiled in. Will try 2.6 with ide next but I don't believe it's the
issue.

loaded at:     00400400 0050221C
relocated to:  00800000 00901E1C
No residual data found.
zimage at:     0080D4A0 008F75E7
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600 console=tty0 root=/dev/sda3
Uncompressing Linux...done.
Now booting the kernel
Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Total memory = 64MB; using 128kB for hash table (at c0260000)
Linux version 2.4.22-rc2 (mroos@ananass) (gcc version 2.95.4 20011002 (Debian prerelease)) #3 P aug 17 14:03:04 EET 2003
PReP architecture
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 console=tty0 root=/dev/sda3
time_init: decrementer frequency = 16.657534 MHz
Console: colour VGA+ 80x25
Calibrating delay loop... 299.00 BogoMIPS
Memory: 62192k available (1456k kernel code, 840k data, 136k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Setting PCI interrupts for a "Utah (Powerstack II Pro4000)"
PCI: moved device 00:0b.1 resource 4 (101) to 1480
PCI: moved device 00:0b.1 resource 5 (101) to 1490
PCI: moved device 00:12.0 resource 0 (1208) to 0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Thermal assist unit not available
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
rtc: I/O port 112 is not free.
Generic RTC Driver v1.07
NET4: Frame Diverter 0.46
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
PCI: Enabling device 00:0e.0 (0000 -> 0003)
PCI: 00:0e.0 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:0e.0 PCI cache line size corrected to 32.
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media AUI (#2) described by a 21140 non-MII (0) block.
tulip0:  Index #1 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  MII transceiver #8 config 3100 status 786b advertising 01e1.
eth0: Digital DS21140 Tulip rev 34 at 0xf200a000, 08:00:3E:28:C4:A2, IRQ 11.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
W82C105: IDE controller at PCI slot 00:0b.1
PCI: Enabling device 00:0b.1 (0000 -> 0001)
W82C105: chipset revision 5
W82C105: bad irq (0): will probe later
    ide0: BM-DMA at 0x1480-0x1487, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x1488-0x148f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
Probing IDE interface ide1...
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
SCSI subsystem driver Revision: 1.00
PCI: Enabling device 00:0c.0 (0000 -> 0003)
sym.0.12.0: setting PCI_COMMAND_MASTER PCI_COMMAND_PARITY...
sym0: <825a> rev 0x13 on pci bus 0 device 12 function 0 irq 15
sym0: No NVRAM, ID 7, Fast-10, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.17a
blk: queue c03dcc18, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: SEAGATE   Model: ST34371W          Rev: 0484
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue c03dce18, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: SEAGATE   Model: ST32171W          Rev: 0460
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue c039b218, I/O limit 4095Mb (mask 0xffffffff)
sym0:0:0: tagged command queuing enabled, command queue depth 16.
sym0:1:0: tagged command queuing enabled, command queue depth 16.
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
sym0:0: FAST-10 WIDE SCSI 20.0 MB/s ST (100.0 ns, offset 8)
SCSI device sda: 8496884 512-byte hdwr sectors (4350 MB)
Partition check:
 sda: sda1 sda2 sda3
sym0:1: FAST-10 WIDE SCSI 20.0 MB/s ST (100.0 ns, offset 8)
SCSI device sdb: 4194158 512-byte hdwr sectors (2147 MB)
 sdb: sdb1
Macintosh non-volatile memory driver v1.0
mice: PS/2 mouse device common for all mice
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 136k init 36k pmac 8k chrp 4k openfirmware
Adding Swap: 498004k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,3), internal journal
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
usb-uhci.c: $Revision: 1.275 $ time 23:41:41 Aug 16 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
eth0: Setting full-duplex based on MII#8 link partner capability of 45e1.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).


loaded at:     00400400 00522FE4
relocated to:  00800000 00922BE4
No residual data found.
zimage at:     0080A79B 00918A59
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600 console=tty0 root=/dev/sda3
Uncompressing Linux...done.
Now booting the kernel
Total memory = 32MB; using 64kB for hash table (at c0290000)
Linux version 2.6.0-test3 (mroos@ananass) (gcc version 3.3.2 20030812 (Debian prerelease)) #2 Mon Aug 18 21:28:30 EEST 2003
PReP architecture
On node 0 totalpages: 8192
  DMA zone: 8192 pages, LIFO batch:2
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: console=ttyS0,9600 console=tty0 root=/dev/sda3
PID hash table entries: 256 (order 8: 2048 bytes)
time_init: decrementer frequency = 16.657522 MHz
Console: colour VGA+ 80x25
Calibrating delay loop... 299.00 BogoMIPS
Memory: 29736k available (1544k kernel code, 900k data, 124k init, 0k highmem)
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
POSIX conformance testing by UNIFIX
Initializing RT netlink socket
PCI: Probing PCI hardware
Setting PCI interrupts for a "Utah (Powerstack II Pro4000)"
BIO: pool of 256 setup, 16Kb (64 bytes/bio)
biovec pool[0]:   1 bvecs:  56 entries (12 bytes)
biovec pool[1]:   4 bvecs:  28 entries (48 bytes)
biovec pool[2]:  16 bvecs:  14 entries (192 bytes)
biovec pool[3]:  64 bvecs:   7 entries (768 bytes)
biovec pool[4]: 128 bvecs:   3 entries (1536 bytes)
biovec pool[5]: 256 bvecs:   1 entries (3072 bytes)
SCSI subsystem initialized
pty: 256 Unix98 ptys configured
Journalled Block Device driver loaded
Initializing Cryptographic API
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ÿttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 0) is a 16550A
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Enabling device 0000:00:04.0 (0000 -> 0003)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media AUI (#2) described by a 21140 non-MII (0) block.
tulip0:  Index #1 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  MII transceiver #8 config 3100 status 786b advertising 01e1.
eth0: Digital DS21140 Tulip rev 34 at 0xf200a000, 08:00:3E:28:C4:A2, IRQ 9.
PCI: Enabling device 0000:00:02.0 (0000 -> 0003)
sym.0.2.0: 53c825a detected
sym0: <825a> rev 0x13 on pci bus 0 device 2 function 0 irq 15
sym0: No NVRAM, ID 7, Fast-10, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.16a
Using anticipatory scheduling elevator
  Vendor: SEAGATE   Model: ST34371W          Rev: 0484
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym0:0:0: tagged command queuing enabled, command queue depth 16.
  Vendor: SEAGATE   Model: ST32171W          Rev: 0460
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym0:1:0: tagged command queuing enabled, command queue depth 16.
sym0:0: FAST-10 WIDE SCSI 20.0 MB/s ST (100.0 ns, offset 8)
SCSI device sda: 8496884 512-byte hdwr sectors (4350 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sym0:1: FAST-10 WIDE SCSI 20.0 MB/s ST (100.0 ns, offset 8)
SCSI device sdb: 4194158 512-byte hdwr sectors (2147 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Macintosh non-volatile memory driver v1.0
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: PS2++ Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Frame Diverter 0.46
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 124k init 32k pmac 4k chrp 4k openfirmware
Adding 498004k swap on /dev/sda2.  Priority:-1 extents:1
EXT3 FS on sda3, internal journal
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27

(and hangs here)

-- 
Meelis Roos (mroos@linux.ee)

