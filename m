Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268254AbUHFTj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268254AbUHFTj4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268259AbUHFTjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:39:02 -0400
Received: from gprs214-146.eurotel.cz ([160.218.214.146]:43136 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268256AbUHFTgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:36:44 -0400
Date: Fri, 6 Aug 2004 21:36:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [6/25] Merge pmdisk and swsusp
Message-ID: <20040806193627.GJ3048@elf.ucw.cz>
References: <Pine.LNX.4.50.0407171528280.22290-100000@monsoon.he.net> <20040718221302.GC31958@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.50.0408012020200.30101-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0408012020200.30101-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +/**
> > > + *	enough_free_mem - Make sure we enough free memory to snapshot.
> > > + *
> > > + *	Returns TRUE or FALSE after checking the number of available
> > > + *	free pages.
> > > + */
> > > +
> > > +static int enough_free_mem(void)
> > > +{
> > > +	if(nr_free_pages() < (nr_copy_pages + PAGES_FOR_IO)) {
> > > +		pr_debug("pmdisk: Not enough free pages: Have %d\n",
> > > +			 nr_free_pages());
> > > +		return 0;
> > > +	}
> > > +	return 1;
> > > +}
> 
> > Perhaps enough_free_* should return 0 / -ERROR to keep it consistent
> > with rest of code, no need to explain TRUE/FALSE etc?
> 
> Well, then they wouldn't read like plain language..

Hmm, it would probably need to be called check_free_mem...

> Besides, they're superfluous and racy anyway - the amount of memory and
> swap space free could change at any time, so we should just remove them
> and make sure our error handlin is correct later down the line when
> allocations fail..

I do not think this is doable. ... ... .. 

Yes, it probably is doable. We should mark ourselves as some kind of
"memory cleaning thread" so we get errors instead of deadlock when we
run out of memory while writing pages, and then we just need to handle
that errors, carefully. Ok.
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
