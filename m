Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVCZNnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVCZNnO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 08:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVCZNnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 08:43:14 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:872 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262061AbVCZNnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 08:43:00 -0500
Message-ID: <424566E0.80001@yahoo.com.au>
Date: Sun, 27 Mar 2005 00:42:56 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org, davem@davemloft.net,
       tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> <20050325212234.F12715@flint.arm.linux.org.uk> <4244C3B7.4020409@yahoo.com.au> <20050326113530.A12809@flint.arm.linux.org.uk>
In-Reply-To: <20050326113530.A12809@flint.arm.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------000900090809090704050403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000900090809090704050403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Russell King wrote:
> On Sat, Mar 26, 2005 at 01:06:47PM +1100, Nick Piggin wrote:
> 
>>The reject should be confined to include/asm-ia64, so it will still
>>work for you.
> 
> 
> I guess I should've tried a little harder last night then.  Sorry.
> 

Well I only said that just in case you had time to try testing
again. I wouldn't expect you to go hunting through rejects and
various kernel trees to try to get a working patch ;)

> 
>>But I've put a clean rollup of all Hugh's patches here in case you'd
>>like to try it.
>>
>>http://www.kerneltrap.org/~npiggin/freepgt-2.6.12-rc1.patch
> 
> 
> This works fine on ARM with high vectors.  With low vectors (located in
> the 1st page of virtual memory space) I get:
> 
> kernel BUG at mm/mmap.c:1934!
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = c1e88000
> [00000000] *pgd=c1e86031, *pte=c04440cf, *ppte=c044400e
> Internal error: Oops: c1e8981f [#1]
> Modules linked in:
> CPU: 0
> PC is at __bug+0x40/0x54
> LR is at 0x1
> pc : [<c0223870>]    lr : [<00000001>]    Not tainted
> sp : c1e7bd18  ip : 60000093  fp : c1e7bd28
> r10: c1f4b040  r9 : 00000006  r8 : c1f02ca0
> r7 : 00000000  r6 : 00000000  r5 : c015b8c0  r4 : 00000000
> r3 : 00000000  r2 : 00000000  r1 : 00000d4e  r0 : 00000001
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
> Control: C1E8917F  Table: C1E8917F  DAC: 00000015
> Process init (pid: 235, stack limit = 0xc1e7a194)
> Stack: (0xc1e7bd18 to 0xc1e7c000)
> ...
> Backtrace:
> [<c0223830>] (__bug+0x0/0x54) from [<c02691d8>] (exit_mmap+0x154/0x168)
>  r4 = C1E7BD3C
> [<c0269084>] (exit_mmap+0x0/0x168) from [<c02358c8>] (mmput+0x40/0xc0)
>  r7 = C015B8C0  r6 = C015B8C0  r5 = 00000000  r4 = C015B8C0
> [<c0235888>] (mmput+0x0/0xc0) from [<c027ecec>] (exec_mmap+0xec/0x134)
>  r4 = C015B6A0
> [<c027ec00>] (exec_mmap+0x0/0x134) from [<c027f234>] (flush_old_exec+0x4c8/0x6e4)
>  r7 = C012B940  r6 = C1E7A000  r5 = C0498A00  r4 = 00000000
> [<c027ed6c>] (flush_old_exec+0x0/0x6e4) from [<c029d53c>] (load_elf_binary+0x5c0/0xdc0)
> [<c029cf7c>] (load_elf_binary+0x0/0xdc0) from [<c027f6e0>] (search_binary_handler+0xa0/0x244)
> [<c027f640>] (search_binary_handler+0x0/0x244) from [<c029c4e8>] (load_script+0x224/0x22c)
> [<c029c2c4>] (load_script+0x0/0x22c) from [<c027f6e0>] (search_binary_handler+0xa0/0x244)
>  r6 = C1E7A000  r5 = C015E400  r4 = C03EC2B4
> [<c027f640>] (search_binary_handler+0x0/0x244) from [<c027f9b8>] (do_execve+0x134/0x1f8)
> [<c027f884>] (do_execve+0x0/0x1f8) from [<c02223f8>] (sys_execve+0x3c/0x5c)
> [<c02223bc>] (sys_execve+0x0/0x5c) from [<c021dca0>] (ret_fast_syscall+0x0/0x2c)
>  r7 = 0000000B  r6 = BED6AA74  r5 = BED6AB00  r4 = 0200F008
> Code: 1b0051b8 e59f0014 eb0051b6 e3a03000 (e5833000)
> 
> In this case, we have a page which must be kept mapped at virtual address
> 0, which means the first entry in the L1 page table must always exist.
> However, user threads start from 0x8000, which is also mapped via the
> first entry in the L1 page table.
> 
> At a guess, I'd imagine that we're freeing the first L1 page table entry,
> thereby causing mm->nr_ptes to become -1.
> 
> I'll do some debugging and try to work out if that (or exactly what's)
> going on.
> 

OK, thanks that would be good. You could well be right in your analysis.
May I suggest a possible avenue of investigation:

--------------000900090809090704050403
Content-Type: text/plain;
 name="freepgt-ARM-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="freepgt-ARM-fix.patch"

Index: linux-2.6/mm/mmap.c
===================================================================
--- linux-2.6.orig/mm/mmap.c	2005-03-26 23:47:51.000000000 +1100
+++ linux-2.6/mm/mmap.c	2005-03-27 00:41:00.000000000 +1100
@@ -1612,6 +1612,8 @@ static void unmap_vma_list(struct mm_str
 	validate_mm(mm);
 }
 
+#define FIRST_USER_ADDRESS	(FIRST_USER_PGD_NR * PGDIR_SIZE)
+
 /*
  * Get rid of page table information in the indicated region.
  *
@@ -1630,7 +1632,7 @@ static void unmap_region(struct mm_struc
 	tlb = tlb_gather_mmu(mm, 0);
 	unmap_vmas(&tlb, mm, vma, start, end, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
-	free_pgtables(&tlb, vma, prev? prev->vm_end: 0,
+	free_pgtables(&tlb, vma, prev? prev->vm_end: FIRST_USER_ADDRESS,
 				 next? next->vm_start: 0);
 	tlb_finish_mmu(tlb, start, end);
 	spin_unlock(&mm->page_table_lock);
@@ -1910,7 +1912,7 @@ void exit_mmap(struct mm_struct *mm)
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
 	end = unmap_vmas(&tlb, mm, vma, 0, -1, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
-	free_pgtables(&tlb, vma, 0, 0);
+	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, 0);
 	tlb_finish_mmu(tlb, 0, end);
 
 	mm->mmap = mm->mmap_cache = NULL;

--------------000900090809090704050403--

