Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261352AbSKBUPk>; Sat, 2 Nov 2002 15:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSKBUPk>; Sat, 2 Nov 2002 15:15:40 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12048 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261352AbSKBUPj>; Sat, 2 Nov 2002 15:15:39 -0500
Date: Sat, 2 Nov 2002 21:22:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: William Lee Irwin III <wli@holomorphy.com>, akpm@zip.com.au,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Hot/cold allocation -- swsusp can not handle hot pages
Message-ID: <20021102202208.GC18576@atrey.karlin.mff.cuni.cz>
References: <20021102181900.GA140@elf.ucw.cz> <20021102184612.GI23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021102184612.GI23425@holomorphy.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Swsusp counts free pages, and relies on fact that when it allocates
> > page there's one free page less. That is no longer true with hot
> > pages.
> > I attempted to work it around but it seems I am getting hot pages even
> > when I ask for cold one. This seems to fix it. Does it looks like
> > "possibly mergable" patch?
> > --- clean/mm/page_alloc.c	2002-11-01 00:37:44.000000000 +0100
> > +++ linux-swsusp/mm/page_alloc.c	2002-11-01 22:53:47.000000000 +0100
> > @@ -361,7 +361,7 @@
> >  	unsigned long flags;
> >  	struct page *page = NULL;
> >  
> > -	if (order == 0) {
> > +	if ((order == 0) && !cold) {
> >  		struct per_cpu_pages *pcp;
> >  
> >  		pcp = &zone->pageset[get_cpu()].pcp[cold];
> > 
> 
> This doesn't seem to be doing what you want, even if it seems to work.
> If you want there to be one free page less, then allocating it will
> work regardless. What are you looking for besides that? If it's not
> already working you want some additional semantics. Could this involve
> is_head_of_free_region()? That should be solvable with a per-cpu list
> shootdown algorithm to fully merge all the buddy bitmap things.

I need pages I allocate to disappear from "is_head_of_free_region()",
so my counts match.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
