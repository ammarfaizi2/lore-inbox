Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbUKEKQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUKEKQw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 05:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbUKEKQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 05:16:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:25268 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261567AbUKEKQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 05:16:51 -0500
Date: Fri, 5 Nov 2004 11:17:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041105101723.GA4667@elte.hu>
References: <20041105001328.3ba97e08.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105001328.3ba97e08.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> - Added Andi's 4-level-pagetable patches.  It's tested on x86, x86_64, ia64
>   and ppc64.  These are fairly intrusive patches and I'll probably push them
>   upstream soon.

make it compile on x86 with !REGPARM (default):

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/mm/pgtable.c.orig
+++ linux/arch/i386/mm/pgtable.c
@@ -221,7 +221,7 @@ void pgd_dtor(void *pgd, kmem_cache_t *c
 	spin_unlock_irqrestore(&pgd_lock, flags);
 }
 
-pgd_t *__pgd_alloc(struct mm_struct *mm, pml4_t *pml4, unsigned long address)
+pgd_t fastcall *__pgd_alloc(struct mm_struct *mm, pml4_t *pml4, unsigned long address)
 {
 	int i;
 	pgd_t *pgd = kmem_cache_alloc(pgd_cache, GFP_KERNEL);
