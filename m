Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVASRNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVASRNf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVASRNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:13:35 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:57310 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261778AbVASRNZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:13:25 -0500
Date: Wed, 19 Jan 2005 09:11:06 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@suse.cz>
Cc: George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119171106.GA14545@atomide.com>
References: <20050119000556.GB14749@atomide.com> <20050119113642.GA1358@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119113642.GA1358@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@suse.cz> [050119 03:32]:
> Hi!
> 
> > As this patch is related to the VST/High-Res timers, there
> > are probably various things that can be merged. I have not
> > yet looked at what all could be merged.
> > 
> > I'd appreciate some comments and testing!
> 
> Good news is that it does seem to reduce number of interrupts. Bad
> news is that time now runs faster (like "sleep 10" finishes in ~5
> seconds) and that I could not measure any difference in power
> consumption.

Thanks for trying it out. I have quite accurate time here on my
systems, and sleep works as it should. I wonder what's happening on
your system? If you have a chance, could you please post the results
from following simple tests?

Regards,

Tony

# dmesg | grep -i time
Using tsc for high-res timesource
dyn-tick: Registering dynamic tick timer
per-CPU timeslice cutoff: 731.77 usecs.
task migration cache decay timeout: 1 msecs.
..TIMER: vector=0x31 pin1=2 pin2=-1
Machine check exception polling timer started.
Real Time Clock Driver v1.12
dyn-tick: Enabling dynamic tick timer
dyn-tick: Timer using dynamic tick

# for i in 1 2 3 4 5; do ntpdate -b rinkeli && sleep 10; done
19 Jan 17:03:16 ntpdate[937]: step time server 192.168.100.254 offset -0.002639 sec
19 Jan 17:03:26 ntpdate[941]: step time server 192.168.100.254 offset -0.000374 sec
19 Jan 17:03:36 ntpdate[945]: step time server 192.168.100.254 offset -0.000100 sec
19 Jan 17:03:47 ntpdate[949]: step time server 192.168.100.254 offset -0.000530 sec
19 Jan 17:03:57 ntpdate[953]: step time server 192.168.100.254 offset -0.000841 sec

# date && sleep 10 && date
Wed Jan 19 17:05:35 UTC 2005
Wed Jan 19 17:05:45 UTC 2005

# while [ 1 ]; do date; done | uniq
Wed Jan 19 17:06:14 UTC 2005
Wed Jan 19 17:06:15 UTC 2005
Wed Jan 19 17:06:16 UTC 2005
Wed Jan 19 17:06:17 UTC 2005
...
