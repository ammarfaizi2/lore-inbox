Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVBAEmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVBAEmx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 23:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVBAEmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 23:42:53 -0500
Received: from mail.joq.us ([67.65.12.105]:43741 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261539AbVBAEmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 23:42:46 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Alexander Nyberg <alexn@dsv.su.se>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] sched - Implement priority and fifo support for
 SCHED_ISO
References: <41F76746.5050801@kolivas.org> <87acqpjuoy.fsf@sulphur.joq.us>
	<41FE9582.7090003@kolivas.org> <87651di55a.fsf@sulphur.joq.us>
	<41FEB8BA.7000106@kolivas.org> <87fz0hf20z.fsf@sulphur.joq.us>
	<41FEED69.9060904@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Mon, 31 Jan 2005 22:44:37 -0600
In-Reply-To: <41FEED69.9060904@kolivas.org> (Con Kolivas's message of "Tue,
 01 Feb 2005 13:46:01 +1100")
Message-ID: <87u0owc2iy.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> Good work. Looks like you're probably right about the accounting. It
> may be as simple as the fact that it is on the timer tick that we're
> getting rescheduled and this ends up being accounted as more since the
> accounting happens only at the scheduler tick. A test run setting
> iso_cpu at 100% should tell you if it's accounting related - however
> the RLIMIT_RT_CPU patch is accounted in a similar way so I'm not sure
> there isn't another bug hanging around. 

> I'm afraid on my hardware it has been behaving just like SCHED_FIFO
> for some time which is why I've been hanging on your results. 

My guess is that most of this test fits inside that huge cache of
yours, making it run much faster than on my system.  You probably need
to increase the number of clients to get comparable results.

When you say just like SCHED_FIFO, do you mean completely clean?  Or
are you still getting unexplained xruns?  If that's the case, we need
to figure out why and eliminate them.

The reason I can measure an effect here is that the test is heavy
enough to stress my system and the system is RT-clean enough for
SCHED_FIFO to work properly.  (That's no surprise, I've been running
it that way for years.)

> You're not obliged to do anything (obviously), but the 100% run
> should help discriminate where the problem is.

I don't mind.  It's the main way I can help.  I just get busy some of
the time.

It did work better.  On the first run, there were a couple of real bad
xruns starting up.  But, the other two runs look fairly clean.

  http://www.joq.us/jack/benchmarks/sched-iso-fix.100

With a compile running, bad xruns and really long delays become a
serious problem again.

  http://www.joq.us/jack/benchmarks/sched-iso-fix.100+compile

Comparing the summary statistics with the 90% run, suggests that the
same problems occur in both cases, but not as often at 100%.

  http://www.joq.us/jack/benchmarks/.SUMMARY

With these latency demands, the system can't ever pick the wrong
thread on exit from even a single interrupt, or we're screwed.  I am
pretty well convinced this is not happening reliably (except with
SCHED_FIFO).
-- 
  joq
