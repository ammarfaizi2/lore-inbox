Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbTJZUIl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 15:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbTJZUIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 15:08:41 -0500
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:23936
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S263646AbTJZUId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 15:08:33 -0500
From: John Mock <kd6pag@qsl.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: test9/PPC: Ejecting CDROM gets slab error in cache_free_debugcheck() from various places
Message-Id: <E1ADrC6-0000ny-00@penngrove.fdns.net>
Date: Sun, 26 Oct 2003 12:08:58 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lots a awful lot like the same bug i just reported with sd_revalidate_disk(),
here it's coming from several places.  So it sounds like the MESH driver is
going to need some work.
				 -- JM

-------------------------------------------------------------------------------
slab error in cache_free_debugcheck(): cache `size-512(DMA)': double free, or memory outside object was overwritten
Call trace:
 [c000956c] dump_stack+0x18/0x28
 [c003beac] __slab_error+0x2c/0x3c
 [c003e784] kfree+0x290/0x384
 [cf8e0f94] get_capabilities+0x3f0/0x42c [sr_mod]
 [cf8e08cc] sr_probe+0x1e0/0x288 [sr_mod]
 [c00b9958] bus_match+0x50/0x8c
 [c00b9ad8] driver_attach+0x88/0xc8
 [c00b9e28] bus_add_driver+0x90/0xe0
 [c00ba288] driver_register+0x30/0x40
 [c00d65d4] scsi_register_driver+0x1c/0x2c
 [cf8cf048] init_sr+0x48/0x90 [sr_mod]
 [c0033ff0] sys_init_module+0x198/0x31c
 [c000595c] ret_from_syscall+0x0/0x44
c797ec88: redzone 1: 0x0, redzone 2: 0x170fc2a5.
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
slab error in cache_free_debugcheck(): cache `size-512(DMA)': double free, or memory outside object was overwritten
Call trace:
 [c000956c] dump_stack+0x18/0x28
 [c003beac] __slab_error+0x2c/0x3c
 [c003e784] kfree+0x290/0x384
 [cf8e0a80] get_sectorsize+0x10c/0x230 [sr_mod]
 [cf8e0688] sr_open+0x74/0x84 [sr_mod]
 [cf8d44a8] cdrom_open+0xec/0x100 [cdrom]
 [cf8e0548] sr_block_open+0x28/0x38 [sr_mod]
 [c005b0c8] do_open+0x160/0x468
 [c005b488] blkdev_open+0x3c/0xa0
 [c00518a8] dentry_open+0x158/0x22c
 [c005174c] filp_open+0x64/0x68
 [c0051c30] sys_open+0x68/0xa0
 [c000595c] ret_from_syscall+0x0/0x44
c797ec88: redzone 1: 0x0, redzone 2: 0x170fc2a5.
slab error in cache_free_debugcheck(): cache `size-32': double free, or memory outside object was overwritten
Call trace:
 [c000956c] dump_stack+0x18/0x28
 [c003beac] __slab_error+0x2c/0x3c
 [c003e784] kfree+0x290/0x384
 [cf8e18dc] sr_audio_ioctl+0xa4/0x24c [sr_mod]
 [cf8e15d0] sr_disk_status+0x24/0xd0 [sr_mod]
 [cf8e2078] sr_cd_check+0xe0/0x46c [sr_mod]
 [cf8e00a0] sr_media_change+0xa0/0xbc [sr_mod]
 [cf8d5158] media_changed+0x7c/0xac [cdrom]
 [cf8e0604] sr_block_media_changed+0x18/0x28 [sr_mod]
 [c005ae74] check_disk_change+0x4c/0xbc
 [cf8d4460] cdrom_open+0xa4/0x100 [cdrom]
 [cf8e0548] sr_block_open+0x28/0x38 [sr_mod]
 [c005b0c8] do_open+0x160/0x468
 [c005b488] blkdev_open+0x3c/0xa0
 [c00518a8] dentry_open+0x158/0x22c
cae46440: redzone 1: 0x70000200, redzone 2: 0x170fc2a5.
slab error in cache_free_debugcheck(): cache `size-512(DMA)': double free, or memory outside object was overwritten
Call trace:
 [c000956c] dump_stack+0x18/0x28
 [c003beac] __slab_error+0x2c/0x3c
 [c003e784] kfree+0x290/0x384
 [cf8e20c8] sr_cd_check+0x130/0x46c [sr_mod]
 [cf8e00a0] sr_media_change+0xa0/0xbc [sr_mod]
 [cf8d5158] media_changed+0x7c/0xac [cdrom]
 [cf8e0604] sr_block_media_changed+0x18/0x28 [sr_mod]
 [c005ae74] check_disk_change+0x4c/0xbc
 [cf8d4460] cdrom_open+0xa4/0x100 [cdrom]
 [cf8e0548] sr_block_open+0x28/0x38 [sr_mod]
 [c005b0c8] do_open+0x160/0x468
 [c005b488] blkdev_open+0x3c/0xa0
 [c00518a8] dentry_open+0x158/0x22c
 [c005174c] filp_open+0x64/0x68
 [c0051c30] sys_open+0x68/0xa0
c797ec88: redzone 1: 0x0, redzone 2: 0x170fc2a5.
===============================================================================
