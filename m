Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbUCDVdl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 16:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUCDVdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 16:33:41 -0500
Received: from joel.ist.utl.pt ([193.136.198.171]:20162 "EHLO joel.ist.utl.pt")
	by vger.kernel.org with ESMTP id S261949AbUCDVdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 16:33:38 -0500
Date: Thu, 4 Mar 2004 21:33:30 +0000 (WET)
From: Rui Saraiva <rmps@joel.ist.utl.pt>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc1-mm2: 3 dumps at __make_request, system freeze
In-Reply-To: <20040304111204.6db8bd6e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0403042127580.28900@joel.ist.utl.pt>
References: <Pine.LNX.4.58.0403041834350.28568@joel.ist.utl.pt>
 <20040304111204.6db8bd6e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2004, Andrew Morton wrote:

> Rui Saraiva <rmps@joel.ist.utl.pt> wrote:
> >
> > Yesterday I got these 3 dumps (on dmesg) while compiling (on ext3 fs) the
> > kernel and some other userland utilities.
>
> Could you please add this?
>
> --- 25/drivers/block/ll_rw_blk.c~blk-unplug-when-max-request-queued-fix	Wed Mar  3 16:03:01 2004
> +++ 25-akpm/drivers/block/ll_rw_blk.c	Wed Mar  3 16:03:32 2004

[CUT]

I'm still experiencing some problems with that patch applied. I was again
compiling the kernel (no tvtime this time) and got this:

Unable to handle kernel paging request at virtual address c1810f70 printing eip:
c02783ae
*pde = 00006063
*pte = 01810000
Oops: 0000 [#1]
PREEMPT DEBUG_PAGEALLOC
CPU:    0
EIP:    0060:[<c02783ae>]    Not tainted VLI
EFLAGS: 00010086
EIP is at __make_request+0x3ae/0x6a0
eax: 00000100   ebx: c1810f60   ecx: 00000020   edx: c1810f60
esi: c87d2bf8   edi: 00000000   ebp: c8849c0c   esp: c8849bc8
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 8, threadinfo=c8848000 task=c885d9d0)
Stack: c8fc72c0 00000018 c8fc72c0 c8ebada8 c8849c08 c0156534 00000010 001778fd
       00000000 00000008 00000008 00000001 c1810f60 c8ebfd3c c87d2bf8 00000008
       c8ebfd3c c8849c60 c0278796 c8fcaf48 c8fe9840 c8fe9840 00000000 c8849c64
Call Trace:
 [<c0156534>] kmem_cache_alloc+0x174/0x200
 [<c0278796>] generic_make_request+0xf6/0x170
 [<c01561dd>] cache_flusharray+0xbd/0x2a0
 [<c0122d50>] autoremove_wake_function+0x0/0x40
 [<c01fce6a>] start_this_handle+0x16a/0x900
 [<c0278868>] submit_bio+0x58/0xf0
 [<c017b913>] bio_alloc+0xc3/0x190
 [<c0179a41>] __block_write_full_page+0x171/0x360
 [<c01f0910>] ext3_get_block+0x0/0xa0
 [<c017afb8>] block_write_full_page+0xd8/0x100
 [<c01f0910>] ext3_get_block+0x0/0xa0
 [<c01f1513>] ext3_writeback_writepage+0x73/0x90
 [<c015ae77>] shrink_list+0x467/0xaa0
 [<c015b6b0>] shrink_cache+0x200/0x6e0
 [<c015a85f>] shrink_slab+0x7f/0x160
 [<c015caf4>] balance_pgdat+0x194/0x1f0
 [<c015cc2c>] kswapd+0xdc/0xf0
 [<c0122d50>] autoremove_wake_function+0x0/0x40
 [<c031f812>] ret_from_fork+0x6/0x14
 [<c0122d50>] autoremove_wake_function+0x0/0x40
 [<c015cb50>] kswapd+0x0/0xf0
 [<c0105289>] kernel_thread_helper+0x5/0xc

Code: 01 00 00 74 2f 8b 86 90 00 00 00 03 86 8c 00 00 00 3b 86 30 01 00 00 0f 84 bc 00 00 00 8b 55 ec 85 d2 74 10 0f b7 86 f0 01 00 00 <39> 42 10 0f 84 a5 00 00 00 8b 96 b4 01 00 00 81 3a 3c 4b 24 1d
 <6>note: kswapd0[8] exited with preempt_count 1
drivers/block/ll_rw_blk.c:1163: spin_lock(drivers/ide/ide.c:c03ae688) already locked by drivers/block/ll_rw_blk.c/2036
