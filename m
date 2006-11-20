Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966807AbWKTWEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966807AbWKTWEb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966811AbWKTWEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:04:31 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:31972 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S966807AbWKTWE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:04:29 -0500
Date: Mon, 20 Nov 2006 23:02:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc6-rt5
Message-ID: <20061120220230.GA30835@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i've released the 2.6.19-rc6-rt5 tree, which can be downloaded from the 
usual place:

  http://redhat.com/~mingo/realtime-preempt/

the -rt YUM repository for Fedora Core 6 can be activated via:

   cd /etc/yum.repos.d
   wget http://people.redhat.com/~mingo/realtime-preempt/rt.repo
   yum install kernel-rt

on x86_64, do:

   yum install kernel-rt.x86_64

lots of fixes and improvements were done to -rt5. In particular 
SMP/dual-core systems should get quite a bit faster. Changes:

 - implemented proper per-cpu page allocation (PCP-list) in 
   page_alloc.c, for PREEMPT_RT too. (previously this code was #ifdef-ed 
   out and we allocated straight from the zones - but this caused the 
   zone lock to act as a global lock)

 - speedup of PREEMPT_RT's implementation of atomic_dec_and_lock().
   (this was a major bottleneck for workloads like kernel compiles.)

 - more tracer features: symbolic stack backtraces embedded in 
   /proc/latency_trace for certain types of events, switchable syscall 
   tracing.

 - irq-threading cleanups, based on the comments from Sergei Shtylyov, 
   Daniel Walker and Benjamin Herrenschmidt.

 - vsyscall & tracing fixes: 'notsc' should not be required on the YUM 
   rpms anymore.

to build a 2.6.19-rc6-rt5 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.18.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.19-rc6.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.19-rc6-rt5

as usual, bugreports, fixes and suggestions are welcome,

	Ingo
