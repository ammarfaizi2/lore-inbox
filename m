Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268031AbUBRUSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267996AbUBRUSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:18:16 -0500
Received: from chaos.analogic.com ([204.178.40.224]:59264 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268031AbUBRUSJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:18:09 -0500
Date: Wed, 18 Feb 2004 15:20:27 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Ulrich Keil <ulrich@der-keiler.de>, linux-kernel@vger.kernel.org
Subject: Re: New do_mremap vulnerabitily.
In-Reply-To: <4033B262.6060402@nortelnetworks.com>
Message-ID: <Pine.LNX.4.53.0402181516500.7318@chaos>
References: <20040218170827.GA93278@mail.der-keiler.de> <4033B262.6060402@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004, Chris Friesen wrote:

> Ulrich Keil wrote:
> > There was also a Proof-of-concept exploit released:
> >
> > http://www.derkeiler.com/Mailing-Lists/Securiteam/2004-02/0052.html
>
> Its a bit confusing.  They talk about multiple instances of do_munmap()
> with unchecked return codes.  I can only find one, in move_vma().
>
> Chris
>

Except in some drivers, you seem to be (nearly) correct ......

For Linux version 2.4.24

(file-name __follows__ the function name)

EXPORT_SYMBOL(do_munmap);
./kernel/ksyms.c
		do_munmap(current->mm, addr, old_len);
		do_munmap(current->mm, new_addr, new_len);
		do_munmap(current->mm, addr+new_len, old_len - new_len);
./mm/mremap.c
		if (!do_munmap(mm, newbrk, oldbrk-newbrk))
		if (do_munmap(mm, addr, len))
		 * in the do_munmap, so FIXME (not in 2.4 to avoid breaking
int do_munmap(struct mm_struct *mm, unsigned long addr, size_t len)
	ret = do_munmap(mm, addr, len);
		if (do_munmap(mm, addr, len))
./mm/mmap.c
	 * do_munmap() behaves similarly, taking the range out of mm's
		 * exit_mmap() and do_munmap() cases described above:
./mm/swapfile.c
			do_munmap(mm, shmd->vm_start, shmd->vm_end - shmd->vm_start);
******---> ./ipc/shm.c


	if (do_munmap(current->mm, cont_mem.linear, size) != 0)
./drivers/char/drm/savage_drv.c
#define DO_MUNMAP(m, a, l)	do_munmap(m, a, l)
./drivers/char/drm/i830_dma.c
#define DO_MUNMAP(m, a, l)	do_munmap(m, a, l)
./drivers/char/drm/i810_dma.c
        	retcode = do_munmap(current->mm,
./drivers/char/drm-4.0/i810_dma.c
		do_munmap(current->mm, newbrk, oldbrk-newbrk);
./arch/sparc/kernel/sys_sunos.c
		do_munmap(mm, newbrk, oldbrk-newbrk);
./arch/mips/kernel/sysirix.c
		do_munmap(current->mm, newbrk, oldbrk-newbrk);
./arch/sparc64/kernel/sys_sunos32.c
	ret = do_munmap(current->mm, addr, len);
./arch/sparc64/kernel/sys_sparc.c
	r = do_munmap(task->mm, ctx->ctx_smpl_vaddr, psb->psb_size);
./arch/ia64/kernel/perfmon.c
		if (!do_munmap(mm, newbrk, oldbrk-newbrk))
./arch/ia64/kernel/sys_ia64.c
		do_munmap(current->mm, addr, len);
./arch/s390x/kernel/linux32.c

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an Intel Pentium III machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


