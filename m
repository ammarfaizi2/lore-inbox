Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVATHjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVATHjv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 02:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVATHjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 02:39:51 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:9400 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261882AbVATHjo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 02:39:44 -0500
Date: Wed, 19 Jan 2005 23:39:14 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@suse.cz>
Cc: George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050120073914.GE9975@atomide.com>
References: <20050119000556.GB14749@atomide.com> <20050119113642.GA1358@elf.ucw.cz> <20050119171106.GA14545@atomide.com> <20050119220637.GA7513@elf.ucw.cz> <20050119230813.GI14545@atomide.com> <20050119235905.GA1371@elf.ucw.cz> <20050120000755.GD9975@atomide.com> <20050120005451.GA1344@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120005451.GA1344@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@suse.cz> [050119 16:56]:
> Hi!
> 
> > > > > > Thanks for trying it out. I have quite accurate time here on my
> > > > > > systems, and sleep works as it should. I wonder what's happening on
> > > > > > your system? If you have a chance, could you please post the results
> > > > > > from following simple tests?
> > > > > 
> > > > > On patched 2.6.11-rc1:
> > > > > 
> > > > > [Heh, clock is two times too fast, perhaps that makes ntpdate fail? -- yes.
> > > > > 
> > > > > root@amd:~# dmesg | grep -i time; for i in 1 2 3 4 5; do ntpdate -b tak.cesnet.cz && sleep 10; done ; date && sleep 10 && date; while [ 1 ]; do date; done | uniq
> > > > > PCI: Setting latency timer of device 0000:00:11.5 to 64
> > > > > dyn-tick: Enabling dynamic tick timer
> > > > > dyn-tick: Timer using dynamic tick
> > > > 
> > > > Thanks. Looks like you're running on PIT only, I guess my patch
> > > > currently breaks PIT (and possibly HPET) No dmesg message for "
> > > > "Using XXX for high-res timesource".
> > > 
> > > This machine definitely has TSC... What do I have to do in .config to
> > > make it do something interesting? My .config is:
> > 
> > I suspect it's the HPET_TIMER, see below. CONFIG_X86_PM_TIMER is
> > optional, otherwise TSC is used.
> 
> Okay, so I tried to measure power consumption. Patched kernel seems to
> be about 200mW better. That's on 22W... I'll see if I can tweak ACPI
> somehow to decrease it a bit more.

Good to hear you finally got it to work, and can enjoy the extra few 
milliseconds of battery life :) Now the real problem is what to do
with the idle to take advantage of the extra idle time... I'm not
convinced that hlt or ACPI C2/C3 actually sleep through it. Maybe
there's something more that can be done?

Tony
