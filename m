Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267671AbSLSXdf>; Thu, 19 Dec 2002 18:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267680AbSLSXde>; Thu, 19 Dec 2002 18:33:34 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:28945
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267671AbSLSXda>; Thu, 19 Dec 2002 18:33:30 -0500
Subject: Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3E0253D9.94961FB@digeo.com>
References: <200212200850.32886.conman@kolivas.net>
	 <1040337982.2519.45.camel@phantasy>  <3E0253D9.94961FB@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1040341293.2521.71.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 19 Dec 2002 18:41:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-19 at 18:18, Andrew Morton wrote:

> That is too often not the case.

I knew you would say that!

> I can get the desktop machine working about as comfortably
> as 2.4.19 with:
> 
> # echo 10 > max_timeslice 
> # echo 0 > prio_bonus_ratio 
> 
> ie: disabling all the fancy new scheduler features :(
> 
> Dropping max_timeslice fixes the enormous stalls which happen
> when an interactive process gets incorrectly identified as a
> cpu hog.  (OK, that's expected)

Curious why you need to drop max_timeslice, too.  Did you do that
_before_ changing the interactivity estimator?  Dropping max_timeslice
closer to min_timeslice would do away with a lot of effect of the
interactivity estimator, since bonuses and penalties would be less
apparent.

There would still be (a) the improved priority given to interactive
processes and (b) the reinsertion into the active away done to
interactive processes.

Setting prio_bonus_ratio to zero would finish off (a) and (b).  It would
also accomplish the effect of setting max_timeslice low, without
actually doing it.

Thus, can you try putting max_timeslice back to 300?  You would never
actually use that range, mind you, except for niced/real-time
processes.  But at least then the default timeslice would be a saner
100ms.

> I don't expect the interactivity/cpuhog estimator will ever work
> properly on the desktop, frankly.  There will always be failure
> cases when a sudden swing in load causes it to make the wrong
> decision.
> 
> So it appears that to stem my stream of complaints we need to
> merge scheduler_tunables.patch and edit my /etc/rc.local.

I am glad sched-tune helped identify and fix the issue.  I would have no
problem merging this to Linus.  I actually have a 2.5.52 patch out which
is a bit cleaner - it removes the defines completely and uses the new
variables.  More proper for the long term.  Feel free to push what you
have, too.

But that in no way precludes not fixing what we have, because good
algorithms should not require tuning for common cases.  Period.

	Robert Love

