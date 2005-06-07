Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVFGTmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVFGTmB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 15:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVFGTmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 15:42:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:58568 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261878AbVFGTlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 15:41:55 -0400
Date: Tue, 7 Jun 2005 21:41:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Esben Nielsen <simlo@phys.au.dk>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-29
Message-ID: <20050607194119.GA11185@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the -V0.7.47-29 Real-Time Preemption patch, which can be 
downloaded from the usual place:

    http://redhat.com/~mingo/realtime-preempt/

it's a fixes and speedups release. Changes since -47-20:

 - x64 fixes (Michal Schmidt)

 - cpufreq fix (Esben Nielsen)

 - CONFIG_RT_DEADLOCK_DETECT build fix (Michal Schmidt)

 - MAX_USER_RT_PRIO fix (Steven Rostedt)

there are more microoptimizations to the spin_lock/unlock hotpath:

 - the caching of mutex_getprio() priority in p->normal_prio

 - the mutex lock/unlock paths are now all fall-through. (Found a gcc
   bug, it mishandles __builtin_expect() in certain cases and produces 
   correct but suboptimal code - we are working it around now.)

 - reduced the amount of recursive preemption-counter bumps via the use 
   of raw spinlocks

 - rely on the preemption-counter instead of IRQs-off sections

These changes brought the PREEMPT_RT overhead significantly down on 
hackbench workloads (clearly a worst-case test for PREEMPT_RT overhead).  

Would be interesting to see what kind of system time overhead PREEMPT_RT 
now causes for e.g. jack_test workloads.

to build a -V0.7.47-29 tree, the following patches should to be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc6.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc6-V0.7.47-29

	Ingo
