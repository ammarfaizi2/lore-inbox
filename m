Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269834AbUICUx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269834AbUICUx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 16:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269820AbUICUx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 16:53:56 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:22246 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S269807AbUICUvX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 16:51:23 -0400
Date: Fri, 3 Sep 2004 22:26:15 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, clameter@sgi.com,
       Len Brown <len.brown@intel.com>, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC] New Time of day proposal (updated 9/2/04)
Message-ID: <20040903202615.GA18255@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
	george anzinger <george@mvista.com>, albert@users.sourceforge.net,
	Ulrich.Windl@rz.uni-regensburg.de, clameter@sgi.com,
	Len Brown <len.brown@intel.com>, David Mosberger <davidm@hpl.hp.com>,
	Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
	jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
	greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
	Chris McDermott <lcm@us.ibm.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com> <20040903095435.GA11572@dominikbrodowski.de> <1094240482.14662.525.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094240482.14662.525.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 12:41:22PM -0700, john stultz wrote:
> > - cpufreq hooks to tsc.c and i386_tsc.c[*] can easily be added. For them to
> >   work _better_ than current code: can timeofday_hook() be called (with IRQs
> >   disabled) _anywhen_ from kernel context? 
> >    [*] actually, only one of them needs the notifier, AFAICS...
> 
> Yep, that's on my list. I'm trying to keep to just cleaning up one thing
> at a time, but since I've got to re-work the timer_tsc.c code anyway, I
> figured I'd try to organize all the TSC related functions
> (synchronization, cpufreq, get_cycles(), tsc_delay maybe?) into tsc.c.
> This will simplify things if we ever get around to correctly fixing the
> SMP systems w/ different speed cpus issue. 

What about removing cpu_freq_khz you have in your patch, adding a per-CPU 
value, and just use the value of the boot CPU for the other CPUs if
!CONFIG_DIFFERENT_CPU_SPEEDS or something like that?

> > - what about keeping lower-priority timesources still "active" in some sort to
> >   a) enable loading _and_ unloading timsources (even modularizing them
> > 	becoms possible which should make testing easier...),
> >   b) call them every couple of seconds to verify the currently used
> > 	timesource is still sane (and if not, call cpufreq_delayed_get() for
> > 	example or disable the timesource). This would mean that e.g. pmtmr 
> > 	and pit can be used to "verify" and "backup" tsc, or otherwise... 
> > 	The "clock=tsc" override would only affect the priority of the 
> > 	timesource then, making it so large that no other timesource can 
> > 	"preempt" it, but doesn't avoid making other timesources available
> > 	for backup and verification purposes.
> 
> That's totally the plan, although I want to put the control into sysfs.

Even better. Thought about that too, but was worried you'd dislike the sysfs
overhead.

Thanks,
	Dominik
