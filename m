Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbUCMArW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 19:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbUCMArW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 19:47:22 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:4013 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S262773AbUCMArK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 19:47:10 -0500
Date: Sat, 13 Mar 2004 01:47:07 +0100
From: Marc Lehmann <pcg@schmorp.de>
To: linux-kernel@vger.kernel.org
Subject: strange ext3 corruption problem on 2.6.x
Message-ID: <20040313004707.GA389@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux version 2.6.4 (root@cerebro) (gcc version 3.3.3 20040125 (prerelease) (Debian)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use lvm-over-raid5 and get these messages once a day (requiring a reboot
afterwards):

   EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #4804801: directory entry across blocks - offset=0, inode=0, rec_len=50000,
   name_len=152
   Aborting journal on device dm-0.
   add_dirent_to_buf: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device dm-0) in add_dirent_to
   _buf: Journal has aborted
   EXT3-fs error (device dm-0) in ext3_writeback_writepage: IO failure
   EXT3-fs error (device dm-0) in ext3_writeback_writepage: IO failure
   ext3_abort called.
   EXT3-fs abort (device dm-0): ext3_journal_start: Detected aborted journal
   Remounting filesystem read-only
   EXT3-fs error (device dm-0) in start_transaction: Journal has aborted
   EXT3-fs error (device dm-0) in ext3_delete_inode: Journal has aborted
   EXT3-fs error (device dm-0) in ext3_create: Journal has aborted
   EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #4804801: directory entry across blocks - offset=0, inode=0, rec_len=50000,
   name_len=152
   EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #4804801: directory entry across blocks - offset=0, inode=0, rec_len=50000,
   name_len=152
   EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #4804801: directory entry across blocks - offset=0, inode=0, rec_len=50000, 
   name_len=152

e2fsck after rebooting shows no errors and nothing to fix, and in fact, in
this very incident my home directory was missing, after rebooting it was
there again, so so far this doesn't look like on-disk data corruption.

About my configuration:

5 IDE disks were combined into one raid5, with lvm on top. Theer are
two lvs on the raid, one formatted with ext3 and one with reiserfs. the
array was not degraded and not rebuilding. Data throughput under 2.6 is
much lower than under 2.4, though (and 2.6 takes enourmous amounts of cpu
for reading from the raid5 array), but this issue is probably a seperate
problem.

Both partitions currently undergo heavy filesystem activity, mainly
untar'ing big tars with lots of medium-sized files (e.g. 10gb of jpeg
files, or cvs directories).

Reiserfs so far never gave a problem, neither did ext3 filesystems on
normal harddisk partitions (although the latter ones were never under
write stress like the partitions on the lv partitions).

There are no other kernel messages between mounting the volume and the
problem.

I can use this machine for many hours under no stress without any
problems.

I had these problems on 2.6.3 and 2.6.4, other 2.6. kernels have not been
tested.

Using 2.4 on the same machine (lvm1) doesn't show any problems (the
machine is a dual P-III 1ghz).

Summary: the ext3 partition regularly gives me these problems (about once
per day), while reiserfs on the same device does not.  Neither of them
make problems under 2.4.

Hope that helps,

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
