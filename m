Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266802AbUGLLaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266802AbUGLLaj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 07:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266803AbUGLLaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 07:30:39 -0400
Received: from witte.sonytel.be ([80.88.33.193]:27094 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266802AbUGLLaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 07:30:24 -0400
Date: Mon, 12 Jul 2004 13:30:17 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: is_highmem() and WANT_PAGE_VIRTUAL (was: Re: Linux 2.6.8-rc1)
In-Reply-To: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
Message-ID: <Pine.GSO.4.58.0407121326410.17199@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jul 2004, Linus Torvalds wrote:
> Andy Whitcroft:
>   o convert uses of ZONE_HIGHMEM to is_highmem

| --- reference/mm/page_alloc.c	2004-07-07 18:08:56.000000000 +0100
| +++ current/mm/page_alloc.c	2004-07-07 18:10:15.000000000 +0100
| @@ -1421,7 +1421,7 @@ void __init memmap_init_zone(struct page
|  		INIT_LIST_HEAD(&page->lru);
|  #ifdef WANT_PAGE_VIRTUAL
|  		/* The shift won't overflow because ZONE_NORMAL is below 4G. */
| -		if (zone != ZONE_HIGHMEM)
| +		if (!is_highmem(zone))
|  			set_page_address(page, __va(start_pfn << PAGE_SHIFT));
|  #endif
|  		start_pfn++;

The above change is incorrect, since zone is an unsigned long, while
is_highmem() takes a struct zone *.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
