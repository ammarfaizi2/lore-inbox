Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264437AbVBDRSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbVBDRSn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264713AbVBDRSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:18:42 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:31391 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S264367AbVBDRS3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:18:29 -0500
Date: Fri, 4 Feb 2005 09:18:05 -0800
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
Message-ID: <20050204171805.GF22444@atomide.com>
References: <20050201110006.GA1338@elf.ucw.cz> <20050201204008.GD14274@atomide.com> <20050201212542.GA3691@openzaurus.ucw.cz> <20050201230357.GH14274@atomide.com> <20050202141105.GA1316@elf.ucw.cz> <20050203030359.GL13984@atomide.com> <20050203105647.GA1369@elf.ucw.cz> <20050203164331.GE14325@atomide.com> <20050204051929.GO14325@atomide.com> <Pine.LNX.4.61.0502032329150.26742@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502032329150.26742@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zwane Mwaikambo <zwane@arm.linux.org.uk> [050203 22:33]:
> On Thu, 3 Feb 2005, Tony Lindgren wrote:
> 
> > > > > It could also be that the reprogamming of PIT timer does not work on
> > > > > your machine. I chopped off the udelays there... Can you try
> > > > > something like this:
> > > > 
> > > > I added the udelays, but behaviour did not change.
> > > 
> > > Yeah, and if the first patch was working better, that means the PIT
> > > interrupts work. I'll do another version of the patch where PIT
> > > interrupts work again without local APIC needed, let's see what
> > > happens with that.
> 
> I see in the patch that you're reprogramming the PIT for a periodic mode 
> (2) but using dyn_tick->skip as the period. Is this intentional? I thought 
> you wanted a oneshot for that.

Yes, it's safer to keep the timer periodic, although it's
used for oneshot purposes for the skips. If the timer interrupt
got missed for some reason, the system would be able to recover when
it's in periodic mode.

And with some timers, we can do the reprogramming faster, as we just
need to load the new value.

I could not figure out how to disable the interrupts for PIT
when local APIC is used and the ticks to skip is longer than PIT
would allow. So I just changed the mode temporarily to disable it.

Does anybody know if there's a way to stop PIT interrupts while
keeping it in the periodic mode?

Regards,

Tony
