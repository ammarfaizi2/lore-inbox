Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265320AbSJaShJ>; Thu, 31 Oct 2002 13:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265322AbSJaShI>; Thu, 31 Oct 2002 13:37:08 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:29614 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265320AbSJaShD> convert rfc822-to-8bit; Thu, 31 Oct 2002 13:37:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: Nikita Danilov <Nikita@Namesys.COM>
Subject: Re: [PATCH]: reiser4 [0/8] overview
Date: Thu, 31 Oct 2002 19:43:15 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200210311910.48774.m.c.p@wolk-project.de> <15809.29694.883782.811063@laputa.namesys.com>
In-Reply-To: <15809.29694.883782.811063@laputa.namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210311931.08347.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 October 2002 19:18, Nikita Danilov wrote:

Hi Nikita,

>  > Forbidden
>  > You don't have permission to access
>  > /snapshots/2002.10.31/reiser4progs-0.1.0.tar.gz on this server.
>  > Apache/1.3.23 Server at thebsh.namesys.com Port 80
>  > The directory itself does _not_ contain any reiserfs progs.
> Fixed.
thank you :)

ok, here we go: 2.5.45, Reiser4 patches from today.

Mounting newly created Reiser4 partition:

Debug: sleeping function called from illegal context at mm/page_alloc.c:409
Call Trace:
 [<c01152b4>] __might_sleep+0x54/0x60
 [<c01326ac>] __alloc_pages+0x24/0x278
 [<c0132928>] __get_free_pages+0x28/0x60
 [<c0115563>] dup_task_struct+0x47/0xbc
 [<c0115f28>] copy_process+0xa0/0xa40
 [<c01e10f0>] ide_do_request+0x2d4/0x334
 [<c01168eb>] do_fork+0x23/0xa8
 [<e4a4f380>] kdaemon+0x0/0x40 [reiser4]
 [<c0105574>] kernel_thread+0x74/0x8c
 [<e4a4f380>] kdaemon+0x0/0x40 [reiser4]
 [<e4a209a0>] ktxnmgrd+0x0/0x1e4 [reiser4]
 [<e4a4f380>] kdaemon+0x0/0x40 [reiser4]
 [<c01054f4>] kernel_thread_helper+0x0/0xc
 [<e4a20c33>] ktxnmgrd_attach+0x53/0x88 [reiser4]
 [<e4a209a0>] ktxnmgrd+0x0/0x1e4 [reiser4]
 [<e4a4f380>] kdaemon+0x0/0x40 [reiser4]
 [<e4a4ee60>] format_plugins+0x0/0xa0 [reiser4]
 [<e4a254bf>] reiser4_fill_super+0x313/0x540 [reiser4]
 [<e4a4f380>] kdaemon+0x0/0x40 [reiser4]
 [<e4a3f490>] PSEUDO_FILES_PREFIX+0x123/0x12b [reiser4]
 [<c0142f04>] get_sb_bdev+0x1bc/0x220
 [<e4a4dbc0>] reiser4_fs_type+0x0/0x20 [reiser4]
 [<e4a4dbc0>] reiser4_fs_type+0x0/0x20 [reiser4]
 [<e4a25953>] reiser4_get_sb+0x1f/0x24 [reiser4]
 [<e4a4dbc0>] reiser4_fs_type+0x0/0x20 [reiser4]
 [<e4a251ac>] reiser4_fill_super+0x0/0x540 [reiser4]
 [<c01430e0>] do_kern_mount+0x48/0xa8
 [<e4a4dbc0>] reiser4_fs_type+0x0/0x20 [reiser4]
 [<c0155235>] do_add_mount+0x65/0x148
 [<c015551a>] do_mount+0x15e/0x178
 [<c015536d>] copy_mount_options+0x55/0xa4
 [<c0155970>] sys_mount+0xa4/0x110
 [<c0106f13>] syscall_call+0x7/0xb

/dev/hda7 on /opt/squid/cache type reiser4 
(rw,noexec,nosuid,nodev,noatime,nodiratime)

After creating 100,000 files (time seq -f "%06.0f" 1 100000  | xargs touch),
I got _TONS_ of this:

Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
  [__might_sleep+84/96] __might_sleep+0x54/0x60
  [<e4a42a76>] ABSOLUTE_MIN_OID+0x13e/0x580 [reiser4]
  [<e4a3347c>] load_and_lock_bnode+0x14/0x1a4 [reiser4]
  [<e4a42a76>] ABSOLUTE_MIN_OID+0x13e/0x580 [reiser4]
  [<e4a336d7>] search_one_bitmap+0x5f/0x1f0 [reiser4]
  [<e4a33913>] bitmap_alloc+0xab/0x150 [reiser4]
  [<e4a33a6a>] bitmap_alloc_blocks+0xb2/0x13c [reiser4]
  [<e4a4eda0>] space_plugins+0x0/0xc0 [reiser4]
  [<e4a14e97>] reiser4_alloc_blocks+0xaf/0x13c [reiser4]
  [<e4a19ffa>] flush_allocate_znode_update+0x5e/0x198 [reiser4]
  [<e4a2d6ce>] internal_at+0xa/0x10 [reiser4]
  [<e4a2d6fe>] pointer_at+0xa/0x14 [reiser4]
  [<e4a125a5>] check_tree_pointer+0x5d/0x84 [reiser4]
  [<e4a19f02>] flush_allocate_znode+0x176/0x210 [reiser4]
  [<e4a19d2c>] jnode_check_flushprepped+0x18/0x54 [reiser4]
  [<e4a18aaf>] flush_alloc_one_ancestor+0x8b/0x124 [reiser4]
  [<e4a18b22>] flush_alloc_one_ancestor+0xfe/0x124 [reiser4]
  [<e4a18b09>] flush_alloc_one_ancestor+0xe5/0x124 [reiser4]
  [<e4a4e8c0>] item_plugins+0x1e0/0x480 [reiser4]
  [<e4a189d9>] flush_alloc_ancestors+0xa9/0xf4 [reiser4]
  [<e4a4e8c0>] item_plugins+0x1e0/0x480 [reiser4]
  [<e4a183da>] jnode_flush+0x3ea/0x568 [reiser4]
  [<e4a4e8c0>] item_plugins+0x1e0/0x480 [reiser4]
  [<e4a1608d>] flush_this_atom+0x41/0x14c [reiser4]
  [<e4a162e0>] flush_one_atom+0x148/0x164 [reiser4]
  [<e4a20da5>] scan_mgr+0x51/0x8c [reiser4]
  [<e4a4f3ac>] kdaemon+0x2c/0x40 [reiser4]
  [<e4a4f380>] kdaemon+0x0/0x40 [reiser4]
  [<e4a20b46>] ktxnmgrd+0x1a6/0x1e4 [reiser4]
  [<e4a209a0>] ktxnmgrd+0x0/0x1e4 [reiser4]
  [<e4a4f398>] kdaemon+0x18/0x40 [reiser4]
  [<e4a4f388>] kdaemon+0x8/0x40 [reiser4]
  [<e4a4f3a0>] kdaemon+0x20/0x40 [reiser4]
  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
  [<e4a4f380>] kdaemon+0x0/0x40 [reiser4]

and also _TONS_ of this:

bad: scheduling while atomic!
Call Trace:
  [schedule+61/712] schedule+0x3d/0x2c8
  [io_schedule+11/20] io_schedule+0xb/0x14
  [__lock_page+176/204] __lock_page+0xb0/0xcc
  [autoremove_wake_function+0/56] autoremove_wake_function+0x0/0x38
  [autoremove_wake_function+0/56] autoremove_wake_function+0x0/0x38
  [read_cache_page+315/484] read_cache_page+0x13b/0x1e4
  [<e4a4d6d8>] jnode_plugins+0x78/0x130 [reiser4]
  [<e4a0c8a6>] jload+0xc6/0x1fc [reiser4]
  [<e4a0c7c4>] page_filler+0x0/0x1c [reiser4]
  [<e4a33528>] load_and_lock_bnode+0xc0/0x1a4 [reiser4]
  [<e4a336d7>] search_one_bitmap+0x5f/0x1f0 [reiser4]
  [<e4a33913>] bitmap_alloc+0xab/0x150 [reiser4]
  [<e4a33a6a>] bitmap_alloc_blocks+0xb2/0x13c [reiser4]
  [<e4a4eda0>] space_plugins+0x0/0xc0 [reiser4]
  [<e4a14e97>] reiser4_alloc_blocks+0xaf/0x13c [reiser4]
  [<e4a19ffa>] flush_allocate_znode_update+0x5e/0x198 [reiser4]
  [<e4a2d6ce>] internal_at+0xa/0x10 [reiser4]
  [<e4a2d6fe>] pointer_at+0xa/0x14 [reiser4]
  [<e4a125a5>] check_tree_pointer+0x5d/0x84 [reiser4]
  [<e4a19f02>] flush_allocate_znode+0x176/0x210 [reiser4]
  [<e4a19d2c>] jnode_check_flushprepped+0x18/0x54 [reiser4]
  [<e4a18aaf>] flush_alloc_one_ancestor+0x8b/0x124 [reiser4]
  [<e4a18b22>] flush_alloc_one_ancestor+0xfe/0x124 [reiser4]
  [<e4a18b09>] flush_alloc_one_ancestor+0xe5/0x124 [reiser4]
  [<e4a4e8c0>] item_plugins+0x1e0/0x480 [reiser4]
  [<e4a189d9>] flush_alloc_ancestors+0xa9/0xf4 [reiser4]
  [<e4a4e8c0>] item_plugins+0x1e0/0x480 [reiser4]
  [<e4a183da>] jnode_flush+0x3ea/0x568 [reiser4]
  [<e4a4e8c0>] item_plugins+0x1e0/0x480 [reiser4]
  [<e4a1608d>] flush_this_atom+0x41/0x14c [reiser4]
  [<e4a162e0>] flush_one_atom+0x148/0x164 [reiser4]
  [<e4a20da5>] scan_mgr+0x51/0x8c [reiser4]
  [<e4a4f3ac>] kdaemon+0x2c/0x40 [reiser4]
  [<e4a4f380>] kdaemon+0x0/0x40 [reiser4]
  [<e4a20b46>] ktxnmgrd+0x1a6/0x1e4 [reiser4]
  [<e4a209a0>] ktxnmgrd+0x0/0x1e4 [reiser4]
  [<e4a4f398>] kdaemon+0x18/0x40 [reiser4]
  [<e4a4f388>] kdaemon+0x8/0x40 [reiser4]
  [<e4a4f3a0>] kdaemon+0x20/0x40 [reiser4]
  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
  [<e4a4f380>] kdaemon+0x0/0x40 [reiser4]
bad: scheduling while atomic!
Call Trace:
 [<c0113ef1>] schedule+0x3d/0x2c8
 [<c0114e27>] __cond_resched+0x17/0x1c
 [<e4a0c114>] preempt_point+0x14/0x24 [reiser4]
 [<e4a0e903>] carry+0x153/0x1cc [reiser4]
 [<e4a199c3>] squeeze_right_non_twig+0xc3/0x114 [reiser4]
 [<e4a198f9>] squalloc_right_neighbor+0x29/0x30 [reiser4]
 [<e4a194d8>] flush_squalloc_one_changed_ancestor+0x23c/0x634 [reiser4]
 [<e4a0c821>] jload+0x41/0x1fc [reiser4]
 [<e4a18dcc>] flush_squalloc_changed_ancestors+0x40/0x510 [reiser4]
 [<e4a18d66>] flush_forward_squalloc+0x186/0x1ac [reiser4]
 [<e4a183da>] jnode_flush+0x3ea/0x568 [reiser4]
 [<e4a183ef>] jnode_flush+0x3ff/0x568 [reiser4]
 [<e4a4e8c0>] item_plugins+0x1e0/0x480 [reiser4]
 [<e4a1608d>] flush_this_atom+0x41/0x14c [reiser4]
 [<e4a162e0>] flush_one_atom+0x148/0x164 [reiser4]
 [<e4a20da5>] scan_mgr+0x51/0x8c [reiser4]
 [<e4a4f3ac>] kdaemon+0x2c/0x40 [reiser4]
 [<e4a4f380>] kdaemon+0x0/0x40 [reiser4]
 [<e4a20b46>] ktxnmgrd+0x1a6/0x1e4 [reiser4]
 [<e4a209a0>] ktxnmgrd+0x0/0x1e4 [reiser4]
 [<e4a4f398>] kdaemon+0x18/0x40 [reiser4]
 [<e4a4f388>] kdaemon+0x8/0x40 [reiser4]
 [<e4a4f3a0>] kdaemon+0x20/0x40 [reiser4]
 [<c01054f9>] kernel_thread_helper+0x5/0xc
 [<e4a4f380>] kdaemon+0x0/0x40 [reiser4]


and also _TONS_ of this:

Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
 [<c01152b4>] __might_sleep+0x54/0x60
 [<e4a42a76>] ABSOLUTE_MIN_OID+0x13e/0x580 [reiser4]
 [<e4a3347c>] load_and_lock_bnode+0x14/0x1a4 [reiser4]
 [<e4a42a76>] ABSOLUTE_MIN_OID+0x13e/0x580 [reiser4]
 [<e4a33e07>] bitmap_pre_commit_hook+0x12f/0x2b7 [reiser4]
 [<e4a15361>] pre_commit_hook+0x11/0x14 [reiser4]
 [<e4a1c2ab>] reiser4_write_logs+0x3f/0x2d0 [reiser4]
 [<e4a1fef6>] finish_all_fq+0x52/0x98 [reiser4]
 [<e4a1ff5c>] current_atom_finish_all_fq+0x20/0x70 [reiser4]
 [<e4a15c0d>] atom_try_commit_locked+0x165/0x210 [reiser4]
 [<e4a16551>] commit_txnh+0xcd/0x150 [reiser4]
 [<e4a15676>] txn_end+0x22/0x38 [reiser4]
 [<e4a16176>] flush_this_atom+0x12a/0x14c [reiser4]
 [<e4a162e0>] flush_one_atom+0x148/0x164 [reiser4]
 [<e4a1637a>] flush_some_atom+0x7e/0x88 [reiser4]
 [<e4a2602b>] reiser4_writepages+0xab/0x114 [reiser4]
 [<c013a314>] do_writepages+0x18/0x2c
 [<c0157a5d>] __sync_single_inode+0x69/0x168
 [<c0157bd0>] __writeback_single_inode+0x74/0x7c
 [<c0157d67>] sync_sb_inodes+0x18f/0x21c
 [<c0157e47>] writeback_inodes+0x53/0x98
 [<c013a1e7>] wb_kupdate+0x9f/0x100
 [<c0139cc1>] __pdflush+0x151/0x1f8
 [<c0139d68>] pdflush+0x0/0x14
 [<c0139d73>] pdflush+0xb/0x14
 [<c013a148>] wb_kupdate+0x0/0x100
 [<c01054f9>] kernel_thread_helper+0x5/0xc


Does not occur with ReiserFS 3 from 2.5.45 nor with any other FS doing those 
small stress test. My personal impression is that Reiser4 is slower than 3 but 
that might be because of above debugging.

I hope this helps.

ciao, Marc


