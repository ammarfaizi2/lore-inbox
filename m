Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbULNJiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbULNJiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 04:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbULNJiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 04:38:09 -0500
Received: from gprs214-98.eurotel.cz ([160.218.214.98]:21376 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261465AbULNJiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 04:38:04 -0500
Date: Tue, 14 Dec 2004 10:37:35 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: dynamic-hz
Message-ID: <20041214093735.GA1063@elf.ucw.cz>
References: <cone.1102897095.171542.10669.502@pc.kolivas.org> <20041213002751.GP16322@dualathlon.random> <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com> <20041213112853.GS16322@dualathlon.random> <20041213124313.GB29426@atrey.karlin.mff.cuni.cz> <20041213125844.GY16322@dualathlon.random> <20041213191249.GB1052@elf.ucw.cz> <1102970039.1281.415.camel@cog.beaverton.ibm.com> <20041213204933.GA4693@elf.ucw.cz> <20041214013924.GB14617@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214013924.GB14617@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > > But that does not matter, right? Yes, one-shot timer will not fire
> > > > > > exactly at right place, but as long as you are reading TSC and basing
> > > > > > next shot on current time, error should not accumulate.
> > > > > 
> > > > > As said in the rest of the message, the error (or some other error)
> > > > > accumulates heavily today in the tick-loss compensation/adjustment
> > > > > algorithm in arch/i386/kernel/timers/timer_tsc.c, so I'm sceptical
> > > > > about
> > > > 
> > > > I do not see how it should accumulate. Lets have working TSC. You want
> > > > to emulate fixed-period timer with single-shot timer.
> > > 
> > > Its caused by the fact that we don't use the the TSC to accumulate time.
> > > We are instead interpolating between timer ticks and the TSC, where
> > 
> > Yes, it was supposed to be simple, so that Andrea understands that
> > there's nothing inherently broken with single-shot timers.
> 
> Just a quick comment; The timer does not need to be single-shot 
> all the time, it can be a combination of continuous and variable
> length timer, and it can change depending on the system load.
> 
> We recently added VST support for OMAP in linux-omap bk tree, and 
> made some changes to the previous VST implementations that might be
> of interest:
...
> The patch in question is at:
> 
> http://linux-omap.bkbits.net:8080/main/user=tmlind/patch@1.2016.4.18?nav=!-|index.html|stats|!+|index.html|ChangeSet@-12w|cset@1.2016.4.18

Wow, that's basically 8 lines of code plus driver for new
hardware... Is it really that simple?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
