Return-Path: <linux-kernel-owner+willy=40w.ods.org-S272148AbVBEXIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272148AbVBEXIx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 18:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbVBEXIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 18:08:53 -0500
Received: from gprs215-88.eurotel.cz ([160.218.215.88]:18394 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S272221AbVBEXIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 18:08:05 -0500
Date: Sun, 6 Feb 2005 00:00:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick, version 050127-1
Message-ID: <20050205230017.GA1070@elf.ucw.cz>
References: <20050127212902.GF15274@atomide.com> <20050201110006.GA1338@elf.ucw.cz> <20050201204008.GD14274@atomide.com> <20050201212542.GA3691@openzaurus.ucw.cz> <20050201230357.GH14274@atomide.com> <20050202141105.GA1316@elf.ucw.cz> <20050203030359.GL13984@atomide.com> <20050203105647.GA1369@elf.ucw.cz> <20050203164331.GE14325@atomide.com> <20050204051929.GO14325@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204051929.GO14325@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > It could also be that the reprogamming of PIT timer does not work on
> > > > your machine. I chopped off the udelays there... Can you try
> > > > something like this:
> > > 
> > > I added the udelays, but behaviour did not change.
> > 
> > Yeah, and if the first patch was working better, that means the PIT
> > interrupts work. I'll do another version of the patch where PIT
> > interrupts work again without local APIC needed, let's see what
> > happens with that.
> 
> I think something broke TSC timer after the first patch, but I could
> not figure out yet what. So the bad combo might be local APIC + TSC.
> At least I'm seeing similar problems with local APIC + TSC timer.
> 
> Attached is a slightly improved patch, but the patch does not fix
> the TSC problem. It just fixes compile without local APIC, and
> booting SMP kernel on uniprocessor machine.
> 
> Currently the suggested combo is local APIC + ACPI PM timer...

Ok, works slightly better: time no longer runs 2x too fast. When TSC
is used, I get same behaviour  as before ("sleepy machine"). With
"notsc", machine seems to work okay, but I still get 1000 timer
interrupts a second.

> And if that works, changing the I8042_POLL_PERIOD from HZ/20 in
> drivers/input/serio/i8042.h to something like HZ increases the
> sleep interval quite a bit. I think I had lots of polling also in
> CONFIG_NETFILTER, but I haven't verified that.

Okay, I set POLL_PERIOD to 5*HZ, and disabled USB. Perhaps it will
sleep better now?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
