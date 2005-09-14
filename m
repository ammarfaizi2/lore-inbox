Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932715AbVINKvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbVINKvm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 06:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbVINKvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 06:51:42 -0400
Received: from mail.rentalia.com ([213.192.209.14]:50094 "EHLO
	mail.rentalia.net") by vger.kernel.org with ESMTP id S932715AbVINKvm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 06:51:42 -0400
X-Antivirus-MYDOMAIN-Mail-From: ruben@rentalia.com via txori
X-Antivirus-MYDOMAIN: 1.25-st-qms (Clear:RC:0(62.37.217.64):SA:0(-2.2/5.0):. Processed in 0.623963 secs Process 2421)
Message-ID: <432800AA.10500@rentalia.com>
Date: Wed, 14 Sep 2005 12:51:22 +0200
From: Ruben Rubio Rey <ruben@rentalia.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050912)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-1.667smp perl page allocation failure
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Im specting some problems with a server. Somtimes (each 7 days more or 
less) i can found some
errors in dmesg like the following:

perl5.8.5: page allocation failure. order:4, mode:0x50
 [<0213d396>] __alloc_pages+0x28b/0x298
 [<0213d3bb>] __get_free_pages+0x18/0x24
 [<0213fc88>] kmem_getpages+0x1c/0xbb
 [<021407d9>] cache_grow+0xae/0x136
 [<021409c6>] cache_alloc_refill+0x165/0x19d
 [<02140d9d>] __kmalloc+0x76/0x88
 [<8293ee20>] kmem_alloc+0x50/0x9e [xfs]
 [<8293eef0>] kmem_realloc+0x17/0x52 [xfs]
 [<82924188>] xfs_iext_realloc+0xc9/0xdc [xfs]
 [<82901912>] xfs_bmap_insert_exlist+0x22/0x77 [xfs]
 [<828fed42>] xfs_bmap_add_extent_hole_delay+0x438/0x48e [xfs]
 [<828fc7b4>] xfs_bmap_add_extent+0x146/0x399 [xfs]
 [<829039bc>] xfs_bmapi+0xb00/0x12bf [xfs]
 [<829031e2>] xfs_bmapi+0x326/0x12bf [xfs]
 [<021398ef>] wake_up_page+0x9/0x29
 [<82926bdf>] xfs_iomap_write_delay+0x628/0x702 [xfs]
 [<8292ad03>] xlog_state_get_iclog_space+0x163/0x172 [xfs]
 [<82925b32>] xfs_imap_to_bmap+0x2a/0x28a [xfs]
 [<82925fcc>] xfs_iomap+0x23a/0x3ec [xfs]
 [<82926076>] xfs_iomap+0x2e4/0x3ec [xfs]
 [<82945e39>] xfs_bmap+0x1a/0x1e [xfs]
 [<8294005f>] linvfs_get_block_core+0x6b/0x257 [xfs]
 [<02139c3f>] find_or_create_page+0x18/0x72
 [<022b7b17>] __cond_resched+0x14/0x39
 [<02156002>] set_bh_page+0x2c/0x34
 [<8294025e>] linvfs_get_block+0x13/0x17 [xfs]
 [<0215664f>] __block_prepare_write+0x15d/0x3e4
 [<02156f61>] block_prepare_write+0x16/0x23
 [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
 [<82940578>] linvfs_prepare_write+0x12/0x16 [xfs]
 [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
 [<0213b3c8>] generic_file_buffered_write+0x1b5/0x4ae
 [<8290e4ed>] xfs_da_brelse+0x73/0x92 [xfs]
 [<828f7400>] xfs_attr_leaf_get+0x4b/0x82 [xfs]
 [<82945a87>] xfs_write+0x622/0x982 [xfs]
 [<8294230d>] linvfs_write+0x6f/0x77 [xfs]
 [<02153d7b>] do_sync_write+0x97/0xc9
 [<8293a4d9>] xfs_inactive_free_eofblocks+0xd2/0x210 [xfs]
 [<0211deca>] autoremove_wake_function+0x0/0x2d
 [<02153e63>] vfs_write+0xb6/0xe2
 [<02153f2d>] sys_write+0x3c/0x62
possible deadlock in kmem_alloc (mode:0x50)

There is alot of errors in a few second like that and its always follow 
by several "possible deadlock in kmem_alloc (mode:0x50)"

Whats does it means?

The error is on a production server, is it dangerous?

What shoud I do to fix it?

Some extra info:
Filesystem: XFS
Kernel: 2.6.9-1.667smp


Thanks in advance. I have been searching several days and I have found nothing .

Ruben Rubio Rey

