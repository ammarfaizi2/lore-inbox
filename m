Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUKXJOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUKXJOc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 04:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbUKXJOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 04:14:14 -0500
Received: from mx1.elte.hu ([157.181.1.137]:36551 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262547AbUKXJOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 04:14:05 -0500
Date: Wed, 24 Nov 2004 11:16:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-10
Message-ID: <20041124101626.GA31788@elte.hu>
References: <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123175823.GA8803@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the -V0.7.30-10 Real-Time Preemption patch, which can be
downloaded from the usual place:

    http://redhat.com/~mingo/realtime-preempt/

this is a fixes-only release.

the most important fixes are the ones to the priority inheritance logic
(affecting the latency of RT tasks), discovered and reported by Esben
Nielsen. I also found two more PI bugs running the new pi_test2 code
from Esben.

Changes since -V0.7.30-9:

 - PI fixes:

   - the waiter->prio field caused wrong priority settings upon unlock, 
     resulting in PI bugs in the nested-locking case.

   - use rt_task() when determining PI tasks, not p->policy.

   - in the blocking-on-blocked-task nesting case both promote now-RT
     tasks to the pi_waiters list and queue them to the head of the wait
     list, and demote now-non-RT tasks from the pi_waiters list and 
     queue them to the tail of the wait list.

 - PI-debugging blocker device update from Esben Nielsen

 - module build fix: export user_trace_stop symbol, this fixes the error 
   reported by Florian Schmidt

 - tracer fix: in the default !freerunning tracing mode, if the trace
   buffer overflows (this is relatively rare, but can happen) then the
   tracer overwrote kernel memory that leads to lockups/kernel crashes. 
   Maybe this bug was also the source of the truncated trace bug
   reported by Mark H. Johnson?

 - reduce tracing overhead within schedule() when !tracing_enabled.

to create a -V0.7.30-10 tree from scratch, the patching order is:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc2.bz2
  http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm2/2.6.10-rc2-mm2.bz2
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc2-mm2-V0.7.30-10

	Ingo
