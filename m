Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVASXIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVASXIz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbVASXIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:08:55 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:26832 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261964AbVASXIi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:08:38 -0500
Date: Wed, 19 Jan 2005 15:08:14 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@suse.cz>
Cc: George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119230813.GI14545@atomide.com>
References: <20050119000556.GB14749@atomide.com> <20050119113642.GA1358@elf.ucw.cz> <20050119171106.GA14545@atomide.com> <20050119220637.GA7513@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119220637.GA7513@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@suse.cz> [050119 14:06]:
> Hi!
> 
> > > > As this patch is related to the VST/High-Res timers, there
> > > > are probably various things that can be merged. I have not
> > > > yet looked at what all could be merged.
> > > > 
> > > > I'd appreciate some comments and testing!
> > > 
> > > Good news is that it does seem to reduce number of interrupts. Bad
> > > news is that time now runs faster (like "sleep 10" finishes in ~5
> > > seconds) and that I could not measure any difference in power
> > > consumption.
> > 
> > Thanks for trying it out. I have quite accurate time here on my
> > systems, and sleep works as it should. I wonder what's happening on
> > your system? If you have a chance, could you please post the results
> > from following simple tests?
> 
> On patched 2.6.11-rc1:
> 
> [Heh, clock is two times too fast, perhaps that makes ntpdate fail? -- yes.
> 
> root@amd:~# dmesg | grep -i time; for i in 1 2 3 4 5; do ntpdate -b tak.cesnet.cz && sleep 10; done ; date && sleep 10 && date; while [ 1 ]; do date; done | uniq
> PCI: Setting latency timer of device 0000:00:11.5 to 64
> dyn-tick: Enabling dynamic tick timer
> dyn-tick: Timer using dynamic tick

Thanks. Looks like you're running on PIT only, I guess my patch
currently breaks PIT (and possibly HPET) No dmesg message for "
"Using XXX for high-res timesource".

Tony
