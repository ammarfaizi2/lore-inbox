Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263744AbUCXPLz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 10:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUCXPLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 10:11:54 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:38084 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263744AbUCXPLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 10:11:51 -0500
Date: Wed, 24 Mar 2004 10:11:58 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: drivers/block/elevator.c:249
Message-ID: <Pine.LNX.4.58.0403241006310.28727@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm hitting the following WARN_ON constantly on a slow (133MHz) SMP box
with Fast SCSI for disks. Kernel is 2.6.5-rc2-mm1, i'll be trying
2.6.5-rc2-mm2 shortly. The warning crops up as early as the bootscripts.

Badness in elv_remove_request at drivers/block/elevator.c:249
Call Trace:
 [<c034ab67>] elv_remove_request+0x77/0x80
 [<c03a3432>] scsi_request_fn+0x432/0x4f0
 [<c034aa55>] elv_next_request+0x45/0xe0
 [<c034c4ac>] generic_unplug_device+0x7c/0xa0
 [<c034ed8a>] blk_backing_dev_unplug+0x1a/0x1d
 [<c0160dbe>] __wait_on_buffer+0xde/0xf0
 [<c011d980>] autoremove_wake_function+0x0/0x40
 [<c011d980>] autoremove_wake_function+0x0/0x40
 [<c01daba4>] jread+0x94/0xe0
 [<c01dad9f>] do_one_pass+0x4f/0x3f0
 [<c011d980>] autoremove_wake_function+0x0/0x40
 [<c01646e1>] submit_bh+0x71/0x160
 [<c01dac89>] journal_recover+0x49/0xa0
 [<c01de56d>] journal_load+0x4d/0x90
 [<c01d4c2d>] ext3_load_journal+0xbd/0x1a0
 [<c01d46d3>] ext3_fill_super+0x973/0xae0
 [<c02d6708>] snprintf+0x18/0x20
 [<c016777d>] get_sb_bdev+0xed/0x130
 [<c0147325>] __kmalloc+0x85/0xa0
 [<c01d546d>] ext3_get_sb+0x1d/0x21
 [<c01d3d60>] ext3_fill_super+0x0/0xae0
 [<c01679a5>] do_kern_mount+0x95/0x140
 [<c0180ee1>] do_add_mount+0x51/0x160
 [<c018124c>] do_mount+0x14c/0x1b0
 [<c018107f>] copy_mount_options+0x8f/0x110
 [<c01816eb>] sys_mount+0xbb/0x170
 [<c0691ffd>] do_mount_root+0x1d/0xa0
 [<c06920bf>] mount_block_root+0x3f/0xf0
 [<c06921c1>] mount_root+0x51/0x60
 [<c06921e9>] prepare_namespace+0x19/0xa0
 [<c0103239>] init+0x179/0x1b0
 [<c01030c0>] init+0x0/0x1b0
 [<c01050f5>] kernel_thread_helper+0x5/0x10

