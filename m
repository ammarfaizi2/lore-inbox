Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbVKWAO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbVKWAO4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 19:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbVKWAO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 19:14:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65484 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030270AbVKWAOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 19:14:55 -0500
Date: Tue, 22 Nov 2005 16:15:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Workaround for gcc 2.96 (undefined references)
Message-Id: <20051122161518.2c04cf28.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0511211145330.4586-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0511211145330.4586-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Andrew:
> 
> As of 2.6.15-rc1-git4, gcc 2.96 complains about undefined references 
> unless this patch (as607) is applied.  Apparently the old compiler isn't 
> so good at avoiding linker references to unused code.
> 

Strange.  Do you know which change caused this to happen?  I'm a bit
worried that we might have done something silly to offend the compiler -
would like to understand the problem a little better.

Can you share the .config?

> 
> Index: usb-2.6/mm/memory.c
> ===================================================================
> --- usb-2.6.orig/mm/memory.c
> +++ usb-2.6/mm/memory.c
> @@ -2101,6 +2101,13 @@ int __pud_alloc(struct mm_struct *mm, pg
>  	spin_unlock(&mm->page_table_lock);
>  	return 0;
>  }
> +#else
> +
> +/* Workaround for gcc 2.96 */
> +int __pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
> +{
> +	return 0;
> +}
>  #endif /* __PAGETABLE_PUD_FOLDED */
>  
>  #ifndef __PAGETABLE_PMD_FOLDED
> @@ -2129,6 +2136,13 @@ int __pmd_alloc(struct mm_struct *mm, pu
>  	spin_unlock(&mm->page_table_lock);
>  	return 0;
>  }
> +#else
> +
> +/* Workaround for gcc 2.96 */
> +int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
> +{
> +	return 0;
> +}
>  #endif /* __PAGETABLE_PMD_FOLDED */
>  
>  int make_pages_present(unsigned long addr, unsigned long end)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
