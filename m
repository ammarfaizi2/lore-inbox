Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263074AbVHESxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263074AbVHESxM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbVHESwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:52:37 -0400
Received: from nproxy.gmail.com ([64.233.182.201]:46141 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263088AbVHESvz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:51:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hHugt4nY8LLW/0JoXN10NqqceM4BfdNxTCSJb712XdnrfFdJ4rKzATSpvOBv0yauwAKHK/1576i8fbH/Z7okg+hQFxLbPoL5CidVxnF6pXKlFavivZiUWHDLky03Yjcp6XCs3u0QbwC0k6uq+Vte5zphEdRINv44puKAmLRq08g=
Message-ID: <40f323d005080511516a81a7d6@mail.gmail.com>
Date: Fri, 5 Aug 2005 20:51:51 +0200
From: Benoit Boissinot <bboissin@gmail.com>
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] implicit declaration of function `page_cache_release'
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050708150313.GA30373@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050708150313.GA30373@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/05, Olaf Hering <olh@suse.de> wrote:
> 
> In file included from include2/asm/tlb.h:31,
>                  from linux-2.6.13-rc2-olh/arch/ppc64/kernel/pSeries_lpar.c:37:
> linux-2.6.13-rc2-olh/include/asm-generic/tlb.h: In function `tlb_flush_mmu':
> linux-2.6.13-rc2-olh/include/asm-generic/tlb.h:77: warning: implicit declaration of function `release_pages'
> linux-2.6.13-rc2-olh/include/asm-generic/tlb.h: In function `tlb_remove_page':
> linux-2.6.13-rc2-olh/include/asm-generic/tlb.h:117: warning: implicit declaration of function `page_cache_release'
> 
This went in 2.6.13-rc3 (commit
542d1c88bd7f73e2e59d41b12e4a9041deea89e4), and broke sparc compilation
because of the following circular dependency:
asm-sparc/pgtable include linux/swap.h
linux/swap.h include now linux/pagemap.h
linux/pagemap.h include linux/mm.h
linux/mm.h include asm/pgtable.h

I haven't found a satisfactory way to resolve this, but i think the
patch should be removed (it removes a warning but breaks an
architecture).

Regards,

Benoit Boissinot

> Index: linux-2.6.13-rc2-olh/include/linux/pagemap.h
>  ===================================================================
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
