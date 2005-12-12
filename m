Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVLLUHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVLLUHW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVLLUHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:07:22 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:63661 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932154AbVLLUHV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:07:21 -0500
Subject: Re: [Lse-tech] [RFC][Patch 1/5] nanosecond timestamps and diffs
From: john stultz <johnstul@us.ibm.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       lse-tech@lists.sourceforge.net,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jay Lan <jlan@sgi.com>, Jens Axboe <axboe@suse.de>
In-Reply-To: <439DD6E8.7010802@watson.ibm.com>
References: <43975D45.3080801@watson.ibm.com>
	 <43975E6D.9000301@watson.ibm.com>
	 <Pine.LNX.4.62.0512121049400.14868@schroedinger.engr.sgi.com>
	 <439DD01A.2060803@watson.ibm.com>
	 <1134416962.14627.7.camel@cog.beaverton.ibm.com>
	 <439DD6E8.7010802@watson.ibm.com>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 12:07:14 -0800
Message-Id: <1134418034.14627.14.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-12 at 20:00 +0000, Shailabh Nagar wrote:
> john stultz wrote:
> > On Mon, 2005-12-12 at 19:31 +0000, Shailabh Nagar wrote:
> > 
> >>Christoph Lameter wrote:
> >>
> >>>On Wed, 7 Dec 2005, Shailabh Nagar wrote:
> >>>>+void getnstimestamp(struct timespec *ts)
> >>>
> >>>There is already getnstimeofday in the kernel.
> >>
> >>Yes, and that function is being used within the getnstimestamp() being proposed.
> >>However, John Stultz had advised that getnstimeofday could get affected by calls to
> >>settimeofday and had recommended adjusting the getnstimeofday value with wall_to_monotonic.
> >>
> >>John, could you elaborate ?
> > 
> > I think you pretty well have it covered. 
> > 
> > getnstimeofday + wall_to_monotonic should be higher-res and more
> > reliable (then TSC based sched_clock(), for example) for getting a
> > timestamp.
> > 
> > There may be performance concerns as you have to access the clock
> > hardware in getnstimeofday(), but there really is no other way for
> > reliable finely grained monotonically increasing timestamps.
> > 

> Thanks, that clarifies. I guess the other underlying concern here would be whether these
> improvements (in resolution and reliability) should be going into getnstimeofday()
> itself (rather than creating a new func for the same) ? Or is it better to leave
> getnstimeofday as it is ?

No, getnstimeofday() is very much needed to get a nanosecond grained
wall-time clock, so a new function is needed for the monotonic clock.

In my timeofday re-work I have used the name "get_monotonic_clock()" and
"get_monotonic_clock_ts()" for basically the same functionality
(providing a ktime and a timespec respectively). You might consider
naming it as such, but resolving these naming collisions shouldn't be
too difficult either way.

thanks
-john

