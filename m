Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317540AbSGOQnU>; Mon, 15 Jul 2002 12:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317541AbSGOQnT>; Mon, 15 Jul 2002 12:43:19 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:39116 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP
	id <S317540AbSGOQnQ>; Mon, 15 Jul 2002 12:43:16 -0400
Mime-Version: 1.0
Message-Id: <a05111619b958ac72d6b3@[129.98.90.227]>
Date: Mon, 15 Jul 2002 12:46:09 -0400
To: linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Mount corrupts an ext2 filesystem on a RAM disk
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just wanted to you to note this is an old issue, which is still 
waiting to be resolved. (I tried contacting Andrew Morton recently, 
but haven't heard back from him.)

Ideally, this issue should be addressed before 2.4.19 goes official. 
(I have not tested recent releases of this 2.4.19, so I can't say 
whether it was fixed incidentally.)

Also, later on I learned that one must "cd" into the mounted ramdisk 
to cause the corruption.

(All this was done on a RedHat 7.1 system with kernel 2.4.18 and 
mount-2.11n-7. The problem does not happen on a RedHat 7.1 system 
with kernel 2.4.17. )

The following was discovered attempting to use mkcdrec to make a backup.

I do the following to setup a ram disk on /dev/ram0...

dd if=/dev/zero of=/dev/ram0 bs=1k count=4096
mkfs.ext2 /dev/ram0 -m 0 -N 4096

This ram disk checks OK with fsck -f.

I mount it and already the lost+found directory is not there.

If unmount and force fsck, I get...

fsck 1.25 (20-Sep-2001)
e2fsck 1.25 (20-Sep-2001)
Pass 1: Checking inodes, blocks, and sizes
Duplicate blocks found... invoking duplicate block passes.
Pass 1B: Rescan for duplicate/bad blocks
Duplicate/bad block(s) in inode 2: 52
Pass 1C: Scan directories for inodes with dup blocks.
Pass 1D: Reconciling duplicate blocks
(There are 1 inodes containing duplicate/bad blocks.)

File / (inode #2, mod time Fri Mar  1 21:03:59 2002)
   has 1 duplicate block(s), shared with 1 file(s):
         <filesystem metadata>
Clone duplicate/bad blocks<y>? yes

Pass 2: Checking directory structure
Directory inode 2, block 0, offset 0: directory corrupted
Salvage<y>? yes

Missing '.' in directory inode 2.
Fix<y>? yes

Setting filetype for entry '.' in ??? (2) to 2.
Missing '..' in directory inode 2.
Fix<y>? yes

Setting filetype for entry '..' in ??? (2) to 2.
Pass 3: Checking directory connectivity
'..' in / (2) is <The NULL inode> (0), should be / (2).
Fix<y>? yes

Unconnected directory inode 11 (/???)
Connect to /lost+found<y>? yes

/lost+found not found.  Create<y>? yes

Pass 4: Checking reference counts
Inode 2 ref count is 10, should be 3.  Fix<y>? yes

Inode 11 ref count is 3, should be 2.  Fix<y>? yes

Pass 5: Checking group summary information
Free blocks count wrong for group #0 (3566, counted=3565).
Fix<y>? yes

Free blocks count wrong (3566, counted=3565).
Fix<y>? yes

Free inodes count wrong for group #0 (4085, counted=4084).
Fix<y>? yes

Directories count wrong for group #0 (2, counted=3).
Fix<y>? yes

Free inodes count wrong (4085, counted=4084).
Fix<y>? yes

If I mount the disk, lost+found is still missing. If I unmount and 
force fsck, I get the same result above.
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
