Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWHZQJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWHZQJo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 12:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWHZQJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 12:09:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42960 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030222AbWHZQJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 12:09:43 -0400
Subject: Re: 2.6.18 Headers - Long
From: David Woodhouse <dwmw2@infradead.org>
To: Jim Gifford <maillist@jg555.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org
In-Reply-To: <1152836749.31372.36.camel@shinybook.infradead.org>
References: <44B443D2.4070600@jg555.com>
	 <1152836749.31372.36.camel@shinybook.infradead.org>
Content-Type: text/plain
Date: Sat, 26 Aug 2006 17:09:20 +0100
Message-Id: <1156608560.3012.112.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 01:25 +0100, David Woodhouse wrote:
> On Tue, 2006-07-11 at 17:35 -0700, Jim Gifford wrote:
> > I will only document one issue, but there are several more like this
> > in the kernel.
> 
> Please elaborate, preferably in 'diff -u' form as below...

Got any more, Jim?

> > I'm going to use the MIPS architecture in my example, along with the 
> > file page.h. 

Ralf, you haven't applied this yet AFAICT...

> [PATCH] Reduce user-visible noise in asm-mips/page.h
> 
> Since PAGE_SIZE is variable according to configuration options, don't
> expose it to userspace. Userspace should be using sysconf(_SC_PAGE_SIZE)
> instead. Move some other noise inside __KERNEL__ too while we're at it.
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> 
> diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
> index 6ed1151..ee2ef88 100644
> --- a/include/asm-mips/page.h
> +++ b/include/asm-mips/page.h
> @@ -14,8 +14,6 @@ #ifdef __KERNEL__
>  
>  #include <spaces.h>
>  
> -#endif
> -
>  /*
>   * PAGE_SHIFT determines the page size
>   */
> @@ -35,7 +33,6 @@ #define PAGE_SIZE	(1UL << PAGE_SHIFT)
>  #define PAGE_MASK       (~((1 << PAGE_SHIFT) - 1))
>  
> 
> -#ifdef __KERNEL__
>  #ifndef __ASSEMBLY__
>  
>  extern void clear_page(void * page);
> @@ -168,7 +165,6 @@ #define VM_DATA_DEFAULT_FLAGS	(VM_READ |
>  #define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE)
>  #define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET)
>  
> -#endif /* defined (__KERNEL__) */
>  
>  #ifdef CONFIG_LIMITED_DMA
>  #define WANT_PAGE_VIRTUAL
> @@ -177,4 +173,6 @@ #endif
>  #include <asm-generic/memory_model.h>
>  #include <asm-generic/page.h>
>  
> +#endif /* defined (__KERNEL__) */
> +
>  #endif /* _ASM_PAGE_H */
> 
> 
-- 
dwmw2

