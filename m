Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVDAOjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVDAOjM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 09:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbVDAOjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 09:39:12 -0500
Received: from addr-213-139-170-200.suomi.net ([213.139.170.200]:1923 "EHLO
	asalmela.iki.fi") by vger.kernel.org with ESMTP id S261661AbVDAOjD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 09:39:03 -0500
Date: Fri, 1 Apr 2005 17:38:53 +0300
From: Antti Salmela <asalmela@iki.fi>
To: linux-kernel@vger.kernel.org
Cc: linux-lvm@redhat.com
Subject: 2.6.11ac5 oops while reconstructing md array and moving volumegroup with pvmove
Message-ID: <20050401143853.GA11763@asalmela.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had created a new raid1 array and started moving a volume group to it at the
same time while it was reconstructing. Got this oops after several hours,
apparently while cron-jobs were run.

1 GB of memory, HIGHMEM configured.

 Unable to handle kernel paging request at virtual address f88d63a0
  printing eip:
 c028a7f6
 *pde = 018eb067
 *pte = 00000000
 Oops: 0000 [#1]
 Modules linked in: esp6 ah6 nfsd exportfs via686a snd_ymfpci snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_opl3_lib snd_timer snd_hwdep snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore uhci_hcd i2c_dev w83781d i2c_sensor i2c_viapro i2c_core
 CPU:    0
 EIP:    0060:[core_in_sync+6/32]    Not tainted VLI
 EFLAGS: 00010246   (2.6.11ac5) 
 EIP is at core_in_sync+0x6/0x20
 eax: f88d3000   ebx: c0407260   ecx: 00000000   edx: 00019d00
 esi: f21d7aa0   edi: f6c78720   ebp: 00000000   esp: ea22eb74
 ds: 007b   es: 007b   ss: 0068
 Process find (pid: 14250, threadinfo=ea22e000 task=ebdf50e0)
 Stack: c028bf7c f7c05f60 e87945fc f21d7aa0 f882c06c c027ffb0 06740010 00000000 
        ea22ebe0 ebed0520 ebed0520 c0280367 00000001 00000008 ebdf50e0 c01266e0 
        e87945fc 0263bff0 00000000 f882c06c ebed0520 ea22ebe0 ebed0520 ea22ec40 
 Call Trace:
  [mirror_map+76/192] mirror_map+0x4c/0xc0
  [__map_bio+64/256] __map_bio+0x40/0x100
  [__clone_and_map+551/576] __clone_and_map+0x227/0x240
  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
  [__split_bio+142/256] __split_bio+0x8e/0x100
  [dm_request+100/144] dm_request+0x64/0x90
  [generic_make_request+326/480] generic_make_request+0x146/0x1e0
  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
  [bio_clone+160/176] bio_clone+0xa0/0xb0
  [__map_bio+64/256] __map_bio+0x40/0x100
  [__clone_and_map+551/576] __clone_and_map+0x227/0x240
  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
  [__split_bio+142/256] __split_bio+0x8e/0x100
  [dm_request+100/144] dm_request+0x64/0x90
  [ext3_get_block_handle+123/736] ext3_get_block_handle+0x7b/0x2e0
  [dm_request+100/144] dm_request+0x64/0x90
  [generic_make_request+326/480] generic_make_request+0x146/0x1e0
  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
  [mempool_alloc+99/256] mempool_alloc+0x63/0x100
  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
  [submit_bio+88/224] submit_bio+0x58/0xe0
  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
  [__find_get_block+66/160] __find_get_block+0x42/0xa0
  [bio_alloc+200/400] bio_alloc+0xc8/0x190
  [submit_bh+193/272] submit_bh+0xc1/0x110
  [__ext3_get_inode_loc+309/528] __ext3_get_inode_loc+0x135/0x210
  [schedule+691/1184] schedule+0x2b3/0x4a0
  [generic_unplug_device+6/16] generic_unplug_device+0x6/0x10
  [ext3_read_inode+53/896] ext3_read_inode+0x35/0x380
  [ext3_alloc_inode+15/80] ext3_alloc_inode+0xf/0x50
  [alloc_inode+22/336] alloc_inode+0x16/0x150
  [ext3_lookup+132/176] ext3_lookup+0x84/0xb0
  [real_lookup+174/208] real_lookup+0xae/0xd0
  [do_lookup+126/144] do_lookup+0x7e/0x90
  [link_path_walk+1561/2880] link_path_walk+0x619/0xb40
  [path_lookup+109/272] path_lookup+0x6d/0x110
  [__user_walk+47/96] __user_walk+0x2f/0x60
  [vfs_lstat+26/80] vfs_lstat+0x1a/0x50
  [sys_lstat64+18/48] sys_lstat64+0x12/0x30
  [shmem_populate+173/336] shmem_populate+0xad/0x150
  [do_IRQ+69/96] do_IRQ+0x45/0x60
  [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75
Code: 27 00 00 00 00 8b 40 04 8b 40 18 0f a3 10 19 d2 31 c0 85 d2 0f 95 c0 c3 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 40 04 8b 40 1c <0f> a3 10 19 d2 31 c0 85 d2 0f 95 c0 c3 8d b6 00 00 00 00 8d bc

-- 
Antti Salmela
