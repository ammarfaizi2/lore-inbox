Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVBDR4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVBDR4x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVBDR4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:56:52 -0500
Received: from fsmlabs.com ([168.103.115.128]:48580 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S263754AbVBDRyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:54:45 -0500
Date: Fri, 4 Feb 2005 10:54:24 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Tony Lindgren <tony@atomide.com>
cc: Pavel Machek <pavel@suse.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick, version 050127-1
In-Reply-To: <20050204174254.GG22444@atomide.com>
Message-ID: <Pine.LNX.4.61.0502041052550.2194@montezuma.fsmlabs.com>
References: <20050201212542.GA3691@openzaurus.ucw.cz> <20050201230357.GH14274@atomide.com>
 <20050202141105.GA1316@elf.ucw.cz> <20050203030359.GL13984@atomide.com>
 <20050203105647.GA1369@elf.ucw.cz> <20050203164331.GE14325@atomide.com>
 <20050204051929.GO14325@atomide.com> <Pine.LNX.4.61.0502032329150.26742@montezuma.fsmlabs.com>
 <20050204171805.GF22444@atomide.com> <Pine.LNX.4.61.0502041028460.2194@montezuma.fsmlabs.com>
 <20050204174254.GG22444@atomide.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005, Tony Lindgren wrote:

> * Zwane Mwaikambo <zwane@arm.linux.org.uk> [050204 09:31]:
> > On Fri, 4 Feb 2005, Tony Lindgren wrote:
> > 
> > > Yes, it's safer to keep the timer periodic, although it's
> > > used for oneshot purposes for the skips. If the timer interrupt
> > > got missed for some reason, the system would be able to recover when
> > > it's in periodic mode.
> > > 
> > > And with some timers, we can do the reprogramming faster, as we just
> > > need to load the new value.
> > > 
> > > I could not figure out how to disable the interrupts for PIT
> > > when local APIC is used and the ticks to skip is longer than PIT
> > > would allow. So I just changed the mode temporarily to disable it.
> > >
> > > Does anybody know if there's a way to stop PIT interrupts while
> > > keeping it in the periodic mode?
> > 
> > disable_irq(0) ?
> 
> Then the problem is that the CPU does not stay in sleep but wakes to
> the first PIT interrupt AFAIK.

I do not understand, do you want to disable the PIT from interrupting the 
processor and enable it interrupting at a later time?
