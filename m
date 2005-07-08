Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262839AbVGHUeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbVGHUeu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVGHUdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:33:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44699 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262840AbVGHUab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:30:31 -0400
Date: Fri, 8 Jul 2005 13:31:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  implicit declaration of function `page_cache_release'
Message-Id: <20050708133127.302cbafe.akpm@osdl.org>
In-Reply-To: <20050708150313.GA30373@suse.de>
References: <20050708150313.GA30373@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> wrote:
>
> 
> In file included from include2/asm/tlb.h:31,
>                  from linux-2.6.13-rc2-olh/arch/ppc64/kernel/pSeries_lpar.c:37:
> linux-2.6.13-rc2-olh/include/asm-generic/tlb.h: In function `tlb_flush_mmu':
> linux-2.6.13-rc2-olh/include/asm-generic/tlb.h:77: warning: implicit declaration of function `release_pages'
> linux-2.6.13-rc2-olh/include/asm-generic/tlb.h: In function `tlb_remove_page':
> linux-2.6.13-rc2-olh/include/asm-generic/tlb.h:117: warning: implicit declaration of function `page_cache_release'
> 
> Signed-off-by: Olaf Hering <olh@suse.de>
> 
>  include/linux/pagemap.h |    2 +-
>  include/linux/swap.h    |    1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.13-rc2-olh/include/linux/pagemap.h
> ===================================================================
> --- linux-2.6.13-rc2-olh.orig/include/linux/pagemap.h
> +++ linux-2.6.13-rc2-olh/include/linux/pagemap.h
> @@ -48,7 +48,7 @@ static inline void mapping_set_gfp_mask(
>  
>  #define page_cache_get(page)		get_page(page)
>  #define page_cache_release(page)	put_page(page)
> -void release_pages(struct page **pages, int nr, int cold);
> +extern void release_pages(struct page **pages, int nr, int cold);

Why this change?  I think that was just me saving disk space.

>  static inline struct page *page_cache_alloc(struct address_space *x)
>  {
> Index: linux-2.6.13-rc2-olh/include/linux/swap.h
> ===================================================================
> --- linux-2.6.13-rc2-olh.orig/include/linux/swap.h
> +++ linux-2.6.13-rc2-olh/include/linux/swap.h
> @@ -7,6 +7,7 @@
>  #include <linux/mmzone.h>
>  #include <linux/list.h>
>  #include <linux/sched.h>
> +#include <linux/pagemap.h>
>  #include <asm/atomic.h>
>  #include <asm/page.h>
>

Yup.
