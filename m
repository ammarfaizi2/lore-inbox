Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWH1XBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWH1XBr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 19:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWH1XBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 19:01:47 -0400
Received: from cantor2.suse.de ([195.135.220.15]:12981 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751167AbWH1XBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 19:01:46 -0400
From: Andi Kleen <ak@suse.de>
To: Badari Pulavarty <pbadari@gmail.com>
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Date: Tue, 29 Aug 2006 00:54:47 +0200
User-Agent: KMail/1.9.3
Cc: Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@osdl.org>,
       "J. Bruce Fields" <bfields@fieldses.org>,
       lkml <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
References: <20060820013121.GA18401@fieldses.org> <44EAD613.76E4.0078.0@novell.com> <1156804352.447.5.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1156804352.447.5.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608290054.47781.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the test cases. If you have more keep them comming.

> Call Trace:
>  [<ffffffff80284179>] ll_rw_block+0x79/0xd0
>  [<ffffffff8030e868>] journal_commit_transaction+0x478/0x1170
>  [<ffffffff80312c8e>] kjournald+0xde/0x290
>  [<ffffffff8024562c>] kthread+0xdc/0x110
>  [<ffffffff8020abe2>] child_rip+0x8/0x12
> DWARF2 unwinder stuck at child_rip+0x8/0x12
> Leftover inexact backtrace:
>  [<ffffffff80245550>] kthread+0x0/0x110
>  [<ffffffff8020abda>] child_rip+0x0/0x12

I submitted Jan's patch to fix that one for .18, but Linus hasn't merged it 
yet.



>  [<ffffffff8027fbbc>] kfree+0x26/0x1f2
>  [<ffffffff80304110>] do_get_write_access+0x52e/0x54f
>  [<ffffffff803051a3>] journal_get_undo_access+0x2e/0x118
>  [<ffffffff802f0a0c>] ext3_try_to_allocate_with_rsv+0x4b/0x504
>  [<ffffffff802f117e>] ext3_new_blocks+0x2b9/0x74e
>  [<ffffffff802f46d3>] ext3_get_blocks_handle+0x467/0xac4
>  [<ffffffff802f5095>] ext3_get_block+0xc4/0xec
>  [<ffffffff8028795c>] __block_prepare_write+0x1bf/0x41e
>  [<ffffffff80287bdd>] block_prepare_write+0x22/0x30
>  [<ffffffff802f660f>] ext3_prepare_write+0xb5/0x185
>  [<ffffffff8025fbc3>] generic_file_buffered_write+0x2c7/0x6b7
>  [<ffffffff80260298>] __generic_file_aio_write_nolock+0x2e5/0x331
>  [<ffffffff8026034d>] generic_file_aio_write+0x69/0xc4
>  [<ffffffff802f21a6>] ext3_file_write+0x1e/0x9b
>  [<ffffffff80284804>] do_sync_write+0xf0/0x12e
>  [<ffffffff80285197>] vfs_write+0xcf/0x175
>  [<ffffffff8028577f>] sys_write+0x47/0x70
>  [<ffffffff8020988e>] system_call+0x7e/0x83
> DWARF2 unwinder stuck at system_call+0x7e/0x83

This one will be fixed in .19 only


> Leftover inexact backtrace:
> 
> 
> Code: 0f 0b 68 ae 3c 4a 80 c2 8a 0a 58 5b c9 c3 55 48 89 e5 41 57
> RIP  [<ffffffff8027de3d>] kfree_debugcheck+0x9a/0xa8
>  RSP <ffff81010d9ad5b8>
>  <3>BUG: sleeping function called from invalid context at
> kernel/rwsem.c:20
> in_atomic():0, irqs_disabled():1
> 
> Call Trace:
>  [<ffffffff8020ad7f>] show_trace+0xae/0x30e
>  [<ffffffff8020aff4>] dump_stack+0x15/0x17
>  [<ffffffff802288a5>] __might_sleep+0xb2/0xb4
>  [<ffffffff8024750e>] down_read+0x1d/0x2f
>  [<ffffffff8023e674>] blocking_notifier_call_chain+0x1b/0x41
>  [<ffffffff80232511>] profile_task_exit+0x15/0x17
>  [<ffffffff80233f95>] do_exit+0x25/0x91e
>  [<ffffffff8020b222>] kernel_math_error+0x0/0x96
>  [<ffff81010b6a30c0>]


Hmm, not sure about that one. In theory it should have been fixed
in rc4 already. Was this from an earlier kernel?

> DWARF2 unwinder stuck at 0xffff81010b6a30c0
> Leftover inexact backtrace:
>  [<ffffffff80471079>] do_trap+0xe0/0xef
>  [<ffffffff8020b82d>] do_invalid_op+0xa7/0xb3
>  [<ffffffff8027de3d>] kfree_debugcheck+0x9a/0xa8


-Andi
