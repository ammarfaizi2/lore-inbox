Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbULGVmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbULGVmr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 16:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbULGVmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 16:42:47 -0500
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:57542 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S261947AbULGVmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 16:42:31 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Date: Tue, 7 Dec 2004 15:41:20 -0600
Message-ID: <OF82BE5296.785D9307-ON86256F63.007723D9-86256F63.00772414@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/07/2004 03:41:21 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i have released the -V0.7.32-6 Real-Time Preemption patch, which can be
>downloaded from the usual place:
>
>   http://redhat.com/~mingo/realtime-preempt/
>

When building V0.7.32-5, (using a -2 kernel) I had another failure
when doing the second mkinitrd. Let me know if you need the trace
for that (since I could not reproduce it with -5).

Some preliminary results for -5 (with PREEMPT_DESKTOP)....

[1] I have a FEW cases where the cpu_delay program triggers
a user trace, but my data collection script does not get any
data to report:
  /proc/sys/kernel/preempt_max_latency
does not change.

For example, the following sequence of activated / triggered messages

Trace activated with 0.000300 second delay.
Trace triggered with 0.000399 second delay. [not recorded]
Trace activated with 0.000300 second delay.
Trace triggered with 0.000383 second delay. [00]
Trace activated with 0.000300 second delay.
Trace triggered with 0.000439 second delay. [01]
Trace activated with 0.000300 second delay.
Trace triggered with 0.000351 second delay. [02]
Trace activated with 0.000300 second delay.
Trace triggered with 0.000521 second delay. [03]
Trace activated with 0.000300 second delay.
Trace triggered with 0.000470 second delay. [04]
Trace activated with 0.000300 second delay.
Trace triggered with 0.000302 second delay. [05]
Trace activated with 0.000300 second delay.
Trace triggered with 0.000313 second delay. [06]
Trace activated with 0.000300 second delay.
Trace triggered with 0.000325 second delay. [07]
Trace activated with 0.000300 second delay.
Trace triggered with 0.000326 second delay. [08]
Trace activated with 0.000300 second delay.
Trace triggered with 0.000434 second delay. [09]
Trace activated with 0.000300 second delay.
Trace triggered with 0.000306 second delay. [10]
Trace activated with 0.000300 second delay.
Trace triggered with 0.000645 second delay. [not recorded]
Trace activated with 0.000300 second delay.
Trace triggered with 0.000324 second delay. [not recorded]
Trace activated with 0.000300 second delay.
Trace triggered with 0.000396 second delay. [11]

and the collected data...

#lt.00: latency: 385 us, entries: 454 (454)   |   [VP:0 KP:1 SP:0 HP:0
#CPUS:2]
lt.01: latency: 439 us, entries: 434 (434)   |   [VP:0 KP:1 SP:0 HP:0
#CPUS:2]
lt.02: latency: 351 us, entries: 885 (885)   |   [VP:0 KP:1 SP:0 HP:0
#CPUS:2]
lt.03: latency: 523 us, entries: 592 (592)   |   [VP:0 KP:1 SP:0 HP:0
#CPUS:2]
lt.04: latency: 470 us, entries: 571 (571)   |   [VP:0 KP:1 SP:0 HP:0
#CPUS:2]
lt.05: latency: 303 us, entries: 235 (235)   |   [VP:0 KP:1 SP:0 HP:0
#CPUS:2]
lt.06: latency: 314 us, entries: 5 (5)   |   [VP:0 KP:1 SP:0 HP:0 #CPUS:2]
lt.07: latency: 325 us, entries: 868 (868)   |   [VP:0 KP:1 SP:0 HP:0
#CPUS:2]
lt.08: latency: 327 us, entries: 226 (226)   |   [VP:0 KP:1 SP:0 HP:0
#CPUS:2]
lt.09: latency: 437 us, entries: 508 (508)   |   [VP:0 KP:1 SP:0 HP:0
#CPUS:2]
lt.10: latency: 308 us, entries: 411 (411)   |   [VP:0 KP:1 SP:0 HP:0
#CPUS:2]
lt.11: latency: 396 us, entries: 435 (435)   |   [VP:0 KP:1 SP:0 HP:0
#CPUS:2]

None of the ones I collected cross CPU's so I assume that's
why I get a few triggered conditions that don't get traced.

[2] The non RT process starvation continues. I'll send a few
profile logs separately to see if something is obvious. The script
that sleeps for 5 seconds was delayed over 200 seconds at one point.
It may be related to heavy disk activity.

[3] The charts from latencytest had the following results. I'll repeat
the tests to see if the results are consistent.

  a. Max CPU duration was 2.24 msec (vs. 1.16 nominal). That is better
than any of the 2.4 kernel results I have. Duration of the CPU task is
generally pretty good (percentage wise).

  b. Odd variations in audio duration. Varies between
   - consistently "too fast" (should be 1.45 msec, appears to be 1.25 usec)
   - "wide variation" (should be 1.45 msec, varies up to about 2 usec)
   - a FEW huge audio delays (up to 896 msec)

  c. A few periods (up to 10 seconds long) where the CPU duration is
about 100 usec longer than nominal. Primarily during the disk write
stress test but appears in shorter duration in a few of the other tests.
May be hardware related but I find it a little odd that EVERY frame in
these periods are delayed by 100 usec (out of 1160 usec nominal). The
other possible cause I'm thinking of is I got on the same CPU as the
clock interrupt for a long period [not sure why that would happen either].

[4] Of the latency traces, I see the following patterns:

  a. modprobe (don't do that during RT...)
  b. IRQ chaining (e.g., hard IRQ for disk followed by soft IRQ for
network)
  c. timer / signal processing
  d. a FEW odd examples where I get a BIG chunk of time in one line (up
to 400 usec).
  e. long series of rt_check_expire (up to 300 usec) traces
  f. a FEW cases where it appears my serial console may be causing
some long delays (over 200 msec). Of course, if the crashes go away I
can go back to dmesg -n 0 (now using dmesg -n 8).

Will send latency traces separately (as well as the profile outputs).

The max CPU duration numbers during the stress tests are REALLY
encouraging.

  --Mark

