Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271089AbTGWDa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 23:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271090AbTGWDa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 23:30:27 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:37082 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S271089AbTGWDaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 23:30:24 -0400
Subject: 2.6.0-test1 ext3 slab/fs corruption
From: Nicholas Miell <nmiell@attbi.com>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com, akpm@digeo.com, adilger@clusterfs.com
Content-Type: multipart/mixed; boundary="=-0Co21Yn55rm9OwAoFE6Z"
Message-Id: <1058931916.1286.9.camel@entropy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 22 Jul 2003 20:45:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0Co21Yn55rm9OwAoFE6Z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I woke up this morning and discovered that a compile had died due to I/O
errors. I found the following in my logs (the rest of the relevant bits
from the log is attached -- 5k bz2, 146k uncompressed). Preempt is on,
htree is in use, e2fsck worked fine.

Jul 21 19:25:32 entropy kernel: EXT3-fs warning (device hda1):
ext3_unlink: Deleting nonexistent file (5632341), 0
Jul 21 19:28:31 entropy kernel: Slab corruption: start=c2a4ba30,
expend=c2a4bbff, problemat=c2a4baa8
Jul 21 19:28:31 entropy kernel: Last user:
[<c584f877>](ext3_destroy_inode+0x17/0x20 [ext3])
Jul 21 19:28:31 entropy kernel: Data:
************************************************************************************************************************6C 13 EC C4 ***************************************************************************************************************************************************************************************************************************************************************************************************************************************************A5
Jul 21 19:28:31 entropy kernel: Next: 71 F0 2C .77 F8 84 C5 A5 C2 0F 17
14 02 C8 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Jul 21 19:28:31 entropy kernel: slab error in check_poison_obj(): cache
`ext3_inode_cache': object was modified after freeing
Jul 21 19:28:31 entropy kernel: Call Trace:
Jul 21 19:28:31 entropy kernel:  [<c013b33f>]
check_poison_obj+0x13f/0x190
Jul 21 19:28:31 entropy kernel:  [<c013ca67>]
kmem_cache_alloc+0x117/0x160
Jul 21 19:28:31 entropy kernel:  [<c584f830>] ext3_alloc_inode+0x10/0x40
[ext3]
Jul 21 19:28:31 entropy kernel:  [<c584f830>] ext3_alloc_inode+0x10/0x40
[ext3]
Jul 21 19:28:31 entropy kernel:  [<c0168909>] alloc_inode+0x19/0x150
Jul 21 19:28:32 entropy kernel:  [<c0169336>] new_inode+0x16/0x90
Jul 21 19:28:32 entropy kernel:  [<c5847792>] ext3_new_inode+0x42/0x750
[ext3]
Jul 21 19:28:32 entropy kernel:  [<c013ca72>]
kmem_cache_alloc+0x122/0x160
Jul 21 19:28:32 entropy kernel:  [<c5814442>] new_handle+0x12/0x50 [jbd]
Jul 21 19:28:32 entropy kernel:  [<c5814509>] journal_start+0x89/0xb0
[jbd]
Jul 21 19:28:32 entropy kernel:  [<c584de0f>] ext3_create+0x3f/0x90
[ext3]
Jul 21 19:28:32 entropy kernel:  [<c015edec>] vfs_create+0x7c/0xe0
Jul 21 19:28:32 entropy kernel:  [<c015f43f>] open_namei+0x3ef/0x450
Jul 21 19:28:32 entropy kernel:  [<c014fc55>] filp_open+0x35/0x60
Jul 21 19:28:32 entropy kernel:  [<c015011f>] sys_open+0x3f/0x70
Jul 21 19:28:32 entropy kernel:  [<c010aec7>] syscall_call+0x7/0xb
Jul 21 19:28:32 entropy kernel:


--=-0Co21Yn55rm9OwAoFE6Z
Content-Disposition: attachment; filename=2.6.0-test1_ext3_slab_corruption.txt.bz2
Content-Type: application/x-bzip; name=2.6.0-test1_ext3_slab_corruption.txt.bz2
Content-Transfer-Encoding: base64

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
MrS2OJbVglvi81KL/4u5IpwoSFJ+PasA

--=-0Co21Yn55rm9OwAoFE6Z--

