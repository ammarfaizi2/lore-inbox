Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbTFQJYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 05:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbTFQJYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 05:24:13 -0400
Received: from vsmtp1.tin.it ([212.216.176.221]:16365 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S261414AbTFQJYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 05:24:01 -0400
Message-ID: <001001c334b4$2cdb6800$0201a8c0@mitchell>
From: "NeXTstep" <lost-soul@libero.it>
To: <linux-kernel@vger.kernel.org>
Subject: [2.4.21] problem with USB mass storage device (?)
Date: Tue, 17 Jun 2003 11:38:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone!

    I'm experiencing a problem with 2.4.21 kernel, accessing an USB mass
storage device (a "pen drive") on which I have the root filesystem on it.

Here is the problem, as dmesg says:

hub.c: already running port 1 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 00:08.0-1 address 2
usb_control/bulk_msg: timeout
Device 08:01 not ready.
 I/O error: dev 08:01, sector 49158
Device 08:01 not ready.
[...]
Device 08:01 not ready.
 I/O error: dev 08:01, sector 2
hub.c: new USB device 00:08.0-1, assigned address 3
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 3


It looks like it looses the connection with the USB device, following a
bunch of I/O errors, and finally get the connection to it, with a different
address.

Note: I have two USB controllers, an embedded one and an external one (both
VIA-based).

Following I posted:

 - dmesg output
 - cat /proc/scsi/usb-storage-0/0
 - cat /proc/scsi/scsi

Please note: I'm not an expert -- I tried to post in the best way I could :)
Feel free to ask me more information if needed.


dmesg:

Linux version 2.4.21 (root@mitchell) (gcc version 3.2 (Mandrake Linux 9.0
3.2-1mdk)) #1 dom

giu 15 20:55:04 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000004000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
64MB LOWMEM available.
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Kernel command line: rw root=/dev/nfs root=/dev/sda1 devfs=mount
Initializing CPU#0
Detected 132.874 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 264.60 BogoMIPS
Memory: 61240k/65536k available (1870k kernel code, 3912k reserved, 496k
data, 304k init,

0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Intel Pentium with F0 0F bug - workaround enabled.
CPU:     After generic, caps: 000001bf 00000000 00000000 00000000
CPU:             Common caps: 000001bf 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb530, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
parport0: PC-style at 0x378 [PCSPP(,...)]
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  MII transceiver #3 config 3100 status 7809 advertising 01e1.
eth0: Digital DS21140 Tulip rev 32 at 0x6300, 00:00:C0:C5:5F:00, IRQ 9.
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth1: RealTek RTL-8029 found at 0x6200, IRQ 10, 00:80:AD:C9:8F:AE.
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
bonding.c:v2.4.20-20030320 (March 20, 2003)
bonding_init(): either miimon or arp_interval and arp_ip_target module
parameters must be

specified, otherwise bonding will not detect link failures! see bonding.txt
for details.
bond0 registered without MII link monitoring, in load balancing
(round-robin) mode.
bond0 registered without ARP monitoring
SCSI subsystem driver Revision: 1.00
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/uhci.c: USB Universal Host Controller Interface driver v1.1
host/uhci.c: USB UHCI at I/O 0x6100, IRQ 11
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
Linux IP multicast router 0.06 plus PIM-SM
ip_conntrack version 2.1 (512 buckets, 4096 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
registering ipv6 mark target
NET4: Ethernet Bridge 008 for NET4.0
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
RAMDISK: Compressed image found at block 0
hub.c: new USB device 00:08.0-1, assigned address 2
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: TwinMOS   Model: Mobile Disk       Rev: 1.11
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 129024 512-byte hdwr sectors (66 MB)
sda: Write Protect is off
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
Freeing initrd memory: 308k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Mounted devfs on /dev
Freeing unused kernel memory: 304k freed
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
eth0: no IPv6 routers present
eth1: no IPv6 routers present
hub.c: already running port 1 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 00:08.0-1 address 2
usb_control/bulk_msg: timeout
Device 08:01 not ready.
 I/O error: dev 08:01, sector 49158
Device 08:01 not ready.
 I/O error: dev 08:01, sector 49238
Device 08:01 not ready.
 I/O error: dev 08:01, sector 49288
Device 08:01 not ready.
 I/O error: dev 08:01, sector 98306
Device 08:01 not ready.
 I/O error: dev 08:01, sector 98406
Device 08:01 not ready.
 I/O error: dev 08:01, sector 98424
Device 08:01 not ready.
 I/O error: dev 08:01, sector 99446
Device 08:01 not ready.
 I/O error: dev 08:01, sector 114776
Device 08:01 not ready.
 I/O error: dev 08:01, sector 114786
Device 08:01 not ready.
 I/O error: dev 08:01, sector 1334
Device 08:01 not ready.
 I/O error: dev 08:01, sector 16390
Device 08:01 not ready.
 I/O error: dev 08:01, sector 16394
Device 08:01 not ready.
 I/O error: dev 08:01, sector 16468
Device 08:01 not ready.
 I/O error: dev 08:01, sector 16472
Device 08:01 not ready.
 I/O error: dev 08:01, sector 16476
Device 08:01 not ready.
 I/O error: dev 08:01, sector 16480
Device 08:01 not ready.
 I/O error: dev 08:01, sector 16488
Device 08:01 not ready.
 I/O error: dev 08:01, sector 16496
Device 08:01 not ready.
 I/O error: dev 08:01, sector 16504
Device 08:01 not ready.
 I/O error: dev 08:01, sector 32780
Device 08:01 not ready.
 I/O error: dev 08:01, sector 32788
Device 08:01 not ready.
 I/O error: dev 08:01, sector 32794
Device 08:01 not ready.
 I/O error: dev 08:01, sector 32798
Device 08:01 not ready.
 I/O error: dev 08:01, sector 32816
Device 08:01 not ready.
 I/O error: dev 08:01, sector 49256
EXT3-fs error (device sd(8,1)): ext3_get_inode_loc: unable to read inode
block -

inode=7893, block=24628
Device 08:01 not ready.
 I/O error: dev 08:01, sector 1340
Device 08:01 not ready.
 I/O error: dev 08:01, sector 2
EXT3-fs error (device sd(8,1)) in ext3_reserve_inode_write: IO failure
Device 08:01 not ready.
 I/O error: dev 08:01, sector 2
Device 08:01 not ready.
 I/O error: dev 08:01, sector 49260
EXT3-fs error (device sd(8,1)): ext3_get_inode_loc: unable to read inode
block -

inode=7905, block=24630
Device 08:01 not ready.
 I/O error: dev 08:01, sector 2
EXT3-fs error (device sd(8,1)) in ext3_reserve_inode_write: IO failure
Device 08:01 not ready.
 I/O error: dev 08:01, sector 2
Device 08:01 not ready.
 I/O error: dev 08:01, sector 49258
EXT3-fs error (device sd(8,1)): ext3_get_inode_loc: unable to read inode
block -

inode=7904, block=24629
Device 08:01 not ready.
 I/O error: dev 08:01, sector 2
EXT3-fs error (device sd(8,1)) in ext3_reserve_inode_write: IO failure
Device 08:01 not ready.
 I/O error: dev 08:01, sector 2
hub.c: new USB device 00:08.0-1, assigned address 3
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 3


[root@efigeny /]# cat /proc/scsi/usb-storage-0/0
   Host scsi0: usb-storage
       Vendor: USB
      Product: Solid state disk
Serial Number: 27561E023E5BB518
     Protocol: Transparent SCSI
    Transport: Bulk
         GUID: 0ea0680327561e023e5bb518
     Attached: Yes

[root@efigeny /]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: TwinMOS  Model: Mobile Disk      Rev: 1.11
  Type:   Direct-Access                    ANSI SCSI revision: 02


