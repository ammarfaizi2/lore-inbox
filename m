Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316637AbSGLRcV>; Fri, 12 Jul 2002 13:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSGLRcU>; Fri, 12 Jul 2002 13:32:20 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1920 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316637AbSGLRcR>; Fri, 12 Jul 2002 13:32:17 -0400
Date: Fri, 12 Jul 2002 13:34:59 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andreas Dilger <adilger@clusterfs.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2 'remount' problem
In-Reply-To: <20020712163928.GH8738@clusterfs.com>
Message-ID: <Pine.LNX.3.95.1020712132914.211A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2002, Andreas Dilger wrote:

> On Jul 12, 2002  08:53 -0400, Richard B. Johnson wrote:
> > If file-systems are mounted upon boot with 'defaults' as options
> > 
> > like /etc/fstab...
> > /dev/sdc1			/alt		ext2	defaults  0   2
> > 
> > mount -o remount,rw,noatime /alt
> > 
> > The result is (correctly)
> > /dev/sdc1 /alt ext2 rw,noatime 0 0
> > 
> > Now, if I shut down the system, properly dismounting all the drives,
> > then I reboot, the drives that were re-mounted end up being fscked
> > due to 'was not cleanly unmounted' inference. Nothing wrong is found.
> > 
> > Now, if I mount the drives "noatime" from the start, i.e., from
> > /etc/fstab upon startup, there are no such errors upon re-boot.
> 
> There was once a problem that if you mounted a filesystem and crashed
> shortly thereafter the filesystem would mistakenly be marked clean and
> not checked when it should be, but I haven't heard the opposite problem.
> 
> I did a quick check (just mounting an ext2 filesystem on 2.4.18 from bash,
> remounting, then unmounting) and everything worked as expected.  Could
> you try doing your test and running "dumpe2fs -h /dev/foo" between each
> step to check the filesystem state.  It should be "not clean" until the
> filesystem is unmounted, at which point it should be "clean".
> 
> Also try doing the unmount steps manually before shutdown to see if it
> is a timing issue.  If you have writeback cache enabled on your disks
> and this is not being flushed to the oxide before power is lost you may
> not just be having an fsck problem, but also a data loss/corruption
> problem.
> 
> Cheers, Andreas
> --

Script started on Fri Jul 12 12:54:51 2002
[9;0]# 
# 
# 
# umount -s a
umount: /mnt: device is busy

# 
# 
# 
# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   6211760   9548208  39% /
/dev/fd0                  1423        25      1398   2% /mnt
# umount /
# dumpe2fs -h /dev/sdb1
dumpe2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          ea36cab5-82d4-4717-b572-57828567263c
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      filetype sparse_super
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              2109408
Block count:              4217054
Reserved block count:     210852
Free blocks:              2597904
Free inodes:              1867368
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         16352
Inode blocks per group:   511
Last mount time:          Fri Jul 12 12:55:11 2002
Last write time:          Fri Jul 12 12:55:11 2002
Mount count:              15
Maximum mount count:      20
Last checked:             Thu May 23 13:05:14 2002
Check interval:           15552000 (6 months)
Next check after:         Tue Nov 19 12:05:14 2002
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:		  128

# dumpe2fs -d /dev/sdc1
dumpe2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
dumpe2fs: invalid option -- d
Usage: dumpe2fs [-bV] [-ob superblock] [-oB blocksize] device
# dumpe2fs -h /dev/sdc1
dumpe2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          c9ec8442-5c82-4e97-a010-461f3a47464b
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      filetype sparse_super
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              808000
Block count:              1614524
Reserved block count:     80726
Free blocks:              1289481
Free inodes:              759260
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         16160
Inode blocks per group:   505
Last mount time:          Fri Jul 12 04:21:17 2002
Last write time:          Fri Jul 12 12:55:10 2002
Mount count:              2
Maximum mount count:      20
Last checked:             Fri Jul 12 04:18:38 2002
Check interval:           15552000 (6 months)
Next check after:         Wed Jan  8 03:18:38 2003
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:		  128

# cat /etc/fstab
# /etc/fstab
# static file system information
#
# This file is not used by the kernel, but rather by mount(8) and umount(8)
# (and some day fsck(8)).  Comment lines have "#" in the first column.
# Entries that are to be ignored should have "none" in the directory field,
# and have type "ignore" or options "xx".  Frequency and pass are numeric
# fields for dump(8) and fsck(8) that are not used yet in Linux.  You can
# leave them empty if want.

# device			directory	type	options	freq pass
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
/dev/sdb1			/		ext2	rw,noatime  0   1
/dev/sdc1			/alt		ext2	rw,noatime  0   2
/dev/sdb2			none		swap	defaults    0	2
/dev/sdc2			none		swap	defaults    0	2
/dev/sdc3			/home/users	ext2	rw,noatime  0	2	
none				/proc		proc	defaults  0	2
/dev/sda1			/dos/drive_C	msdos	defaults  0     2
/dev/sda5			/dos/drive_D	msdos	defaults  0     2
#/dev/sdb1			/alt		ext2	defaults  0	2
#/dev/sda6			/dos/drive_E	msdos	defaults  0	2
#/dev/sda7			/dos/drive_F	msdos	defaults  0	2
#/dev/sdb1			/home/hpbd	ext2	defaults  0	2
#/dev/sdc1			/home/disk3	ext2	defaults  0	2
#/dev/sdd1			/laser		ext2	defaults  0	2
#/dev/sdd3			/laser/home	ext2	defaults  0	2
#/dev/cdrom			/cdrom		iso9660	ro,user	  0	2

# dumpe2fs -d   h /dev/sdc3
dumpe2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          89cb684f-de7d-460f-8d09-be328b3ce3bb
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      filetype sparse_super
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              286272
Block count:              572315
Reserved block count:     28615
Free blocks:              121190
Free inodes:              197598
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         15904
Inode blocks per group:   497
Last mount time:          Fri Jul 12 04:21:17 2002
Last write time:          Fri Jul 12 12:55:10 2002
Mount count:              2
Maximum mount count:      20
Last checked:             Fri Jul 12 04:19:33 2002
Check interval:           15552000 (6 months)
Next check after:         Wed Jan  8 03:19:33 2003
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:		  128

# e2fsck /dev/sdb1
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
/dev/sdb1: clean, 242040/2109408 files, 1619150/4217054 blocks
# e2fsck /dev/sdc1
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
/dev/sdc1: clean, 48740/808000 files, 325043/1614524 blocks
# e2fsck /dev/sdc3
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
/dev/sdc3: clean, 88674/286272 files, 451125/572315 blocks
# e2fsck -f /dev/sdb1
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/sdb1: 242040/2109408 files (1.1% non-contiguous), 1619150/4217054 blocks
# mount -n -o remount /dev/sdb1 /
# mount -o remount /dev/sdb1 /
# mount -o remount,rw,noatime /dev/sdb1 /
# dumpe2fs -h /dev/sdb1
dumpe2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          ea36cab5-82d4-4717-b572-57828567263c
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      filetype sparse_super
Filesystem state:         not clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              2109408
Block count:              4217054
Reserved block count:     210852
Free blocks:              2597904
Free inodes:              1867368
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         16352
Inode blocks per group:   511
Last mount time:          Fri Jul 12 13:03:01 2002
Last write time:          Fri Jul 12 13:03:36 2002
Mount count:              1
Maximum mount count:      20
Last checked:             Fri Jul 12 13:02:09 2002
Check interval:           15552000 (6 months)
Next check after:         Wed Jan  8 12:02:09 2003
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:		  128

# umount /dev/sdb1
# dumpe2fs -h /dev/sdb1
dumpe2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          ea36cab5-82d4-4717-b572-57828567263c
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      filetype sparse_super
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              2109408
Block count:              4217054
Reserved block count:     210852
Free blocks:              2597904
Free inodes:              1867368
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         16352
Inode blocks per group:   511
Last mount time:          Fri Jul 12 13:04:15 2002
Last write time:          Fri Jul 12 13:04:15 2002
Mount count:              1
Maximum mount count:      20
Last checked:             Fri Jul 12 13:02:09 2002
Check interval:           15552000 (6 months)
Next check after:         Wed Jan  8 12:02:09 2003
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:		  128

# >/foo
bash: /foo: Read-only file system
# cd /
# exit
exit

Script done on Fri Jul 12 13:05:19 2002

Booted with init=/bin/bash
Then I mounted a floppy off from /tmp, chdir there, and ran script.


Script started on Fri Jul 12 09:07:57 2002
bash# ls
dir  dir.c  makefile  type.org	typescri  xxx.c
bash# fsck /dev/sdb1
bash: fsck: command not found
bash# e2fsck /dev/sdb1
bash: e2fsck: command not found
bash# /sbin/e2fsck /dev/sdb1
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
/dev/sdb1: was not cleanly unmounted, check forced
 242040/2109408 files, 1619150/4217054 blocks
bash# /sbin/e2fsck /dev/sdc1
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
/dev/sdc1: was not cleanly unmounted, check forced
 48740/808000 files, 325043/1614524 blocks
bash# /sbin/e2fsck /dev/sdc3
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
/dev/sdc3: clean, 88674/286272 files, 451125/572315 blocks
bash# pwd
/tmp
bash# exit
exit

Script done on Fri Jul 12 09:10:25 2002




If I don't remount with 'noatime' I don't get the unclean error
upon startup. /dev/sdc3 was clean (for some reason) while the
othet two were dirty.



Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

