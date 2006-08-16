Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWHPKzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWHPKzN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 06:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWHPKzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 06:55:13 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:60427 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750849AbWHPKzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 06:55:11 -0400
Date: Wed, 16 Aug 2006 13:55:07 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Diego Calleja <diegocg@gmail.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 2/2] Simple shared page tables
Message-ID: <20060816105507.GE3067@rhun.haifa.ibm.com>
References: <20060815225607.17433.32727.sendpatch@wildcat> <20060815225618.17433.84777.sendpatch@wildcat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815225618.17433.84777.sendpatch@wildcat>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 05:56:18PM -0500, Dave McCracken wrote:

> The actual shared page table patches

Some stylistic nits I ran into while reading these:

> +#else /* CONFIG_PTSHARE */
> +#define pt_is_shared(page)	(0)
> +#define pt_is_shared_pte(pmdval)	(0)
> +#define pt_increment_share(page)
> +#define pt_decrement_share(page)
> +#define	pt_share_pte(vma, pmd, address)	pte_alloc_map(vma->vm_mm, pmd, address)
> +#define pt_unshare_range(mm, address, end)
> +#define pt_check_unshare_pte(mm, address, pmd)	(0)
> +#endif /* CONFIG_PTSHARE */

ISTR empty statements gave warnings with some compilers, perhaps use
do {} while (0) here?

> @@ -144,8 +147,9 @@ mprotect_fixup(struct vm_area_struct *vm
>  	if (newflags & VM_WRITE) {
>  		if (!(oldflags & (VM_ACCOUNT|VM_WRITE|VM_SHARED))) {
>  			charged = nrpages;
> -			if (security_vm_enough_memory(charged))
> +			if (security_vm_enough_memory(charged)) {
>  				return -ENOMEM;
> +			}

Superflous {}

>  			newflags |= VM_ACCOUNT;
>  		}
>  	}
> @@ -182,7 +186,7 @@ success:
>  	if (vma->vm_ops && vma->vm_ops->page_mkwrite)
>  		mask &= ~VM_SHARED;
>  
> -	newprot = protection_map[newflags & mask];
> + 	newprot = protection_map[newflags & mask];

Whitespace damaged

Cheers,
Muli
