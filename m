Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266846AbUGLOYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266846AbUGLOYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 10:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUGLOYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 10:24:10 -0400
Received: from witte.sonytel.be ([80.88.33.193]:54008 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266847AbUGLOYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 10:24:04 -0400
Date: Mon, 12 Jul 2004 16:23:51 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andy Whitcroft <apw@shadowen.org>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: is_highmem() and WANT_PAGE_VIRTUAL (was: Re: Linux 2.6.8-rc1)
In-Reply-To: <200407121351.i6CDplLM031827@voidhawk.shadowen.org>
Message-ID: <Pine.GSO.4.58.0407121623240.17199@waterleaf.sonytel.be>
References: <200407121351.i6CDplLM031827@voidhawk.shadowen.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004, Andy Whitcroft wrote:
> --- Geert wrote:
> > | --- reference/mm/page_alloc.c	2004-07-07 18:08:56.000000000 +0100
> > | +++ current/mm/page_alloc.c	2004-07-07 18:10:15.000000000 +0100
> > | @@ -1421,7 +1421,7 @@ void __init memmap_init_zone(struct page
> > |  		INIT_LIST_HEAD(&page->lru);
> > |  #ifdef WANT_PAGE_VIRTUAL
> > |  		/* The shift won't overflow because ZONE_NORMAL is below 4G. */
> > | -		if (zone != ZONE_HIGHMEM)
> > | +		if (!is_highmem(zone))
> > |  			set_page_address(page, __va(start_pfn << PAGE_SHIFT));
> > |  #endif
> > |  		start_pfn++;
> >
> > The above change is incorrect, since zone is an unsigned long, while
> > is_highmem() takes a struct zone *.
>
> My bad.  I was stupidly assuming that this was used then ZONE_HIGHMEM was
> not enabled.  This should apply on top of 2.6.8-rc1 and repair the damage.
>
> -apw
>
> === 8< ===
> Should be applying is_highmem() to a zone.

I can confirm this patch fixes compilation.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
