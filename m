Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUIMBXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUIMBXj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 21:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUIMBXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 21:23:39 -0400
Received: from [64.65.177.98] ([64.65.177.98]:22954 "EHLO mail.pacrimopen.com")
	by vger.kernel.org with ESMTP id S264704AbUIMBXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 21:23:33 -0400
Message-ID: <4144F691.6040405@pacrimopen.com>
Date: Sun, 12 Sep 2004 18:23:29 -0700
From: Joshua Schmidlkofer <kernel@pacrimopen.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040824)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jch@imr-net.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck kernel mailing list <ck@vds.kolivas.org>,
       Cliff Wells <clifford.wells@comcast.net>
Subject: Re: 2.6.8.1-ck7, Two Badnessess, one dump.
References: <41412765.4010005@kolivas.org>
In-Reply-To: <41412765.4010005@kolivas.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded from 2.6.8.1-ck5.

First off - this has been a landmark improvement for me.   Running an 
"emerge -a world" on my system has gone from a matter of minutes to a 
matter of seconds.

The performance has been !outstanding!. 
[Disclosure:  Using NVIDIA Binary Drivers]

The first night of running I got this:
xfs_fsr: page allocation failure. order:4, mode:0x50
[<c0131174>] __alloc_pages+0x332/0x3f6
[<c0131257>] __get_free_pages+0x1f/0x3b
[<c013404f>] kmem_getpages+0x1d/0xb3
[<c0134b05>] cache_grow+0x96/0x122
[<c0134ccc>] cache_alloc_refill+0x13b/0x1d7
[<c01350d9>] __kmalloc+0x72/0x79
[<c0221144>] kmem_alloc+0x58/0xba
[<c01c546c>] xfs_alloc_log_agf+0x58/0x5c
[<c0221253>] kmem_realloc+0x2b/0x7c
[<c020058e>] xfs_iext_realloc+0xf6/0x13e
[<c01d6967>] xfs_bmap_insert_exlist+0x35/0x8c
[<c01d3f3a>] xfs_bmap_add_extent_hole_real+0x3cd/0x73f
[<c01df64f>] xfs_bmbt_get_state+0x2f/0x3b
[<c01d0eb6>] xfs_bmap_add_extent+0x35b/0x42d
[<c02212f4>] kmem_zone_alloc+0x50/0x96
[<c022136f>] kmem_zone_zalloc+0x35/0x62
[<c01e1070>] xfs_btree_init_cursor+0x2a/0x147
[<c01d888f>] xfs_bmapi+0x66a/0x141b
[<c0214fde>] xfs_trans_tail_ail+0x12/0x28
[<c0206c9e>] xlog_assign_tail_lsn+0x19/0x33
[<c0208cc2>] xlog_state_release_iclog+0x26/0xd1
[<c02065df>] xfs_log_reserve+0xbe/0xc7
[<c0216100>] xfs_trans_iget+0x9c/0x163
[<c021f8bf>] xfs_alloc_file_space+0x425/0x695
[<c0201adf>] xfs_ichgtime+0x10a/0x10c
[<c02208a4>] xfs_change_file_space+0x1e3/0x420
[<c02064e4>] xfs_log_release_iclog+0x21/0x5e
[<c021488b>] xfs_trans_commit+0x219/0x3a7
[<c0130daa>] buffered_rmqueue+0xc8/0x160
[<c0242100>] copy_from_user+0x42/0x6e
[<c0226e6e>] xfs_ioc_space+0x9c/0xb9
[<c0226932>] xfs_ioctl+0x389/0x829
[<c013ac28>] handle_mm_fault+0xd2/0x138
[<c0113230>] do_page_fault+0x13f/0x53d
[<c013c55d>] do_mmap_pgoff+0x591/0x6ac
[<c0225916>] linvfs_ioctl+0x3b/0x47
[<c01573ca>] file_ioctl+0x6a/0x171
[<c01575a0>] sys_ioctl+0xcf/0x203
[<c0105791>] sysenter_past_esp+0x52/0x71

I shutdown, did an xfs_repair, and the error has not returned.

Two days later I got this:

Badness in cfq_sort_rr_list at drivers/block/cfq-iosched.c:428
[<c02a82d6>] cfq_add_crq_rb+0x16f/0x17a
[<c02a8fe0>] cfq_enqueue+0x3b/0x6c
[<c02a9108>] cfq_insert_request+0xf7/0x12b
[<c029e4fd>] __elv_add_request+0x45/0x9e
[<c02a134f>] __make_request+0x293/0x4e5
[<c02a16aa>] generic_make_request+0x109/0x18a
[<c012fc97>] mempool_alloc+0x6f/0x11e
[<c0115690>] autoremove_wake_function+0x0/0x57
[<c02a1788>] submit_bio+0x5d/0xfb
[<c014b93b>] bio_add_page+0x34/0x38
[<c02241a6>] _pagebuf_ioapply+0x1b6/0x2a4
[<c0224319>] pagebuf_iorequest+0x85/0x153
[<c01fe1ec>] xfs_xlate_dinode_core+0x15e/0x81d
[<c0114847>] default_wake_function+0x0/0x12
[<c0114847>] default_wake_function+0x0/0x12
[<c022973f>] xfs_bdstrat_cb+0x42/0x48
[<c0223e66>] pagebuf_iostart+0x4e/0xa3
[<c0200fda>] xfs_iflush+0x1ad/0x472
[<c021eef1>] xfs_inode_flush+0x189/0x1fe
[<c022973f>] xfs_bdstrat_cb+0x42/0x48
[<c02153db>] xfs_trans_first_ail+0x16/0x27
[<c0229d89>] linvfs_write_inode+0x32/0x36
[<c01631dc>] write_inode+0x46/0x48
[<c016339c>] __sync_single_inode+0x1be/0x1d0
[<c01635fc>] generic_sync_sb_inodes+0x19d/0x2b1
[<c01637ec>] writeback_inodes+0xaa/0xac
[<c01320c1>] background_writeout+0x71/0xb1
[<c0132b03>] pdflush+0x0/0x2c
[<c0132a40>] __pdflush+0x9c/0x15f
[<c0132b2b>] pdflush+0x28/0x2c
[<c0132050>] background_writeout+0x0/0xb1
[<c0132b03>] pdflush+0x0/0x2c
[<c0126dd1>] kthread+0xa5/0xab
[<c0126d2c>] kthread+0x0/0xab
[<c0103c1d>] kernel_thread_helper+0x5/0xb
Badness in cfq_sort_rr_list at drivers/block/cfq-iosched.c:428
[<c02a82d6>] cfq_add_crq_rb+0x16f/0x17a
[<c02a8fe0>] cfq_enqueue+0x3b/0x6c
[<c02a9108>] cfq_insert_request+0xf7/0x12b
[<c029e4fd>] __elv_add_request+0x45/0x9e
[<c02a134f>] __make_request+0x293/0x4e5
[<c02a16aa>] generic_make_request+0x109/0x18a
[<c012fc97>] mempool_alloc+0x6f/0x11e
[<c0115690>] autoremove_wake_function+0x0/0x57
[<c02a1788>] submit_bio+0x5d/0xfb
[<c01145fe>] scheduler_tick+0x1f/0x268
[<c014b93b>] bio_add_page+0x34/0x38
[<c02241a6>] _pagebuf_ioapply+0x1b6/0x2a4
[<c0224319>] pagebuf_iorequest+0x85/0x153
[<c0114847>] default_wake_function+0x0/0x12
[<c0114847>] default_wake_function+0x0/0x12
[<c022973f>] xfs_bdstrat_cb+0x42/0x48
[<c02248c2>] pagebuf_daemon+0xdc/0x1ce
[<c02247e6>] pagebuf_daemon+0x0/0x1ce
[<c0103c1d>] kernel_thread_helper+0x5/0xb


==

Thread model: posix
gcc version 3.3.4 20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)

binutils-2.14.90.0.8


If there is something I can do, please let me know.  I have limited 
time, but I will do my best to help.

