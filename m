Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161174AbWANMJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161174AbWANMJw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 07:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWANMJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 07:09:52 -0500
Received: from 213-140-2-73.ip.fastwebnet.it ([213.140.2.73]:32416 "EHLO
	aa006msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751046AbWANMJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 07:09:51 -0500
Date: Sat, 14 Jan 2006 13:08:16 +0100
From: Mattia Dongili <malattia@linux.it>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: first bisection results in -mm3 [was: Re: 2.6.15-mm2: reiser3 oops on suspend and more (bonus oops shot!)]
Message-ID: <20060114120816.GA3554@inferi.kami.home>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060110170037.4a614245.akpm@osdl.org> <15632.83.103.117.254.1136989660.squirrel@picard.linux.it> <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org> <20060111100016.GC2574@elf.ucw.cz> <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org> <20060111184027.GB4735@inferi.kami.home> <20060112220825.GA3490@inferi.kami.home> <1137108362.2890.141.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137108362.2890.141.camel@cog.beaverton.ibm.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.15-rc5-mm3-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

sorry, it took me a while to come back to this issue.

On Thu, Jan 12, 2006 at 03:26:01PM -0800, john stultz wrote:
> On Thu, 2006-01-12 at 23:08 +0100, Mattia Dongili wrote:
> > [cleaned up some Cc as this is not interesting to all MLs]
> > 
> > Andrew,
> > 
> > first bisection spotted the cause of the stalls at boot (happening while
> > starting portmap and after usb-storage scan):
> > 
> > time-clocksource-infrastructure.patch
> > time-generic-timekeeping-infrastructure.patch
> > time-i386-conversion-part-1-move-timer_pitc-to-i8253c.patch
> > time-i386-conversion-part-2-rework-tsc-support.patch
> > time-i386-conversion-part-3-enable-generic-timekeeping.patch
> > time-i386-conversion-part-4-remove-old-timer_opts-code.patch
> > time-i386-conversion-part-5-acpi-pm-variable-renaming-and-config-change.patch
> > time-i386-clocksource-drivers.patch
> > time-fix-cpu-frequency-detection.patch
> > 
> > Cc-ed john stultz
> > 
> > actually git bisect[1] pointed to time-fix-cpu-frequency-detection.patch
> > but it's clearly wrong. Reverting all the above patches (I suppose they
> > are somewhat related) fixes the stalls I experience. I can test
> > corrections if necessary.
> 
> Hmmm. I'm not quite understanding. Does reverting just
> time-fix-cpu-frequency-detection.patch change anything? I just sent out

no, that's why I reverted the full thing.

> a fix for an error case that patch, but I doubt you'd be hitting it.
> 
> Looking at the log here:
> http://oioio.altervista.org/linux/boot-2.6.15-mm2.3
> 
> I'm curious if you're getting cpufreq effects during interval while the
> TSC is being used as a clocksource before we switch to using the acpi_pm
> clocksource.

What should I expect? I didn't notice anything in particular and
actually the box stays alive for just a few minutes, then reiserfs
explodes so I have no chance to notice anything in the long run.

> After the system boots up, does it keep accurate time? Time doesn't
> obviously move too fast or to slow compared to a watch?

yes, during the short time it stays alive there's no difference between
my watch and my laptop.

> Few things to try (independently):
> 1. Does booting w/ idle=poll change the behavior?

yes, no more stalls

> 2. Does booting w/ clocksource=jiffies change the behavior?

yes, same as above

> 3. After booting up, run: 
>    echo tsc > /sys/devices/system/clocksource/clocksource0/current_clocksource
>    And check that the system keeps accurate time.

didn't try as there seems to be no problem in timekeeping

thanks
-- 
mattia
:wq!
