Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbUALXUu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 18:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbUALXUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 18:20:50 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:63878 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263441AbUALXUF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 18:20:05 -0500
Subject: Re: Laptops & CPU frequency
From: john stultz <johnstul@us.ibm.com>
To: Disconnect <lkml@sigkill.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1073938271.2156.10.camel@slappy>
References: <20040111025623.GA19890@ncsu.edu>
	 <1073791061.1663.77.camel@localhost>  <1073816858.6189.186.camel@nomade>
	 <1073817226.6189.189.camel@nomade>
	 <1073937159.28098.46.camel@cog.beaverton.ibm.com>
	 <1073938271.2156.10.camel@slappy>
Content-Type: text/plain
Message-Id: <1073949577.28098.68.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 12 Jan 2004 15:19:38 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-12 at 12:11, Disconnect wrote:
> On Mon, 2004-01-12 at 14:52, john stultz wrote:
> > More info please. What type of hardware is this?  Could you send me your
> > dmesg for booting both with and without AC power? 
> 
> I had a similar problem with 2.4 (with and without acpi, speedstep, etc)
> on an Inspiron 8500.  Unfortunately, Dell only gives "use speedstep"
> (boot in powersave on battery, performance on ac)  and "always in lowest
> performance mode" options in the bios.  (Dell, you listening? How about
> "don't use speedstep, only use [powersave/performance] mode"? Or "Boot
> in last-used mode"..)
> 
> When the machine is suspended (swsusp) while on AC, it must be resumed
> on AC (and same if suspended on battery) or the kernel gets very
> confused.  Time doubles (or halves), etc.  No amount of arguing with
> speedstep (or acpi in general, if speedstep wasn't applied/used) will
> get it sane.  (FWIW XP gets this right - hibernate XP on battery, resume
> on ac, hibernate, resume on battery, etc and it does fine.)
> 
> Perhaps linux would benefit from some form of "make sure the cpu is
> doing what we think it is" knob?  Something that could be triggered by
> scripts (or even swsusp/apm directly) as early in a resume as possible,
> before the miscalculation cascades into crashes.  (This would be
> completely independent from speedstep or acpi, since I suspect that the
> same problems may occur independently of acpi on other machines with
> similar braindamaged bios.)
> 
> Thoughts?  I can do more rigorous testing and report back if needed.  (I
> spent 2 days playing with it a few months ago, then gave it up as
> hopeless.)

I'm surprised that you've seen this on 2.4, as the TSC time code does
not try to compensate for lost ticks. Instead we only use the TSC value
to offset from xtime, reseting our offset each tick. So changes in cpu
frequency should only cause time inconsistencies, not time doubling.
Might something be going oddly in setting up the timer interrupt on
restore? I'd be interested in more details. 

In 2.6 we do try to detect when cpufreq changes without notifying us.
However its a balancing act as the symptoms are the same as when you
have a broken PIT or lose too many interrupt. Hopefully HPET and the
ACPI PM timesource will provide more reliable time sources. 

thanks
-john



