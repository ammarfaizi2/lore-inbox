Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWIORfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWIORfo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 13:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWIORfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 13:35:44 -0400
Received: from tinc.cathedrallabs.org ([72.9.252.66]:50593 "EHLO
	tinc.cathedrallabs.org") by vger.kernel.org with ESMTP
	id S1750776AbWIORfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 13:35:43 -0400
Date: Fri, 15 Sep 2006 14:33:22 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [-mm patch] add missing page_copy export for ppc and powerpc (was Re: cachefiles on latest -mm fails to build on powerpc)
Message-ID: <20060915173321.GD8098@cathedrallabs.org>
References: <20060915173546.GE2876@slug> <20060915123132.GA4817@cathedrallabs.org> <20060915155023.GC2876@slug> <20060915151724.GA8098@cathedrallabs.org> <5069.1158334773@warthog.cambridge.redhat.com> <20060915175856.GF2876@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060915175856.GF2876@slug>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Pyzor-Results: Reported 0 times.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oops, thanks, here's a corrected patch. From a quick look, it seems that
> the ppc needs the same kind of export.
> This adds a missing copy_page export for the powerpc and ppc arches.
this last patch solves the problem
> 
> Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>
Acked-by: Aristeu S. Rozanski F. <aris@cathedrallabs.org>

> diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
> index 39d3bfc..23ccd5d 100644
> --- a/arch/powerpc/kernel/ppc_ksyms.c
> +++ b/arch/powerpc/kernel/ppc_ksyms.c
> @@ -93,6 +93,12 @@ EXPORT_SYMBOL(__strncpy_from_user);
>  EXPORT_SYMBOL(__strnlen_user);
>  
>  #ifndef  __powerpc64__
> +EXPORT_SYMBOL(copy_page);
> +#else
> +EXPORT_SYMBOL(copy_4K_page);
> +#endif
> +
> +#ifndef  __powerpc64__
>  EXPORT_SYMBOL(__ide_mm_insl);
>  EXPORT_SYMBOL(__ide_mm_outsw);
>  EXPORT_SYMBOL(__ide_mm_insw);
> diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
> index d173540..3045cc3 100644
> --- a/arch/ppc/kernel/ppc_ksyms.c
> +++ b/arch/ppc/kernel/ppc_ksyms.c
> @@ -106,6 +106,8 @@ EXPORT_SYMBOL(__clear_user);
>  EXPORT_SYMBOL(__strncpy_from_user);
>  EXPORT_SYMBOL(__strnlen_user);
>  
> +EXPORT_SYMBOL(copy_page);
> +
>  /*
>  EXPORT_SYMBOL(inb);
>  EXPORT_SYMBOL(inw);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Aristeu

