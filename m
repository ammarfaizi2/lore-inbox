Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVCSTRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVCSTRU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 14:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVCSTRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 14:17:20 -0500
Received: from mx1.elte.hu ([157.181.1.137]:29870 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261718AbVCSTRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 14:17:11 -0500
Date: Sat, 19 Mar 2005 20:16:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-00
Message-ID: <20050319191658.GA5921@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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


i have released the -V0.7.41-00 Real-Time Preemption patch (merged to
2.6.12-rc1), which can be downloaded from the usual place:

  http://redhat.com/~mingo/realtime-preempt/

the biggest change in this patch is the merge of Paul E. McKenney's
preemptable RCU code. The new RCU code is active on PREEMPT_RT. While it
is still quite experimental at this stage, it allowed the removal of
locking cruft (mainly in the networking code), so it could solve some of
the longstanding netfilter/networking deadlocks/crashes reported by a
number of people. Be careful nevertheless.

there are a couple of minor changes relative to Paul's latest
preemptable-RCU code drop:

 - made the two variants two #ifdef blocks - this is sufficient for now
   and we'll see what the best way is in the longer run.

 - moved rcu_check_callbacks() from the timer IRQ to ksoftirqd. (the
   timer IRQ still runs in hardirq context on PREEMPT_RT.)

 - changed the irq-flags method to a preempt_disable()-based method, and
   moved the lock taking outside of the critical sections. (due to locks
   potentially sleeping on PREEMPT_RT).

to create a -V0.7.41-00 tree from scratch, the patching order is:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc1.bz2
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc1-V0.7.41-00

	Ingo

