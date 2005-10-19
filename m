Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVJSSjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVJSSjk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 14:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVJSSjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 14:39:39 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:16846 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751212AbVJSSjj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 14:39:39 -0400
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
From: john stultz <johnstul@us.ibm.com>
To: tglx@linutronix.de
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1129734626.19559.275.camel@tglx.tec.linutronix.de>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
	 <1129734626.19559.275.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 11:39:32 -0700
Message-Id: <1129747172.27168.149.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 17:10 +0200, Thomas Gleixner wrote:
> On Wed, 2005-10-19 at 10:59 -0400, Steven Rostedt wrote:
> > Hi Thomas,
> > 
> > I switched my custom kernel timer to use the ktimers with the prio of -1
> > as you mentioned to me offline.  I set up the timer to be monotonic and
> > have a requirement that the returned time is always greater or equal to
> > the last time returned from do_get_ktime_mono.
> > 
> > Now here's the results that I got between two calls of do_get_ktime_mono
> > 
> > 358.069795728 secs then later 355.981483177.  Should this ever happen?
> 
> Definitely not. monotonic time must go forwards. 

Steven: What clocksource are you using? Could you send me your dmesg?


> > I haven't look to see if this happens in vanilla -rt10 but I haven't
> > touched your ktimer code except for my logging and the patch with the
> > unlock_ktimer_base (since I was based off of -rt9)
> 
> The ktimer code itself calls the timeofday code, which provides the
> monotonic clock. I have no idea what might go wrong. 
> 
> Is this reproducible ?

Last night I just caught a bug I accidentally introduced with the fixed
interval math (oh, if only optimizations didn't dirty code so!), where
time inconsistencies were possible when clocksources were changed. I'm
not sure if that's the issue being seen above, but I'll wrap things up
and send out a B8 release today if I can.

thanks
-john

