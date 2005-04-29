Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262763AbVD2Ow7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbVD2Ow7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbVD2Ovr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:51:47 -0400
Received: from mail.microway.com ([64.80.227.22]:36233 "EHLO mail.microway.com")
	by vger.kernel.org with ESMTP id S262763AbVD2OqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:46:15 -0400
From: Rick Warner <rick@microway.com>
Organization: Microway, Inc.
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: very strange issue with sata,<4G Ram, and ext3
Date: Fri, 29 Apr 2005 10:45:58 -0400
User-Agent: KMail/1.7.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200504281216.08026.rick@microway.com> <1114728503.24687.248.camel@localhost.localdomain>
In-Reply-To: <1114728503.24687.248.camel@localhost.localdomain>
Message-Id: <200504291045.58893.rick@microway.com>
X-Sanitizer: Advosys mail filter
MIME-Version: 1.0
Content-Type: Multipart/Mixed; boundary="MIMEStream=_0+228666_922755298866_559463914737"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MIMEStream=_0+228666_922755298866_559463914737
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 28 April 2005 06:48 pm, Alan Cox wrote:
> On Iau, 2005-04-28 at 17:16, Rick Warner wrote:
> >  On these systems, we are getting ext2 errors from the initrd during the
> > untarring.  Soon after, we start getting seg faults on random things
> > (looks like stuff caused by the still running dhcp client), and then a
> > continuous stream of segfaults on the restore script itself (restore[1]).
>
> This sounds almost like the pxe/boot code is still using ram that the
> kernel has now used (eg the PXE layer or pxe booter forgot to close the
> client and
> its still DMAing happily into the kernel)
This morning, we tried updating to a newer pxelinux (3.07) and had the same 
results.  We then tried using etherboot with a mknbi tagged image and also 
had the same results.   Since we are getting the same problem on 3 different 
motherboards with 2 different network adapters, I have not looked into 
updating the boot rom on the nics.  Should I?

What should I look into next?  I have attached a serial console log of the 
system and errors.  The slashes and pipes you see are from a spinning bar 
thing.  If you want output that is cleaned up without that, I can provide it.

-- 
Richard Warner
Lead Systems Integrator
Microway, Inc
(508)732-5517

--MIMEStream=_0+228666_922755298866_559463914737
Content-Type: text/plain; charset="iso-8859-1"; name="new-pxelinux.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="new-pxelinux.txt"

Bootdata ok (command line is initrd=initrd.img.gz ramdisk_size=46080 rw root=/dev/ram0 devfs=nomount init=/restore console=tty0 console=ttyS0,115200 BOOT_IMAGE=vmlinuz )
Linux version 2.6.12-rc3-em64t-mcms (root@master.cl.usgs.gov) (gcc version 3.4.3 20041212 (Red Hat 3.4.3-9.EL4)) #6 Thu Apr 28 10:11:16 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b400 (usable)
 BIOS-e820: 000000000009b400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff70000 (usable)
 BIOS-e820: 000000007ff70000 - 000000007ff78000 (ACPI data)
 BIOS-e820: 000000007ff78000 - 000000007ff80000 (ACPI NVS)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    <6>Product ID: Lindenhurst  <6>APIC at: 0xFEE00000
Processor #0 15:4 APIC version 20
Processor #6 15:4 APIC version 20
WARNING: NR_CPUS limit of 1 reached. Processor ignored.
I/O APIC #2 Version 32 at 0xFEC00000.
I/O APIC #3 Version 32 at 0xFEC80000.
I/O APIC #4 Version 32 at 0xFEC80400.
I/O APIC #5 Version 32 at 0xFEC84000.
I/O APIC #8 Version 32 at 0xFEC84400.
Setting APIC routing to flat
Processors: 1
Allocating PCI resources starting at 80000000 (gap: 80000000:60000000)
Checking aperture...
Built 1 zonelists
Kernel command line: initrd=initrd.img.gz ramdisk_size=46080 rw root=/dev/ram0 devfs=nomount init=/restore console=tty0 console=ttyS0,115200 BOOT_IMAGE=vmlinuz 
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 3000.254 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Placing software IO TLB between 0x3243000 - 0x5243000
Memory: 2007900k/2096576k available (2932k kernel code, 87916k reserved, 1263k data, 140k init)
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
using mwait in idle threads.
CPU0: Thermal monitoring enabled (TM1)
CPU:                   Intel(R) Xeon(TM) CPU 3.00GHz stepping 01
Using IO APIC NMI watchdog
Using IO-APIC 2
Using IO-APIC 3
Using IO-APIC 4
Using IO-APIC 5
Using IO-APIC 8
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
PCI->APIC IRQ transform: 0000:00:02.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:04.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:06.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:1d.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:1d.1[B] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:1d.2[C] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:1d.3[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:1d.7[D] -> IRQ 23
PCI->APIC IRQ transform: 0000:00:1f.2[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 17
PCI->APIC IRQ transform: 0000:03:02.0[A] -> IRQ 54
PCI->APIC IRQ transform: 0000:03:02.1[B] -> IRQ 55
PCI->APIC IRQ transform: 0000:08:01.0[A] -> IRQ 17
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
JFS: nTxBlock = 8192, nTxLock = 65536
SGI XFS with large block/inode numbers, no debug enabled
Linux agpgart interface v0.101 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 8 RAM disks of 46080K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ata1: SATA max UDMA/133 cmd 0x14E8 ctl 0x14DE bmdma 0x14B0 irq 18
ata2: SATA max UDMA/133 cmd 0x14E0 ctl 0x14DA bmdma 0x14B8 irq 18
ata1: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: SATA port has no device.
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 112Kbytes
TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 3670016 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 140k freed
Turning on debugging options.
Intel(R) PRO/1000 Network Driver - version 5.7.6-k2
Copyright (c) 1999-2004 Intel Corporation.
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
Internet Software Consortium DHCP Client V3.0.1rc13
Copyright 1995-2002 Internet Software Consortium.
All rights reserved.
For info, please visit http://www.isc.org/products/DHCP

e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
Listening on LPF/eth1/00:30:48:74:a5:71
Sending on   LPF/eth1/00:30:48:74:a5:71
Listening on LPF/eth0/00:30:48:74:a5:70
Sending on   LPF/eth0/00:30:48:74:a5:70
Listening on LPF/lo/
Sending on   LPF/lo/
Sending on   Socket/fallback
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 3
DHCPDISCOVER on lo to 255.255.255.255 port 67 interval 2
DHCPOFFER from 10.0.0.1
DHCPDISCOVER on eth1 to 255.255.255.255 port 67 interval 3
DHCPDISCOVER on lo to 255.255.255.255 port 67 interval 3
DHCPDISCOVER on eth1 to 255.255.255.255 port 67 interval 4
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPDISCOVER on lo to 255.255.255.255 port 67 interval 5
DHCPACK from 10.0.0.1
bound to 10.0.0.100 -- renewal in 1455 seconds.
Brought up network devices.
Setting date to match master
Permission denied.
Fri Apr 29 01:51:44 EDT 2005
nfs warning: mount version older than kernel
Checking that noSCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
-one is using thSCSI device sda: drive cache: write back
is disk right no sda:w ...
 sda1 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >
OK

Disk /dev/sda: 24792 cylinders, 255 heads, 63 sectors/track
Old situation:
Units = cylinders of 8225280 bytes, blocks of 1024 bytes, counting from 0

   Device Boot Start     End   #cyls    #blocks   Id  System
/dev/sda1          0+      9      10-     80293+  83  Linux
/dev/sda2          0       -       0          0    0  Empty
/dev/sda3          0       -       0          0    0  Empty
/dev/sda4         10   24791   24782  199061415    5  Extended
/dev/sda5         10+    253     244-   1959898+  83  Linux
/dev/sda6        254+   1470    1217-   9775521   83  Linux
/dev/sda7       1471+   1836     366-   2939863+  83  Linux
/dev/sda8       1837+   2202     366-   2939863+  83  Linux
/dev/sda9       2203+   2689     487-   3911796   82  Linux swap
/dev/sda10      2690+  24791   22102- 177534283+  83  Linux
New situation:
Units = sectors of 512 bytes, counting from 0

   Device Boot    Start       End   #sectors  Id  System
/dev/sda1            63    160649     160587  83  Linux
/dev/sda2             0         -          0   0  Empty
/dev/sda3             0         -          0   0  Empty
/dev/sda4        160650 398283479  398122830   5  Extended
/dev/sda5        160713   4080509    3919797  83  Linux
/dev/sda6       4080573  23631614   19551042  83  Linux
/dev/sda7      23631678  29511404    5879727  83  Linux
/dev/sda8      29511468  35391194    5879727  83  Linux
/dev/sda9      35391258  43214849    7823592  82  Linux swap
/dev/sda10     43214913 398283479  355068567  83  Linux
Warning: no primary partition is marked bootable (active)
This does not matter for LILO, but the DOS MBR will not boot this disk.
Successfully wrote the new partition table

Re-reading the partition table ...
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >

If you created or changed a DOS partition, /dev/foo7, say, then use dd(1)
to zero the first 512 bytes:  dd if=/dev/zero of=/dev/foo7 bs=512 count=1
(See fdisk(8).)
grep: /mnt/raidtab: No such file or directory
Created ext2/3 filesystem on /dev/sda1
Created ext2/3 filesystem on /dev/sda5
Created ext2/3 filesystem on /dev/sda6
Created ext2/3 filesystem on /dev/sda7
Created ext2/3 filesystem on /dev/sda8
Created ext2/3 filesystem on /dev/sda10
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Mounted /dev/sda5 at /drive
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Mounted /dev/sda1 at /drive/boot
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Mounted /dev/sda6 at /drive/usr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Mounted /dev/sda7 at /drive/var
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Mounted /dev/sda8 at /drive/tmp
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Mounted /dev/sda10 at /drive/home
Adding 3911788k swap on /dev/sda9.  Priority:-1 extents:1
Swapspace /dev/sda9 initialized and added
Restoring drive....
						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #3345: rec_len is smaller than minimal - offset=24576, inode=0, rec_len=0, name_len=0
EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #3345: rec_len is smaller than minimal - offset=28672, inode=0, rec_len=0, name_len=0
EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #3345: rec_len is smaller than minimal - offset=32768, inode=0, rec_len=0, name_len=0
EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #3345: rec_len is smaller than minimal - offset=36864, inode=0, rec_len=0, name_len=0
EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #3345: rec_len is smaller than minimal - offset=40960, inode=0, rec_len=0, name_len=0
						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #3345: rec_len is smaller than minimal - offset=12288, inode=0, rec_len=0, name_len=0
EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #3345: rec_len is smaller than minimal - offset=16384, inode=0, rec_len=0, name_len=0
uname[1129]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffefe920 error 4
sed[1133]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffb99d90 error 4
sed[1136]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffcbdf90 error 4
						\						|						/						-						\						|						/						-						\						|uname[1150]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffac5a40 error 4
						/sed[1155]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffb24b70 error 4
sed[1158]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffa44d50 error 4
						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #3345: rec_len is smaller than minimal - offset=12288, inode=0, rec_len=0, name_len=0
EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #3345: rec_len is smaller than minimal - offset=16384, inode=0, rec_len=0, name_len=0
uname[1231]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007ffffff0d1f0 error 4
sed[1235]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffd9aea0 error 4
sed[1238]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffbb5710 error 4
						-uname[1242]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffcc1300 error 4
sed[1246]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007ffffffe9910 error 4
sed[1249]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffef7ce0 error 4
						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #3345: rec_len is smaller than minimal - offset=20480, inode=0, rec_len=0, name_len=0
EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #3345: rec_len is smaller than minimal - offset=24576, inode=0, rec_len=0, name_len=0
EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #3345: rec_len is smaller than minimal - offset=28672, inode=0, rec_len=0, name_len=0
EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #3345: rec_len is smaller than minimal - offset=32768, inode=0, rec_len=0, name_len=0
EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #3345: rec_len is smaller than minimal - offset=36864, inode=0, rec_len=0, name_len=0
EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #3345: rec_len is smaller than minimal - offset=40960, inode=0, rec_len=0, name_len=0
uname[1307]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffbce170 error 4
sed[1311]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffff96b900 error 4
sed[1314]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffff9557d0 error 4
						|						/						-						\						|						/						-						\						|						/						-						\uname[1330]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffbb4930 error 4
sed[1334]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffff9200d0 error 4
sed[1337]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007ffffff780f0 error 4
						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-uname[1395]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffa83250 error 4
sed[1399]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007ffffffa8380 error 4
sed[1402]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffbc0690 error 4
						\						|						/						-						\						|						/						-						\						|uname[1419]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007ffffff07bf0 error 4
sed[1423]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffff82cb00 error 4
sed[1426]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffa072b0 error 4
						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-						\						|						/						-EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #3345: rec_len is smaller than minimal - offset=12288, inode=0, rec_len=0, name_len=0
EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #3345: rec_len is smaller than minimal - offset=16384, inode=0, rec_len=0, name_len=0
uname[1482]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffc3af00 error 4
						\sed[1487]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffd3c3c0 error 4
sed[1490]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffbe9b10 error 4
						|						/						-						\						|						/						-						\						|						/						-						\uname[1505]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffeda150 error 4
sed[1509]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007ffffff6b310 error 4
sed[1512]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffff9bed80 error 4
						|
mkdir[1514]: segfault at 0000000000000008 rip 00002aaaaaab1dff rsp 00007fffff815d60 error 4
/restore: line 1mkdir[1515]: segfault at 0000000000000008 rip 00002aaaaaab1dff rsp 00007fffff994c70 error 4
72:  1514 Segmenchmod[1516]: segfault at 0000000000000008 rip 00002aaaaaab3ce7 rsp 00007fffffa8f3b0 error 4
tation fault    restore[1517]: segfault at 0000000000000004 rip 00000000004322a2 rsp 00007fffffca6e58 error 6
  mkdir /drive/drive
File Restoration complete.Kernel panic - not syncing: Attempted to kill init!

Ensuring /medi a/floppy and /media/cdrom have been created
/restore: line 177:  1515 Segmentation fault      mkdir -p /drive/media/floppy /drive/media/cdrom /drive/media/dvd
Ensuring correct permissions on tmp
/restore: line 180:  1516 Segmentation fault      chmod 1777 /drive/tmp
/restore: line 190:  1517 Segmentation fault      chroot /drive $GRUB --batch --no-floppy  >&/dev/null <<EOF
device (hd0) ${device_save[0]}
root (hd0,0)
setup (hd0)
EOF

Unable to run grub on /dev/sda
/restore: line 195:  1518 Segmentation fault      bash

--MIMEStream=_0+228666_922755298866_559463914737--
