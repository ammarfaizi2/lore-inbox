Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbVHOXZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbVHOXZH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbVHOXZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:25:06 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26634 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932569AbVHOXZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 19:25:04 -0400
Date: Tue, 16 Aug 2005 01:25:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: zach@vmware.com
Cc: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org
Subject: Re: [PATCH 5/6] i386 virtualization - Make generic set wrprotect a macro
Message-ID: <20050815232502.GG3614@stusta.de>
References: <200508152300.j7FN0dD7005336@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508152300.j7FN0dD7005336@zach-dev.vmware.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 04:00:39PM -0700, zach@vmware.com wrote:

> Make the generic version of ptep_set_wrprotect a macro.  This is good for
> code uniformity, and fixes the build for architectures which include pgtable.h
> through headers into assembly code, but do not define a ptep_set_wrprotect
> function.


This against the kernel coding style.
In fact, we are usually doing exactly the opposite. 

What exactly is the technical problem this patch is trying to solve, IOW 
which architectures are breaking for you?


> Signed-off-by: Zachary Amsden <zach@vmware.com>
> Index: linux-2.6.13/include/asm-generic/pgtable.h
> ===================================================================
> --- linux-2.6.13.orig/include/asm-generic/pgtable.h	2005-08-12 12:12:55.000000000 -0700
> +++ linux-2.6.13/include/asm-generic/pgtable.h	2005-08-15 13:54:42.000000000 -0700
> @@ -313,11 +313,12 @@
>  #endif
>  
>  #ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT
> -static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
> -{
> -	pte_t old_pte = *ptep;
> -	set_pte_at(mm, address, ptep, pte_wrprotect(old_pte));
> -}
> +#define ptep_set_wrprotect(__mm, __address, __ptep)			\
> +({									\
> +	pte_t __old_pte = *(__ptep);					\
> +	set_pte_at((__mm), (__address), (__ptep),			\
> +			pte_wrprotect(__old_pte));			\
> +})
>  #endif
>  
>  #ifndef __HAVE_ARCH_PTE_SAME


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

