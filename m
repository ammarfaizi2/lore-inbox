Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266410AbUAIC60 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 21:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266412AbUAIC60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 21:58:26 -0500
Received: from [61.51.122.197] ([61.51.122.197]:16382 "EHLO
	kapok.exavio.com.cn") by vger.kernel.org with ESMTP id S266410AbUAIC6M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 21:58:12 -0500
Date: Fri, 9 Jan 2004 11:00:26 +0800
From: Isaac Claymore <clay@exavio.com.cn>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.1-rc2-mm1][BUG] kernel BUG at mm/rmap.c:305!
Message-ID: <20040109030026.GB4259@exavio.com.cn>
Mail-Followup-To: Isaac Claymore <clay@exavio.com.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <1073605394.1070.3.camel@debian> <20040109013553.GA3755@exavio.com.cn> <20040108181116.530608a0.akpm@osdl.org> <20040109025314.GA4259@exavio.com.cn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20040109025314.GA4259@exavio.com.cn>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 09, 2004 at 10:53:14AM +0800, Isaac Claymore wrote:
> On Thu, Jan 08, 2004 at 06:11:16PM -0800, Andrew Morton wrote:
> > Isaac Claymore <clay@exavio.com.cn> wrote:
> > >
> > > I got a similar problem after running rc2-mm1 for about 12 hours,
> > >  and my window manager got killed as a result.
> > 
> > Sorry, it's a turkey.  rc3-mm1 will be better, I promise.
> > 
> Just after having read your message, it bit again. This time there's
> also a "bad: scheduling while atomic!" error. I guess it must've been
> reported already. I've included a snipped dmesg, just to provide more
> context to help trace down the bug.

Sorry, forgot to attach the dmesg.

> 
> Also, I misread your "turkey" as a "turnkey" at a first glance ;)
> 
> 

-- 

Regards, Isaac
()  ascii ribbon campaign - against html e-mail
/\                        - against microsoft attachments

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

------------[ cut here ]------------
kernel BUG at mm/rmap.c:305!
invalid operand: 0000 [#3]
PREEMPT 
CPU:    0
EIP:    0060:[<c0149737>]    Not tainted VLI
EFLAGS: 00013246
EIP is at try_to_unmap_one+0x1c4/0x1d1
eax: 00000000   ebx: 0000138b   ecx: cf0eaf00   edx: c3a8f000
esi: c1146798   edi: c1146798   ebp: c3a8f000   esp: ccb2fbc4
ds: 007b   es: 007b   ss: 0068
Process XFree86 (pid: 3708, threadinfo=ccb2e000 task=cc58e6c0)
Stack: c142d580 ccb2e000 c37d5e00 00000000 00000000 0000001a c1146798 0000001a 
       cf0eaf00 c01497d1 c10f0280 00000000 00000000 cf0eaf00 00000000 c1146798 
       00000001 ccb2e000 c01411df c10f0280 000000d2 c111e720 ffffffff 00000004 
Call Trace:
 [<c01497d1>] try_to_unmap+0x8d/0x152
 [<c01411df>] shrink_list+0x232/0x586
 [<c014050f>] __pagevec_lru_add_active+0xe8/0x111
 [<c01416db>] shrink_cache+0x1a8/0x363
 [<c0141e75>] shrink_zone+0x83/0xab
 [<c0141f4d>] shrink_caches+0xb0/0xc6
 [<c0142002>] try_to_free_pages+0x9f/0x162
 [<c013b4cb>] __alloc_pages+0x1cb/0x325
 [<c014050f>] __pagevec_lru_add_active+0xe8/0x111
 [<c0144ee4>] do_anonymous_page+0x87/0x219
 [<c01450db>] do_no_page+0x65/0x3d9
 [<c01deda6>] normal_poll+0x10a/0x150
 [<c014565a>] handle_mm_fault+0xd6/0x166
 [<c011ab5f>] do_page_fault+0x327/0x50c
 [<c0146afc>] do_mmap_pgoff+0x37f/0x6a1
 [<c0110938>] sys_mmap2+0x78/0xa7
 [<c011a838>] do_page_fault+0x0/0x50c
 [<c02a7bc7>] error_code+0x2f/0x38

Code: e8 1b c1 e3 08 01 c0 09 d8 89 45 00 31 c0 85 c0 0f 84 3a ff ff ff 0f 0b 57 01 05 96 2b c0 e9 2d ff ff ff 0f 01 3b e9 c3 fe ff ff <0f> 0b 31 01 05 96 2b c0 e9 69 fe ff ff 55 57 bf ff ff ff ff 56 
Badness in unblank_screen at drivers/char/vt.c:2793
Call Trace:
 [<c010b8d9>] do_invalid_op+0x0/0xcb
 [<c01eacff>] unblank_screen+0x126/0x12b
 [<c011a5b8>] bust_spinlocks+0x2c/0x54
 [<c010b5a6>] die+0x98/0xfd
 [<c010b9a2>] do_invalid_op+0xc9/0xcb
 [<c0149737>] try_to_unmap_one+0x1c4/0x1d1
 [<c011bac9>] wake_up_state+0x1a/0x1e
 [<c011b80e>] recalc_task_prio+0x90/0x1aa
 [<c02a7bc7>] error_code+0x2f/0x38
 [<c0149737>] try_to_unmap_one+0x1c4/0x1d1
 [<c01497d1>] try_to_unmap+0x8d/0x152
 [<c01411df>] shrink_list+0x232/0x586
 [<c014050f>] __pagevec_lru_add_active+0xe8/0x111
 [<c01416db>] shrink_cache+0x1a8/0x363
 [<c0141e75>] shrink_zone+0x83/0xab
 [<c0141f4d>] shrink_caches+0xb0/0xc6
 [<c0142002>] try_to_free_pages+0x9f/0x162
 [<c013b4cb>] __alloc_pages+0x1cb/0x325
 [<c014050f>] __pagevec_lru_add_active+0xe8/0x111
 [<c0144ee4>] do_anonymous_page+0x87/0x219
 [<c01450db>] do_no_page+0x65/0x3d9
 [<c01deda6>] normal_poll+0x10a/0x150
 [<c014565a>] handle_mm_fault+0xd6/0x166
 [<c011ab5f>] do_page_fault+0x327/0x50c
 [<c0146afc>] do_mmap_pgoff+0x37f/0x6a1
 [<c0110938>] sys_mmap2+0x78/0xa7
 [<c011a838>] do_page_fault+0x0/0x50c
 [<c02a7bc7>] error_code+0x2f/0x38

 <6>note: XFree86[3708] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c011c8ca>] schedule+0x5ad/0x5b2
 [<c0143b49>] unmap_page_range+0x43/0x69
 [<c0143d1f>] unmap_vmas+0x1b0/0x208
 [<c01479db>] exit_mmap+0x7c/0x190
 [<c011e272>] mmput+0x7b/0xe4
 [<c01220ca>] do_exit+0x150/0x40a
 [<c010b8d9>] do_invalid_op+0x0/0xcb
 [<c010b60b>] do_divide_error+0x0/0xfa
 [<c010b9a2>] do_invalid_op+0xc9/0xcb
 [<c0149737>] try_to_unmap_one+0x1c4/0x1d1
 [<c011bac9>] wake_up_state+0x1a/0x1e
 [<c011b80e>] recalc_task_prio+0x90/0x1aa
 [<c02a7bc7>] error_code+0x2f/0x38
 [<c0149737>] try_to_unmap_one+0x1c4/0x1d1
 [<c01497d1>] try_to_unmap+0x8d/0x152
 [<c01411df>] shrink_list+0x232/0x586
 [<c014050f>] __pagevec_lru_add_active+0xe8/0x111
 [<c01416db>] shrink_cache+0x1a8/0x363
 [<c0141e75>] shrink_zone+0x83/0xab
 [<c0141f4d>] shrink_caches+0xb0/0xc6
 [<c0142002>] try_to_free_pages+0x9f/0x162
 [<c013b4cb>] __alloc_pages+0x1cb/0x325
 [<c014050f>] __pagevec_lru_add_active+0xe8/0x111
 [<c0144ee4>] do_anonymous_page+0x87/0x219
 [<c01450db>] do_no_page+0x65/0x3d9
 [<c01deda6>] normal_poll+0x10a/0x150
 [<c014565a>] handle_mm_fault+0xd6/0x166
 [<c011ab5f>] do_page_fault+0x327/0x50c
 [<c0146afc>] do_mmap_pgoff+0x37f/0x6a1
 [<c0110938>] sys_mmap2+0x78/0xa7
 [<c011a838>] do_page_fault+0x0/0x50c
 [<c02a7bc7>] error_code+0x2f/0x38

bad: scheduling while atomic!
Call Trace:
 [<c011c8ca>] schedule+0x5ad/0x5b2
 [<c0218cbf>] do_ide_request+0x1d/0x21
 [<c020ae0e>] generic_unplug_device+0x77/0x79
 [<c020af4e>] blk_run_queues+0x79/0xae
 [<c011d82f>] io_schedule+0xe/0x16
 [<c015393f>] __wait_on_buffer_wq+0xd9/0xe2
 [<c011dfbb>] autoremove_wake_function+0x0/0x4f
 [<c015751d>] bio_alloc+0xcb/0x19c
 [<c011dfbb>] autoremove_wake_function+0x0/0x4f
 [<c0156dcf>] submit_bh+0x7d/0x169
 [<c0154d53>] __bread_slow_wq+0x6e/0xe8
 [<c0155080>] __bread+0x3d/0x41
 [<c01a0e2a>] search_by_key+0x6e/0xe03
 [<c01a1c6a>] search_for_position_by_key+0xab/0x3cd
 [<c0154fc1>] __getblk+0x2b/0x51
 [<c01a0dba>] is_tree_node+0x67/0x69
 [<c01a1416>] search_by_key+0x65a/0xe03
 [<c018cb3b>] make_cpu_key+0x59/0x65
 [<c018cd10>] _get_block_create_0+0xe8/0x6f8
 [<c022659c>] ide_build_sglist+0x3d/0xa5
 [<c018e9b5>] reiserfs_get_block+0x13ca/0x1440
 [<c01b4d3a>] __delay+0x12/0x16
 [<c021b662>] ide_wait_stat+0x8e/0x127
 [<c0109a67>] __switch_to+0x128/0x198
 [<c011c671>] schedule+0x354/0x5b2
 [<c0218cbf>] do_ide_request+0x1d/0x21
 [<c0154e7c>] bh_lru_install+0xaf/0xeb
 [<c0154f21>] __find_get_block+0x69/0xde
 [<c01e9e7a>] vt_console_print+0x60/0x2ec
 [<c0127949>] update_process_times+0x46/0x52
 [<c011b9d5>] try_to_wake_up+0xad/0x165
 [<c0120342>] __call_console_drivers+0x55/0x57
 [<c011c955>] __wake_up_common+0x31/0x50
 [<c015598c>] __block_prepare_write+0x1f0/0x419
 [<c015637b>] block_prepare_write+0x34/0x44
 [<c018d3b3>] reiserfs_get_block_create_0+0x0/0xd
 [<c018ff73>] grab_tail_page+0x9c/0x16e
 [<c018d3b3>] reiserfs_get_block_create_0+0x0/0xd
 [<c01900c1>] reiserfs_truncate_file+0x7c/0x24a
 [<c01a99a0>] journal_end+0x27/0x2b
 [<c019155e>] reiserfs_file_release+0x27e/0x49c
 [<c0154810>] invalidate_inode_buffers+0x11/0x6b
 [<c0232ce4>] sock_destroy_inode+0x1b/0x1f
 [<c016a08f>] destroy_inode+0x35/0x50
 [<c016828e>] dput+0x22/0x268
 [<c01534ed>] __fput+0x102/0x114
 [<c0151c37>] filp_close+0x59/0x86
 [<c01214b3>] put_files_struct+0x84/0xe9
 [<c0122107>] do_exit+0x18d/0x40a
 [<c010b8d9>] do_invalid_op+0x0/0xcb
 [<c010b60b>] do_divide_error+0x0/0xfa
 [<c010b9a2>] do_invalid_op+0xc9/0xcb
 [<c0149737>] try_to_unmap_one+0x1c4/0x1d1
 [<c011bac9>] wake_up_state+0x1a/0x1e
 [<c011b80e>] recalc_task_prio+0x90/0x1aa
 [<c02a7bc7>] error_code+0x2f/0x38
 [<c0149737>] try_to_unmap_one+0x1c4/0x1d1
 [<c01497d1>] try_to_unmap+0x8d/0x152
 [<c01411df>] shrink_list+0x232/0x586
 [<c014050f>] __pagevec_lru_add_active+0xe8/0x111
 [<c01416db>] shrink_cache+0x1a8/0x363
 [<c0141e75>] shrink_zone+0x83/0xab
 [<c0141f4d>] shrink_caches+0xb0/0xc6
 [<c0142002>] try_to_free_pages+0x9f/0x162
 [<c013b4cb>] __alloc_pages+0x1cb/0x325
 [<c014050f>] __pagevec_lru_add_active+0xe8/0x111
 [<c0144ee4>] do_anonymous_page+0x87/0x219
 [<c01450db>] do_no_page+0x65/0x3d9
 [<c01deda6>] normal_poll+0x10a/0x150
 [<c014565a>] handle_mm_fault+0xd6/0x166
 [<c011ab5f>] do_page_fault+0x327/0x50c
 [<c0146afc>] do_mmap_pgoff+0x37f/0x6a1
 [<c0110938>] sys_mmap2+0x78/0xa7
 [<c011a838>] do_page_fault+0x0/0x50c
 [<c02a7bc7>] error_code+0x2f/0x38

bad: scheduling while atomic!
Call Trace:
 [<c011c8ca>] schedule+0x5ad/0x5b2
 [<c0218cbf>] do_ide_request+0x1d/0x21
 [<c020ae0e>] generic_unplug_device+0x77/0x79
 [<c020af4e>] blk_run_queues+0x79/0xae
 [<c011d82f>] io_schedule+0xe/0x16
 [<c015393f>] __wait_on_buffer_wq+0xd9/0xe2
 [<c011dfbb>] autoremove_wake_function+0x0/0x4f
 [<c011dfbb>] autoremove_wake_function+0x0/0x4f
 [<c0156f1d>] ll_rw_block+0x62/0x81
 [<c01558bd>] __block_prepare_write+0x121/0x419
 [<c015637b>] block_prepare_write+0x34/0x44
 [<c018d3b3>] reiserfs_get_block_create_0+0x0/0xd
 [<c018ff73>] grab_tail_page+0x9c/0x16e
 [<c018d3b3>] reiserfs_get_block_create_0+0x0/0xd
 [<c01900c1>] reiserfs_truncate_file+0x7c/0x24a
 [<c01a99a0>] journal_end+0x27/0x2b
 [<c019155e>] reiserfs_file_release+0x27e/0x49c
 [<c0154810>] invalidate_inode_buffers+0x11/0x6b
 [<c0232ce4>] sock_destroy_inode+0x1b/0x1f
 [<c016a08f>] destroy_inode+0x35/0x50
 [<c016828e>] dput+0x22/0x268
 [<c01534ed>] __fput+0x102/0x114
 [<c0151c37>] filp_close+0x59/0x86
 [<c01214b3>] put_files_struct+0x84/0xe9
 [<c0122107>] do_exit+0x18d/0x40a
 [<c010b8d9>] do_invalid_op+0x0/0xcb
 [<c010b60b>] do_divide_error+0x0/0xfa
 [<c010b9a2>] do_invalid_op+0xc9/0xcb
 [<c0149737>] try_to_unmap_one+0x1c4/0x1d1
 [<c011bac9>] wake_up_state+0x1a/0x1e
 [<c011b80e>] recalc_task_prio+0x90/0x1aa
 [<c02a7bc7>] error_code+0x2f/0x38
 [<c0149737>] try_to_unmap_one+0x1c4/0x1d1
 [<c01497d1>] try_to_unmap+0x8d/0x152
 [<c01411df>] shrink_list+0x232/0x586
 [<c014050f>] __pagevec_lru_add_active+0xe8/0x111
 [<c01416db>] shrink_cache+0x1a8/0x363
 [<c0141e75>] shrink_zone+0x83/0xab
 [<c0141f4d>] shrink_caches+0xb0/0xc6
 [<c0142002>] try_to_free_pages+0x9f/0x162
 [<c013b4cb>] __alloc_pages+0x1cb/0x325
 [<c014050f>] __pagevec_lru_add_active+0xe8/0x111
 [<c0144ee4>] do_anonymous_page+0x87/0x219
 [<c01450db>] do_no_page+0x65/0x3d9
 [<c01deda6>] normal_poll+0x10a/0x150
 [<c014565a>] handle_mm_fault+0xd6/0x166
 [<c011ab5f>] do_page_fault+0x327/0x50c
 [<c0146afc>] do_mmap_pgoff+0x37f/0x6a1
 [<c0110938>] sys_mmap2+0x78/0xa7
 [<c011a838>] do_page_fault+0x0/0x50c
 [<c02a7bc7>] error_code+0x2f/0x38

atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).

--n8g4imXOkfNTN/H1--
