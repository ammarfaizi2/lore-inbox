Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVGFBpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVGFBpr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 21:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVGFBpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 21:45:47 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:17041 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262036AbVGFBpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 21:45:20 -0400
Subject: Re: realtime-preempt-2.6.12-final-V0.7.51-01 compile error and
	more problems
From: Lee Revell <rlrevell@joe-job.com>
To: William Weston <weston@sysex.net>
Cc: Carlo Scarfoglio <mi2332@mclink.it>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0507051701440.13700@echo.lysdexia.org>
References: <42CB1707.6000205@mclink.it>
	 <Pine.LNX.4.58.0507051701440.13700@echo.lysdexia.org>
Content-Type: text/plain
Date: Tue, 05 Jul 2005 21:45:16 -0400
Message-Id: <1120614316.22671.64.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-05 at 18:13 -0700, William Weston wrote:
> Audio without xruns is an RT requirement, IMHO  ;-}
> 

This isn't even an opinion, it's a fact.  If you are capturing data and
your audio handling thread does not get scheduled in (periods_per_buffer
- 1) * period_time time units, you lose that chunk of sound *forever*.

Some people on this list make the ridiculous argument that this is
different from more conventional RT applications because "they can
always record again".  Try telling that to someone who is paying for
studio time; you won't be running a studio for long.  Pro audio is
exactly like controlling a satellite or monitoring a power plant, if you
don't get scheduled in time, it's a fatal error.

In practice you only have to be more reliable than the alternatives,
which are pretty reliable these days.

> > 4) Xruns occur every 10-60 minutes even when the system is
> practically 
> > idle (no playback
> > or recording). When copying large files (between sata disks on two 
> > sil3112 controllers)
> > xruns frequency is much higher.  When sound is used xruns occur
> every 2 
> > or 20 minutes.
> 
> Do these xruns coincide with the RTC 'Read missed before next
> interrupt'
> messages?
> 
> Have you tried running JACK with a larger buffer period size?  Some
> cards

Disable CONFIG_RTC_HISTOGRAM.

Then before you try anything else, check the /proc/latency trace output.
What's the max reported latency?  Is it significantly less than the
xruns?

Lee

