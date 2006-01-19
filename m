Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161188AbWASQU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161188AbWASQU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 11:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161295AbWASQU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 11:20:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34321 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161188AbWASQU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 11:20:58 -0500
Date: Thu, 19 Jan 2006 17:20:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: kus Kusche Klaus <kus@keba.com>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       jesse.brandeburg@intel.com, netdev@vger.kernel.org
Subject: Re: My vote against eepro* removal
Message-ID: <20060119162056.GP19398@stusta.de>
References: <AAD6DA242BC63C488511C611BD51F367323322@MAILIT.keba.co.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323322@MAILIT.keba.co.at>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 11:26:51AM +0100, kus Kusche Klaus wrote:
> > From: Lee Revell
> > On Thu, 2006-01-19 at 08:19 +0100, kus Kusche Klaus wrote:
> > > Last time I tested (around 2.6.12), eepro100 worked much better 
> > > in -rt kernels w.r.t. latencies than e100:
> > > 
> > > e100 caused a periodic latency of about 500 microseconds
> > > exactly every 2 seconds, no matter what the load on the interface
> > > was (i.e. even on an idle interface).
> > > 
> > > eepro100 did not show any latencies that long, it worked much
> > > smoother w.r.t. latencies.
> > > 
> > > Of course I would prefer to have e100 fixed over keeping eepro100
> > > around forever, but the last time I checked, it still wasn't fixed.
> > 
> > Please provide latency traces to illustrate the problematic code path.
> 
> It's not a "latency": As far as I can tell, interrupts or preemption
> are not disabled, the latency tracer doesn't show anything.
> 
> I just noticed that low-pri rt processes did not get scheduled for
> about 500 microseconds when e100 was active (even if the net was
> idle), and that there were no such breaks with eepro100.
> 
> I didn't analyze it in detail at that time, I believed that the e100
> interrupt handler thread was running every 2 seconds for 500 
> microseconds, because the interrupt count of eth0 incremented every
> 2 seconds, exactly when my rt processes paused.
> 
> This would be bad: That irq thread is at rt prio 47 on my system, 
> above many importent things.
> 
> However, I checked more closely now, and found out that only a small
> portion of the 500 microseconds is spent in the irq thread. Most of
> it is spent in the timer thread, at rt prio 1, so the whole thing
> is a much smaller problem than I originally believed.
> 
> Must be the function e100_watchdog.
>...

Is this with 2.6.12 or 2.6.16-rc1?

If it's the former, please check whether the problem is still presnt in 
the latter.

If it's the latter, I'm sure the e100 developers (Cc'ed) are interested 
in your problem.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

