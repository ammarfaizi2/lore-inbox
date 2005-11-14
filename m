Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbVKNRl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVKNRl7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 12:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVKNRl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 12:41:58 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:50100 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751208AbVKNRl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 12:41:58 -0500
Subject: Re: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B10)
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200511131153.25978.ak@suse.de>
References: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>
	 <p73lkzt49wr.fsf@verdi.suse.de> <20051113073228.GA31468@elte.hu>
	 <200511131153.25978.ak@suse.de>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 09:41:51 -0800
Message-Id: <1131990111.3928.27.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-13 at 11:53 +0100, Andi Kleen wrote:
> On Sunday 13 November 2005 08:32, Ingo Molnar wrote:
> 
> > there are 3 "generic" components needed right now to clean up all time 
> > related stuff: GTOD, ktimers and clockevents. [you know the first two, 
> > and clockevents is new code from Thomas Gleixner that generalizes timer 
> > interrupts and introduces one compact notion for 'clock chips'.]
> 
> Both noidletick and the per cpu gettimeofday change significantly
> how timer interrupts work. I hope your generalizations will be still
> compatible to that. It's a bit dangerous to generalize
> before things have their final shape. 

The separation of timekeeing from the timer tick is one of the core
design goals here. This allows timer ticks to be modulated without
affecting timekeeping, so I expect this should simplify noidletick. I
know you've mentioned it before, but I don't think I've seen the
noidletick work on lkml. Do you have a link to this work, so I could
make sure the meshing is as nice as I hope it to be?

> Also vsyscalls make it all more difficult, because they don't map
> very well to any kind of "timer drivers". 

Again, it is a bit of complexity, but I feel I've resolved the issue
well. However, since it does require more care, specific feedback and
suggestions for improvements will be greatly welcomed.

> > what is the point? Ontop of these, a previously difficult feature, High 
> > Resolution Timers became _massively_ simpler. All of these patches exist 
> > together in the -rt tree, so it's not handwaving. The same will be the 
> > case for idle ticks / dynamic ticks [we started with HRT because it is 
> > so much harder than idle ticks]. So i do agree with you that GTOD needs 
> > more work, but it also makes time related features all that much easier.
> > 
> > right now it's GTOD that needs the most work before it can be merged 
> > upstream, so you picked the right one to criticise :-)
> 
> My point was basically that there is a lot of feature work going on
> on x86-64 in this area, and that has priority over  any "cleanups" like this 
> from my side. If it has settled again later maybe it can be generalized,
> or maybe not. I will only do it if it truly makes the code cleaner in the end,
> just lots of indirect pointers by itself isn't necessarily something
> that does this.

I disagree that this is just a cleanup. This work is focused on keeping
time correctly, and it fixes a number problems where timekeeping
inconsistencies have been seen by customers. Most specifically, those
dealing with late or lost timers interrupts. Its just that to fix these
issues much of the code had to be reworked, so I spent some time making
sure the new method was reusable by other arches and made other time
related features (HRT, dynmaic ticks, etc) simpler.

Again, I really look forward to any suggestions you have for the code.

thanks
-john

