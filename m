Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263987AbRFEOKv>; Tue, 5 Jun 2001 10:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263990AbRFEOKl>; Tue, 5 Jun 2001 10:10:41 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:11796 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S263987AbRFEOKg>; Tue, 5 Jun 2001 10:10:36 -0400
Date: Tue, 5 Jun 2001 14:56:06 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: linux-kernel@vger.kernel.org
Subject: meaning of vmalloc shortcut comment in fault.c
Message-ID: <Pine.LNX.3.96.1010605145320.9033B-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone elaborate on why it's bad to refer to tsk directly below (this
is a 2.4.5 change in x86) and why it's needed on x86 and not other archs..

What should I do for an arch that does not have a "cr3" machine register
to check with ?

/BW

vmalloc_fault:
        {
                /*
                 * Synchronize this task's top level page-table
                 * with the 'reference' page table.
                 *
                 * Do _not_ use "tsk" here. We might be inside
                 * an interrupt in the middle of a task switch..
                 */
                int offset = __pgd_offset(address);
                pgd_t *pgd, *pgd_k;
                pmd_t *pmd, *pmd_k;
                pte_t *pte_k;

                asm("movl %%cr3,%0":"=r" (pgd));
                pgd = offset + (pgd_t *)__va(pgd);


