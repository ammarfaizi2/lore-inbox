Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265582AbTFXBWQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 21:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265611AbTFXBWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 21:22:16 -0400
Received: from larry.aptalaska.net ([64.186.96.3]:62632 "EHLO
	larry.aptalaska.net") by vger.kernel.org with ESMTP id S265582AbTFXBWK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 21:22:10 -0400
Message-ID: <3EF7AB11.4060504@aptalaska.net>
Date: Mon, 23 Jun 2003 17:36:17 -0800
From: Matthew Schumacher <matt.s@aptalaska.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: strange memory detection / initrd behavior
X-Enigmail-Version: 0.74.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is long but verbose.  Here is a brief synopsis for your 
comfort:

Problem: Linux detects 8MB of system memory using initrd image 3439373 
bytes in size, but detects 64MB of system memory (the correct amount) 
using initrd image 7472149 in size.


Long description:

I am building a firewall appliance (for personal use) out of an old 486 
single board computer (Interjet: http://www.whistle.com/).  I have 64MB 
of memory in the system and want 32MB to be used as a ramdisk and 32MB 
to be used as system memory.  I created a root file system and pass it 
as the initrd option in the kernel.

If I put a large initrd image on the system (~ 7MB) then the system 
boots once, uncompresses the kernel, says 'ready', reboots, and the 
second time it starts the kernel and detects the correct amount of memory:

========================================================================
SYSLINUX 2.01 2003-01-31  Copyright (C) 1994-2003 H. Peter Anvin 

Loading linux............... 

Loading 
rootfs.gz.................................................................................................................
Ready.

<REBOOT>

SYSLINUX 2.01 2003-01-31  Copyright (C) 1994-2003 H. Peter Anvin
Loading linux...............
Loading 
rootfs.gz.................................................................................................................
Ready.
Linux version 2.4.21 (root@percy) (gcc version 3.2 20020903 (Red Hat 
Linux 8.0 3.2-7)) #2 Mon Jun 23 10:16:00 AKDT 2003
BIOS-provided physical RAM map: 

  BIOS-88: 0000000000000000 - 000000000009f000 (usable)
  BIOS-88: 0000000000100000 - 0000000004000000 (usable)
64MB LOWMEM available.
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600n8 load_ramdisk=1 
initrd=rootfs.gz root=/dev/ram ramdisk_size=32768 ether=9,0x320,0,0x3c50o
Initializing CPU#0 

Console: colour VGA+ 80x25
Calibrating delay loop... 29.90 BogoMIPS
Memory: 55412k/65536k available (1090k kernel code, 9736k reserved, 262k 
data, 96k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... 
Ok.
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: Cyrix Cx486DX4 stepping 06
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: Using configuration type 1
PCI: Probing PCI hardware
isapnp: Scanning for PnP cards...
isapnp: Card 'ESS ES1869 Plug and Play AudioDrive'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
eth0: 3c5x9 at 0x320, 10baseT port, address  00 60 8c b9 89 3a, IRQ 9.
3c509.c:1.19 16Oct2002 becker@scyld.com
http://www.scyld.com/network/3c509.html
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: Conner Peripherals 210MB - CFS210A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 416480 sectors (213 MB) w/32KiB Cache, CHS=685/16/38
Partition check:
  hda: hda1
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: ESS ES1869 Plug and Play AudioDrive detected
sb: ISAPnP reports 'ESS ES1869 Plug and Play AudioDrive' at i/o 0x220, 
irq 5, dma 1, 3
sb: 1 Soundblaster PnP card(s) found. 

NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
ip_conntrack version 2.1 (512 buckets, 4096 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 7296k freed
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 96k freed
init started:  BusyBox v0.60.5 (2003.01.24-22:12+0000) multi-call binary
eth0: Setting 3c5x9/3c5x9B half-duplex mode if_port: 0, sw_info: 1310
eth0: Setting Rx mode to 1 addresses.
========================================================================

If I put a small initrd image on the system (~ 3MB) then the system 
boots once, uncompresses the kernel, starts, and detects only 8MB of memory:

========================================================================
SYSLINUX 2.01 2003-01-31  Copyright (C) 1994-2003 H. Peter Anvin 

Loading linux............... 

Loading rootfs.gz....................................................... 

Ready.
Linux version 2.4.21 (root@percy) (gcc version 3.2 20020903 (Red Hat 
Linux 8.0 3.2-7)) #2 Mon Jun 23 10:16:00 AKDT 2003
BIOS-provided physical RAM map: 

  BIOS-88: 0000000000000000 - 000000000009f000 (usable)
  BIOS-88: 0000000000100000 - 0000000000800000 (usable)
8MB LOWMEM available.
On node 0 totalpages: 2048
zone(0): 2048 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600n8 load_ramdisk=1 
initrd=rootfs.gz root=/dev/ram ramdisk_size=32768 ether=9,0x320,0,0x3c509,o
Initializing CPU#0 

Console: colour VGA+ 80x25
Calibrating delay loop... 29.90 BogoMIPS
Memory: 2684k/8192k available (1090k kernel code, 5120k reserved, 262k 
data, 96k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... 
Ok.
Dentry cache hash table entries: 1024 (order: 1, 8192 bytes)
Inode cache hash table entries: 512 (order: 0, 4096 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: Cyrix Cx486DX4 stepping 06
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: Using configuration type 1
PCI: Probing PCI hardware
isapnp: Scanning for PnP cards...
isapnp: Card 'ESS ES1869 Plug and Play AudioDrive'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A 

ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
eth0: 3c5x9 at 0x320, 10baseT port, address  00 60 8c b9 89 3a, IRQ 9.
3c509.c:1.19 16Oct2002 becker@scyld.com
http://www.scyld.com/network/3c509.html
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: Conner Peripherals 210MB - CFS210A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 416480 sectors (213 MB) w/32KiB Cache, CHS=685/16/38
Partition check:
  hda: hda1
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: ESS ES1869 Plug and Play AudioDrive detected
sb: ISAPnP reports 'ESS ES1869 Plug and Play AudioDrive' at i/o 0x220, 
irq 5, dma 1, 3
sb: 1 Soundblaster PnP card(s) found. 

NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 1024)
ip_conntrack version 2.1 (64 buckets, 512 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Kernel panic: Out of memory and no killable processes...
========================================================================

Notes:

Various software versions and hardware descriptions are in the dmesg 
output, however if there is something missing please ask.

If I boot with the large initrd image first, then copy the small one to 
the system, then do a soft reboot then the system detects the correct 
memory with the small initrd image.  This works great until I need to 
hard reboot again.

I have noticed this on several kernel versions.  2.4.21, 2.4.20, and 2.4.18.

The initrd images do not need to be exactly the same.  All I did to 
create the larger image was copy a couple of large binaries into the 
rootfs before making the roofs image.

Commands used to create the image:

dd if=/dev/zero of=rootfs.img bs=1k count=32768
/sbin/mke2fs -q -F -m 0 -N 2000 rootfs.img
mount -o loop -t ext2 rootfs.img mnt
cp -a rootfs/* mnt
/sbin/ldconfig -r mnt
umount mnt
dd if=rootfs.img bs=1k | gzip -v9 > rootfs.gz

I create a new file system and copy over the rootfs every time to avoid 
fs fragmentation and wasted space.

Kernel arguments:
mem=64M console=ttyS0,9600n8r load_ramdisk=1 initrd=rootfs.gz 
root=/dev/ram ramdisk_size=32768 ether=9,0x320,0,0x3c509,eth0 
ether=10,0x330,0,0x3c509,eth1

Any Ideas on why this odd behavior might be showing up?

Thanks,

schu

