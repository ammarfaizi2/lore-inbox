Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbULNXHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbULNXHC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 18:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbULNXFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 18:05:37 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:37641
	"EHLO mail.muru.com") by vger.kernel.org with ESMTP id S261748AbULNXFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:05:03 -0500
Date: Tue, 14 Dec 2004 15:04:48 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@suse.cz>
Cc: john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: dynamic-hz
Message-ID: <20041214230448.GC31226@atomide.com>
References: <20041213112853.GS16322@dualathlon.random> <20041213124313.GB29426@atrey.karlin.mff.cuni.cz> <20041213125844.GY16322@dualathlon.random> <20041213191249.GB1052@elf.ucw.cz> <1102970039.1281.415.camel@cog.beaverton.ibm.com> <20041213204933.GA4693@elf.ucw.cz> <20041214013924.GB14617@atomide.com> <20041214093735.GA1063@elf.ucw.cz> <20041214211814.GA31226@atomide.com> <20041214220646.GC19218@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214220646.GC19218@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@suse.cz> [041214 14:07]:
> Hi!
> 
> > > > The patch in question is at:
> > > > 
> > > > http://linux-omap.bkbits.net:8080/main/user=tmlind/patch@1.2016.4.18?nav=!-|index.html|stats|!+|index.html|ChangeSet@-12w|cset@1.2016.4.18
> > > 
> > > Wow, that's basically 8 lines of code plus driver for new
> > > hardware... Is it really that simple?
> > 
> > Yeah, the key things are reprogramming the timer in the idle loop
> > based on next_timer_interrupt(), and calling timer_interrupt from
> > other interrupts as well :)
> > 
> > Should we try a similar patch for x86/amd64? I'm not sure which timers
> > to use though? One should be programmable length for the interrupt, 
> > and the other continuous for the timekeeping.
> 
> Yes, it would certainly be interesting. 5% power savings, and no
> singing capacitors, while keeping HZ=1000. Sounds good to me.
> 
> There are about 1000 timers available in PC, each having its own
> quirks. CMOS clock should be able to generate 1024Hz periodic timer
> (we currently do not use) and TSC we currently use for periodic timer
> should be usable in single-shot mode.

I guess you mean to use the CMOS clock for continuous timer, and TSC
for periodic timer?

OK, I'll take a look at it later this week or over the weekend.

Haven't looked at the x86 timer code for a while, but I think
I'll set up a new clock where we can just register a timer update
function and a periodic tick function. That way we can easily use 
whatever hardware timers are available.

Tony
