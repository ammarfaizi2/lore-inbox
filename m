Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264154AbUHGSgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbUHGSgP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 14:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbUHGSgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 14:36:15 -0400
Received: from lakermmtao10.cox.net ([68.230.240.29]:7600 "EHLO
	lakermmtao10.cox.net") by vger.kernel.org with ESMTP
	id S264154AbUHGSf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 14:35:58 -0400
Date: Sat, 7 Aug 2004 09:44:14 -0400
From: Chris Shoemaker <c.shoemaker@cox.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Gene Heskett <gene.heskett@verizon.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       vda@port.imtp.ilyichevsk.odessa.ua, ak@suse.de,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Possible dcache BUG
Message-ID: <20040807134414.GA16953@cox.net>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <20040806073739.GA6617@elte.hu> <20040806004231.143c8bd2.akpm@osdl.org> <200408060751.07605.gene.heskett@verizon.net> <Pine.LNX.4.58.0408060948310.24588@ppc970.osdl.org> <20040806230924.GA15493@cox.net> <Pine.LNX.4.58.0408062304580.24588@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408062304580.24588@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 06, 2004 at 11:20:28PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 6 Aug 2004, Chris Shoemaker wrote:
> > 
> > I _was_ able to find the attached oops, but I don't think I have the
> > corresponding object files, so I hope the decoding it contains is
> > good enough. 
> 
> It's fine.

Well then, maybe you'd like more?  I attached two more from the same
period.  Please remember that these are 5 months old, and could
represent bugs already fixed.  I think this was stock 2.6.4.

> 
> It oopses on
> 
> 	inode->i_sb->s_op
> 
> where "i_sb" is bad and contains the pointer "0x0b7eebf8" which is 
> definitely not a valid kernel pointer.
> 
> There's a few other strange details in your oops report too. One being 
> that the inode pointer (in %ebx, apparently) doesn't show on the stack 
> where I'd expect it to show. Hmm. That might be just a different compiler 
> issue, though.

Perhaps due to CONFIG_REGPARM?  I haven't used it for quite a while, but
back in March I was a bit bolder about config options marked
experimental.  Gene, are you using REGPARM?

-chris

> 
> Anyway, this does look somewhat like the ones Gene is seeing. If I had to 
> guess, I'd guess that either the inode pointer is bad, or it's just stale 
> from an inode that has already been free'd. Most likely because of 
> prune_dcache() having had a corrupt LRU list with a stale/corrupt entry.
> 
> That would blow the prefetch theory out of the water. 
> 
> 		Linus

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Mar17.2.txt"

Mar 17 03:34:28 peace kernel: Unable to handle kernel paging request at virtual address 0034779d
Mar 17 03:34:28 peace kernel:  printing eip:
Mar 17 03:34:28 peace kernel: c0211e8f
Mar 17 03:34:28 peace kernel: *pde = 00000000
Mar 17 03:34:28 peace kernel: Oops: 0000 [#1]
Mar 17 03:34:28 peace kernel: PREEMPT DEBUG_PAGEALLOC
Mar 17 03:34:28 peace kernel: CPU:    0
Mar 17 03:34:28 peace kernel: EIP:    0060:[vsnprintf+799/1184]    Not tainted
Mar 17 03:34:28 peace kernel: EFLAGS: 00010097
Mar 17 03:34:28 peace kernel: EIP is at vsnprintf+0x31f/0x4a0
Mar 17 03:34:28 peace kernel: eax: 0034779d   ebx: 0000000a   ecx: 0034779d   edx: fffffffe
Mar 17 03:34:28 peace kernel: esi: c042d1fb   edi: 00000000   ebp: cba33cf4   esp: cba33cb8
Mar 17 03:34:28 peace kernel: ds: 007b   es: 007b   ss: 0068
Mar 17 03:34:29 peace kernel: Process kswapd0 (pid: 7, threadinfo=cba32000 task=cba559e0)
Mar 17 03:34:29 peace kernel: Stack: 000001a0 00000000 0000000a ffffffff 00000002 00000002 ffffffff ffffffff 
Mar 17 03:34:29 peace kernel:        c042d5df 00000400 c042d1e0 c033a3f2 00000400 00000246 c03419b3 cba33d04 
Mar 17 03:34:29 peace kernel:        c0212028 cba33d6c c042d1e0 cba33d54 c012a7b7 cba33d60 c10786b8 c1078690 
Mar 17 03:34:29 peace kernel: Call Trace:
Mar 17 03:34:29 peace kernel:  [vscnprintf+24/48] vscnprintf+0x18/0x30
Mar 17 03:34:29 peace kernel:  [printk+359/1008] printk+0x167/0x3f0
Mar 17 03:34:29 peace kernel:  [shrink_list+2259/2816] shrink_list+0x8d3/0xb00
Mar 17 03:34:29 peace kernel:  [shrink_cache+574/1664] shrink_cache+0x23e/0x680
Mar 17 03:34:29 peace kernel:  [balance_pgdat+401/528] balance_pgdat+0x191/0x210
Mar 17 03:34:29 peace kernel:  [kswapd+220/240] kswapd+0xdc/0xf0
Mar 17 03:34:29 peace kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Mar 17 03:34:29 peace kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Mar 17 03:34:29 peace kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Mar 17 03:34:29 peace kernel:  [kswapd+0/240] kswapd+0x0/0xf0
Mar 17 03:34:29 peace kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Mar 17 03:34:29 peace kernel: 
Mar 17 03:34:29 peace kernel: Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75 
Mar 17 03:34:29 peace kernel:  <6>note: kswapd0[7] exited with preempt_count 2
Mar 17 03:34:29 peace kernel: Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
Mar 17 03:34:29 peace kernel: in_atomic():1, irqs_disabled():0
Mar 17 03:34:29 peace kernel: Call Trace:
Mar 17 03:34:29 peace kernel:  [__might_sleep+172/224] __might_sleep+0xac/0xe0
Mar 17 03:34:29 peace kernel:  [profile_exit_task+35/96] profile_exit_task+0x23/0x60
Mar 17 03:34:29 peace kernel:  [do_exit+117/2480] do_exit+0x75/0x9b0
Mar 17 03:34:29 peace kernel:  [die+594/608] die+0x252/0x260
Mar 17 03:34:29 peace kernel:  [do_page_fault+0/1360] do_page_fault+0x0/0x550
Mar 17 03:34:29 peace kernel:  [do_page_fault+485/1360] do_page_fault+0x1e5/0x550
Mar 17 03:34:29 peace kernel:  [update_wall_time+22/64] update_wall_time+0x16/0x40
Mar 17 03:34:29 peace kernel:  [do_timer+199/208] do_timer+0xc7/0xd0
Mar 17 03:34:29 peace kernel:  [do_page_fault+0/1360] do_page_fault+0x0/0x550
Mar 17 03:34:29 peace kernel:  [error_code+45/56] error_code+0x2d/0x38
Mar 17 03:34:29 peace kernel:  [vsnprintf+799/1184] vsnprintf+0x31f/0x4a0
Mar 17 03:34:29 peace kernel:  [vscnprintf+24/48] vscnprintf+0x18/0x30
Mar 17 03:34:29 peace kernel:  [printk+359/1008] printk+0x167/0x3f0
Mar 17 03:34:29 peace kernel:  [shrink_list+2259/2816] shrink_list+0x8d3/0xb00
Mar 17 03:34:29 peace kernel:  [shrink_cache+574/1664] shrink_cache+0x23e/0x680
Mar 17 03:34:29 peace kernel:  [balance_pgdat+401/528] balance_pgdat+0x191/0x210
Mar 17 03:34:29 peace kernel:  [kswapd+220/240] kswapd+0xdc/0xf0
Mar 17 03:34:29 peace kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Mar 17 03:34:29 peace kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Mar 17 03:34:29 peace kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Mar 17 03:34:29 peace kernel:  [kswapd+0/240] kswapd+0x0/0xf0
Mar 17 03:34:29 peace kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Mar 17 03:34:29 peace kernel: 

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Mar17.3.txt"

Mar 17 06:25:01 peace /USR/SBIN/CRON[1153]: (root) CMD (test -e /usr/sbin/anacron || run-parts --report /etc/cron.daily)
Mar 17 06:25:04 peace kernel: Unable to handle kernel paging request at virtual address 00a6be3c
Mar 17 06:25:04 peace kernel:  printing eip:
Mar 17 06:25:04 peace kernel: c01a4650
Mar 17 06:25:04 peace kernel: *pde = 00000000
Mar 17 06:25:04 peace kernel: Oops: 0000 [#2]
Mar 17 06:25:04 peace kernel: PREEMPT DEBUG_PAGEALLOC
Mar 17 06:25:04 peace kernel: CPU:    0
Mar 17 06:25:04 peace kernel: EIP:    0060:[find_inode_fast+32/96]    Not tainted
Mar 17 06:25:04 peace kernel: EFLAGS: 00010206
Mar 17 06:25:04 peace kernel: EIP is at find_inode_fast+0x20/0x60
Mar 17 06:25:04 peace kernel: eax: c35b5e3c   ebx: 000382ea   ecx: 00a6be3c   edx: 00a6be3c
Mar 17 06:25:04 peace kernel: esi: cb7eebf8   edi: c11f1cac   ebp: c616de24   esp: c616de18
Mar 17 06:25:04 peace kernel: ds: 007b   es: 007b   ss: 0068
Mar 17 06:25:04 peace kernel: Process find (pid: 1170, threadinfo=c616c000 task=c5d169e0)
Mar 17 06:25:04 peace kernel: Stack: 000382ea 000382ea cb7eebf8 c616de58 c01a5aa0 c55612ec 00000000 00000000 
Mar 17 06:25:04 peace kernel:        c5f87f8c c616def8 cab3cef8 1d244b3c c11f1cac 000382ea c5f87ef8 cb7eebf8 
Mar 17 06:25:04 peace kernel:        c616de70 c01dde7c c8fae110 c0388a80 fffffff4 cacb3ebc c616de94 c0191a7e 
Mar 17 06:25:04 peace kernel: Call Trace:
Mar 17 06:25:04 peace kernel:  [iget_locked+176/672] iget_locked+0xb0/0x2a0
Mar 17 06:25:04 peace kernel:  [ext3_lookup+92/176] ext3_lookup+0x5c/0xb0
Mar 17 06:25:04 peace kernel:  [real_lookup+206/256] real_lookup+0xce/0x100
Mar 17 06:25:04 peace kernel:  [do_lookup+117/128] do_lookup+0x75/0x80
Mar 17 06:25:04 peace kernel:  [link_path_walk+2138/4224] link_path_walk+0x85a/0x1080
Mar 17 06:25:04 peace kernel:  [kmem_cache_alloc+134/480] kmem_cache_alloc+0x86/0x1e0
Mar 17 06:25:04 peace kernel:  [getname+126/192] getname+0x7e/0xc0
Mar 17 06:25:04 peace kernel:  [__user_walk+61/80] __user_walk+0x3d/0x50
Mar 17 06:25:04 peace kernel:  [vfs_lstat+29/80] vfs_lstat+0x1d/0x50
Mar 17 06:25:04 peace kernel:  [sys_lstat64+22/48] sys_lstat64+0x16/0x30
Mar 17 06:25:04 peace kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar 17 06:25:04 peace kernel: 
Mar 17 06:25:04 peace kernel: Code: 8b 11 0f 18 02 90 39 59 18 89 c8 74 13 85 d2 89 d1 75 ed 31 
Mar 17 06:25:04 peace kernel:  <6>note: find[1170] exited with preempt_count 1
Mar 17 06:25:04 peace kernel: Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
Mar 17 06:25:04 peace kernel: in_atomic():1, irqs_disabled():0
Mar 17 06:25:04 peace kernel: Call Trace:
Mar 17 06:25:04 peace kernel:  [__might_sleep+172/224] __might_sleep+0xac/0xe0
Mar 17 06:25:04 peace kernel:  [profile_exit_task+35/96] profile_exit_task+0x23/0x60
Mar 17 06:25:04 peace kernel:  [do_exit+117/2480] do_exit+0x75/0x9b0
Mar 17 06:25:04 peace kernel:  [die+594/608] die+0x252/0x260
Mar 17 06:25:04 peace kernel:  [do_page_fault+0/1360] do_page_fault+0x0/0x550
Mar 17 06:25:04 peace kernel:  [do_page_fault+485/1360] do_page_fault+0x1e5/0x550
Mar 17 06:25:04 peace kernel:  [__getblk+28/64] __getblk+0x1c/0x40
Mar 17 06:25:04 peace kernel:  [ext3_getblk+119/576] ext3_getblk+0x77/0x240
Mar 17 06:25:04 peace kernel:  [wake_up_buffer+9/48] wake_up_buffer+0x9/0x30
Mar 17 06:25:04 peace kernel:  [ll_rw_block+92/144] ll_rw_block+0x5c/0x90
Mar 17 06:25:04 peace kernel:  [do_page_fault+0/1360] do_page_fault+0x0/0x550
Mar 17 06:25:04 peace kernel:  [error_code+45/56] error_code+0x2d/0x38
Mar 17 06:25:04 peace kernel:  [find_inode_fast+32/96] find_inode_fast+0x20/0x60
Mar 17 06:25:04 peace kernel:  [iget_locked+176/672] iget_locked+0xb0/0x2a0
Mar 17 06:25:04 peace kernel:  [ext3_lookup+92/176] ext3_lookup+0x5c/0xb0
Mar 17 06:25:04 peace kernel:  [real_lookup+206/256] real_lookup+0xce/0x100
Mar 17 06:25:04 peace kernel:  [do_lookup+117/128] do_lookup+0x75/0x80
Mar 17 06:25:04 peace kernel:  [link_path_walk+2138/4224] link_path_walk+0x85a/0x1080
Mar 17 06:25:04 peace kernel:  [kmem_cache_alloc+134/480] kmem_cache_alloc+0x86/0x1e0
Mar 17 06:25:04 peace kernel:  [getname+126/192] getname+0x7e/0xc0
Mar 17 06:25:04 peace kernel:  [__user_walk+61/80] __user_walk+0x3d/0x50
Mar 17 06:25:04 peace kernel:  [vfs_lstat+29/80] vfs_lstat+0x1d/0x50
Mar 17 06:25:04 peace kernel:  [sys_lstat64+22/48] sys_lstat64+0x16/0x30
Mar 17 06:25:04 peace kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar 17 06:25:04 peace kernel: 
Mar 17 06:25:04 peace kernel: bad: scheduling while atomic!
Mar 17 06:25:04 peace kernel: Call Trace:
Mar 17 06:25:04 peace kernel:  [schedule+2311/2320] schedule+0x907/0x910
Mar 17 06:25:04 peace kernel:  [zap_pmd_range+68/96] zap_pmd_range+0x44/0x60
Mar 17 06:25:04 peace kernel:  [unmap_page_range+70/128] unmap_page_range+0x46/0x80
Mar 17 06:25:04 peace kernel:  [unmap_vmas+534/848] unmap_vmas+0x216/0x350
Mar 17 06:25:04 peace kernel:  [__pagevec_lru_add_active+451/672] __pagevec_lru_add_active+0x1c3/0x2a0
Mar 17 06:25:04 peace kernel:  [exit_mmap+199/688] exit_mmap+0xc7/0x2b0
Mar 17 06:25:04 peace kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Mar 17 06:25:04 peace kernel:  [mmput+173/288] mmput+0xad/0x120
Mar 17 06:25:04 peace kernel:  [do_exit+482/2480] do_exit+0x1e2/0x9b0
Mar 17 06:25:04 peace kernel:  [die+594/608] die+0x252/0x260
Mar 17 06:25:04 peace kernel:  [do_page_fault+0/1360] do_page_fault+0x0/0x550
Mar 17 06:25:04 peace kernel:  [do_page_fault+485/1360] do_page_fault+0x1e5/0x550
Mar 17 06:25:04 peace kernel:  [__getblk+28/64] __getblk+0x1c/0x40
Mar 17 06:25:04 peace kernel:  [ext3_getblk+119/576] ext3_getblk+0x77/0x240
Mar 17 06:25:04 peace kernel:  [wake_up_buffer+9/48] wake_up_buffer+0x9/0x30
Mar 17 06:25:04 peace kernel:  [ll_rw_block+92/144] ll_rw_block+0x5c/0x90
Mar 17 06:25:04 peace kernel:  [do_page_fault+0/1360] do_page_fault+0x0/0x550
Mar 17 06:25:04 peace kernel:  [error_code+45/56] error_code+0x2d/0x38
Mar 17 06:25:04 peace kernel:  [find_inode_fast+32/96] find_inode_fast+0x20/0x60
Mar 17 06:25:04 peace kernel:  [iget_locked+176/672] iget_locked+0xb0/0x2a0
Mar 17 06:25:04 peace kernel:  [ext3_lookup+92/176] ext3_lookup+0x5c/0xb0
Mar 17 06:25:04 peace kernel:  [real_lookup+206/256] real_lookup+0xce/0x100
Mar 17 06:25:04 peace kernel:  [do_lookup+117/128] do_lookup+0x75/0x80
Mar 17 06:25:04 peace kernel:  [link_path_walk+2138/4224] link_path_walk+0x85a/0x1080
Mar 17 06:25:04 peace kernel:  [kmem_cache_alloc+134/480] kmem_cache_alloc+0x86/0x1e0
Mar 17 06:25:04 peace kernel:  [getname+126/192] getname+0x7e/0xc0
Mar 17 06:25:04 peace kernel:  [__user_walk+61/80] __user_walk+0x3d/0x50
Mar 17 06:25:04 peace kernel:  [vfs_lstat+29/80] vfs_lstat+0x1d/0x50
Mar 17 06:25:04 peace kernel:  [sys_lstat64+22/48] sys_lstat64+0x16/0x30
Mar 17 06:25:04 peace kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar 17 06:25:04 peace kernel: 
Mar 17 06:25:04 peace kernel: fs/fs-writeback.c:71: spin_lock(fs/inode.c:c0386770) already locked by fs/inode.c/798

--LZvS9be/3tNcYl/X--
