Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUJNOh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUJNOh4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 10:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUJNOdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 10:33:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:38824 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265234AbUJNOau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 10:30:50 -0400
Date: Thu, 14 Oct 2004 16:31:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Daniel Walker <dwalker@mvista.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>, Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
Message-ID: <20041014143131.GA20258@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014002433.GA19399@elte.hu>
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


i have released the -U1 PREEMPT_REALTIME patch:
 
  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U1

this is a strict bugfixes-only release. With -U1 i cannot reproduce any
of the bugs on my testsystems anymore, but take care nevertheless, this
is still experimental code.

Changes since -U0:

 - bugfix: fixed the highmem related crash reported by Adam Heath and i 
   think this could also fix the crash reported by Mark H Johnson.

 - bugfix: fixed a number of networking related soft-lockups, caused by
   a deadlock scenarios in the ipv4, netfilter and net-xmit locking
   code. This could fix the lockup reported by Lorenzo Allegrucci.

 - bugfix: enable interrupts in the int3 handler - gdb will otherwise
   trigger a kernel debug message.

 - cleanup: reworked the RCU API wrappers, we now have the following
   variants:
 
     rcu_read_[un]lock_spin(&spinlock)
     rcu_read_[un]lock_bh_spin(&spinlock)
     rcu_read_[un]lock_sem(&semaphore)

   this change was necessary for the network locking fixes.

 - debugging helper: SysRq-T will now print the stacktrace of currently
   running tasks too. (They might be a bit unreliable occasionally but
   very useful to debug deadlocks.)

 - configurability fix: disabled the /proc/kernel/softirq_preemption and
   hardirq_preemption runtime flags (and the softirq-preempt= and
   hardirq-preempt= boot flags) if PREEMPT_REALTIME is enabled - in the
   fully preemptible model these must always be on.

there are no known bugs at this moment, so please re-report any issues 
you might still encounter.

to create a -U1 tree from scratch the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc4.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/2.6.9-rc4-mm1.bz2
 + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U1

	Ingo
