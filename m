Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVASXw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVASXw1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVASXuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:50:37 -0500
Received: from gprs215-178.eurotel.cz ([160.218.215.178]:48784 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261989AbVASXrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:47:19 -0500
Date: Thu, 20 Jan 2005 00:46:08 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119234608.GA28211@elf.ucw.cz>
References: <20050119000556.GB14749@atomide.com> <20050119113642.GA1358@elf.ucw.cz> <20050119171106.GA14545@atomide.com> <20050119220637.GA7513@elf.ucw.cz> <20050119230813.GI14545@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119230813.GI14545@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > As this patch is related to the VST/High-Res timers, there
> > > > > are probably various things that can be merged. I have not
> > > > > yet looked at what all could be merged.
> > > > > 
> > > > > I'd appreciate some comments and testing!
> > > > 
> > > > Good news is that it does seem to reduce number of interrupts. Bad
> > > > news is that time now runs faster (like "sleep 10" finishes in ~5
> > > > seconds) and that I could not measure any difference in power
> > > > consumption.
> > > 
> > > Thanks for trying it out. I have quite accurate time here on my
> > > systems, and sleep works as it should. I wonder what's happening on
> > > your system? If you have a chance, could you please post the results
> > > from following simple tests?
> > 
> > On patched 2.6.11-rc1:
> > 
> > [Heh, clock is two times too fast, perhaps that makes ntpdate fail? -- yes.
> > 
> > root@amd:~# dmesg | grep -i time; for i in 1 2 3 4 5; do ntpdate -b tak.cesnet.cz && sleep 10; done ; date && sleep 10 && date; while [ 1 ]; do date; done | uniq
> > PCI: Setting latency timer of device 0000:00:11.5 to 64
> > dyn-tick: Enabling dynamic tick timer
> > dyn-tick: Timer using dynamic tick
> 
> Thanks. Looks like you're running on PIT only, I guess my patch
> currently breaks PIT (and possibly HPET) No dmesg message for "
> "Using XXX for high-res timesource".

Okay, so I set CONFIG_HPET. CONFIG_X86_TSC was already set, I wonder
why the code did not use it?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
