Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWBGKs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWBGKs3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 05:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWBGKs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 05:48:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:51110 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964963AbWBGKs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 05:48:28 -0500
From: Andi Kleen <ak@suse.de>
To: trond.myklebust@fys.uio.no
Subject: radix-tree.c:378 BUG NFS client bug on 2.6.15-git7
Date: Tue, 7 Feb 2006 11:46:19 +0100
User-Agent: KMail/1.8.2
Cc: okir@suse.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071146.19881.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found this on a box still running 2.6.15-git7 (I know it's a bit old).
It was under relatively heavy NFS client traffic. Perhaps it's of interest 
for someone.

-Andi


nfs_update_inode: inode 961647 mode changed, 0040755 to 0100644
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at /home/lsrc/quilt/linux/lib/radix-tree.c:378
invalid opcode: 0000 [1] SMP 
CPU 4 
Modules linked in:
Pid: 3853, comm: cp Tainted: G   M  2.6.15-git7 #91
RIP: 0010:[<ffffffff80239ce1>] <ffffffff80239ce1>{radix_tree_tag_set+93}
RSP: 0018:ffff810086ee1bf0  EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff810101627188 RCX: ffff8100e957e538
RDX: 0000000000000008 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff8100f475dd98 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000282 R14: 0000000000000000 R15: ffff81007e4d0200
FS:  00002aaaab106b00(0000) GS:ffff810101c58ec0(0000) knlGS:0000000040340da0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaab0c1390 CR3: 0000000173034000 CR4: 00000000000006e0
Process cp (pid: 3853, threadinfo ffff810086ee0000, task ffff8100fb9d54f0)
Stack: ffffffff801598f2 ffff81011191f678 ffff8100b866c840 ffff81011191f3c0 
       ffff81011191f678 0000000000000000 ffffffff802067be 0000000100000004 
       0000000100000002 0000000000000000 
Call Trace: <ffffffff801598f2>{test_set_page_writeback+117}
       <ffffffff802067be>{nfs_flush_inode+1032} <ffffffff80206e2f>{nfs_writepage
s+97}
       <ffffffff8015952f>{do_writepages+32} <ffffffff801537ad>{__filemap_fdatawr
ite_range+81}
       <ffffffff80154426>{filemap_write_and_wait+20} <ffffffff801ffee2>{nfs_sync
_mapping+32}
       <ffffffff801fff35>{nfs_revalidate_mapping+46} <ffffffff802001b7>{__nfs_re
validate_inode+514}
       <ffffffff80140002>{__dequeue_signal+418} <ffffffff8013fab8>{sigprocmask+1
80}
       <ffffffff80206bea>{nfs_sync_inode+79} <ffffffff8020057f>{nfs_getattr+108}
       <ffffffff8017cc18>{vfs_fstat+41} <ffffffff8017d077>{sys_newfstat+17}
       <ffffffff8010f8d2>{system_call+126}

Code: 0f 0b 68 1b a6 43 80 c2 7a 01 41 83 e9 06 41 ff c3 45 39 d3 
RIP <ffffffff80239ce1>{radix_tree_tag_set+93} RSP <ffff810086ee1bf0>
