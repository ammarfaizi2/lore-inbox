Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVCZLgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVCZLgA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 06:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVCZLgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 06:36:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13833 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262039AbVCZLfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 06:35:44 -0500
Date: Sat, 26 Mar 2005 11:35:30 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org, davem@davemloft.net,
       tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
Message-ID: <20050326113530.A12809@flint.arm.linux.org.uk>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Hugh Dickins <hugh@veritas.com>, akpm@osdl.org, davem@davemloft.net,
	tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> <20050325212234.F12715@flint.arm.linux.org.uk> <4244C3B7.4020409@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4244C3B7.4020409@yahoo.com.au>; from nickpiggin@yahoo.com.au on Sat, Mar 26, 2005 at 01:06:47PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 01:06:47PM +1100, Nick Piggin wrote:
> The reject should be confined to include/asm-ia64, so it will still
> work for you.

I guess I should've tried a little harder last night then.  Sorry.

> But I've put a clean rollup of all Hugh's patches here in case you'd
> like to try it.
> 
> http://www.kerneltrap.org/~npiggin/freepgt-2.6.12-rc1.patch

This works fine on ARM with high vectors.  With low vectors (located in
the 1st page of virtual memory space) I get:

kernel BUG at mm/mmap.c:1934!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c1e88000
[00000000] *pgd=c1e86031, *pte=c04440cf, *ppte=c044400e
Internal error: Oops: c1e8981f [#1]
Modules linked in:
CPU: 0
PC is at __bug+0x40/0x54
LR is at 0x1
pc : [<c0223870>]    lr : [<00000001>]    Not tainted
sp : c1e7bd18  ip : 60000093  fp : c1e7bd28
r10: c1f4b040  r9 : 00000006  r8 : c1f02ca0
r7 : 00000000  r6 : 00000000  r5 : c015b8c0  r4 : 00000000
r3 : 00000000  r2 : 00000000  r1 : 00000d4e  r0 : 00000001
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: C1E8917F  Table: C1E8917F  DAC: 00000015
Process init (pid: 235, stack limit = 0xc1e7a194)
Stack: (0xc1e7bd18 to 0xc1e7c000)
...
Backtrace:
[<c0223830>] (__bug+0x0/0x54) from [<c02691d8>] (exit_mmap+0x154/0x168)
 r4 = C1E7BD3C
[<c0269084>] (exit_mmap+0x0/0x168) from [<c02358c8>] (mmput+0x40/0xc0)
 r7 = C015B8C0  r6 = C015B8C0  r5 = 00000000  r4 = C015B8C0
[<c0235888>] (mmput+0x0/0xc0) from [<c027ecec>] (exec_mmap+0xec/0x134)
 r4 = C015B6A0
[<c027ec00>] (exec_mmap+0x0/0x134) from [<c027f234>] (flush_old_exec+0x4c8/0x6e4)
 r7 = C012B940  r6 = C1E7A000  r5 = C0498A00  r4 = 00000000
[<c027ed6c>] (flush_old_exec+0x0/0x6e4) from [<c029d53c>] (load_elf_binary+0x5c0/0xdc0)
[<c029cf7c>] (load_elf_binary+0x0/0xdc0) from [<c027f6e0>] (search_binary_handler+0xa0/0x244)
[<c027f640>] (search_binary_handler+0x0/0x244) from [<c029c4e8>] (load_script+0x224/0x22c)
[<c029c2c4>] (load_script+0x0/0x22c) from [<c027f6e0>] (search_binary_handler+0xa0/0x244)
 r6 = C1E7A000  r5 = C015E400  r4 = C03EC2B4
[<c027f640>] (search_binary_handler+0x0/0x244) from [<c027f9b8>] (do_execve+0x134/0x1f8)
[<c027f884>] (do_execve+0x0/0x1f8) from [<c02223f8>] (sys_execve+0x3c/0x5c)
[<c02223bc>] (sys_execve+0x0/0x5c) from [<c021dca0>] (ret_fast_syscall+0x0/0x2c)
 r7 = 0000000B  r6 = BED6AA74  r5 = BED6AB00  r4 = 0200F008
Code: 1b0051b8 e59f0014 eb0051b6 e3a03000 (e5833000)

In this case, we have a page which must be kept mapped at virtual address
0, which means the first entry in the L1 page table must always exist.
However, user threads start from 0x8000, which is also mapped via the
first entry in the L1 page table.

At a guess, I'd imagine that we're freeing the first L1 page table entry,
thereby causing mm->nr_ptes to become -1.

I'll do some debugging and try to work out if that (or exactly what's)
going on.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
