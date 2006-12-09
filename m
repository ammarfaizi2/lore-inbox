Return-Path: <linux-kernel-owner+w=401wt.eu-S1947621AbWLIBFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947621AbWLIBFb (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 20:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947620AbWLIBFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 20:05:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:42080 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947610AbWLIBF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 20:05:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=WKr95tjH1hATM6wgzORADBFM4QWW2OquqPmKoYB7Q5UhhGAdKvM1gvnz+MQU741cCKVuiyHuMdSoMc+Ho3sEtDYtJnPkE/AonGl7pLKxnC954bHQli87n7qhOWiUA3j9CnqlhTlAYvapItLdIW15z/3ox6mhtnhZnPqKI9tMapE=
Message-ID: <457A0BCB.3080808@gmail.com>
Date: Sat, 09 Dec 2006 02:04:52 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Larry Finger <Larry.Finger@lwfinger.net>
CC: LKML <linux-kernel@vger.kernel.org>, aia21@cantab.net,
       Andrew Morton <akpm@osdl.org>, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: Possible circular locking in ntfs on 2.6.19-rc5-mm2 (now 2.6.19-rc6-mm2)
References: <45671B11.5010801@lwfinger.net> <3888a5cd0612081658r3980471byf4e502ec756073d8@mail.gmail.com>
In-Reply-To: <3888a5cd0612081658r3980471byf4e502ec756073d8@mail.gmail.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> ---------- Forwarded message ----------
> From: Larry Finger <Larry.Finger@lwfinger.net>
> Date: Nov 24, 2006 5:17 PM
> Subject: Possible circular locking in ntfs on 2.6.19-rc5-mm2
> To: LKML <linux-kernel@vger.kernel.org>, aia21@cantab.net
> 
> 
> On kernel 2.6.19-rc5-mm2, my log shows the following dump of a
> possible circular locking problem.
> The dump occurred while running an updatedb command that was initiated
> by cron.
> 
> Nov 24 02:13:23 larrylap kernel:
> =======================================================
> Nov 24 02:13:23 larrylap kernel: [ INFO: possible circular locking
> dependency detected ]
> Nov 24 02:13:23 larrylap kernel: 2.6.19-rc5-mm2-DSCA #4
> Nov 24 02:13:23 larrylap kernel:
> -------------------------------------------------------
> Nov 24 02:13:23 larrylap kernel: find/32325 is trying to acquire lock:
> Nov 24 02:13:23 larrylap kernel:  (iprune_mutex){--..}, at:
> [<c0325689>] mutex_lock+0x29/0x30
> Nov 24 02:13:23 larrylap kernel:
> Nov 24 02:13:23 larrylap kernel: but task is already holding lock:
> Nov 24 02:13:23 larrylap kernel:  (&ni->mrec_lock){--..}, at:
> [<c0325689>] mutex_lock+0x29/0x30
> Nov 24 02:13:23 larrylap kernel:
> Nov 24 02:13:23 larrylap kernel: which lock already depends on the new
> lock.
> Nov 24 02:13:23 larrylap kernel:
> Nov 24 02:13:25 larrylap kernel:
> Nov 24 02:13:25 larrylap kernel: the existing dependency chain (in
> reverse order) is:
> Nov 24 02:13:25 larrylap kernel:
> Nov 24 02:13:25 larrylap kernel: -> #2 (&ni->mrec_lock){--..}:
> Nov 24 02:13:25 larrylap kernel:        [<c01334ad>]
> add_lock_to_list+0x3d/0xb0
> Nov 24 02:13:25 larrylap kernel:        [<c0135b07>]
> __lock_acquire+0xac7/0xcd0
> Nov 24 02:13:25 larrylap kernel:        [<c0136092>] lock_acquire+0x62/0x80
> Nov 24 02:13:25 larrylap kernel:        [<c032545f>]
> __mutex_lock_slowpath+0x7f/0x280
> Nov 24 02:13:25 larrylap kernel:        [<c0325689>] mutex_lock+0x29/0x30
> Nov 24 02:13:25 larrylap kernel:        [<e583b0bc>]
> map_mft_record+0x1c/0x260 [ntfs]
> Nov 24 02:13:25 larrylap kernel:        [<e5832d9c>]
> ntfs_map_runlist_nolock+0x3dc/0x520 [ntfs]
> Nov 24 02:13:25 larrylap kernel:        [<e5833304>]
> ntfs_map_runlist+0x54/0x80 [ntfs]
> Nov 24 02:13:25 larrylap kernel:        [<e5831af8>]
> ntfs_readpage+0x7d8/0x930 [ntfs]
> Nov 24 02:13:25 larrylap kernel:        [<c0144ce3>]
> read_cache_page+0xa3/0x180
> Nov 24 02:13:25 larrylap kernel:        [<e5834f86>]
> ntfs_lookup_inode_by_name+0x3c6/0xde0 [ntfs]
> Nov 24 02:13:25 larrylap kernel:        [<e583bb25>]
> ntfs_lookup+0x65/0x5e0 [ntfs]
> Nov 24 02:13:25 larrylap kernel:        [<c016d184>] do_lookup+0x144/0x190
> Nov 24 02:13:25 larrylap kernel:        [<c016d314>]
> __link_path_walk+0x144/0xe00
> Nov 24 02:13:25 larrylap kernel:        [<c016e01e>]
> link_path_walk+0x4e/0xe0
> Nov 24 02:13:25 larrylap kernel:        [<c016e3ec>]
> do_path_lookup+0x8c/0x1d0
> Nov 24 02:13:25 larrylap kernel:        [<c016ea7a>]
> __path_lookup_intent_open+0x4a/0x90
> Nov 24 02:13:25 larrylap kernel:        [<c016eb4a>]
> path_lookup_open+0x2a/0x30
> Nov 24 02:13:25 larrylap kernel:        [<c016edd7>] open_namei+0x77/0x6a0
> Nov 24 02:13:25 larrylap kernel:        [<c0163c28>] do_filp_open+0x38/0x60
> Nov 24 02:13:25 larrylap kernel:        [<c0163c9b>] do_sys_open+0x4b/0x100
> Nov 24 02:13:25 larrylap kernel:        [<c0163da7>] sys_open+0x27/0x30
> Nov 24 02:13:25 larrylap kernel:        [<c0102fb2>]
> sysenter_past_esp+0x5f/0x99
> Nov 24 02:13:25 larrylap kernel:        [<b7f72410>] 0xb7f72410
> Nov 24 02:13:25 larrylap kernel:        [<ffffffff>] 0xffffffff
> Nov 24 02:13:25 larrylap kernel:
> Nov 24 02:13:25 larrylap kernel: -> #1 (&rl->lock){----}:
> Nov 24 02:13:25 larrylap kernel:        [<c01334ad>]
> add_lock_to_list+0x3d/0xb0
> Nov 24 02:13:25 larrylap kernel:        [<c0135b07>]
> __lock_acquire+0xac7/0xcd0
> Nov 24 02:13:25 larrylap kernel:        [<c0136092>] lock_acquire+0x62/0x80
> Nov 24 02:13:25 larrylap kernel:        [<c0130165>] down_write+0x55/0x70
> Nov 24 02:13:25 larrylap kernel:        [<e5837965>]
> __ntfs_clear_inode+0x15/0x160 [ntfs]
> Nov 24 02:13:25 larrylap kernel:        [<e5837b99>]
> ntfs_clear_big_inode+0x69/0xf0 [ntfs]
> Nov 24 02:13:25 larrylap kernel:        [<c0178a62>] clear_inode+0x92/0x130
> Nov 24 02:13:25 larrylap kernel:        [<c0178b28>]
> dispose_list+0x28/0x100
> Nov 24 02:13:25 larrylap kernel:        [<c0178ded>]
> shrink_icache_memory+0x1ed/0x220
> Nov 24 02:13:26 larrylap kernel:        [<c014deb2>]
> shrink_slab+0x122/0x1a0
> Nov 24 02:13:26 larrylap kernel:        [<c014ef97>] kswapd+0x287/0x420
> Nov 24 02:13:26 larrylap kernel:        [<c012c68b>] kthread+0xdb/0xe0
> Nov 24 02:13:26 larrylap kernel:        [<c0103373>]
> kernel_thread_helper+0x7/0x14
> Nov 24 02:13:26 larrylap kernel:        [<ffffffff>] 0xffffffff
> Nov 24 02:13:26 larrylap kernel:
> Nov 24 02:13:26 larrylap kernel: -> #0 (iprune_mutex){--..}:
> Nov 24 02:13:26 larrylap kernel:        [<c0133706>]
> print_circular_bug_tail+0x46/0x90
> Nov 24 02:13:26 larrylap kernel:        [<c0135969>]
> __lock_acquire+0x929/0xcd0
> Nov 24 02:13:26 larrylap kernel:        [<c0136092>] lock_acquire+0x62/0x80
> Nov 24 02:13:26 larrylap kernel:        [<c032545f>]
> __mutex_lock_slowpath+0x7f/0x280
> Nov 24 02:13:26 larrylap kernel:        [<c0325689>] mutex_lock+0x29/0x30
> Nov 24 02:13:26 larrylap kernel:        [<c0178c61>]
> shrink_icache_memory+0x61/0x220
> Nov 24 02:13:26 larrylap kernel:        [<c014deb2>]
> shrink_slab+0x122/0x1a0
> Nov 24 02:13:26 larrylap kernel:        [<c014f5c6>]
> try_to_free_pages+0x146/0x230
> Nov 24 02:13:26 larrylap kernel:        [<c014904a>]
> __alloc_pages+0x13a/0x340
> Nov 24 02:13:26 larrylap kernel:        [<c0144cb8>]
> read_cache_page+0x78/0x180
> Nov 24 02:13:26 larrylap kernel:        [<e583b157>]
> map_mft_record+0xb7/0x260 [ntfs]
> Nov 24 02:13:26 larrylap kernel:        [<e5838ea9>]
> ntfs_read_locked_inode+0x59/0x1580 [ntfs]
> Nov 24 02:13:26 larrylap kernel:        [<e583b026>] ntfs_iget+0x66/0x90
> [ntfs]
> Nov 24 02:13:26 larrylap kernel:        [<e583bbc1>]
> ntfs_lookup+0x101/0x5e0 [ntfs]
> Nov 24 02:13:26 larrylap kernel:        [<c016d184>] do_lookup+0x144/0x190
> Nov 24 02:13:26 larrylap kernel:        [<c016da26>]
> __link_path_walk+0x856/0xe00
> Nov 24 02:13:26 larrylap kernel:        [<c016e01e>]
> link_path_walk+0x4e/0xe0
> Nov 24 02:13:26 larrylap kernel:        [<c016e3ec>]
> do_path_lookup+0x8c/0x1d0
> Nov 24 02:13:26 larrylap kernel:        [<c016eb89>]
> __user_walk_fd+0x39/0x60
> Nov 24 02:13:26 larrylap kernel:        [<c016799f>] vfs_lstat_fd+0x1f/0x60
> Nov 24 02:13:26 larrylap kernel:        [<c0167a00>] vfs_lstat+0x20/0x30
> Nov 24 02:13:26 larrylap kernel:        [<c01682c9>] sys_lstat64+0x19/0x30
> Nov 24 02:13:26 larrylap kernel:        [<c0102fb2>]
> sysenter_past_esp+0x5f/0x99
> Nov 24 02:13:26 larrylap kernel:        [<b7f67410>] 0xb7f67410
> Nov 24 02:13:26 larrylap kernel:        [<ffffffff>] 0xffffffff
> Nov 24 02:13:26 larrylap kernel:
> Nov 24 02:13:26 larrylap kernel: other info that might help us debug this:
> Nov 24 02:13:26 larrylap kernel:
> Nov 24 02:13:26 larrylap kernel: 3 locks held by find/32325:
> Nov 24 02:13:26 larrylap kernel:  #0:  (&inode->i_mutex){--..}, at:
> [<c0325689>] mutex_lock+0x29/0x30
> Nov 24 02:13:26 larrylap kernel:  #1:  (&ni->mrec_lock){--..}, at:
> [<c0325689>] mutex_lock+0x29/0x30
> Nov 24 02:13:26 larrylap kernel:  #2:  (shrinker_rwsem){----}, at:
> [<c014ddb2>] shrink_slab+0x22/0x1a0
> Nov 24 02:13:26 larrylap kernel:
> Nov 24 02:13:26 larrylap kernel: stack backtrace:
> Nov 24 02:13:26 larrylap kernel:  [<c01039d0>] dump_trace+0x210/0x220
> Nov 24 02:13:26 larrylap kernel:  [<c0103a06>] show_trace_log_lvl+0x26/0x40
> Nov 24 02:13:26 larrylap kernel:  [<c0103dfb>] show_trace+0x1b/0x20
> Nov 24 02:13:27 larrylap kernel:  [<c0103e24>] dump_stack+0x24/0x30
> Nov 24 02:13:27 larrylap kernel:  [<c0133741>]
> print_circular_bug_tail+0x81/0x90
> Nov 24 02:13:27 larrylap kernel:  [<c0135969>] __lock_acquire+0x929/0xcd0
> Nov 24 02:13:27 larrylap kernel:  [<c0136092>] lock_acquire+0x62/0x80
> Nov 24 02:13:27 larrylap kernel:  [<c032545f>]
> __mutex_lock_slowpath+0x7f/0x280
> Nov 24 02:13:27 larrylap kernel:  [<c0325689>] mutex_lock+0x29/0x30
> Nov 24 02:13:27 larrylap kernel:  [<c0178c61>]
> shrink_icache_memory+0x61/0x220
> Nov 24 02:13:27 larrylap kernel:  [<c014deb2>] shrink_slab+0x122/0x1a0
> Nov 24 02:13:27 larrylap kernel:  [<c014f5c6>]
> try_to_free_pages+0x146/0x230
> Nov 24 02:13:27 larrylap kernel:  [<c014904a>] __alloc_pages+0x13a/0x340
> Nov 24 02:13:27 larrylap kernel:  [<c0144cb8>] read_cache_page+0x78/0x180
> Nov 24 02:13:27 larrylap kernel:  [<e583b157>] map_mft_record+0xb7/0x260
> [ntfs]
> Nov 24 02:13:27 larrylap kernel:  [<e5838ea9>]
> ntfs_read_locked_inode+0x59/0x1580 [ntfs]
> Nov 24 02:13:27 larrylap kernel:  [<e583b026>] ntfs_iget+0x66/0x90 [ntfs]
> Nov 24 02:13:27 larrylap kernel:  [<e583bbc1>] ntfs_lookup+0x101/0x5e0
> [ntfs]
> Nov 24 02:13:27 larrylap kernel:  [<c016d184>] do_lookup+0x144/0x190
> Nov 24 02:13:27 larrylap kernel:  [<c016da26>] __link_path_walk+0x856/0xe00
> Nov 24 02:13:27 larrylap kernel:  [<c016e01e>] link_path_walk+0x4e/0xe0
> Nov 24 02:13:27 larrylap kernel:  [<c016e3ec>] do_path_lookup+0x8c/0x1d0
> Nov 24 02:13:27 larrylap kernel:  [<c016eb89>] __user_walk_fd+0x39/0x60
> Nov 24 02:13:27 larrylap kernel:  [<c016799f>] vfs_lstat_fd+0x1f/0x60
> Nov 24 02:13:27 larrylap kernel:  [<c0167a00>] vfs_lstat+0x20/0x30
> Nov 24 02:13:27 larrylap kernel:  [<c01682c9>] sys_lstat64+0x19/0x30
> Nov 24 02:13:27 larrylap kernel:  [<c0102fb2>] sysenter_past_esp+0x5f/0x99
> Nov 24 02:13:27 larrylap kernel:  [<b7f67410>] 0xb7f67410
> Nov 24 02:13:27 larrylap kernel:  =======================

I have similar problem here, on 2.6.19-rc6-mm2:
[  701.477654] =======================================================
[  701.477793] [ INFO: possible circular locking dependency detected ]
[  701.477862] 2.6.19-rc6-mm2 #202
[  701.477925] -------------------------------------------------------
[  701.477994] umount/12641 is trying to acquire lock:
[  701.478060]  (&inode->i_mutex){--..}, at: [<c036f216>] mutex_lock+0x12/0x15
[  701.478297]
[  701.478299] but task is already holding lock:
[  701.478441]  (iprune_mutex){--..}, at: [<c036f216>] mutex_lock+0x12/0x15
[  701.478692]
[  701.478693] which lock already depends on the new lock.
[  701.478696]
[  701.478908]
[  701.478910] the existing dependency chain (in reverse order) is:
[  701.479059]
[  701.479061] -> #3 (iprune_mutex){--..}:
[  701.479290]        [<c013d928>] __lock_acquire+0xaed/0xc03
[  701.479612]        [<c013dd5d>] lock_acquire+0x57/0x70
[  701.479920]        [<c036f018>] __mutex_lock_slowpath+0x73/0x25f
[  701.480230]        [<c036f216>] mutex_lock+0x12/0x15
[  701.480539]        [<c017dc87>] invalidate_inodes+0x1e/0xd6
[  701.480848]        [<c016d181>] generic_shutdown_super+0x48/0x10c
[  701.481158]        [<c016d265>] kill_block_super+0x20/0x32
[  701.481496]        [<c016d307>] deactivate_super+0x3f/0x51
[  701.481804]        [<c017f6eb>] mntput_no_expire+0x44/0x62
[  701.482111]        [<c0171c2f>] path_release_on_umount+0x15/0x18
[  701.482420]        [<c01806fb>] sys_umount+0x3b/0x201
[  701.482727]        [<c01808da>] sys_oldumount+0x19/0x1b
[  701.483035]        [<c0103030>] syscall_call+0x7/0xb
[  701.483342]        [<ffffffff>] 0xffffffff
[  701.483650]
[  701.483651] -> #2 (&type->s_lock_key#6){--..}:
[  701.483891]        [<c013d928>] __lock_acquire+0xaed/0xc03
[  701.484200]        [<c013dd5d>] lock_acquire+0x57/0x70
[  701.484508]        [<c036f018>] __mutex_lock_slowpath+0x73/0x25f
[  701.484816]        [<c036f216>] mutex_lock+0x12/0x15
[  701.485123]        [<c01abcfa>] ext3_orphan_add+0x2c/0x190
[  701.485432]        [<c01a954e>] ext3_setattr+0x144/0x19b
[  701.485740]        [<c017e286>] notify_change+0xcc/0x28e
[  701.486047]        [<c016a553>] do_truncate+0x53/0x6c
[  701.486355]        [<c0172fd1>] may_open+0x164/0x1d5
[  701.486661]        [<c0174eaf>] open_namei+0x75/0x5da
[  701.486969]        [<c016a212>] do_filp_open+0x26/0x43
[  701.487276]        [<c016a270>] do_sys_open+0x41/0xca
[  701.487584]        [<c016a331>] sys_open+0x1c/0x1e
[  701.487890]        [<c0103030>] syscall_call+0x7/0xb
[  701.488197]        [<ffffffff>] 0xffffffff
[  701.488504]
[  701.488504] -> #1 (&inode->i_alloc_sem){--..}:
[  701.488713]        [<c013d928>] __lock_acquire+0xaed/0xc03
[  701.489021]        [<c013dd5d>] lock_acquire+0x57/0x70
[  701.489329]        [<c013895c>] down_write+0x30/0x4a
[  701.489637]        [<c017e3cb>] notify_change+0x211/0x28e
[  701.489945]        [<c016a553>] do_truncate+0x53/0x6c
[  701.490252]        [<c0172fd1>] may_open+0x164/0x1d5
[  701.490560]        [<c0174eaf>] open_namei+0x75/0x5da
[  701.490867]        [<c016a212>] do_filp_open+0x26/0x43
[  701.491174]        [<c016a270>] do_sys_open+0x41/0xca
[  701.491481]        [<c016a331>] sys_open+0x1c/0x1e
[  701.491789]        [<c0103030>] syscall_call+0x7/0xb
[  701.492096]        [<ffffffff>] 0xffffffff
[  701.492404]
[  701.492405] -> #0 (&inode->i_mutex){--..}:
[  701.492612]        [<c013d79d>] __lock_acquire+0x962/0xc03
[  701.492921]        [<c013dd5d>] lock_acquire+0x57/0x70
[  701.493229]        [<c036f018>] __mutex_lock_slowpath+0x73/0x25f
[  701.493537]        [<c036f216>] mutex_lock+0x12/0x15
[  701.493844]        [<c01c229d>] ntfs_put_inode+0x42/0x77
[  701.494153]        [<c017cd63>] iput+0x2b/0x66
[  701.494460]        [<c019149b>] inotify_unmount_inodes+0x14e/0x18e
[  701.494771]        [<c017dc9f>] invalidate_inodes+0x36/0xd6
[  701.495079]        [<c016d181>] generic_shutdown_super+0x48/0x10c
[  701.495387]        [<c016d265>] kill_block_super+0x20/0x32
[  701.495695]        [<c016d307>] deactivate_super+0x3f/0x51
[  701.496003]        [<c017f6eb>] mntput_no_expire+0x44/0x62
[  701.496311]        [<c0171c2f>] path_release_on_umount+0x15/0x18
[  701.496620]        [<c01806fb>] sys_umount+0x3b/0x201
[  701.496927]        [<c01808da>] sys_oldumount+0x19/0x1b
[  701.497235]        [<c0103030>] syscall_call+0x7/0xb
[  701.497542]        [<ffffffff>] 0xffffffff
[  701.497848]
[  701.497849] other info that might help us debug this:
[  701.497851]
[  701.498023] 3 locks held by umount/12641:
[  701.498083]  #0:  (&type->s_umount_key#15){--..}, at: [<c016d302>]
deactivate_super+0x3a/0x51
[  701.498358]  #1:  (&type->s_lock_key#9){--..}, at: [<c036f216>]
mutex_lock+0x12/0x15
[  701.498632]  #2:  (iprune_mutex){--..}, at: [<c036f216>] mutex_lock+0x12/0x15
[  701.498851]
[  701.498852] stack backtrace:
[  701.498967]  [<c0103feb>] show_trace_log_lvl+0x1a/0x30
[  701.499060]  [<c0104696>] show_trace+0x12/0x14
[  701.499152]  [<c010471d>] dump_stack+0x16/0x18
[  701.499244]  [<c013ce32>] print_circular_bug_tail+0x86/0x8f
[  701.499338]  [<c013d79d>] __lock_acquire+0x962/0xc03
[  701.499431]  [<c013dd5d>] lock_acquire+0x57/0x70
[  701.499523]  [<c036f018>] __mutex_lock_slowpath+0x73/0x25f
[  701.499616]  [<c036f216>] mutex_lock+0x12/0x15
[  701.499708]  [<c01c229d>] ntfs_put_inode+0x42/0x77
[  701.499801]  [<c017cd63>] iput+0x2b/0x66
[  701.499892]  [<c019149b>] inotify_unmount_inodes+0x14e/0x18e
[  701.499986]  [<c017dc9f>] invalidate_inodes+0x36/0xd6
[  701.500078]  [<c016d181>] generic_shutdown_super+0x48/0x10c
[  701.500172]  [<c016d265>] kill_block_super+0x20/0x32
[  701.501486]  [<c016d307>] deactivate_super+0x3f/0x51
[  701.501579]  [<c017f6eb>] mntput_no_expire+0x44/0x62
[  701.501671]  [<c0171c2f>] path_release_on_umount+0x15/0x18
[  701.501764]  [<c01806fb>] sys_umount+0x3b/0x201
[  701.501856]  [<c01808da>] sys_oldumount+0x19/0x1b
[  701.501949]  [<c0103030>] syscall_call+0x7/0xb
[  701.502041]  =======================

It appeared after unmounting ntfs volume. Anton, was there any solution, that
missed -mm, or is this anything else?

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
