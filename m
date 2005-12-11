Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbVLKX2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVLKX2Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 18:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbVLKX2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 18:28:25 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57263 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750914AbVLKX2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 18:28:25 -0500
Date: Mon, 12 Dec 2005 00:28:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, adi@hexapodia.org,
       linux-kernel@vger.kernel.org
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-ID: <20051211232805.GC5982@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org> <200512110007.35346.rjw@sisk.pl> <20051210153306.02377935.akpm@osdl.org> <200512111316.47153.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512111316.47153.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >  Would that be ok if I made drop_pagecache() nonstatic and called it directly
> > >  from swsusp?
> > 
> > Sure, I'll updates the patch for that.
> 
> Thanks a lot.
>  
> > It changed a bit..  You'll need to run sys_sync() then drop_pagecache()
> > then drop_slab().
> 
> I think it won't hurt if we do this unconditionally in swsusp_shrink_memory().
> Pavel, what do you think?
> 
> The appended patch illustrates the way in which I think we can use this.
> I've tested it a little, but if someone feels like trying it, please
 >  do.

Not sure, do we really want to drop all the pagecache? We want to free
memory that is not going to be used soon after suspend, but I guess
pagecache can be quite "hot".

I'd certainly wait with this until code settles. And at least trying
if it helps or hurts...
								Pavel

-- 
Thanks, Sharp!
