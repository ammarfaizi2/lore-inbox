Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTEVTch (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 15:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbTEVTch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 15:32:37 -0400
Received: from tmi.comex.ru ([217.10.33.92]:13502 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S263179AbTEVTcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 15:32:35 -0400
X-Comment-To: "Martin J. Bligh"
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 739] New: Null pointer dereference in
 ext3_test_allocatable
From: Alex Tomas <bzzz@tmi.comex.ru>
To: linux-kernel@vger.kernel.org
Organization: HOME
Date: Thu, 22 May 2003 23:46:17 +0000
In-Reply-To: <7240000.1053631274@[10.10.2.4]> (Martin J. Bligh's message of
 "Thu, 22 May 2003 12:21:14 -0700")
Message-ID: <877k8ibl4m.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <7240000.1053631274@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think we already know the reason. Fix will be available soon.

>>>>> Martin J Bligh (MJB) writes:

 MJB>            Summary: Null pointer dereference in ext3_test_allocatable
 MJB>     Kernel Version: 2.5.69-mm8
 MJB>             Status: NEW
 MJB>           Severity: normal
 MJB>              Owner: akpm@digeo.com
 MJB>          Submitter: plars@austin.ibm.com


 MJB> Distribution: RH7.3
 MJB> Hardware Environment: 8-way PIII-700, 16 GB ram

 MJB> Software Environment:
 MJB> anticipatory scheduler, ext3, preempt enabled

 MJB> Problem Description:
 MJB> While I was trying to reproduce bug 738, I got this but I believe it is
 MJB> sufficiently different enough to call it a new bug.  Apologies in advance if I'm
 MJB> wrong on that.  I was also able to produce this one earlier today when I was
 MJB> compiling LTP but was unsuccessful upon trying it again.  I didn't have the
 MJB> serial console setup during the LTP compile when I produced this bug the first
 MJB> time so I missed the output that time, but I recognize the Null pointer and the
 MJB> EIP from before.

 MJB> Unable to handle kernel NULL pointer dereference at virtual address 00000010
 MJB>  printing eip:
 MJB> c0197db3
 MJB> *pde = 35b80001
 MJB> Oops: 0000 [#1]
 MJB> CPU:    3
 MJB> EIP:    0060:[<c0197db3>]    Not tainted VLI
 MJB> EFLAGS: 00010206
 MJB> EIP is at ext3_test_allocatable+0x23/0x40
 MJB> eax: 00000000   ebx: f6a9e000   ecx: 00002c76   edx: f6628688
 MJB> esi: 00002c76   edi: 00002c60   ebp: 00000000   esp: f6b11a2c
 MJB> ds: 007b   es: 007b   ss: 0068
 MJB> Process ftest07 (pid: 1354, threadinfo=f6b10000 task=f63a3920)
 MJB> Stack: c0197f9f 00002c76 f6628688 00000000 00001000 f6a9e000 00008000 ffffffff
 MJB>        f7c6351c f6628688 c01980d6 ffffffff f6628688 00008000 00000000 c0160744
 MJB>        f7c5c6dc 001c0000 00001000 00000037 00000038 f7c6351c f6b11ac8 c019848d
 MJB> Call Trace:
 MJB>  [<c0197f9f>] find_next_usable_block+0x1cf/0x2c0
 MJB>  [<c01980d6>] ext3_try_to_allocate+0x46/0x190
 MJB>  [<c0160744>] __bread+0x14/0x30
 MJB>  [<c019848d>] ext3_new_block+0x26d/0x610
 MJB>  [<c011cbb6>] __wake_up+0x66/0xb0
 MJB>  [<c019a9cd>] ext3_alloc_block+0x1d/0x30
 MJB>  [<c019ad45>] ext3_alloc_branch+0x45/0x280
 MJB>  [<c01605fa>] bh_lru_install+0xca/0xf0
 MJB>  [<c019b31f>] ext3_get_block_handle+0x20f/0x2f0
 MJB>  [<c0162b43>] alloc_buffer_head+0x13/0x60
 MJB>  [<c015ff87>] create_buffers+0x57/0xb0
 MJB>  [<c019b460>] ext3_get_block+0x60/0x70
 MJB>  [<c0161070>] __block_prepare_write+0x140/0x3e0
 MJB>  [<c010829c>] __up_wakeup+0x8/0xc
 MJB>  [<c0161bf0>] block_prepare_write+0x20/0x40
 MJB>  [<c019b400>] ext3_get_block+0x0/0x70
 MJB>  [<c019b882>] ext3_prepare_write+0x42/0xe0
 MJB>  [<c019b400>] ext3_get_block+0x0/0x70
 MJB>  [<c013e12e>] generic_file_aio_write_nolock+0x66e/0xac0
 MJB>  [<c013bb9a>] unlock_page+0xa/0x50
 MJB>  [<c013c994>] file_read_actor+0x64/0xd0
 MJB>  [<c013c9a1>] file_read_actor+0x71/0xd0
 MJB>  [<c013c535>] do_generic_mapping_read+0xf5/0x4f0
 MJB>  [<c0179a2d>] update_atime+0x6d/0xc0
 MJB>  [<c013cbb5>] __generic_file_aio_read+0x1b5/0x1e0
 MJB>  [<c013e619>] generic_file_write_nolock+0x99/0xc0
 MJB>  [<c0160dc4>] __block_write_full_page+0x284/0x3f0
 MJB>  [<c011f7c0>] autoremove_wake_function+0x0/0x40
 MJB>  [<c011f7c0>] autoremove_wake_function+0x0/0x40
 MJB>  [<c0182174>] mpage_writepages+0x234/0x3d0
 MJB>  [<c01657c0>] blkdev_writepage+0x0/0x20
 MJB>  [<c0142b89>] check_poison_obj+0x39/0x190
 MJB>  [<c0144a5a>] kmalloc+0xfa/0x1c0
 MJB>  [<c013e850>] generic_file_writev+0x40/0x60
 MJB>  [<c015dc30>] do_readv_writev+0x1c0/0x270
 MJB>  [<c015d6d0>] do_sync_write+0x0/0xe0
 MJB>  [<c015d07d>] generic_file_llseek+0x2d/0xd0
 MJB>  [<c015d050>] generic_file_llseek+0x0/0xd0
 MJB>  [<c015dd77>] vfs_writev+0x47/0x50
 MJB>  [<c015ddff>] sys_writev+0x2f/0x50
 MJB>  [<c01094df>] syscall_call+0x7/0xb

 MJB> Code: 00 8d bc 27 00 00 00 00 8b 54 24 08 8b 4c 24 04 8b 42 18 0f a3 08 19 c0 85
 MJB> c0 74 03 31 c0 c3 8b 02 a9 00 04 00 00 74 0a 8b 42 24 <8b> 40 10 85 c0 75 06 b8
 MJB> 01 00 00 00 c3 0f a3 08 19 d2 31 c0 85

 MJB> Steps to reproduce:
 MJB> from a current CVS of LTP (today is 5/22/2003):
 MJB> run ftest07 in one session
 MJB> while waiting for that to complete (it takes a while)
 MJB> I ran these:
 MJB> aio01 -n100000
 MJB> aio01 -c10 -n10000

 MJB> Both completed successfully but when ftest07 finished it had the output above.


 MJB> -
 MJB> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 MJB> the body of a message to majordomo@vger.kernel.org
 MJB> More majordomo info at  http://vger.kernel.org/majordomo-info.html
 MJB> Please read the FAQ at  http://www.tux.org/lkml/

