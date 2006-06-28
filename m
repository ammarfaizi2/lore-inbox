Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWF1UGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWF1UGQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWF1UGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:06:15 -0400
Received: from [212.76.91.47] ([212.76.91.47]:42761 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751200AbWF1UGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:06:13 -0400
From: Al Boldi <a1426z@gawab.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: Incorrect CPU process accounting using CONFIG_HZ=100
Date: Wed, 28 Jun 2006 23:06:14 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Con Kolivas <kernel@kolivas.org>
References: <200606211716.01472.a1426z@gawab.com> <200606272302.16950.kernel@kolivas.org> <44A1C4D4.3080805@bigpond.net.au>
In-Reply-To: <44A1C4D4.3080805@bigpond.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200606282306.14498.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Con Kolivas wrote:
> > On Tuesday 27 June 2006 22:32, Al Boldi wrote:
> >> Pavel Machek wrote:
> >>> On Thu 2006-06-22 20:36:39, Al Boldi wrote:
> >>>> Jan Engelhardt wrote:
> >>>>>> Setting CONFIG_HZ=100 results in incorrect CPU process accounting.
> >>>>>>
> >>>>>> This can be seen running top d.1, that shows top, itself, consuming
> >>>>>> 0ms CPUtime.
> >>>>>>
> >>>>>> Will this bug have consequences for sched.c?
> >>>>>
> >>>>> Works for me, somewhat.
> >>>>> TIME+ says 0:00.02 after 70 secs. (Ergo: top is not expensive on
> >>>>> this CPU.)
> >>>>
> >>>> That's what I thought for a long time.  But at closer inspection, top
> >>>> d.1 slows down other apps by about the same amount of time at 1000Hz
> >>>> and 100Hz, only at 1000Hz it is accounted for whereas at 100Hz it is
> >>>> not.
> >>>
> >>> It is not a bug... it is design decision. If you eat "too little" cpu
> >>> time, you'll be accouted 0 msec. That's what happens at 100Hz...
> >>
> >> Bummer!
> >>
> > The actual problem is that tasks
> > only get charged if they happen to be running at the precise moment the
> > tick fires. Now you could increase the accuracy of this timekeeping but
> > it is expensive and this is exactly the sort of thing that we're saving
> > cpu resources on by running at 100HZ (one of many).
>
> It could be (partly) done fairly cheaply in nanoseconds if sched_clock()
> was reliable enough (but comments on this mail list indicate that it
> currently isn't) as it is already called in all the right places for
> getting the total cpu time used (so just a subtraction, addition and
> assignment).  The reason that I say partly is that splitting the time
> into "system" and "user" would be a more complex problem.

If I am reading this correctly, then the kernel is accounting process times 
twice:
	1. for external proc monitoring, using a probed approach
	2. for scheduling, using an inlined approach

Wouldn't merging the two approaches be in the interest of conserving cpu 
resources, while at the same time reflecting an accurate view of cpu 
utilization?

Thanks!

--
Al

