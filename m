Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267308AbUG1Q1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267308AbUG1Q1V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267315AbUG1QZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:25:30 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:11759 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S267308AbUG1QUe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:20:34 -0400
Message-ID: <4107D236.9090601@austin.ibm.com>
Date: Wed, 28 Jul 2004 11:20:06 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Use of __pa() with CONFIG_NONLINEAR
References: <1090965630.15847.575.camel@nighthawk>
In-Reply-To: <1090965630.15847.575.camel@nighthawk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the largest and hardest to maintain part of the CONFIG_NONLINEAR
> patch at this point, and I'd love to start merging bits of it back in. 
> Would anybody object to a patch that just does this for a bunch of
> architectures?

I like the idea but would suggest a comment with the #defines to better 
explain why there are two names for the same thing, how they might in 
fact be different things in the future, and which one to use where.

> 
> --- include/asm-i386/page.h.orig	2004-07-27 14:31:09.000000000 -0700
> +++ include/asm-i386/page.h	2004-07-27 14:31:36.000000000 -0700
> @@ -128,8 +128,10 @@ static __inline__ int get_order(unsigned
>  #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
>  #define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
>  #define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
> -#define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
> -#define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
> +#define __boot_pa(x)		((unsigned long)(x)-PAGE_OFFSET)
> +#define __boot_va(x)		((void *)((unsigned long)(x)+PAGE_OFFSET))
> +#define __pa(x)			__boot_pa(x)
> +#define __va(x)			__boot_va(x)
>  #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
>  #ifndef CONFIG_DISCONTIGMEM
>  #define pfn_to_page(pfn)	(mem_map + (pfn))

