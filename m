Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290111AbSAKVCf>; Fri, 11 Jan 2002 16:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290110AbSAKVCU>; Fri, 11 Jan 2002 16:02:20 -0500
Received: from zero.tech9.net ([209.61.188.187]:10767 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290111AbSAKVCL>;
	Fri, 11 Jan 2002 16:02:11 -0500
Subject: [PATCH] Preemptive Kernel for Ingo's O(1) scheduler
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: kpreempt-tech@lists.sourceforge.net, george@mvista.com, mingo@elte.hu,
        torvalds@transmeta.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 11 Jan 2002 16:04:54 -0500
Message-Id: <1010783095.819.61.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A version of preempt-kernel is now available for Ingo's O(1) scheduler.

For 2.5.2-pre11:
	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.5/preempt-kernel-rml-2.5.2-pre11-1.patch
For 2.4.18-pre3 + sched-O1-H6:
	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/ingo-O1-sched/preempt-kernel-rml-2.4.18-pre3-ingo-1.patch

Because of changes in load_balance, I suggest not using preempt-kernel
and an additional sched update on 2.5.  I'll update as the patches are
merged into 2.5.

Making the kernel fully preemptible should be synergistic with Ingo's
scheduler with its faster task dispatch time and better RT support.

Getting the two to play together was not hard, albeit a bit of a pain. 
The actually scheduling support is less, due to the simplified schedule
and schedule_tail, although there is added code for making the per-CPU
runqueues preempt-safe.

Benchmarks:

2.5.2-pre11 dbench 16:		24.5364 MB/s
2.5.2-pre11-preempt dbench 16:	27.5192 MB/s

2.5.2-pre11 latencytest:
worst-case latency is 18.7ms with 96% scheduling latency on-time
2.5.2-pre11-preempt latencytest:
6ms (<1.5ms in all but disk write) with 99.9% scheduling latency on-time

2.5.2-pre11-preempt avg latency is 1.1ms (for an arbitray work-load I
tested with).  The obstacle for sub-ms average latency is still the
long-held spinlocks that can be 100ms+.

Full ChangeLog:

- make preempt-kernel and Ingo's O(1) scheduler play nicely

- (2.5 only) more include additions

- various cleanups and such

Comments, patches, etc. are appreciated.  While it is running stable
here in both SMP and UP on both 2.4 and 2.5, more testing could reveal
problems.  Also, some optimization could be done at this point to
hopefully reduce overhead.  Enjoy,

	Robert Love

