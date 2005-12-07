Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVLGMAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVLGMAI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 07:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbVLGMAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 07:00:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3224 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750755AbVLGMAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 07:00:07 -0500
Date: Wed, 7 Dec 2005 12:59:52 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andy Isaacson <adi@hexapodia.org>, linux-kernel@vger.kernel.org
Subject: Re: swsusp: how much memory to free? [was Re: swsusp performance problems in 2.6.15-rc3-mm1]
Message-ID: <20051207115952.GF2563@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org> <200512052218.18769.rjw@sisk.pl> <20051205235501.GC1770@elf.ucw.cz> <200512071253.54055.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512071253.54055.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > OTOH, we can get similar result by just making the kernel free some
> > > more memory _after_ we are sure we have enough memory to suspend.
> > > IOW, after the code that's currently in swsusp_shrink_memory() has finished,
> > > we can try to free some "extra" memory to improve performance, if
> > > needed.  The question is how much "extra" memory should be freed and
> > > I'm afraid it will have to be tuned on the per-system, or at least
> > > per-RAM-size, basis.
> > 
> > I'd prefer not to have extra tunables. "Write only 500MB" will work
> > okay for common desktop users -- as long as common desktop fits into
> > 500MB, that is. "Free not used in last 10 minutes" should work okay
> > for everyone, but may be slightly harder to implement.
> 
> Still, it can be done with a fairly small patch that has an additional
> advantage, as it allows us to get rid of the FAST_FREE constant
> which I don't like.  Appended (untested).

Looks good to me.

> Index: linux-2.6.15-rc5-mm1/kernel/power/swsusp.c
> ===================================================================
> --- linux-2.6.15-rc5-mm1.orig/kernel/power/swsusp.c	2005-12-05 22:07:12.000000000 +0100
> +++ linux-2.6.15-rc5-mm1/kernel/power/swsusp.c	2005-12-07 12:40:27.000000000 +0100
> @@ -626,6 +626,7 @@
>  
>  int swsusp_shrink_memory(void)
>  {
> +	unsigned long size;
>  	long tmp;

Perhaps both should be long, or both unsigned long?

								Pavel
-- 
Thanks, Sharp!
