Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTH3DU1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 23:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbTH3DU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 23:20:27 -0400
Received: from mail.skjellin.no ([80.239.42.67]:12716 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S262363AbTH3DTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 23:19:40 -0400
Message-ID: <3F5017CA.4080700@tomt.net>
Date: Sat, 30 Aug 2003 05:19:38 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030820 Mozilla Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mingo@redhat.com, neilb@cse.unsw.edu.au
Subject: md: bug in file md.c, line 1440 (2.4.22)
Content-Type: multipart/mixed;
 boundary="------------000405040803040006020401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000405040803040006020401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Heya :-)

Having a funny showstopper problem here with md, the autostart fails 
miserably with "md: bug in file md.c, line 1440"

Here's the story;

A few weeks ago, when running 2.4.22-pre7, I had to temporarily jank out 
a drive from a two drive md raid 1 setup, a raid1 setup that had been 
working flawlessly for ages.

Then, some days ago, I added the drive back in, as I got it back. I 
raidhotadd'ed the partitions after cloning back the partition table with 
sfdisk. All swell, I though, untill I decided to upgrade kernel to 
2.4.22, wich of course means a reboot.

Reboot, boom. Unable to mount root fs. Tried to boot old 2.4.22-pre7 
kernel again, still boom. Janking the hdc drive again lets it boot 
normally again. Tried adding the hdc drive in another computer and dd 
if=/dev/zero'ed it, moved it back, recreated the partitions manually, 
and hotadded. Same problem, works fine, until I reboot.

minicom dump and raidtab attached, should contain most relevant 
information. If not, yell. The system is running Debian Unstable. Notice 
the kernel command line, hdc has overridden geometry. The two drives are 
identical, still the bios or whatever is giving them away differently. 
The override "had" to be done to get the raid up and running properly.

--------------000405040803040006020401
Content-Type: text/plain;
 name="raidtab"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="raidtab"

# /boot
raiddev                 /dev/md0
raid-level              1
nr-raid-disks           2
chunk-size              32
nr-spare-disks          0
persistent-superblock   1
device                  /dev/hda1
raid-disk             0
device                  /dev/hdc1
raid-disk               1

# swap
raiddev                 /dev/md1
raid-level              1
nr-raid-disks           2
chunk-size              32
nr-spare-disks          0
persistent-superblock   1
device                  /dev/hda5
raid-disk             0
device                  /dev/hdc5
raid-disk               1

# /
raiddev                 /dev/md2
raid-level              1
nr-raid-disks           2
chunk-size              32
nr-spare-disks          0
persistent-superblock   1
device                  /dev/hda6
raid-disk             0
device                  /dev/hdc6
raid-disk               1

# /tmp
raiddev                 /dev/md3
raid-level              1
nr-raid-disks           2
chunk-size              32
nr-spare-disks          0
persistent-superblock   1
device                  /dev/hda7
raid-disk             0
device                  /dev/hdc7
raid-disk               1

# /var
raiddev                 /dev/md4
raid-level              1
nr-raid-disks           2
chunk-size              32
nr-spare-disks          0
persistent-superblock   1
device                  /dev/hda8
raid-disk             0
device                  /dev/hdc8
raid-disk               1

# /home
raiddev                 /dev/md5
raid-level              1
nr-raid-disks           2
chunk-size              32
nr-spare-disks          0
persistent-superblock   1
device                  /dev/hda9
raid-disk             0
device                  /dev/hdc9
raid-disk               1

--------------000405040803040006020401
Content-Type: text/plain;
 name="minicom.cap"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="minicom.cap"

Linux version 2.4.22-s2 (root@kvass) (gcc version 3.3.2 20030812 (Debian prerelease)) #1 Sat Aug 30 01:46:47 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
ACPI disabled because your bios is from 2000                       and too old
You can enable it with acpi=force
ACPI: RSDP (v000 AMI                                       ) @ 0x000faf50
ACPI: RSDT (v001 AMIINT          0x00000010 MSFT 0x00000097) @ 0x0fff0000
ACPI: FADT (v001 AMIINT          0x00000010 MSFT 0x00000097) @ 0x0fff0030
ACPI: DSDT (v001   ASUS      K7M 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: MADT not present
Kernel command line: auto BOOT_IMAGE=2422s2 ro root=902 hdc=3737,255,63 console=ttyS0,9600
ide_setup: hdc=3737,255,63
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 704.946 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1405.74 BogoMIPS
Memory: 256720k/262080k available (1304k kernel code, 4972k reserved, 303k data, 276k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 704.8864 MHz.
..... host bus clock speed is 201.3960 MHz.
cpu: 0, clocks: 2013960, slice: 1006980
CPU0<T0:2013952,T1:1006960,D:12,S:1006980,C:2013960>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030813
ACPI: Interpreter disabled.
PCI: PCI BIOS revision 2.10 entry at 0xfd9e1, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
PCI: Disabling Via external APIC routing
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Detected PS/2 Mouse Port.
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Software Watchdog Timer: 0.05, timer margin: 60 sec
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:04.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 1b) IDE UDMA66 controller on pci00:04.1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DTLA-307030, ATA DISK drive
blk: queue c03049c0, I/O limit 4095Mb (mask 0xffffffff)
hdc: IBM-DTLA-307030, ATA DISK drive
blk: queue c0304e14, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
spurious 8259A interrupt: IRQ7.
hda: host protected area => 1
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(66)
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(66)
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
 hdc: hdc1 hdc2 < hdc5 hdc6 hdc7 hdc8 hdc9 >
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 0000006d]
 [events: 0000006d]
 [events: 0000006d]
 [events: 0000006d]
 [events: 0000006d]
 [events: 0000006d]
 [events: 0000006d]
 [events: 0000006d]
 [events: 0000006d]
 [events: 0000006d]
 [events: 0000006d]
 [events: 0000006d]
md: autorun ...
md: considering hdc9 ...
md:  adding hdc9 ...
md:  adding hda9 ...
md: created md5
md: bind<hda9,1>
md: bind<hdc9,2>
md: running: <hdc9><hda9>
md: hdc9's event counter: 0000006d
md: hda9's event counter: 0000006d
md5: kicking faulty hdc9!
md: unbind<hdc9,1>
md: export_rdev(hdc9)
md: bug in file md.c, line 1440

md:	**********************************
md:	* <COMPLETE RAID STATE PRINTOUT> *
md:	**********************************
md5: <hda9> array superblock:
md:  SB: (V:0.90.0) ID:<80012e77.b449af86.6bccffae.ddda9474> CT:3e4caa02
md:     L1 S24394560 ND:-22 RD:2 md5 LO:0 CS:32768
md:     UT:3f50117d ST:1 AD:2 WD:2 FD:-24 SD:0 CSUM:a62f39ca E:0000006d
     D  0:  DISK<N:0,hdc9(22,9),R:0,S:6>
     D  1:  DISK<N:1,hda9(3,9),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:0,hdc9(22,9),R:0,S:6>
md: rdev hda9: O:hda9, SZ:00000000 F:0 DN:1 <6>md: rdev superblock:
md:  SB: (V:0.90.0) ID:<80012e77.b449af86.6bccffae.ddda9474> CT:3e4caa02
md:     L1 S24394560 ND:-21 RD:2 md5 LO:0 CS:32768
md:     UT:3f50117d ST:1 AD:2 WD:2 FD:-23 SD:0 CSUM:a62f39b9 E:0000006d
     D  0:  DISK<N:0,hdc9(22,9),R:0,S:6>
     D  1:  DISK<N:1,hda9(3,9),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:1,hda9(3,9),R:1,S:6>
md:	**********************************

md: bug in file md.c, line 1650

md:	**********************************
md:	* <COMPLETE RAID STATE PRINTOUT> *
md:	**********************************
md5: <hda9> array superblock:
md:  SB: (V:0.90.0) ID:<80012e77.b449af86.6bccffae.ddda9474> CT:3e4caa02
md:     L1 S24394560 ND:-22 RD:2 md5 LO:0 CS:32768
md:     UT:3f50117d ST:1 AD:2 WD:2 FD:-24 SD:0 CSUM:a62f39ca E:0000006d
     D  0:  DISK<N:0,hdc9(22,9),R:0,S:6>
     D  1:  DISK<N:1,hda9(3,9),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:0,hdc9(22,9),R:0,S:6>
md: rdev hda9: O:hda9, SZ:00000000 F:0 DN:1 <6>md: rdev superblock:
md:  SB: (V:0.90.0) ID:<80012e77.b449af86.6bccffae.ddda9474> CT:3e4caa02
md:     L1 S24394560 ND:-21 RD:2 md5 LO:0 CS:32768
md:     UT:3f50117d ST:1 AD:2 WD:2 FD:-23 SD:0 CSUM:a62f39b9 E:0000006d
     D  0:  DISK<N:0,hdc9(22,9),R:0,S:6>
     D  1:  DISK<N:1,hda9(3,9),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:1,hda9(3,9),R:1,S:6>
md:	**********************************

md :do_md_run() returned -22
md: md5 stopped.
md: unbind<hda9,0>
md: export_rdev(hda9)
md: considering hdc8 ...
md:  adding hdc8 ...
md:  adding hda8 ...
md: created md4
md: bind<hda8,1>
md: bind<hdc8,2>
md: running: <hdc8><hda8>
md: hdc8's event counter: 0000006d
md: hda8's event counter: 0000006d
md4: kicking faulty hdc8!
md: unbind<hdc8,1>
md: export_rdev(hdc8)
md: bug in file md.c, line 1440

md:	**********************************
md:	* <COMPLETE RAID STATE PRINTOUT> *
md:	**********************************
md4: <hda8> array superblock:
md:  SB: (V:0.90.0) ID:<42c9b878.4c5fd02d.4db1c3b9.c1fa2e55> CT:3e4ca9fb
md:     L1 S00995904 ND:-22 RD:2 md4 LO:0 CS:32768
md:     UT:3f50117d ST:1 AD:2 WD:2 FD:-24 SD:0 CSUM:c5ad3952 E:0000006d
     D  0:  DISK<N:0,hdc8(22,8),R:0,S:6>
     D  1:  DISK<N:1,hda8(3,8),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:0,hdc8(22,8),R:0,S:6>
md: rdev hda8: O:hda8, SZ:00000000 F:0 DN:1 <6>md: rdev superblock:
md:  SB: (V:0.90.0) ID:<42c9b878.4c5fd02d.4db1c3b9.c1fa2e55> CT:3e4ca9fb
md:     L1 S00995904 ND:-21 RD:2 md4 LO:0 CS:32768
md:     UT:3f50117d ST:1 AD:2 WD:2 FD:-23 SD:0 CSUM:c5ad3941 E:0000006d
     D  0:  DISK<N:0,hdc8(22,8),R:0,S:6>
     D  1:  DISK<N:1,hda8(3,8),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:1,hda8(3,8),R:1,S:6>
md:	**********************************

md: bug in file md.c, line 1650

md:	**********************************
md:	* <COMPLETE RAID STATE PRINTOUT> *
md:	**********************************
md4: <hda8> array superblock:
md:  SB: (V:0.90.0) ID:<42c9b878.4c5fd02d.4db1c3b9.c1fa2e55> CT:3e4ca9fb
md:     L1 S00995904 ND:-22 RD:2 md4 LO:0 CS:32768
md:     UT:3f50117d ST:1 AD:2 WD:2 FD:-24 SD:0 CSUM:c5ad3952 E:0000006d
     D  0:  DISK<N:0,hdc8(22,8),R:0,S:6>
     D  1:  DISK<N:1,hda8(3,8),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:0,hdc8(22,8),R:0,S:6>
md: rdev hda8: O:hda8, SZ:00000000 F:0 DN:1 <6>md: rdev superblock:
md:  SB: (V:0.90.0) ID:<42c9b878.4c5fd02d.4db1c3b9.c1fa2e55> CT:3e4ca9fb
md:     L1 S00995904 ND:-21 RD:2 md4 LO:0 CS:32768
md:     UT:3f50117d ST:1 AD:2 WD:2 FD:-23 SD:0 CSUM:c5ad3941 E:0000006d
     D  0:  DISK<N:0,hdc8(22,8),R:0,S:6>
     D  1:  DISK<N:1,hda8(3,8),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:1,hda8(3,8),R:1,S:6>
md:	**********************************

md :do_md_run() returned -22
md: md4 stopped.
md: unbind<hda8,0>
md: export_rdev(hda8)
md: considering hdc7 ...
md:  adding hdc7 ...
md:  adding hda7 ...
md: created md3
md: bind<hda7,1>
md: bind<hdc7,2>
md: running: <hdc7><hda7>
md: hdc7's event counter: 0000006d
md: hda7's event counter: 0000006d
md3: kicking faulty hdc7!
md: unbind<hdc7,1>
md: export_rdev(hdc7)
md: bug in file md.c, line 1440

md:	**********************************
md:	* <COMPLETE RAID STATE PRINTOUT> *
md:	**********************************
md3: <hda7> array superblock:
md:  SB: (V:0.90.0) ID:<d21c7ff1.505b6d3f.fba0f396.be6a31cd> CT:3e4ca9f5
md:     L1 S00497856 ND:-22 RD:2 md3 LO:0 CS:32768
md:     UT:3f50117d ST:1 AD:2 WD:2 FD:-24 SD:0 CSUM:035337aa E:0000006d
     D  0:  DISK<N:0,hdc7(22,7),R:0,S:6>
     D  1:  DISK<N:1,hda7(3,7),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:0,hdc7(22,7),R:0,S:6>
md: rdev hda7: O:hda7, SZ:00000000 F:0 DN:1 <6>md: rdev superblock:
md:  SB: (V:0.90.0) ID:<d21c7ff1.505b6d3f.fba0f396.be6a31cd> CT:3e4ca9f5
md:     L1 S00497856 ND:-21 RD:2 md3 LO:0 CS:32768
md:     UT:3f50117d ST:1 AD:2 WD:2 FD:-23 SD:0 CSUM:03533799 E:0000006d
     D  0:  DISK<N:0,hdc7(22,7),R:0,S:6>
     D  1:  DISK<N:1,hda7(3,7),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:1,hda7(3,7),R:1,S:6>
md:	**********************************

md: bug in file md.c, line 1650

md:	**********************************
md:	* <COMPLETE RAID STATE PRINTOUT> *
md:	**********************************
md3: <hda7> array superblock:
md:  SB: (V:0.90.0) ID:<d21c7ff1.505b6d3f.fba0f396.be6a31cd> CT:3e4ca9f5
md:     L1 S00497856 ND:-22 RD:2 md3 LO:0 CS:32768
md:     UT:3f50117d ST:1 AD:2 WD:2 FD:-24 SD:0 CSUM:035337aa E:0000006d
     D  0:  DISK<N:0,hdc7(22,7),R:0,S:6>
     D  1:  DISK<N:1,hda7(3,7),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:0,hdc7(22,7),R:0,S:6>
md: rdev hda7: O:hda7, SZ:00000000 F:0 DN:1 <6>md: rdev superblock:
md:  SB: (V:0.90.0) ID:<d21c7ff1.505b6d3f.fba0f396.be6a31cd> CT:3e4ca9f5
md:     L1 S00497856 ND:-21 RD:2 md3 LO:0 CS:32768
md:     UT:3f50117d ST:1 AD:2 WD:2 FD:-23 SD:0 CSUM:03533799 E:0000006d
     D  0:  DISK<N:0,hdc7(22,7),R:0,S:6>
     D  1:  DISK<N:1,hda7(3,7),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:1,hda7(3,7),R:1,S:6>
md:	**********************************

md :do_md_run() returned -22
md: md3 stopped.
md: unbind<hda7,0>
md: export_rdev(hda7)
md: considering hdc6 ...
md:  adding hdc6 ...
md:  adding hda6 ...
md: created md2
md: bind<hda6,1>
md: bind<hdc6,2>
md: running: <hdc6><hda6>
md: hdc6's event counter: 0000006d
md: hda6's event counter: 0000006d
md2: kicking faulty hdc6!
md: unbind<hdc6,1>
md: export_rdev(hdc6)
md: bug in file md.c, line 1440

md:	**********************************
md:	* <COMPLETE RAID STATE PRINTOUT> *
md:	**********************************
md2: <hda6> array superblock:
md:  SB: (V:0.90.0) ID:<7b8ea5a9.fbdb4b8a.baf920bb.d640a175> CT:3e4ca9ef
md:     L1 S03036160 ND:-22 RD:2 md2 LO:0 CS:32768
md:     UT:3f50117c ST:1 AD:2 WD:2 FD:-24 SD:0 CSUM:2f9a93af E:0000006d
     D  0:  DISK<N:0,hdc6(22,6),R:0,S:6>
     D  1:  DISK<N:1,hda6(3,6),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:0,hdc6(22,6),R:0,S:6>
md: rdev hda6: O:hda6, SZ:00000000 F:0 DN:1 <6>md: rdev superblock:
md:  SB: (V:0.90.0) ID:<7b8ea5a9.fbdb4b8a.baf920bb.d640a175> CT:3e4ca9ef
md:     L1 S03036160 ND:-21 RD:2 md2 LO:0 CS:32768
md:     UT:3f50117c ST:1 AD:2 WD:2 FD:-23 SD:0 CSUM:2f9a939e E:0000006d
     D  0:  DISK<N:0,hdc6(22,6),R:0,S:6>
     D  1:  DISK<N:1,hda6(3,6),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:1,hda6(3,6),R:1,S:6>
md:	**********************************

md: bug in file md.c, line 1650

md:	**********************************
md:	* <COMPLETE RAID STATE PRINTOUT> *
md:	**********************************
md2: <hda6> array superblock:
md:  SB: (V:0.90.0) ID:<7b8ea5a9.fbdb4b8a.baf920bb.d640a175> CT:3e4ca9ef
md:     L1 S03036160 ND:-22 RD:2 md2 LO:0 CS:32768
md:     UT:3f50117c ST:1 AD:2 WD:2 FD:-24 SD:0 CSUM:2f9a93af E:0000006d
     D  0:  DISK<N:0,hdc6(22,6),R:0,S:6>
     D  1:  DISK<N:1,hda6(3,6),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:0,hdc6(22,6),R:0,S:6>
md: rdev hda6: O:hda6, SZ:00000000 F:0 DN:1 <6>md: rdev superblock:
md:  SB: (V:0.90.0) ID:<7b8ea5a9.fbdb4b8a.baf920bb.d640a175> CT:3e4ca9ef
md:     L1 S03036160 ND:-21 RD:2 md2 LO:0 CS:32768
md:     UT:3f50117c ST:1 AD:2 WD:2 FD:-23 SD:0 CSUM:2f9a939e E:0000006d
     D  0:  DISK<N:0,hdc6(22,6),R:0,S:6>
     D  1:  DISK<N:1,hda6(3,6),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:1,hda6(3,6),R:1,S:6>
md:	**********************************

md :do_md_run() returned -22
md: md2 stopped.
md: unbind<hda6,0>
md: export_rdev(hda6)
md: considering hdc5 ...
md:  adding hdc5 ...
md:  adding hda5 ...
md: created md1
md: bind<hda5,1>
md: bind<hdc5,2>
md: running: <hdc5><hda5>
md: hdc5's event counter: 0000006d
md: hda5's event counter: 0000006d
md1: kicking faulty hdc5!
md: unbind<hdc5,1>
md: export_rdev(hdc5)
md: bug in file md.c, line 1440

md:	**********************************
md:	* <COMPLETE RAID STATE PRINTOUT> *
md:	**********************************
md1: <hda5> array superblock:
md:  SB: (V:0.90.0) ID:<bd67f00e.7bc0d212.e92f6374.7256c93a> CT:3e4ca9e8
md:     L1 S00995904 ND:-22 RD:2 md1 LO:0 CS:32768
md:     UT:3f50117c ST:1 AD:2 WD:2 FD:-24 SD:0 CSUM:bb86ad4e E:0000006d
     D  0:  DISK<N:0,hdc5(22,5),R:0,S:6>
     D  1:  DISK<N:1,hda5(3,5),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:0,hdc5(22,5),R:0,S:6>
md: rdev hda5: O:hda5, SZ:00000000 F:0 DN:1 <6>md: rdev superblock:
md:  SB: (V:0.90.0) ID:<bd67f00e.7bc0d212.e92f6374.7256c93a> CT:3e4ca9e8
md:     L1 S00995904 ND:-21 RD:2 md1 LO:0 CS:32768
md:     UT:3f50117c ST:1 AD:2 WD:2 FD:-23 SD:0 CSUM:bb86ad3d E:0000006d
     D  0:  DISK<N:0,hdc5(22,5),R:0,S:6>
     D  1:  DISK<N:1,hda5(3,5),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:1,hda5(3,5),R:1,S:6>
md:	**********************************

md: bug in file md.c, line 1650

md:	**********************************
md:	* <COMPLETE RAID STATE PRINTOUT> *
md:	**********************************
md1: <hda5> array superblock:
md:  SB: (V:0.90.0) ID:<bd67f00e.7bc0d212.e92f6374.7256c93a> CT:3e4ca9e8
md:     L1 S00995904 ND:-22 RD:2 md1 LO:0 CS:32768
md:     UT:3f50117c ST:1 AD:2 WD:2 FD:-24 SD:0 CSUM:bb86ad4e E:0000006d
     D  0:  DISK<N:0,hdc5(22,5),R:0,S:6>
     D  1:  DISK<N:1,hda5(3,5),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:0,hdc5(22,5),R:0,S:6>
md: rdev hda5: O:hda5, SZ:00000000 F:0 DN:1 <6>md: rdev superblock:
md:  SB: (V:0.90.0) ID:<bd67f00e.7bc0d212.e92f6374.7256c93a> CT:3e4ca9e8
md:     L1 S00995904 ND:-21 RD:2 md1 LO:0 CS:32768
md:     UT:3f50117c ST:1 AD:2 WD:2 FD:-23 SD:0 CSUM:bb86ad3d E:0000006d
     D  0:  DISK<N:0,hdc5(22,5),R:0,S:6>
     D  1:  DISK<N:1,hda5(3,5),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:1,hda5(3,5),R:1,S:6>
md:	**********************************

md :do_md_run() returned -22
md: md1 stopped.
md: unbind<hda5,0>
md: export_rdev(hda5)
md: considering hdc1 ...
md:  adding hdc1 ...
md:  adding hda1 ...
md: created md0
md: bind<hda1,1>
md: bind<hdc1,2>
md: running: <hdc1><hda1>
md: hdc1's event counter: 0000006d
md: hda1's event counter: 0000006d
md0: kicking faulty hdc1!
md: unbind<hdc1,1>
md: export_rdev(hdc1)
md: bug in file md.c, line 1440

md:	**********************************
md:	* <COMPLETE RAID STATE PRINTOUT> *
md:	**********************************
md0: <hda1> array superblock:
md:  SB: (V:0.90.0) ID:<193a8155.f02debdc.e3821633.b47fb7fd> CT:3e4ca9df
md:     L1 S00096256 ND:-22 RD:2 md0 LO:0 CS:32768
md:     UT:3f50117c ST:1 AD:2 WD:2 FD:-24 SD:0 CSUM:c8343f8b E:0000006d
     D  0:  DISK<N:0,hdc1(22,1),R:0,S:6>
     D  1:  DISK<N:1,hda1(3,1),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:0,hdc1(22,1),R:0,S:6>
md: rdev hda1: O:hda1, SZ:00000000 F:0 DN:1 <6>md: rdev superblock:
md:  SB: (V:0.90.0) ID:<193a8155.f02debdc.e3821633.b47fb7fd> CT:3e4ca9df
md:     L1 S00096256 ND:-21 RD:2 md0 LO:0 CS:32768
md:     UT:3f50117c ST:1 AD:2 WD:2 FD:-23 SD:0 CSUM:c8343f7a E:0000006d
     D  0:  DISK<N:0,hdc1(22,1),R:0,S:6>
     D  1:  DISK<N:1,hda1(3,1),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:1,hda1(3,1),R:1,S:6>
md:	**********************************

md: bug in file md.c, line 1650

md:	**********************************
md:	* <COMPLETE RAID STATE PRINTOUT> *
md:	**********************************
md0: <hda1> array superblock:
md:  SB: (V:0.90.0) ID:<193a8155.f02debdc.e3821633.b47fb7fd> CT:3e4ca9df
md:     L1 S00096256 ND:-22 RD:2 md0 LO:0 CS:32768
md:     UT:3f50117c ST:1 AD:2 WD:2 FD:-24 SD:0 CSUM:c8343f8b E:0000006d
     D  0:  DISK<N:0,hdc1(22,1),R:0,S:6>
     D  1:  DISK<N:1,hda1(3,1),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:0,hdc1(22,1),R:0,S:6>
md: rdev hda1: O:hda1, SZ:00000000 F:0 DN:1 <6>md: rdev superblock:
md:  SB: (V:0.90.0) ID:<193a8155.f02debdc.e3821633.b47fb7fd> CT:3e4ca9df
md:     L1 S00096256 ND:-21 RD:2 md0 LO:0 CS:32768
md:     UT:3f50117c ST:1 AD:2 WD:2 FD:-23 SD:0 CSUM:c8343f7a E:0000006d
     D  0:  DISK<N:0,hdc1(22,1),R:0,S:6>
     D  1:  DISK<N:1,hda1(3,1),R:1,S:6>
     D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
     D  3:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  4:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  5:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  6:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  7:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  8:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D  9:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 10:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 11:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 12:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 13:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 14:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 15:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 16:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 17:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 18:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 19:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 20:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 21:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 22:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 23:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 24:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 25:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
     D 26:  DISK<N:0,[dev 00:00](0,0),R:0,S:9>
md:     THIS:  DISK<N:1,hda1(3,1),R:1,S:6>
md:	**********************************

md :do_md_run() returned -22
md: md0 stopped.
md: unbind<hda1,0>
md: export_rdev(hda1)
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
EXT3-fs: unable to read superblock
Kernel panic: VFS: Unable to mount root fs on 09:02
 

--------------000405040803040006020401--

