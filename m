Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVBFRNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVBFRNX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 12:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVBFRLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 12:11:54 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:60801 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261238AbVBFRLP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 12:11:15 -0500
Date: Sun, 6 Feb 2005 09:10:41 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick, version 050127-1
Message-ID: <20050206171041.GC13936@atomide.com>
References: <20050201212542.GA3691@openzaurus.ucw.cz> <20050201230357.GH14274@atomide.com> <20050202141105.GA1316@elf.ucw.cz> <20050203030359.GL13984@atomide.com> <20050203105647.GA1369@elf.ucw.cz> <20050203164331.GE14325@atomide.com> <20050204051929.GO14325@atomide.com> <20050205230017.GA1070@elf.ucw.cz> <20050206023344.GA15853@atomide.com> <20050206081137.GA994@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206081137.GA994@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [050206 00:20]:
> Hi!
> 
> > > > Currently the suggested combo is local APIC + ACPI PM timer...
> > > 
> > > Ok, works slightly better: time no longer runs 2x too fast. When TSC
> > > is used, I get same behaviour  as before ("sleepy machine"). With
> > > "notsc", machine seems to work okay, but I still get 1000 timer
> > > interrupts a second.
> > 
> > Sounds like dyn-tick did not get enabled then, maybe you don't have
> > CONFIG_X86_PM_TIMER, or don't have ACPI PM timer on your board?
> 
> I do have CONFIG_X86_PM_TIMER enabled, but it seems by board does not
> have such piece of hardware:
> 
> pavel@amd:/usr/src/linux-mm$ dmesg | grep -i "time\|tick\|apic"
> PCI: Setting latency timer of device 0000:00:11.5 to 64
> pavel@amd:/usr/src/linux-mm$ 
> 
> [Strange, I should see some messages about apic, no?]

Yeah, looks like you don't have a local APIC then? Let me test the
patch here with just PIT timer only.

It also looks like you don't have TSC either? Or do you still have
notsc cmdline option?

Tony
