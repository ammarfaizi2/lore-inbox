Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267652AbSLSXzi>; Thu, 19 Dec 2002 18:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267659AbSLSXzi>; Thu, 19 Dec 2002 18:55:38 -0500
Received: from packet.digeo.com ([12.110.80.53]:2047 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267652AbSLSXze>;
	Thu, 19 Dec 2002 18:55:34 -0500
Message-ID: <3E025E1A.EA32918A@digeo.com>
Date: Thu, 19 Dec 2002 16:02:34 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
References: <200212200850.32886.conman@kolivas.net>
		 <1040337982.2519.45.camel@phantasy>  <3E0253D9.94961FB@digeo.com> <1040341293.2521.71.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Dec 2002 00:03:30.0352 (UTC) FILETIME=[3A976B00:01C2A7BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Thu, 2002-12-19 at 18:18, Andrew Morton wrote:
> 
> > That is too often not the case.
> 
> I knew you would say that!
> 
> > I can get the desktop machine working about as comfortably
> > as 2.4.19 with:
> >
> > # echo 10 > max_timeslice
> > # echo 0 > prio_bonus_ratio
> >
> > ie: disabling all the fancy new scheduler features :(
> >
> > Dropping max_timeslice fixes the enormous stalls which happen
> > when an interactive process gets incorrectly identified as a
> > cpu hog.  (OK, that's expected)
> 
> Curious why you need to drop max_timeslice, too.

What Con said.  When the scheduler makes an inappropriate decision,
shortening the timeslice minimises its impact.

>  Did you do that _before_ changing the interactivity estimator?

I disabled the estimator first.  The result was amazingly bad ;)

>  Dropping max_timeslice
> closer to min_timeslice would do away with a lot of effect of the
> interactivity estimator, since bonuses and penalties would be less
> apparent.

Yup.  One good test is to keep rebuilding a kernel all the time,
then just *use* the system.  Setting max_timeslice=10, prio_bonus=10
works better still.  prio_bonus=25 has small-but-odd lags.
 
> There would still be (a) the improved priority given to interactive
> processes and (b) the reinsertion into the active away done to
> interactive processes.
> 
> Setting prio_bonus_ratio to zero would finish off (a) and (b).  It would
> also accomplish the effect of setting max_timeslice low, without
> actually doing it.
> 
> Thus, can you try putting max_timeslice back to 300?  You would never
> actually use that range, mind you, except for niced/real-time
> processes.  But at least then the default timeslice would be a saner
> 100ms.

prio_bonus=0, max_timeslice=300 is awful.  Try it...
 
> ...
> But that in no way precludes not fixing what we have, because good
> algorithms should not require tuning for common cases.  Period.

hm.  Good luck ;)

This is a situation in which one is prepares to throw away some cycles
to achieve a desired effect.
