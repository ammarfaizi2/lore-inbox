Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbUKHRCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUKHRCj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbUKHRBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:01:06 -0500
Received: from mx1.elte.hu ([157.181.1.137]:17596 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261907AbUKHPzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 10:55:13 -0500
Date: Mon, 8 Nov 2004 17:57:18 +0100
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
       Shane Shrybman <shrybman@aei.ca>
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.21
Message-ID: <20041108165718.GA7741@elte.hu>
References: <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108091619.GA9897@elte.hu>
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


i have released the -V0.7.21 Real-Time Preemption patch, which can be
downloaded from the usual place:

   http://redhat.com/~mingo/realtime-preempt/

this release includes fixes and debugging-improvements.

Changes since -V0.7.20:

 - reverted the modlist_lock change - it caused more problems than it 
   solved.

 - implemented irqs-off critical section timing/tracing, inspired by the 
   positive results Thomas Gleixner got with a different kind of cli/sti
   tracer. To activate it, enable CONFIG_CRITICAL_TIMING and 
   CONFIG_CRITICAL_IRQSOFF_TIMING and cli/sti latencies will be reported
   'integrated' into the preempt on/off latencies.

 - sped up tracing in a number of ways. Performance of the tracer slowly
   eroded in the past week or two, it needed alignment and size fixes ,
   inlining/branch-prediction updates and i got rid of unnecessary code.
   The max latency is now traced in cycles - this got rid of an
   expensive 64-bit division in the fastpath. (the /proc/sys tunables
   are still in usecs so userspace should not notice anything.) It's
   still not cheap but roughly 5 times faster than -V0.7.20's tracer, on
   a fast desktop box.

 - renamed CONFIG_PREEMPT_REALTIME to CONFIG_PREEMPT_RT - it's shorter.

 - renamed CONFIG_PREEMPT_TIMING to CONFIG_CRITICAL_TIMING and 
   introduced CONFIG_CRITICAL_IRQSOFF_TIMING to enable cli/sti timing.

to create a -V0.7.21 tree from scratch, the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc1.bz2
   http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/2.6.10-rc1-mm3.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc1-mm3-V0.7.21

	Ingo
