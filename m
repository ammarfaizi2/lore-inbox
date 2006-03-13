Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWCMKMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWCMKMu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 05:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWCMKMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 05:12:50 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19406 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751206AbWCMKMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 05:12:49 -0500
Date: Mon, 13 Mar 2006 11:12:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: Faster resuming of suspend technology.
Message-ID: <20060313101214.GB2136@elf.ucw.cz>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060312213228.GA27693@rhlx01.fht-esslingen.de> <200603130930.11800.kernel@kolivas.org> <200603131144.01462.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603131144.01462.ncunningham@cyclades.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 13-03-06 11:43:55, Nigel Cunningham wrote:
> Hi.
> 
> On Monday 13 March 2006 08:30, Con Kolivas wrote:
> > On Monday 13 March 2006 08:32, Andreas Mohr wrote:
> > > And... well... this sounds to me exactly like a prime task
> > > for the newish swap prefetch work, no need for any other
> > > special solutions here, I think.
> > > We probably want a new flag for swap prefetch to let it know
> > > that we just resumed from software suspend and thus need
> > > prefetching to happen *much* faster than under normal
> > > conditions for a short while, though (most likely by
> > > enabling prefetching on a *non-idle* system for a minute).
> >
> > Adding a resume_swap_prefetch() called just before the resume finishes that
> > aggressively prefetches from swap would be easy. Please tell me if you
> > think adding such a function would be worthwhile.
> 
> My 2c would be that swsusp is broken in a number of ways in discarding those 
> pages in the first place:

Yep, feel free to submit a patch.

> - Forcing pages out to swap by vm pressure is an inefficient way of writing 
> the pages.

Really? VM subsystem is supposed to be effective.

> - It doesn't get the pages compressed, and so makes inefficient use of the 
> storage and forces more pages to be discarded that would otherwise be 
> necessary.

"more pages to be discarded" is untrue. If you want to argue that swap
needs to be compressed, feel free to submit patches for swap
compression.

(Compression is actually not as important as you paint it. Rafael
implemented it, only to find out that it is 20 percent speedup in
common cases -- and your gzip actually slows things down.)

> - Bringing the pages back in by swap prefetching or swapoffing or whatever is 
> equally inefficient (I was going to say 'particularly in low memory 
> situations', but immediately ate my words as I remembered that if you've just 
> swsusp'd, you've freed at least half of memory anyway).

...but allows you to use machine immediately after resume, which
people want, as you have just seen.

> - This technique doesn't guarantee that the pages you end up with in memory 
> are the pages that you're actually most likely to want. The vast majority of 
> what you really want will simply have been discarded rather than swapped.
> 
> Having said that, Rafael is making some progress in these areas, such that 
> swsusp is eating less memory than it used to, so that swap prefetching will 
> be less important at resume time than it has been in the past.
> 
> Hope this helps.
> 
> Nigel



-- 
37:
