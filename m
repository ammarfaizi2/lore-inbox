Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbTAVNix>; Wed, 22 Jan 2003 08:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266720AbTAVNix>; Wed, 22 Jan 2003 08:38:53 -0500
Received: from mta03ps.bigpond.com ([144.135.25.135]:36049 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S265754AbTAVNiv> convert rfc822-to-8bit; Wed, 22 Jan 2003 08:38:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: lkml <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.21-pre3aa1 and RAID0 issue (was: 2.4.21-pre2aa1 - RAID0 issue.)
Date: Thu, 23 Jan 2003 01:02:25 +1100
User-Agent: KMail/1.4.3
References: <200212270856.13419.harisri@bigpond.com> <200301222007.48055.harisri@bigpond.com>
In-Reply-To: <200301222007.48055.harisri@bigpond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301230102.25399.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wednesday 22 January 2003 20:07, Srihari Vijayaraghavan wrote:
> ...
> The RAID0 doesn't work in 2.4.21-pre3aa1 in my computer, while it is fine
> with 2.4.21-pre3 and 2.4.20-aa1.
> ...

Ok. I did some more testing, and this is what happens:
/sbin/raidstart /dev/md0 executes and exits fine under 2.4.21-pre3. Where as 
under 2.4.21-pre3aa1 it starts executing but _never_ exits (I waited for few 
minutes). I had to kill it using alt + sysrq + k.

I have captured the dmesg outputs of both 2.4.21-pre3aa1 and 2.4.21-pre3 and 
here is the diff between them:
 --- dmesg-2.4.21-pre3aa1	2003-01-23 00:38:11.000000000 +1100
+++ dmesg-2.4.21-pre3	2003-01-23 00:41:11.000000000 +1100
@@ -1,4 +1,4 @@
-Linux version 2.4.21-pre3aa1 (hari@localhost.localdomain) (gcc version 3.2 
20020903 (Red Hat Linux 8.0 3.2-7)) #9 Tue Jan 21 23:27:11 EST 2003
+Linux version 2.4.21-pre3 (hari@localhost.localdomain) (gcc version 3.2 
20020903 (Red Hat Linux 8.0 3.2-7)) #9 Wed Jan 22 19:28:29 EST 2003
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
@@ -12,14 +12,13 @@
 zone(0): 4096 pages.
 zone(1): 126960 pages.
 zone(2): 0 pages.
-Building zonelist for node : 0
 Kernel command line: ro root=/dev/hda5 hdb=ide-scsi single
 ide_setup: hdb=ide-scsi
 Initializing CPU#0
-Detected 1200.072 MHz processor.
+Detected 1200.061 MHz processor.
 Console: colour VGA+ 80x25
 Calibrating delay loop... 2392.06 BogoMIPS
-Memory: 516560k/524224k available (955k kernel code, 7276k reserved, 209k 
data, 220k init, 0k highmem)
+Memory: 516652k/524224k available (923k kernel code, 7184k reserved, 204k 
data, 216k init, 0k highmem)
 Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
 Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
 Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
@@ -45,9 +44,6 @@
 Based upon Swansea University Computer Society NET3.039
 Initializing RT netlink socket
 Starting kswapd
-bigpage subsystem: allocated 0 bigpages (=0MB).
-aio_setup: num_physpages = 32764
-aio_setup: sizeof(struct page) = 44
 Journalled Block Device driver loaded
 pty: 256 Unix98 ptys configured
 Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
@@ -61,12 +57,12 @@
 hda: QUANTUM FIREBALL CX10.2A, ATA DISK drive
 hdb: RICOH CD-R/RW MP7083A, ATAPI CD/DVD-ROM drive
 hda: DMA disabled
-blk: queue c028ace0, I/O limit 4095Mb (mask 0xffffffff)
+blk: queue c0274460, I/O limit 4095Mb (mask 0xffffffff)
 hdb: DMA disabled
 hdc: SAMSUNG SV1022D, ATA DISK drive
 hdd: Pioneer DVD-ROM ATAPIModel DVD-113 0113, ATAPI CD/DVD-ROM drive
 hdc: DMA disabled
-blk: queue c028b144, I/O limit 4095Mb (mask 0xffffffff)
+blk: queue c02748ac, I/O limit 4095Mb (mask 0xffffffff)
 hdd: DMA disabled
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 ide1 at 0x170-0x177,0x376 on irq 15
@@ -84,7 +80,7 @@
 kjournald starting.  Commit interval 5 seconds
 EXT3-fs: mounted filesystem with ordered data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
-Freeing unused kernel memory: 220k freed
+Freeing unused kernel memory: 216k freed
 NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
 Real Time Clock Driver v1.10e
 EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
@@ -128,4 +124,5 @@
 raid0 : Allocating 8 bytes for hash.
 md: updating md0 RAID superblock on device
 md: hdc1 [events: 00000193]<6>(write) hdc1's sb offset: 2562240
-SysRq : SAK
+md: hda3 [events: 00000193]<6>(write) hda3's sb offset: 2562240
+md: ... autorun DONE.

It looks though the kernel raid sub-system on 2.4.21-pre3aa1 is not able to 
access/activate /dev/hda3 properly, which is part of /dev/md0 raid0 array 
(this raid0 array is made up of /dev/hdc1 and /dev/hda3).

Please feel free to ask for more informartion. Thanks.
-- 
Hari
harisri@bigpond.com

