Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbUKQLlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbUKQLlE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 06:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbUKQLlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 06:41:04 -0500
Received: from mx2.elte.hu ([157.181.151.9]:37519 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262195AbUKQLky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 06:40:54 -0500
Date: Wed, 17 Nov 2004 13:42:34 +0100
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
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-0
Message-ID: <20041117124234.GA25956@elte.hu>
References: <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116134027.GA13360@elte.hu>
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


i have released the -V0.7.28-0 Real-Time Preemption patch, which can be
downloaded from the usual place:

	http://redhat.com/~mingo/realtime-preempt/

this is a fixes & latency-reduction release.

Changes since a -V0.7.27-3:

 - made the UP-ioapic code a bit more conservative again - maybe some of
   the lockups are related?

 - removed the BKL from the sound code in a cleaner way and
   removed the quite fragile 'negative ->lock_depth' code. Much less
   intrusive than i originally thought, and much cleaner as well.

 - more fixes to the wakeup-timing logic, 4 false positives fixed in
   total, mostly related to new-task-wakeup not accurately starting the
   tracer.

 - fixed the mmx-memcpy related latency reported by Florian Schmidt and 
   others. Also turned off the MMX/SSE ops in the RAID code, which 
   can introduce similar latencies.

 - kgdb fix from Bill Huey

 - knfsd shutdown with-BKL-held fix

 - highmem compilation fix

 - profiling related crash fix

 - implemented 'direct-path' rescheduling to further reduce scheduling
   latency: the kernel will now in most cases go from try_to_wakeup()
   into the scheduler directly without re-enabling interrupts ever again
   (and thus not giving irq handlers a window to increase latency). This
   is also the final fix for irq nesting and irq-stack recursion.

 - turn off sync wakeups on PREEMPT_RT -> they are latency generators

to create a -V0.7.28-0 tree from scratch, the patching order is:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc2.bz2
  http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm1/2.6.10-rc2-mm1.bz2
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc2-mm1-V0.7.28-0

	Ingo
