Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVAAKZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVAAKZY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 05:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbVAAKZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 05:25:24 -0500
Received: from witte.sonytel.be ([80.88.33.193]:8897 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261365AbVAAKZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 05:25:14 -0500
Date: Sat, 1 Jan 2005 11:24:43 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Lameter <clameter@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, linux-mm@kvack.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Prezeroing V2 [2/4]: add second parameter to clear_page() for
 all arches
In-Reply-To: <Pine.LNX.4.58.0412231133130.31791@schroedinger.engr.sgi.com>
Message-ID: <Pine.GSO.4.61.0501011123550.27452@waterleaf.sonytel.be>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
 <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231133130.31791@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2004, Christoph Lameter wrote:
> o Extend clear_page to take an order parameter for all architectures.

> Index: linux-2.6.9/include/asm-m68k/page.h
> ===================================================================
> --- linux-2.6.9.orig/include/asm-m68k/page.h	2004-10-18 14:55:36.000000000 -0700
> +++ linux-2.6.9/include/asm-m68k/page.h	2004-12-23 07:44:14.000000000 -0800
> @@ -50,7 +50,7 @@
>  		       );
>  }
> 
> -static inline void clear_page(void *page)
> +static inline void clear_page(void *page, int order)
>  {
>  	unsigned long tmp;
>  	unsigned long *sp = page;
> @@ -69,16 +69,16 @@
>  			     "dbra   %1,1b\n\t"
>  			     : "=a" (sp), "=d" (tmp)
>  			     : "a" (page), "0" (sp),
> -			       "1" ((PAGE_SIZE - 16) / 16 - 1));
> +			       "1" (((PAGE_SIZE<<(order)) - 16) / 16 - 1));
>  }
> 
>  #else
> -#define clear_page(page)	memset((page), 0, PAGE_SIZE)
> +#define clear_page(page, 0)	memset((page), 0, PAGE_SIZE << (order))
                            ^
			    order

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
