Return-Path: <linux-kernel-owner+w=401wt.eu-S1423139AbWLVASd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423139AbWLVASd (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 19:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423143AbWLVASd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 19:18:33 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:47590 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423139AbWLVASd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 19:18:33 -0500
Date: Fri, 22 Dec 2006 01:15:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: v2.6.20-rc1-rt3, yum/rpm
Message-ID: <20061222001538.GA2681@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have released the 2.6.20-rc1-rt3 tree, which can be downloaded from 
the usual place:

  http://redhat.com/~mingo/realtime-preempt/

more info about the -rt patchset can be found on the RT wiki:

  http://rt.wiki.kernel.org

this is a rebase of -rt to v2.6.20, plus lots of fixes all around the 
place. Given that v2.6.20 is a stabilization release, i rebased the -rt 
tree earlier than usual, and it has worked out so far and is converging 
pretty fast. Changes since 2.6.19-rt6:

 - scheduling latency fixes on SMP systems

 - various high-res timers and dynticks fixes

 - all hardirq and softirq threads now default to SCHED_FIFO:50, use 
   rtirq, set_kthread_prio or raw chrt to tune them. Note: the naming of 
   IRQ threads has changed to "IRQ-123", from the "IRQ 123" naming, to 
   make it easier to script them.

 - NUMA/slab-rt fixes

 - tracer fixes

 - merge the latest ARM patches

 - lockless pagecache patchset from Nick Pigging, ported to -rt by Peter
   Zijlstra

 - files_lock scalability patchset from Peter Zijlstra

 - more /proc/lockdep dependency info from Jason Baron

 - latest lockdep fixes

 - latest e1000 fixes

 - /proc/timer_list for timer info and enhanced /proc/timer_stats 
   support via CONFIG_TIMER_STATS.

 - fixed bzImage boot hang when FUNCTION_TRACING/mcount enabled.

 - lots of other fixes i forgot about :)

 - merge to v2.6.20-rc1

 - merge to latest -git after v2.6.20-rc1

to build a 2.6.20-rc1-rt3 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.19.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.20-rc1.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.20-rc1-rt3

the -rt YUM repository for Fedora Core 6 and 5, for architectures x86_64 
and i686 can be activated via:

   cd /etc/yum.repos.d
   wget http://people.redhat.com/~mingo/realtime-preempt/rt.repo

   yum install kernel-rt.x86_64   # on x86_64
   yum install kernel-rt          # on i686

   yum update kernel-rt           # refresh - or enable yum-updatesd

(note: it will take 15-30 minutes from now on for the yum repository to 
be updated to -rt6)

as usual, bugreports, fixes and suggestions are welcome,

	Ingo
