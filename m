Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265587AbVBDTJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265587AbVBDTJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 14:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264599AbVBDTFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 14:05:09 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:26572 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S264339AbVBDS7I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 13:59:08 -0500
Date: Fri, 4 Feb 2005 10:58:04 -0800
From: Tony Lindgren <tony@atomide.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Pavel Machek <pavel@suse.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick, version 050127-1
Message-ID: <20050204185804.GA24544@atomide.com>
References: <20050202141105.GA1316@elf.ucw.cz> <20050203030359.GL13984@atomide.com> <20050203105647.GA1369@elf.ucw.cz> <20050203164331.GE14325@atomide.com> <20050204051929.GO14325@atomide.com> <Pine.LNX.4.61.0502032329150.26742@montezuma.fsmlabs.com> <20050204171805.GF22444@atomide.com> <Pine.LNX.4.61.0502041028460.2194@montezuma.fsmlabs.com> <20050204174254.GG22444@atomide.com> <Pine.LNX.4.61.0502041052550.2194@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502041052550.2194@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zwane Mwaikambo <zwane@arm.linux.org.uk> [050204 09:54]:
> On Fri, 4 Feb 2005, Tony Lindgren wrote:
> 
> > * Zwane Mwaikambo <zwane@arm.linux.org.uk> [050204 09:31]:
> > > On Fri, 4 Feb 2005, Tony Lindgren wrote:
> > > 
> > > > Yes, it's safer to keep the timer periodic, although it's
> > > > used for oneshot purposes for the skips. If the timer interrupt
> > > > got missed for some reason, the system would be able to recover when
> > > > it's in periodic mode.
> > > > 
> > > > And with some timers, we can do the reprogramming faster, as we just
> > > > need to load the new value.
> > > > 
> > > > I could not figure out how to disable the interrupts for PIT
> > > > when local APIC is used and the ticks to skip is longer than PIT
> > > > would allow. So I just changed the mode temporarily to disable it.
> > > >
> > > > Does anybody know if there's a way to stop PIT interrupts while
> > > > keeping it in the periodic mode?
> > > 
> > > disable_irq(0) ?
> > 
> > Then the problem is that the CPU does not stay in sleep but wakes to
> > the first PIT interrupt AFAIK.
> 
> I do not understand, do you want to disable the PIT from interrupting the 
> processor and enable it interrupting at a later time?

Yes, that right. PIT max skip ticks = 54 and local APIC timer > 1000.
PIT interrupt needs to be disabled to stay in sleep for over 54 ticks.

But I think you're right, disable_irq(0) should do the trick :)

Hmmm, we should be able to keep PIT irq disabled all the time when using
local APIC timer. I'll play with it a bit.

Tony
