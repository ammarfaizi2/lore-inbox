Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWGRW3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWGRW3o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 18:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWGRW3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 18:29:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:7378 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932263AbWGRW3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 18:29:43 -0400
Date: Wed, 19 Jul 2006 00:29:41 +0200
From: Torsten Landschoff <torsten@debian.org>
To: linux-kernel@vger.kernel.org
Subject: XFS breakage in 2.6.18-rc1
Message-ID: <20060718222941.GA3801@stargate.galaxy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:d638a0eb9c9fbc21c426336ab6dfa19b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi friends, 

I upgraded to 2.6.18-rc1 on sunday, with the following results (taken
from my /var/log/kern.log), which ultimately led me to reinstall my 
system:

Jul 17 07:10:12 pulsar kernel: klogd 1.4.1#18, log source = /proc/kmsg started.
Jul 17 07:10:12 pulsar kernel: Linux version 2.6.18-rc1 (torsten@pulsar) (gcc version 4.1.2 20060630 (prerelease) (Debian 4.1.1-6)) #18 SMP PREEMPT Fri Jul 14 07:58:49 CEST 2006
...
Jul 17 07:10:32 pulsar kernel: agpgart: Putting AGP V3 device at 0000:03:00.0 into 4x mode
Jul 17 07:10:32 pulsar kernel: [drm] Setting GART location based on new memory map
Jul 17 07:10:32 pulsar kernel: [drm] Loading R200 Microcode
Jul 17 07:10:32 pulsar kernel: [drm] writeback test succeeded in 1 usecs
Jul 17 07:33:53 pulsar kernel: xfs_da_do_buf: bno 16777216
Jul 17 07:33:53 pulsar kernel: dir: inode 54526538
Jul 17 07:33:53 pulsar kernel: Filesystem "dm-6": XFS internal error xfs_da_do_buf(1) at line 1992 of file fs/xfs/xfs_da_btree.c.  Caller 0xf8a837d0
Jul 17 07:33:53 pulsar kernel:  [<f8a83313>] xfs_da_do_buf+0x4d3/0x900 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8a837d0>] xfs_da_read_buf+0x30/0x40 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8a8e0cf>] xfs_dir2_leafn_lookup_int+0x28f/0x520 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8a8e0cf>] xfs_dir2_leafn_lookup_int+0x28f/0x520 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8a89215>] xfs_dir2_data_log_unused+0x55/0x70 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8a837d0>] xfs_da_read_buf+0x30/0x40 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8a8c782>] xfs_dir2_node_removename+0x312/0x500 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8a8c782>] xfs_dir2_node_removename+0x312/0x500 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8a87337>] xfs_dir_removename+0xf7/0x100 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8a9720d>] xfs_ilock_nowait+0xcd/0x100 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8ab9783>] xfs_remove+0x393/0x4c0 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8ac43ef>] xfs_vn_permission+0xf/0x20 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8ac43e0>] xfs_vn_permission+0x0/0x20 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8ac4123>] xfs_vn_unlink+0x23/0x60 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<c017a223>] mntput_no_expire+0x13/0x70
Jul 17 07:33:53 pulsar kernel:  [<c016e0c1>] link_path_walk+0x71/0xf0
Jul 17 07:33:53 pulsar kernel:  [<f8ab0638>] xfs_trans_unlocked_item+0x38/0x60 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8ab63ff>] xfs_access+0x3f/0x50 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8ac43ef>] xfs_vn_permission+0xf/0x20 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8ac43e0>] xfs_vn_permission+0x0/0x20 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<c016bdca>] permission+0x8a/0xc0
Jul 17 07:33:53 pulsar kernel:  [<c016c3e9>] may_delete+0x39/0x120
Jul 17 07:33:53 pulsar kernel:  [<c016c957>] vfs_unlink+0x87/0xe0
Jul 17 07:33:53 pulsar kernel:  [<c016e96c>] do_unlinkat+0xcc/0x150
Jul 17 07:33:53 pulsar kernel:  [<c0102fbf>] syscall_call+0x7/0xb
Jul 17 07:33:53 pulsar kernel: Filesystem "dm-6": XFS internal error xfs_trans_cancel at line 1138 of file fs/xfs/xfs_trans.c.  Caller 0xf8ab97d7
Jul 17 07:33:53 pulsar kernel:  [<f8aaf91d>] xfs_trans_cancel+0xdd/0x100 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8ab97d7>] xfs_remove+0x3e7/0x4c0 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8ab97d7>] xfs_remove+0x3e7/0x4c0 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8ac43ef>] xfs_vn_permission+0xf/0x20 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8ac43e0>] xfs_vn_permission+0x0/0x20 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8ac4123>] xfs_vn_unlink+0x23/0x60 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<c017a223>] mntput_no_expire+0x13/0x70
Jul 17 07:33:53 pulsar kernel:  [<c016e0c1>] link_path_walk+0x71/0xf0
Jul 17 07:33:53 pulsar kernel:  [<f8ab0638>] xfs_trans_unlocked_item+0x38/0x60 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8ab63ff>] xfs_access+0x3f/0x50 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8ac43ef>] xfs_vn_permission+0xf/0x20 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<f8ac43e0>] xfs_vn_permission+0x0/0x20 [xfs]
Jul 17 07:33:53 pulsar kernel:  [<c016bdca>] permission+0x8a/0xc0
Jul 17 07:33:53 pulsar kernel:  [<c016c3e9>] may_delete+0x39/0x120
Jul 17 07:33:53 pulsar kernel:  [<c016c957>] vfs_unlink+0x87/0xe0
Jul 17 07:33:53 pulsar kernel:  [<c016e96c>] do_unlinkat+0xcc/0x150
Jul 17 07:33:53 pulsar kernel:  [<c0102fbf>] syscall_call+0x7/0xb
Jul 17 07:33:53 pulsar kernel: xfs_force_shutdown(dm-6,0x8) called from line 1139 of file fs/xfs/xfs_trans.c.  Return address = 0xf8ac77bc
Jul 17 07:33:53 pulsar kernel: Filesystem "dm-6": Corruption of in-memory data detected.  Shutting down filesystem: dm-6
Jul 17 07:33:53 pulsar kernel: Please umount the filesystem, and rectify the problem(s)
Jul 17 07:39:32 pulsar kernel: Reducing readahead size to 32K
Jul 17 07:39:32 pulsar kernel: Reducing readahead size to 8K

That problem occured during a dist-upgrade, dm-6 is my /usr partition. Funny
enough this happened a few months after finally replaced my ancient disk
with a RAID1 array to make sure I do not lose data ;)


In any case it seems like the XFS driver in 2.6.18-rc1 is decently broken.
After booting into 2.6.17 again, I could use /usr again but random files
contain null bytes, firefox segfaults instead of starting up and a number 
of programs fail in mysterious ways. I tried to recover using xfs_repair
but I feel that my partition is thorougly borked. Of course no data was 
lost due to backups but still I'd like this bug to be fixed ;-)

If more information from my logs is required, I can make it available (and any
part of the partition if required).

Greetings

	Torsten
