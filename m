Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266334AbUA2Tty (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266327AbUA2Ttx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:49:53 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:57596 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266334AbUA2Tte
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:49:34 -0500
Subject: Re: 2.6.1: process start times by procps
From: john stultz <johnstul@us.ibm.com>
To: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040129143847.GA4544@elektroni.ee.tut.fi>
References: <20040123194714.GA22315@elektroni.ee.tut.fi>
	 <20040125110847.GA10824@elektroni.ee.tut.fi>
	 <20040127155254.GA1656@elektroni.ee.tut.fi>
	 <1075342912.1592.72.camel@cog.beaverton.ibm.com>
	 <20040129143847.GA4544@elektroni.ee.tut.fi>
Content-Type: text/plain
Message-Id: <1075405728.1592.100.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 29 Jan 2004 11:48:49 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-29 at 06:38, Petri Kaukasoina wrote:
> Thanks for answering,
> 
> On Wed, Jan 28, 2004 at 06:21:52PM -0800, john stultz wrote:
> > On Tue, 2004-01-27 at 07:52, Petri Kaukasoina wrote:
> > > I made an experiment shown below. I know nothing about kernel programming,
> > > so this is probably not correct, but at least btime seemed to stay constant.
> > > (I don't believe this fixes procps, though. If HZ if off by 180 ppm then I
> > > guess ps can't possibly get its calculations involving HZ right. But at
> > > least the bootup time reported by procinfo stays constant.)
> > 
> > 
> > Uh, what does your /etc/ntp/drift file show?
> 
> ntp.drift is -22.251 on linux-2.6.1. But on linux-2.4.24 it stabilizes at
> about -5.4.

Hmm. 

> > The basic equation is: 
> > btime ~= gettimeodfay() - uptime
> >
> > Thus if your time of day is adjusted by NTP, btime will change as well.
> > Uptime is calculated calculated by jiffies/HZ, and HZ is not NTP
> > adjusted, so if your system is running 180ppm too fast or slow, btime
> > would be expected to change. 
> > 
> 
> Yes, on linux-2.2.24 I can see that /proc/uptime is just the jiffies and
> btime is current time - jiffies. But in linux-2.6.1 /proc/uptime is now
> do_posix_clock_monotonic_gettime(), whatever that means, and /proc/uptime
> gives a correct value. But btime is still gettimeofday-jiffies and it does
> not stay constant. My patch changed btime to be
> gettimeofday-do_posix_clock_monotonic_gettime() and after that it stays
> constant.

Does George Anzinger's patch work as well?


> > I'm not yet sure how that is related to the ps start time being wrong.
> 
> I guess it's not. The relative error was just the same in both. On
> linux-2.2.24, ps start time is correct but on linux-2.6.1 it shows times in
> future. How much in future, about minute per four days of uptime. But if I
> multiply Hertz by e.g. 1.000172 in the ps source, then I get the right
> results on linux-2.6.1.
> 
> I'll do an experiment and boot to linux-2.6.1 without ntpd next...

I'd be interested in that.

thanks
-john



