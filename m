Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbVKNWFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbVKNWFx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 17:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVKNWFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 17:05:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1262 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751274AbVKNWFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 17:05:52 -0500
Date: Mon, 14 Nov 2005 23:05:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: More cleanups for sharpsl_pm.c
Message-ID: <20051114220536.GC13830@elf.ucw.cz>
References: <20051110235614.GA21337@elf.ucw.cz> <1131838003.7597.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131838003.7597.49.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > sharpsl.c uses macros to hide method calls, in quite a confusing
> > way. This just inlines the macros, so it is easy to see what is going
> > on.
> 
> I'm not totally convinced this makes it easier to read. To me,
> CHARGE_ON(); is more readable than sharpsl_pm.machinfo->charge(1);. Yes,
> you need to look up what the macro does but the names give a fairly good
> idea.

I'm quite convinced it is easier to read...

> ALso, keeping the macros means when I implement the LED trigger for
> charging, I don't have to edit every function in sharpsl_pm but can just
> tweak the header and add an extra level of LED functions. Given that,
> I'd prefer to leave these as they are for now.

...but if this code still changes rapidly, it can probably wait.

> > +/* FIXME:
> > +   why not simply get_percentage, and base it off that?
> > +*/
> >  	if (sharpsl_pm.charge_mode == CHRG_ON) {
> >  		high_thresh = sharpsl_pm.machinfo->status_high_acin;
> >  		low_thresh = sharpsl_pm.machinfo->status_low_acin;
> 
> The percentage curves is likely to change in the future and I doubt
> anyone would remember to update these values. I'd therefore prefer for
> them to be independent of the lookup table.

Well, apm status is not quite critical, right? And if 5% is remaining,
it *is* low battery; if that gets more precise over time, that is
okay.
								Pavel
-- 
Thanks, Sharp!
