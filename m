Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVJTOfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVJTOfJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 10:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbVJTOfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 10:35:09 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:51651 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932183AbVJTOfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 10:35:07 -0400
Date: Thu, 20 Oct 2005 10:34:54 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>
cc: john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
In-Reply-To: <1129734626.19559.275.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.58.0510201031270.30996@localhost.localdomain>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
 <1129734626.19559.275.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Oct 2005, Thomas Gleixner wrote:

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
>
> > I haven't look to see if this happens in vanilla -rt10 but I haven't
> > touched your ktimer code except for my logging and the patch with the
> > unlock_ktimer_base (since I was based off of -rt9)
>
> The ktimer code itself calls the timeofday code, which provides the
> monotonic clock. I have no idea what might go wrong.
>
> Is this reproducible ?
>

FYI, I just merged my changes with -rt13 and everything seems to be
working very smoothly.  I've been running my kernel over an hour without
showing the backward times. I haven't even added the change from cycle_t
to be 64 bits.


So, knock on wood, maybe one of the latest updates fixed the problem. Or
maybe as soon as I hit send, the machine will crash.

I'll keep you all posted.

-- Steve

