Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbULNVS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbULNVS7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 16:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbULNVS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 16:18:59 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:12553
	"EHLO mail.muru.com") by vger.kernel.org with ESMTP id S261664AbULNVSx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 16:18:53 -0500
Date: Tue, 14 Dec 2004 13:18:14 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@suse.cz>
Cc: john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: dynamic-hz
Message-ID: <20041214211814.GA31226@atomide.com>
References: <20041213002751.GP16322@dualathlon.random> <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com> <20041213112853.GS16322@dualathlon.random> <20041213124313.GB29426@atrey.karlin.mff.cuni.cz> <20041213125844.GY16322@dualathlon.random> <20041213191249.GB1052@elf.ucw.cz> <1102970039.1281.415.camel@cog.beaverton.ibm.com> <20041213204933.GA4693@elf.ucw.cz> <20041214013924.GB14617@atomide.com> <20041214093735.GA1063@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214093735.GA1063@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@suse.cz> [041214 01:38]:
> Hi!
> 
> > > > > > > But that does not matter, right? Yes, one-shot timer will not fire
> > > > > > > exactly at right place, but as long as you are reading TSC and basing
> > > > > > > next shot on current time, error should not accumulate.
> > > > > > 
> > > > > > As said in the rest of the message, the error (or some other error)
> > > > > > accumulates heavily today in the tick-loss compensation/adjustment
> > > > > > algorithm in arch/i386/kernel/timers/timer_tsc.c, so I'm sceptical
> > > > > > about
> > > > > 
> > > > > I do not see how it should accumulate. Lets have working TSC. You want
> > > > > to emulate fixed-period timer with single-shot timer.
> > > > 
> > > > Its caused by the fact that we don't use the the TSC to accumulate time.
> > > > We are instead interpolating between timer ticks and the TSC, where
> > > 
> > > Yes, it was supposed to be simple, so that Andrea understands that
> > > there's nothing inherently broken with single-shot timers.
> > 
> > Just a quick comment; The timer does not need to be single-shot 
> > all the time, it can be a combination of continuous and variable
> > length timer, and it can change depending on the system load.
> > 
> > We recently added VST support for OMAP in linux-omap bk tree, and 
> > made some changes to the previous VST implementations that might be
> > of interest:
> ...
> > The patch in question is at:
> > 
> > http://linux-omap.bkbits.net:8080/main/user=tmlind/patch@1.2016.4.18?nav=!-|index.html|stats|!+|index.html|ChangeSet@-12w|cset@1.2016.4.18
> 
> Wow, that's basically 8 lines of code plus driver for new
> hardware... Is it really that simple?

Yeah, the key things are reprogramming the timer in the idle loop
based on next_timer_interrupt(), and calling timer_interrupt from
other interrupts as well :)

Should we try a similar patch for x86/amd64? I'm not sure which timers
to use though? One should be programmable length for the interrupt, 
and the other continuous for the timekeeping.

BTW, looks like my upgraded mail server is still a bit messed up, and
my original post did not make it to the list. But most of the message
is quoted above anyways. Here's the link to the patch again as
tinyurl:

http://tinyurl.com/69n4k

Tony
