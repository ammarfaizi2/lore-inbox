Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266821AbUIEPzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266821AbUIEPzb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 11:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUIEPzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 11:55:31 -0400
Received: from nysv.org ([213.157.66.145]:53962 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S266821AbUIEPz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 11:55:26 -0400
Date: Sun, 5 Sep 2004 18:55:02 +0300
To: linux-kernel@vger.kernel.org
Cc: reiserfs-list@namesys.com
Subject: Re: Scheduler experiences (with Reiser4 bug report)
Message-ID: <20040905155502.GR26192@nysv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040905142502.GQ26192@nysv.org>
User-Agent: Mutt/1.5.6i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yours truly wrote:
>I haven't tried nicksched in a while, but it didn't perform as well as
>Staircase.

Just gave -rc1-mm3 a shot and had my filesystems say bad things.
shrike kernel: reiser4 panicked cowardly: assertion failed: extent_get_start(ext) == extent_get_start(&uf_coord->extension.extent.extent)
/bin/sh: line 1:  4407 Segmentation fault      rm -f fs/xfs/.xfs_bmap.o.d


Didn't get around to renicing X, but anyway, app launch time was longer
and the music did twitch a bit when starting the simultaneous kernel
and glibc compiles. So I'm still on Staircase and don't see any reason
to change away.

I retried running as much cpu-intensive stuff as I could on cko5, basically
ck6, and everything was smooth. Respects to Con for that :)

This is not a troll nor a flamebait, but an honest question.
Should the need to re-nice X not be seen as broken behavior?

Then on to the Reiser4 issue:

Sep  5 18:45:37 shrike kernel: reiser4[http(4397)]: ext_by_ext_coord (fs/reiser4/plugin/item/extent_file_ops.c:26)[vs-1650]:
Sep  5 18:45:37 shrike kernel: code: -2 at fs/reiser4/search.c:1214
Sep  5 18:45:37 shrike kernel: ------------[ cut here ]------------
Sep  5 18:45:37 shrike kernel: Modules linked in: snd_bt87x ohci1394 ieee1394 snd_emu10k1 snd_rawmidi snd_pcm snd_timer snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep snd soundcore parport_pc parport evdev tun iptable_nat ip_conntrack ip_tables uhci_hcd usbcore tuner tda9887 msp3400 bttv video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc videodev i2c_dev i2c_core radeon amd_k7_agp agpgart nvram ide_cd cdrom md5 des blowfish oprofile msr cpuid
Sep  5 18:45:37 shrike kernel: CPU:    0
Sep  5 18:45:37 shrike kernel: EIP:    0060:[reiser4_do_panic+536/576]    Not tainted VLI
Sep  5 18:45:37 shrike kernel: EFLAGS: 00210246   (2.6.9-rc1-mm3) 
Sep  5 18:45:37 shrike kernel: EIP is at reiser4_do_panic+0x218/0x240
Sep  5 18:45:37 shrike kernel: eax: c05b3fcc   ebx: d4a71f38   ecx: c05b3fcc   edx: d4a71f38
Sep  5 18:45:37 shrike kernel: esi: 0e2b005b   edi: d2bc3d4c   ebp: d2a5bca0   esp: d2bc3c44
Sep  5 18:45:37 shrike kernel: ds: 007b   es: 007b   ss: 0068
Sep  5 18:45:37 shrike kernel: Process http (pid: 4397, threadinfo=d2bc2000 task=d9ba3aa0)
Sep  5 18:45:37 shrike kernel: Stack: c044f7c0 c05b3ba0 c043d880 0e29005b c023f3e1 c04389b3 c045b7a0 0000001a 
Sep  5 18:45:37 shrike kernel:        d2bc3c70 d2bc3cc8 d2bc3d4c d2a5bca0 00000009 d2a58000 d2bc3d6c d2bc2000 
Sep  5 18:45:38 shrike kernel:        00000000 d2bc3d4c 00000003 c0241b3e 00000000 00000000 d2bc3d4c c0261f0f 
Sep  5 18:45:38 shrike kernel: Call Trace:
Sep  5 18:45:38 shrike kernel:  [coord_extension_is_ok+545/1088] coord_extension_is_ok+0x221/0x440
Sep  5 18:45:38 shrike kernel:  [make_extent+558/976] make_extent+0x22e/0x3d0
Sep  5 18:45:38 shrike kernel:  [how_to_write+143/5136] how_to_write+0x8f/0x1410
Sep  5 18:45:38 shrike kernel:  [check_jload+55/160] check_jload+0x37/0xa0
Sep  5 18:45:38 shrike kernel:  [file_is_built_of_tails+5/16] file_is_built_of_tails+0x5/0x10
Sep  5 18:45:38 shrike kernel:  [capture_extent+248/1536] capture_extent+0xf8/0x600
Sep  5 18:45:38 shrike kernel:  [find_or_create_extent+337/544] find_or_create_extent+0x151/0x220
Sep  5 18:45:38 shrike kernel:  [shorten_file+359/832] shorten_file+0x167/0x340
Sep  5 18:45:38 shrike kernel:  [truncate_file_body+47/64] truncate_file_body+0x2f/0x40
Sep  5 18:45:38 shrike kernel:  [setattr_truncate+114/496] setattr_truncate+0x72/0x1f0
Sep  5 18:45:39 shrike kernel:  [tcp_recvmsg+747/1792] tcp_recvmsg+0x2eb/0x700
Sep  5 18:45:39 shrike kernel:  [schedulable+8/112] schedulable+0x8/0x70
Sep  5 18:45:39 shrike kernel:  [setattr_unix_file+44/80] setattr_unix_file+0x2c/0x50
Sep  5 18:45:39 shrike kernel:  [reiser4_setattr+127/464] reiser4_setattr+0x7f/0x1d0
Sep  5 18:45:39 shrike kernel:  [filemap_nopage+446/768] filemap_nopage+0x1be/0x300
Sep  5 18:45:39 shrike kernel:  [do_page_fault+375/1357] do_page_fault+0x177/0x54d
Sep  5 18:45:39 shrike kernel:  [notify_change+334/400] notify_change+0x14e/0x190
Sep  5 18:45:39 shrike kernel:  [do_truncate+90/160] do_truncate+0x5a/0xa0
Sep  5 18:45:39 shrike kernel:  [sys_ftruncate+253/384] sys_ftruncate+0xfd/0x180
Sep  5 18:45:39 shrike kernel:  [do_fcntl+166/320] do_fcntl+0xa6/0x140
Sep  5 18:45:39 shrike kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep  5 18:45:39 shrike kernel: Code: 42 c0 c7 44 24 08 d6 00 00 00 c7 44 24 04 9e 89 43 c0 c7 04 24 40 29 3f c0 e8 35 00 00 00 c7 44 24 04 40 f8 44 c0 e9 f7 fe ff ff <0f> 0b 85 00 ef 89 43 c0 c7 04 24 0b 54 43 c0 c7 44 24 04 a0 3b 
Sep  5 18:45:45 shrike kernel:  reiser4[bash(3830)]: txnh_list_link_ok (fs/reiser4/txnmgr.c:286)[nikita-1054]:
Sep  5 18:45:45 shrike kernel: code: -2 at fs/reiser4/search.c:1278
Sep  5 18:45:45 shrike kernel: ------------[ cut here ]------------
Sep  5 18:45:45 shrike kernel: Modules linked in: snd_bt87x ohci1394 ieee1394 snd_emu10k1 snd_rawmidi snd_pcm snd_timer snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep snd soundcore parport_pc parport evdev tun iptable_nat ip_conntrack ip_tables uhci_hcd usbcore tuner tda9887 msp3400 bttv video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc videodev i2c_dev i2c_core radeon amd_k7_agp agpgart nvram ide_cd cdrom md5 des blowfish oprofile msr cpuid
Sep  5 18:45:45 shrike kernel: CPU:    0
Sep  5 18:45:45 shrike kernel: EIP:    0060:[reiser4_do_panic+536/576]    Not tainted VLI
Sep  5 18:45:45 shrike kernel: EFLAGS: 00210202   (2.6.9-rc1-mm3) 
Sep  5 18:45:45 shrike kernel: EIP is at reiser4_do_panic+0x218/0x240
Sep  5 18:45:45 shrike kernel: eax: 00000025   ebx: 00000001   ecx: c04389b3   edx: 0000608b
Sep  5 18:45:45 shrike kernel: esi: dab4e040   edi: d9a29df8   ebp: 00000008   esp: d9a299d0
Sep  5 18:45:45 shrike kernel: ds: 007b   es: 007b   ss: 0068
Sep  5 18:45:45 shrike kernel: Process bash (pid: 3830, threadinfo=d9a28000 task=d9a06aa0)
Sep  5 18:45:45 shrike kernel: Stack: c0438a84 fffffffe c043d880 d2bc3e98 c01cd404 c04389b3 c0452da0 0000011e 
Sep  5 18:45:45 shrike kernel:        dab4e040 d6ec8040 d9a29df8 c01cf5e2 00000000 c01edfb2 000000d0 d6ec8040 
Sep  5 18:45:45 shrike kernel:        00000000 00000008 dab4e040 c01cc700 00000001 d9a29cb4 d9a29cb4 d9a29df8 
Sep  5 18:45:45 shrike kernel: Call Trace:
Sep  5 18:45:45 shrike kernel:  [capture_assign_txnh_nolock+164/576] capture_assign_txnh_nolock+0xa4/0x240
Sep  5 18:45:45 shrike kernel:  [capture_assign_txnh+242/592] capture_assign_txnh+0xf2/0x250
Sep  5 18:45:45 shrike kernel:  [reiser4_block_count+18/176] reiser4_block_count+0x12/0xb0
Sep  5 18:45:45 shrike kernel:  [try_capture_block+368/880] try_capture_block+0x170/0x370
Sep  5 18:45:45 shrike kernel:  [try_capture+104/304] try_capture+0x68/0x130
Sep  5 18:45:45 shrike kernel:  [longterm_lock_tryfast+77/272] longterm_lock_tryfast+0x4d/0x110
Sep  5 18:45:45 shrike kernel:  [schedulable+8/112] schedulable+0x8/0x70
Sep  5 18:45:45 shrike kernel:  [longterm_lock_znode+1520/1792] longterm_lock_znode+0x5f0/0x700
Sep  5 18:45:45 shrike kernel:  [reiser4_check_block+27/32] reiser4_check_block+0x1b/0x20
Sep  5 18:45:45 shrike kernel:  [zget+721/1600] zget+0x2d1/0x640
Sep  5 18:45:45 shrike kernel:  [item_type_by_coord+257/928] item_type_by_coord+0x101/0x3a0
Sep  5 18:45:45 shrike kernel:  [cbk_level_lookup+102/1392] cbk_level_lookup+0x66/0x570
Sep  5 18:45:45 shrike kernel:  [return_err+46/176] return_err+0x2e/0xb0
Sep  5 18:45:45 shrike kernel:  [move_lh_internal+715/2064] move_lh_internal+0x2cb/0x810
Sep  5 18:45:45 shrike kernel:  [traverse_tree+291/1824] traverse_tree+0x123/0x720
Sep  5 18:45:45 shrike kernel:  [coord_by_handle+41/80] coord_by_handle+0x29/0x50
Sep  5 18:45:45 shrike kernel:  [coord_by_key+252/800] coord_by_key+0xfc/0x320
Sep  5 18:45:45 shrike kernel:  [find_entry+712/1008] find_entry+0x2c8/0x3f0
Sep  5 18:45:45 shrike kernel:  [get_tree+18/176] get_tree+0x12/0xb0
Sep  5 18:45:45 shrike kernel:  [lookup_sd+117/352] lookup_sd+0x75/0x160
Sep  5 18:45:45 shrike kernel:  [read_inode+116/640] read_inode+0x74/0x280
Sep  5 18:45:45 shrike kernel:  [reiser4_alloc_inode+118/256] reiser4_alloc_inode+0x76/0x100
Sep  5 18:45:45 shrike kernel:  [reiser4_iget+652/1040] reiser4_iget+0x28c/0x410
Sep  5 18:45:45 shrike kernel:  [init_locked_inode+0/320] init_locked_inode+0x0/0x140
Sep  5 18:45:45 shrike kernel:  [__wake_up_common+55/96] __wake_up_common+0x37/0x60
Sep  5 18:45:45 shrike kernel:  [lookup_hashed+133/256] lookup_hashed+0x85/0x100
Sep  5 18:45:45 shrike kernel:  [init_context+237/848] init_context+0xed/0x350
Sep  5 18:45:45 shrike kernel:  [reiser4_lookup+116/432] reiser4_lookup+0x74/0x1b0
Sep  5 18:45:45 shrike kernel:  [d_lookup+27/64] d_lookup+0x1b/0x40
Sep  5 18:45:45 shrike kernel:  [real_lookup+184/224] real_lookup+0xb8/0xe0
Sep  5 18:45:45 shrike kernel:  [do_lookup+126/144] do_lookup+0x7e/0x90
Sep  5 18:45:45 shrike kernel:  [link_path_walk+1474/2944] link_path_walk+0x5c2/0xb80
Sep  5 18:45:45 shrike kernel:  [path_lookup+109/272] path_lookup+0x6d/0x110
Sep  5 18:45:45 shrike kernel:  [__user_walk+47/96] __user_walk+0x2f/0x60
Sep  5 18:45:45 shrike kernel:  [vfs_stat+29/80] vfs_stat+0x1d/0x50
Sep  5 18:45:45 shrike kernel:  [sys_stat64+18/48] sys_stat64+0x12/0x30
Sep  5 18:45:45 shrike kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep  5 18:45:45 shrike kernel: Code: 42 c0 c7 44 24 08 d6 00 00 00 c7 44 24 04 9e 89 43 c0 c7 04 24 40 29 3f c0 e8 35 00 00 00 c7 44 24 04 40 f8 44 c0 e9 f7 fe ff ff <0f> 0b 85 00 ef 89 43 c0 c7 04 24 0b 54 43 c0 c7 44 24 04 a0 3b 

-- 
mjt

