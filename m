Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVBHTK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVBHTK2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 14:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVBHTK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 14:10:27 -0500
Received: from gprs215-10.eurotel.cz ([160.218.215.10]:12210 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261632AbVBHTKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 14:10:19 -0500
Date: Tue, 8 Feb 2005 20:10:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Hu Gang <hugang@soulinfo.com>
Subject: Re: [RFC][PATCH] swsusp: do not use higher order allocations on resume [update 2]
Message-ID: <20050208191001.GB2544@elf.ucw.cz>
References: <200501310019.39526.rjw@sisk.pl> <200502071208.50001.rjw@sisk.pl> <20050207162316.GA8299@elf.ucw.cz> <200502081929.19503.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502081929.19503.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > so it is okay, but... 
> 
> ... I could have done it more elegantly.  You're right, I've now introduced
> a function eat_page() that adds a page to the list of unusable pages and
> used it instead of the free_page() here.

Thanks.

> > > +		p = pbe;
> > > +		pbe += PB_PAGE_SKIP;
> > > +		do
> > > +			p->next = p + 1;
> > > +		while (p++ < pbe);
> > 
> > I've already seen this code somewhere around in different
> > variant... Perhaps you want to make it inline function?
> 
> I tried to avoid modifying the suspend part, but if it's not a problem,
> why don't we go farther and reuse alloc_pagedir() in the resume code?
> 
> It has the advantage that read_pagedir() is then much simpler, and it
> returns an integer.  However, for this purpose, it's better to split
> alloc_pagedir() into two functions, one of which allocates memory pages,
> and the second puts the list structure on them.

I guess that modifying suspend part is okay. We do not want to have
two copies of similar code...

> > > +	if(!(pagedir_nosave = swsusp_pagedir_relocate(p)))
> > > +		return -ENOMEM;
> > 
> > Same here.
> 
> The value is used in error reporting and the only reason why this function
> may fail is the lack of memory (the same applies to alloc_pagedir()).
> 
> The revised (not as thoroughly tested as the previous one, but hopefully
> nicer) patch follows.

I guess I'll wait for "reuse alloc_pagedir" version.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
