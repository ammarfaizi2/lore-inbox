Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVBHW1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVBHW1L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 17:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVBHW1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 17:27:10 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:6855 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261532AbVBHW1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 17:27:03 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] swsusp: do not use higher order allocations on resume [update 2]
Date: Tue, 8 Feb 2005 23:28:00 +0100
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Hu Gang <hugang@soulinfo.com>
References: <200501310019.39526.rjw@sisk.pl> <200502081929.19503.rjw@sisk.pl> <20050208191001.GB2544@elf.ucw.cz>
In-Reply-To: <20050208191001.GB2544@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502082328.00937.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 8 of February 2005 20:10, Pavel Machek wrote:
> Hi!
> 
> > > so it is okay, but... 
> > 
> > ... I could have done it more elegantly.  You're right, I've now introduced
> > a function eat_page() that adds a page to the list of unusable pages and
> > used it instead of the free_page() here.
> 
> Thanks.
> 
> > > > +		p = pbe;
> > > > +		pbe += PB_PAGE_SKIP;
> > > > +		do
> > > > +			p->next = p + 1;
> > > > +		while (p++ < pbe);
> > > 
> > > I've already seen this code somewhere around in different
> > > variant... Perhaps you want to make it inline function?
> > 
> > I tried to avoid modifying the suspend part, but if it's not a problem,
> > why don't we go farther and reuse alloc_pagedir() in the resume code?
> > 
> > It has the advantage that read_pagedir() is then much simpler, and it
> > returns an integer.  However, for this purpose, it's better to split
> > alloc_pagedir() into two functions, one of which allocates memory pages,
> > and the second puts the list structure on them.
> 
> I guess that modifying suspend part is okay. We do not want to have
> two copies of similar code...
> 
> > > > +	if(!(pagedir_nosave = swsusp_pagedir_relocate(p)))
> > > > +		return -ENOMEM;
> > > 
> > > Same here.
> > 
> > The value is used in error reporting and the only reason why this function
> > may fail is the lack of memory (the same applies to alloc_pagedir()).
> > 
> > The revised (not as thoroughly tested as the previous one, but hopefully
> > nicer) patch follows.
> 
> I guess I'll wait for "reuse alloc_pagedir" version.

It's this one. :-)

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
