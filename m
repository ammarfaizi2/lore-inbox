Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267103AbTBKQFG>; Tue, 11 Feb 2003 11:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267078AbTBKQFG>; Tue, 11 Feb 2003 11:05:06 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:4772 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S267084AbTBKQFB>;
	Tue, 11 Feb 2003 11:05:01 -0500
Date: Tue, 11 Feb 2003 17:14:31 +0100 (CET)
From: Stephan van Hienen <raid@a2000.nu>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       "Theodore Ts'o" <tytso@mit.edu>, peter@chubb.wattle.id.au,
       bernard@biesterbos.nl
Subject: Re:2TB+ fs ext3 (was fsck out of memory)
In-Reply-To: <3E479CC7.B170D5C7@aitel.hist.no>
Message-ID: <Pine.LNX.4.53.0302111707530.15933@ddx.a2000.nu>
References: <Pine.LNX.4.53.0302071555110.718@ddx.a2000.nu> 
 <Pine.LNX.4.53.0302071800200.1306@ddx.a2000.nu> <20030207102858.P18636@schatzie.adilger.int>
  <Pine.LNX.4.53.0302090953440.1039@ddx.a2000.nu> <20030209133117.E12639@schatzie.adilger.int>
 <Pine.LNX.4.53.0302101228430.7274@ddx.a2000.nu> <3E479CC7.B170D5C7@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2003, Helge Hafting wrote:

> For 1MB average filesize use -i 1048576

tried to mke2fs with '-i 1048576' :

----
]# mke2fs -i 1048576 /dev/md0 -R stride=16 -m 0 -j
mke2fs 1.32 (09-Nov-2002)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
2403840 inodes, 615381536 blocks
0 blocks (0.00%) reserved for the super user
First data block=0
18780 block groups
32768 blocks per group, 32768 fragments per group
128 inodes per group
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632,
2654208,
        4096000, 7962624, 11239424, 20480000, 23887872, 71663616,
78675968,
        102400000, 214990848, 512000000, 550731776

Writing inode tables: done
Creating journal (8192 blocks): done
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 23 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
----
dmesg output :

md: mke2fs(pid 10600) used obsolete MD ioctl, upgrade your software to use
new ioctls.
----
then i try to mount :

----
]# mount /dev/md0  /raid/
mount: wrong fs type, bad option, bad superblock on /dev/md0,
       or too many mounted file systems
---
dmesg output :

raid5: switching cache buffer size, 4096 --> 1024
raid5: switching cache buffer size, 1024 --> 4096
EXT3-fs error (device md(9,0)): ext3_check_descriptors: Block bitmap for
group 4480 not in group (block 15)!
EXT3-fs: group descriptors corrupted !
----

and e2fsck :

----
e2fsck /dev/md0
e2fsck 1.32 (09-Nov-2002)
Group descriptors look bad... trying backup blocks...
Block bitmap for group 6528 is not in group.  (block 15)
Relocate<y>? yes

Inode bitmap for group 6528 is not in group.  (block 3145728)
Relocate<y>? yes

Inode table for group 6528 is not in group.  (block 0)
WARNING: SEVERE DATA LOSS POSSIBLE.
Relocate<y>? yes

Block bitmap for group 6529 is not in group.  (block 0)
Relocate<y>? yes

Inode bitmap for group 6529 is not in group.  (block 0)
Relocate<y>? yes

Inode table for group 6529 is not in group.  (block 0)
WARNING: SEVERE DATA LOSS POSSIBLE.
Relocate<y>? yes

Block bitmap for group 6530 is not in group.  (block 0)
Relocate<y>? yes

Inode bitmap for group 6530 is not in group.  (block 0)
Relocate<y>? yes

Inode table for group 6530 is not in group.  (block 0)
WARNING: SEVERE DATA LOSS POSSIBLE.
Relocate<y>? yes

.....
