Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbUKJOzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbUKJOzX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbUKJOy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:54:26 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:55590 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S261910AbUKJOxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 09:53:07 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
To: Ingo Molnar <mingo@elte.hu>
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFB20B576E.5695CD7C-ON86256F48.0050136F@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Wed, 10 Nov 2004 08:51:53 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/10/2004 08:51:56 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:
>
>> >- everything else should be SCHED_OTHER. Do latencies get any better if
>> >you do this?
>
>> I can, but that is not necessarily an "apples to apples" comparison.
>
>the goal now would be to simplify the test and work down the issues in
>isolation, instead of looking at a complex setup of mixed workloads and
>just seeing 'it sucks' without knowing which component causes what.

However based on the results of the last several weeks, it is apparent
to me that the simple tests are finding only a subset of the problems.
The stressful series of tests is finding a number of symptoms much
sooner and more repeatable than those simple tests.

I was thinking about this problem this morning and was wondering if
we could do something like an "end trigger" to help determine the cause
of some of these pauses. Something like:
 - start to fill / refresh the trace buffer (already doing this?)
 - run RT CPU loop & sample TSC every 100 iterations or so
 - if delta T exceeds 100 usec (or so), then set "end trigger" and
dump the data from /proc/latency_trace.
Repeat with some rate limit so we don't get too much data.
I can still run the stressful test cases to cause the situations and
get the "just in time" data for the analysis. Perhaps a variant of
the interface you provided before on tracing a specific path.

I may do a variant on this anyway. I think its important to see if
the symptom (> 100 usec CPU delay) is really:
 - lots of short delays
OR
 - relatively few long delays
and I have an idea of how to code that up and add to latencytrace.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

