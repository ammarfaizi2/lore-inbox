Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbSL2XFr>; Sun, 29 Dec 2002 18:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262089AbSL2XFr>; Sun, 29 Dec 2002 18:05:47 -0500
Received: from dsl-67-48-44-237.telocity.com ([67.48.44.237]:14638 "EHLO
	lnuxlab.ath.cx") by vger.kernel.org with ESMTP id <S262067AbSL2XFm>;
	Sun, 29 Dec 2002 18:05:42 -0500
Date: Sun, 29 Dec 2002 18:32:36 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.53-mm3: xmms: page allocation failure. order:5, mode:0x20
Message-ID: <20021229233236.GA25035@lnuxlab.ath.cx>
References: <20021229202610.GA24554@lnuxlab.ath.cx> <3E0F5E2C.70F7D112@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E0F5E2C.70F7D112@digeo.com>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 12:42:20PM -0800, Andrew Morton wrote:
> khromy wrote:
> > 
> > Running 2.5.53-mm3, I found the following in dmesg.  I don't remember
> > getting anything like this with 2.5.53-mm3.
> > 
> > xmms: page allocation failure. order:5, mode:0x20
> 
> gack.  Someone is requesting 128k of memory with GFP_ATOMIC.  It fell
> afoul of the reduced memory reserves.  It deserved to.
> 
> Could you please add this patch, and make sure that you have set
> CONFIG_KALLSYMS=y?  This will find the culprit.

XFree86: page allocation failure. order:0, mode:0xd0
Call Trace:
 [<c012a3dd>] __alloc_pages+0x255/0x264
 [<c012a414>] __get_free_pages+0x28/0x60
 [<c012c7e6>] cache_grow+0xb6/0x20c
 [<c012c9cf>] __cache_alloc_refill+0x93/0x220
 [<c012cb96>] cache_alloc_refill+0x3a/0x58
 [<c012cf1d>] kmem_cache_alloc+0x45/0xc8
 [<c017e36c>] journal_alloc_journal_head+0x10/0x68
 [<c017e458>] journal_add_journal_head+0x80/0x120
 [<c0178fc6>] journal_dirty_data+0x4a/0x1bc
 [<c016cd5f>] journal_dirty_async_data+0x17/0x6c
 [<c016ca84>] walk_page_buffers+0x50/0x74
 [<c016d305>] ext3_writepage+0x261/0x33c
 [<c016cd48>] journal_dirty_async_data+0x0/0x6c
 [<c012f0b6>] shrink_list+0x2b6/0x4bc
 [<c0135bc1>] page_referenced+0xbd/0xcc
 [<c012e296>] __pagevec_release+0x1a/0x28
 [<c012fa48>] refill_inactive_zone+0x4b4/0x4dc
 [<c012e296>] __pagevec_release+0x1a/0x28
 [<c012f467>] shrink_cache+0x1ab/0x2d8
 [<c012fadc>] shrink_zone+0x6c/0x74
 [<c012fb4e>] shrink_caches+0x6a/0x94
 [<c012fbf4>] try_to_free_pages+0x7c/0xbc
 [<c012a33c>] __alloc_pages+0x1b4/0x264
 [<c012a414>] __get_free_pages+0x28/0x60
 [<c014d247>] __pollwait+0x33/0x98
 [<c0265066>] unix_poll+0x22/0x90
 [<c0224ce9>] sock_poll+0x1d/0x24
 [<c014d452>] do_select+0xfe/0x208
 [<c014d214>] __pollwait+0x0/0x98
 [<c014d8b6>] sys_select+0x332/0x46c
 [<c01089af>] syscall_call+0x7/0xb

XFree86: page allocation failure. order:0, mode:0xd0
Call Trace:
 [<c012a3dd>] __alloc_pages+0x255/0x264
 [<c012a414>] __get_free_pages+0x28/0x60
 [<c012c7e6>] cache_grow+0xb6/0x20c
 [<c012c9cf>] __cache_alloc_refill+0x93/0x220
 [<c012cb96>] cache_alloc_refill+0x3a/0x58
 [<c012cf1d>] kmem_cache_alloc+0x45/0xc8
 [<c017e36c>] journal_alloc_journal_head+0x10/0x68
 [<c017e458>] journal_add_journal_head+0x80/0x120
 [<c0178fc6>] journal_dirty_data+0x4a/0x1bc
 [<c016cd5f>] journal_dirty_async_data+0x17/0x6c
 [<c016ca84>] walk_page_buffers+0x50/0x74
 [<c016d305>] ext3_writepage+0x261/0x33c
 [<c016cd48>] journal_dirty_async_data+0x0/0x6c
 [<c012f0b6>] shrink_list+0x2b6/0x4bc
 [<c0135bc1>] page_referenced+0xbd/0xcc
 [<c012e296>] __pagevec_release+0x1a/0x28
 [<c012fa48>] refill_inactive_zone+0x4b4/0x4dc
 [<c012e296>] __pagevec_release+0x1a/0x28
 [<c012f467>] shrink_cache+0x1ab/0x2d8
 [<c012fadc>] shrink_zone+0x6c/0x74
 [<c012fb4e>] shrink_caches+0x6a/0x94
 [<c012fbf4>] try_to_free_pages+0x7c/0xbc
 [<c012a33c>] __alloc_pages+0x1b4/0x264
 [<c012a414>] __get_free_pages+0x28/0x60
 [<c014d247>] __pollwait+0x33/0x98
 [<c0265066>] unix_poll+0x22/0x90
 [<c0224ce9>] sock_poll+0x1d/0x24
 [<c014d452>] do_select+0xfe/0x208
 [<c014d214>] __pollwait+0x0/0x98
 [<c014d8b6>] sys_select+0x332/0x46c
 [<c01089af>] syscall_call+0x7/0xb

ENOMEM in journal_alloc_journal_head, retrying.
xmms: page allocation failure. order:0, mode:0xd0
Call Trace:
 [<c012a3dd>] __alloc_pages+0x255/0x264
 [<c012a414>] __get_free_pages+0x28/0x60
 [<c012c7e6>] cache_grow+0xb6/0x20c
 [<c012c9cf>] __cache_alloc_refill+0x93/0x220
 [<c012cb96>] cache_alloc_refill+0x3a/0x58
 [<c012cf1d>] kmem_cache_alloc+0x45/0xc8
 [<c017e36c>] journal_alloc_journal_head+0x10/0x68
 [<c017e458>] journal_add_journal_head+0x80/0x120
 [<c0178fc6>] journal_dirty_data+0x4a/0x1bc
 [<c016cd5f>] journal_dirty_async_data+0x17/0x6c
 [<c016ca84>] walk_page_buffers+0x50/0x74
 [<c016d305>] ext3_writepage+0x261/0x33c
 [<c016cd48>] journal_dirty_async_data+0x0/0x6c
 [<c012f0b6>] shrink_list+0x2b6/0x4bc
 [<c0135bc1>] page_referenced+0xbd/0xcc
 [<c012e296>] __pagevec_release+0x1a/0x28
 [<c012fa48>] refill_inactive_zone+0x4b4/0x4dc
 [<c012e296>] __pagevec_release+0x1a/0x28
 [<c012f467>] shrink_cache+0x1ab/0x2d8
 [<c012fadc>] shrink_zone+0x6c/0x74
 [<c012fb4e>] shrink_caches+0x6a/0x94
 [<c012fbf4>] try_to_free_pages+0x7c/0xbc
 [<c012a33c>] __alloc_pages+0x1b4/0x264
 [<c012a414>] __get_free_pages+0x28/0x60
 [<c014d247>] __pollwait+0x33/0x98
 [<c021dc2b>] es1371_poll+0xcf/0x20c
 [<c014d452>] do_select+0xfe/0x208
 [<c014d214>] __pollwait+0x0/0x98
 [<c014d8b6>] sys_select+0x332/0x46c
 [<c01089af>] syscall_call+0x7/0xb

xmms: page allocation failure. order:0, mode:0xd0
Call Trace:
 [<c012a3dd>] __alloc_pages+0x255/0x264
 [<c012a414>] __get_free_pages+0x28/0x60
 [<c012c7e6>] cache_grow+0xb6/0x20c
 [<c012c9cf>] __cache_alloc_refill+0x93/0x220
 [<c012cb96>] cache_alloc_refill+0x3a/0x58
 [<c012cf1d>] kmem_cache_alloc+0x45/0xc8
 [<c017e36c>] journal_alloc_journal_head+0x10/0x68
 [<c017e458>] journal_add_journal_head+0x80/0x120
 [<c0178fc6>] journal_dirty_data+0x4a/0x1bc
 [<c016cd5f>] journal_dirty_async_data+0x17/0x6c
 [<c016ca84>] walk_page_buffers+0x50/0x74
 [<c016d305>] ext3_writepage+0x261/0x33c
 [<c016cd48>] journal_dirty_async_data+0x0/0x6c
 [<c012f0b6>] shrink_list+0x2b6/0x4bc
 [<c0135bc1>] page_referenced+0xbd/0xcc
 [<c012e296>] __pagevec_release+0x1a/0x28
 [<c012fa48>] refill_inactive_zone+0x4b4/0x4dc
 [<c012f467>] shrink_cache+0x1ab/0x2d8
 [<c012fadc>] shrink_zone+0x6c/0x74
 [<c012fb4e>] shrink_caches+0x6a/0x94
 [<c012fbf4>] try_to_free_pages+0x7c/0xbc
 [<c012a33c>] __alloc_pages+0x1b4/0x264
 [<c012a414>] __get_free_pages+0x28/0x60
 [<c014d247>] __pollwait+0x33/0x98
 [<c021dc2b>] es1371_poll+0xcf/0x20c
 [<c014d452>] do_select+0xfe/0x208
 [<c014d214>] __pollwait+0x0/0x98
 [<c014d8b6>] sys_select+0x332/0x46c
 [<c01089af>] syscall_call+0x7/0xb

xmms: page allocation failure. order:0, mode:0xd0
Call Trace:
 [<c012a3dd>] __alloc_pages+0x255/0x264
 [<c012a414>] __get_free_pages+0x28/0x60
 [<c012c7e6>] cache_grow+0xb6/0x20c
 [<c012c9cf>] __cache_alloc_refill+0x93/0x220
 [<c012cb96>] cache_alloc_refill+0x3a/0x58
 [<c012cf1d>] kmem_cache_alloc+0x45/0xc8
 [<c017e36c>] journal_alloc_journal_head+0x10/0x68
 [<c017e458>] journal_add_journal_head+0x80/0x120
 [<c0178fc6>] journal_dirty_data+0x4a/0x1bc
 [<c016cd5f>] journal_dirty_async_data+0x17/0x6c
 [<c016ca84>] walk_page_buffers+0x50/0x74
 [<c016d305>] ext3_writepage+0x261/0x33c
 [<c016cd48>] journal_dirty_async_data+0x0/0x6c
 [<c012f0b6>] shrink_list+0x2b6/0x4bc
 [<c0135bc1>] page_referenced+0xbd/0xcc
 [<c012e296>] __pagevec_release+0x1a/0x28
 [<c012fa48>] refill_inactive_zone+0x4b4/0x4dc
 [<c012e296>] __pagevec_release+0x1a/0x28
 [<c012f467>] shrink_cache+0x1ab/0x2d8
 [<c012fadc>] shrink_zone+0x6c/0x74
 [<c012fb4e>] shrink_caches+0x6a/0x94
 [<c012fbf4>] try_to_free_pages+0x7c/0xbc
 [<c012a33c>] __alloc_pages+0x1b4/0x264
 [<c012a414>] __get_free_pages+0x28/0x60
 [<c014d247>] __pollwait+0x33/0x98
 [<c0265066>] unix_poll+0x22/0x90
 [<c0224ce9>] sock_poll+0x1d/0x24
 [<c014da35>] do_pollfd+0x45/0x84
 [<c014dad1>] do_poll+0x5d/0xc0
 [<c014dc48>] sys_poll+0x114/0x1cc
 [<c014d214>] __pollwait+0x0/0x98
 [<c01089af>] syscall_call+0x7/0xb

xmms: page allocation failure. order:0, mode:0xd0
Call Trace:
 [<c012a3dd>] __alloc_pages+0x255/0x264
 [<c012a414>] __get_free_pages+0x28/0x60
 [<c012c7e6>] cache_grow+0xb6/0x20c
 [<c012c9cf>] __cache_alloc_refill+0x93/0x220
 [<c012cb96>] cache_alloc_refill+0x3a/0x58
 [<c012cf1d>] kmem_cache_alloc+0x45/0xc8
 [<c017e36c>] journal_alloc_journal_head+0x10/0x68
 [<c017e458>] journal_add_journal_head+0x80/0x120
 [<c0178fc6>] journal_dirty_data+0x4a/0x1bc
 [<c016cd5f>] journal_dirty_async_data+0x17/0x6c
 [<c016ca84>] walk_page_buffers+0x50/0x74
 [<c016d305>] ext3_writepage+0x261/0x33c
 [<c016cd48>] journal_dirty_async_data+0x0/0x6c
 [<c012f0b6>] shrink_list+0x2b6/0x4bc
 [<c0135bc1>] page_referenced+0xbd/0xcc
 [<c012e296>] __pagevec_release+0x1a/0x28
 [<c012fa48>] refill_inactive_zone+0x4b4/0x4dc
 [<c012f467>] shrink_cache+0x1ab/0x2d8
 [<c012fadc>] shrink_zone+0x6c/0x74
 [<c012fb4e>] shrink_caches+0x6a/0x94
 [<c012fbf4>] try_to_free_pages+0x7c/0xbc
 [<c012a33c>] __alloc_pages+0x1b4/0x264
 [<c012a414>] __get_free_pages+0x28/0x60
 [<c014d247>] __pollwait+0x33/0x98
 [<c0265066>] unix_poll+0x22/0x90
 [<c0224ce9>] sock_poll+0x1d/0x24
 [<c014da35>] do_pollfd+0x45/0x84
 [<c014dad1>] do_poll+0x5d/0xc0
 [<c014dc48>] sys_poll+0x114/0x1cc
 [<c014d214>] __pollwait+0x0/0x98
 [<c01089af>] syscall_call+0x7/0xb

kswapd0: page allocation failure. order:0, mode:0xd0
Call Trace:
 [<c012a3dd>] __alloc_pages+0x255/0x264
 [<c012a414>] __get_free_pages+0x28/0x60
 [<c012c7e6>] cache_grow+0xb6/0x20c
 [<c012c9cf>] __cache_alloc_refill+0x93/0x220
 [<c012cb96>] cache_alloc_refill+0x3a/0x58
 [<c012cf1d>] kmem_cache_alloc+0x45/0xc8
 [<c017e36c>] journal_alloc_journal_head+0x10/0x68
 [<c017e458>] journal_add_journal_head+0x80/0x120
 [<c0178fc6>] journal_dirty_data+0x4a/0x1bc
 [<c016cd5f>] journal_dirty_async_data+0x17/0x6c
 [<c016ca84>] walk_page_buffers+0x50/0x74
 [<c016d305>] ext3_writepage+0x261/0x33c
 [<c016cd48>] journal_dirty_async_data+0x0/0x6c
 [<c012f0b6>] shrink_list+0x2b6/0x4bc
 [<c0135bc1>] page_referenced+0xbd/0xcc
 [<c012e296>] __pagevec_release+0x1a/0x28
 [<c012fa48>] refill_inactive_zone+0x4b4/0x4dc
 [<c012e296>] __pagevec_release+0x1a/0x28
 [<c012f467>] shrink_cache+0x1ab/0x2d8
 [<c012fadc>] shrink_zone+0x6c/0x74
 [<c012fcee>] balance_pgdat+0xba/0x130
 [<c012fe62>] kswapd+0xfe/0x104
 [<c012fd64>] kswapd+0x0/0x104
 [<c0115a54>] autoremove_wake_function+0x0/0x38
 [<c0115a54>] autoremove_wake_function+0x0/0x38
 [<c0106dfd>] kernel_thread_helper+0x5/0xc

kswapd0: page allocation failure. order:0, mode:0xd0
Call Trace:
 [<c012a3dd>] __alloc_pages+0x255/0x264
 [<c012a414>] __get_free_pages+0x28/0x60
 [<c012c7e6>] cache_grow+0xb6/0x20c
 [<c012c9cf>] __cache_alloc_refill+0x93/0x220
 [<c012cb96>] cache_alloc_refill+0x3a/0x58
 [<c012cf1d>] kmem_cache_alloc+0x45/0xc8
 [<c017e36c>] journal_alloc_journal_head+0x10/0x68
 [<c017e458>] journal_add_journal_head+0x80/0x120
 [<c0178fc6>] journal_dirty_data+0x4a/0x1bc
 [<c016cd5f>] journal_dirty_async_data+0x17/0x6c
 [<c016ca84>] walk_page_buffers+0x50/0x74
 [<c016d305>] ext3_writepage+0x261/0x33c
 [<c016cd48>] journal_dirty_async_data+0x0/0x6c
 [<c012f0b6>] shrink_list+0x2b6/0x4bc
 [<c0135bc1>] page_referenced+0xbd/0xcc
 [<c012e296>] __pagevec_release+0x1a/0x28
 [<c012fa48>] refill_inactive_zone+0x4b4/0x4dc
 [<c012e296>] __pagevec_release+0x1a/0x28
 [<c012f467>] shrink_cache+0x1ab/0x2d8
 [<c012fadc>] shrink_zone+0x6c/0x74
 [<c012fcee>] balance_pgdat+0xba/0x130
 [<c012fe62>] kswapd+0xfe/0x104
 [<c012fd64>] kswapd+0x0/0x104
 [<c0115a54>] autoremove_wake_function+0x0/0x38
 [<c0115a54>] autoremove_wake_function+0x0/0x38
 [<c0106dfd>] kernel_thread_helper+0x5/0xc

bk: page allocation failure. order:0, mode:0xd0
Call Trace:
 [<c012a3dd>] __alloc_pages+0x255/0x264
 [<c012a414>] __get_free_pages+0x28/0x60
 [<c012c7e6>] cache_grow+0xb6/0x20c
 [<c012c9cf>] __cache_alloc_refill+0x93/0x220
 [<c012cb96>] cache_alloc_refill+0x3a/0x58
 [<c012cf1d>] kmem_cache_alloc+0x45/0xc8
 [<c017e36c>] journal_alloc_journal_head+0x10/0x68
 [<c017e458>] journal_add_journal_head+0x80/0x120
 [<c0178fc6>] journal_dirty_data+0x4a/0x1bc
 [<c016cd5f>] journal_dirty_async_data+0x17/0x6c
 [<c016ca84>] walk_page_buffers+0x50/0x74
 [<c016d305>] ext3_writepage+0x261/0x33c
 [<c016cd48>] journal_dirty_async_data+0x0/0x6c
 [<c012f0b6>] shrink_list+0x2b6/0x4bc
 [<c0135bc1>] page_referenced+0xbd/0xcc
 [<c012e296>] __pagevec_release+0x1a/0x28
 [<c012fa48>] refill_inactive_zone+0x4b4/0x4dc
 [<c012f467>] shrink_cache+0x1ab/0x2d8
 [<c012fadc>] shrink_zone+0x6c/0x74
 [<c012fb4e>] shrink_caches+0x6a/0x94
 [<c012fbf4>] try_to_free_pages+0x7c/0xbc
 [<c012a33c>] __alloc_pages+0x1b4/0x264
 [<c01322b7>] do_anonymous_page+0xf3/0x24c
 [<c0132448>] do_no_page+0x38/0x2d0
 [<c0132771>] handle_mm_fault+0x91/0x13c
 [<c0112ec2>] do_page_fault+0x132/0x414
 [<c0112d90>] do_page_fault+0x0/0x414
 [<c011d526>] update_wall_time+0x12/0x3c
 [<c01342db>] do_brk+0x10b/0x1dc
 [<c0133205>] sys_brk+0xad/0xd8
 [<c0109391>] error_code+0x2d/0x38

XFree86: page allocation failure. order:0, mode:0xd0
Call Trace:
 [<c012a3dd>] __alloc_pages+0x255/0x264
 [<c012a414>] __get_free_pages+0x28/0x60
 [<c012c7e6>] cache_grow+0xb6/0x20c
 [<c012c9cf>] __cache_alloc_refill+0x93/0x220
 [<c01145ac>] do_schedule+0x268/0x2c8
 [<c012cb96>] cache_alloc_refill+0x3a/0x58
 [<c012cf1d>] kmem_cache_alloc+0x45/0xc8
 [<c017e3bc>] journal_alloc_journal_head+0x60/0x68
 [<c017e458>] journal_add_journal_head+0x80/0x120
 [<c0178fc6>] journal_dirty_data+0x4a/0x1bc
 [<c016cd5f>] journal_dirty_async_data+0x17/0x6c
 [<c016ca84>] walk_page_buffers+0x50/0x74
 [<c016d305>] ext3_writepage+0x261/0x33c
 [<c016cd48>] journal_dirty_async_data+0x0/0x6c
 [<c012f0b6>] shrink_list+0x2b6/0x4bc
 [<c0135bc1>] page_referenced+0xbd/0xcc
 [<c012e296>] __pagevec_release+0x1a/0x28
 [<c012fa48>] refill_inactive_zone+0x4b4/0x4dc
 [<c012e296>] __pagevec_release+0x1a/0x28
 [<c012f467>] shrink_cache+0x1ab/0x2d8
 [<c012fadc>] shrink_zone+0x6c/0x74
 [<c012fb4e>] shrink_caches+0x6a/0x94
 [<c012fbf4>] try_to_free_pages+0x7c/0xbc
 [<c012a33c>] __alloc_pages+0x1b4/0x264
 [<c012a414>] __get_free_pages+0x28/0x60
 [<c014d247>] __pollwait+0x33/0x98
 [<c0265066>] unix_poll+0x22/0x90
 [<c0224ce9>] sock_poll+0x1d/0x24
 [<c014d452>] do_select+0xfe/0x208
 [<c014d214>] __pollwait+0x0/0x98
 [<c014d8b6>] sys_select+0x332/0x46c
 [<c01089af>] syscall_call+0x7/0xb

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
