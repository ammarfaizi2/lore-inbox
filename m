Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262587AbVAVAn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbVAVAn1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbVAVAl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 19:41:57 -0500
Received: from mail.joq.us ([67.65.12.105]:14027 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262624AbVAVAIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 19:08:17 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
 scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Fri, 21 Jan 2005 18:09:43 -0600
Message-ID: <87wtu6fho8.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> just finished a short testrun with nice--20 compared to SCHED_FIFO, on a
> relatively slow 466 MHz box:

> this shows the surprising result that putting all RT tasks on nice--20
> reduced context-switch rate by 20% and the Delay Maximum is lower as
> well. (although the Delay Maximum is quite unreliable so this could be a
> fluke.) But the XRUN count is the same.

> can anyone else reproduce this, with the test-patch below applied?

I finally made new kernel builds for the latest patches from both Ingo
and Con.  I kept the two patch sets separate, as they modify some of
the same files.

I ran three sets of tests with three or more 5 minute runs for each
case.  The results (log files and graphs) are in these directories...

  1) sched-fifo -- as a baseline
     http://www.joq.us/jack/benchmarks/sched-fifo

  2) sched-iso -- Con's scheduler, no privileges
     http://www.joq.us/jack/benchmarks/sched-iso

  3) nice-20 -- Ingo's "nice --20" scheduler hack
     http://www.joq.us/jack/benchmarks/nice-20

The SCHED_FIFO runs are all with Con's scheduler.  I could not figure
out how to get SCHED_FIFO working with Ingo's version.  With or
without the appropriate privileges, it used nice --20, instead.  I
used schedtool to verify that the realtime threads were running in the
expected class for each test.

It's hard to make much sense out of all this information.  The
SCHED_FIFO results are clearly best.  There were no xruns at all in
those three runs.  All of the others had at least a few, some quite
severe.  But, one of the nice-20 runs had just one small sub-
millisecond xrun.  I made some extra runs with that, because I was
puzzled by its lack of consistency.

Yet, both Ingo's and Con's schedulers basically seem to work well.
I'm not sure how to explain the xruns.  Maybe they are caused by other
kernel latency bugs.  (But then, why not SCHED_FIFO?)  Maybe those
schedulers work most of the time, but are not sufficiently careful to
always preempt the running process when an audio interrupt arrives?

I had some problems with the y2 graph axis (for XRUN and DELAY).  In
most of the graphs it is unreadable.  In some it is inconsistent.  I
hacked on the jack_test3_plot.sh script several times, trying to set
readable values, mostly without success.  There is too much variation
in those numbers.  So, be careful reading and comparing that
information.  Some xruns look better or worse than they really are.

These tests were run without any other heavy demands on the system.  I
want to try some with a compile running in the background.  But, I
won't have time for that until tomorrow at the earliest.  So, I'll
post these preliminary results now for your enjoyment.
-- 
  joq
