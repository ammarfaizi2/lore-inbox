Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVATA5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVATA5K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 19:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVATA5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 19:57:10 -0500
Received: from gprs215-87.eurotel.cz ([160.218.215.87]:35543 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262013AbVATA5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 19:57:06 -0500
Date: Thu, 20 Jan 2005 01:54:52 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050120005451.GA1344@elf.ucw.cz>
References: <20050119000556.GB14749@atomide.com> <20050119113642.GA1358@elf.ucw.cz> <20050119171106.GA14545@atomide.com> <20050119220637.GA7513@elf.ucw.cz> <20050119230813.GI14545@atomide.com> <20050119235905.GA1371@elf.ucw.cz> <20050120000755.GD9975@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120000755.GD9975@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > Thanks for trying it out. I have quite accurate time here on my
> > > > > systems, and sleep works as it should. I wonder what's happening on
> > > > > your system? If you have a chance, could you please post the results
> > > > > from following simple tests?
> > > > 
> > > > On patched 2.6.11-rc1:
> > > > 
> > > > [Heh, clock is two times too fast, perhaps that makes ntpdate fail? -- yes.
> > > > 
> > > > root@amd:~# dmesg | grep -i time; for i in 1 2 3 4 5; do ntpdate -b tak.cesnet.cz && sleep 10; done ; date && sleep 10 && date; while [ 1 ]; do date; done | uniq
> > > > PCI: Setting latency timer of device 0000:00:11.5 to 64
> > > > dyn-tick: Enabling dynamic tick timer
> > > > dyn-tick: Timer using dynamic tick
> > > 
> > > Thanks. Looks like you're running on PIT only, I guess my patch
> > > currently breaks PIT (and possibly HPET) No dmesg message for "
> > > "Using XXX for high-res timesource".
> > 
> > This machine definitely has TSC... What do I have to do in .config to
> > make it do something interesting? My .config is:
> 
> I suspect it's the HPET_TIMER, see below. CONFIG_X86_PM_TIMER is
> optional, otherwise TSC is used.

Okay, so I tried to measure power consumption. Patched kernel seems to
be about 200mW better. That's on 22W... I'll see if I can tweak ACPI
somehow to decrease it a bit more.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
