Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbUCSKLh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 05:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbUCSKLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 05:11:37 -0500
Received: from dwdmx2.dwd.de ([141.38.3.197]:36424 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S262365AbUCSKLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 05:11:35 -0500
Date: Fri, 19 Mar 2004 10:11:32 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.5-rc1-mm2 very slow
Message-Id: <Pine.LNX.4.58.0403190956560.18369@praktifix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I am testing 2.6.5-rc1-mm2 and find it very slow when I do a bonnie
test, also the system itself feels very sluggish. Looking at dmesg
I get the following:

   Badness in elv_remove_request at drivers/block/elevator.c:249
   Call Trace:
    [<c028b28f>] elv_remove_request+0x8d/0x8f
    [<c02b6a4e>] scsi_request_fn+0x289/0x333
    [<c028b174>] elv_next_request+0x3d/0xcb
    [<c028c8da>] generic_unplug_device+0x43/0x45
    [<c02f1bfc>] md_unplug_mddev+0x32/0x34
    [<c02f07e4>] make_request+0x22/0x29f
    [<c01a5523>] ext3_get_branch+0x4d/0xca
    [<c028ddc7>] generic_make_request+0xf2/0x165
    [<c0138a41>] mempool_alloc+0x63/0x114
    [<c011d42b>] autoremove_wake_function+0x0/0x38
    [<c028dea6>] submit_bio+0x6c/0x11b
    [<c0154c42>] bio_alloc+0xba/0x182
    [<c015355e>] block_read_full_page+0x19d/0x2a2
    [<c01a5d77>] ext3_get_block+0x0/0x9e
    [<c0154cb3>] bio_alloc+0x12b/0x182
    [<c01a5dcb>] ext3_get_block+0x54/0x9e
    [<c016d08e>] mpage_alloc+0x25/0x8a
    [<c016d3b8>] do_mpage_readpage+0x24b/0x314
    [<c0246894>] radix_tree_node_alloc+0x10/0x4d
    [<c0246b00>] radix_tree_insert+0xdd/0xfd
    [<c0135dfa>] add_to_page_cache+0x5a/0xd5
    [<c016d59b>] mpage_readpages+0x11a/0x15e
    [<c01a5d77>] ext3_get_block+0x0/0x9e
    [<c01a6a59>] ext3_readpages+0x0/0x15
    [<c013bb8d>] read_pages+0x136/0x13f
    [<c01a5d77>] ext3_get_block+0x0/0x9e
    [<c0139a98>] buffered_rmqueue+0xf6/0x1d3
    [<c0139c20>] __alloc_pages+0xab/0x2e0
    [<c013be48>] do_page_cache_readahead+0xfc/0x165
    [<c013c039>] page_cache_readahead+0x188/0x1d7
    [<c01364f0>] do_generic_mapping_read+0xc9/0x38e
    [<c01367b5>] file_read_actor+0x0/0xca
    [<c0136a4c>] __generic_file_aio_read+0x1cd/0x1ff
    [<c01367b5>] file_read_actor+0x0/0xca
    [<c0136ac5>] generic_file_aio_read+0x47/0x61
    [<c015031e>] do_sync_read+0x6f/0xa4
    [<c011a214>] load_balance+0x3c/0x156
    [<c01503fc>] vfs_read+0xa9/0xf5
    [<c0150619>] sys_read+0x38/0x59
    [<c034b8a6>] sysenter_past_esp+0x43/0x65

The system is a dual Xeon with HT enabled and 2GB memory. Bonnie is
running on a software raid10 (six SCSI disks) with ext3.

It is compiled with CONFIG_SCHED_SMT and CONFIG_HIGHMEM4G. CONFIG_PREEMPT
is not set. I can also post the full .config if necessary.

I get more of these badness messages when I boot.

Under 2.6.3 there are no problems. Also have tried 2.6.4-mm2 but that would
oops during boot (when starting the SW raid).

Holger
