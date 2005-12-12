Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVLLRoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVLLRoO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 12:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVLLRoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 12:44:14 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:19674 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750798AbVLLRoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 12:44:14 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Date: Mon, 12 Dec 2005 18:45:33 +0100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>, adi@hexapodia.org,
       linux-kernel@vger.kernel.org
References: <20051205081935.GI22168@hexapodia.org> <200512111316.47153.rjw@sisk.pl> <20051211232805.GC5982@elf.ucw.cz>
In-Reply-To: <20051211232805.GC5982@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512121845.34151.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 12 December 2005 00:28, Pavel Machek wrote:
> > > >  Would that be ok if I made drop_pagecache() nonstatic and called it directly
> > > >  from swsusp?
> > > 
> > > Sure, I'll updates the patch for that.
> > 
> > Thanks a lot.
> >  
> > > It changed a bit..  You'll need to run sys_sync() then drop_pagecache()
> > > then drop_slab().
> > 
> > I think it won't hurt if we do this unconditionally in swsusp_shrink_memory().
> > Pavel, what do you think?
> > 
> > The appended patch illustrates the way in which I think we can use this.
> > I've tested it a little, but if someone feels like trying it, please
>  >  do.
> 
> Not sure, do we really want to drop all the pagecache? We want to free
> memory that is not going to be used soon after suspend, but I guess
> pagecache can be quite "hot".
> 
> I'd certainly wait with this until code settles. And at least trying
> if it helps or hurts...

Sure.  Today it caused my box to stuck in the idle process. ;-)  OTOH,
performance-wise it does not seem to hurt.

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
