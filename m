Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWE2V2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWE2V2r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWE2V2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:28:07 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:12002 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751361AbWE2V1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:27:54 -0400
Date: Mon, 29 May 2006 23:28:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 61/61] lock validator: enable lock validator in Kconfig
Message-ID: <20060529212812.GI3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

offer the following lock validation options:

 CONFIG_PROVE_SPIN_LOCKING
 CONFIG_PROVE_RW_LOCKING
 CONFIG_PROVE_MUTEX_LOCKING
 CONFIG_PROVE_RWSEM_LOCKING

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 lib/Kconfig.debug |  167 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 167 insertions(+)

Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -184,6 +184,173 @@ config DEBUG_SPINLOCK
 	  best used in conjunction with the NMI watchdog so that spinlock
 	  deadlocks are also debuggable.
 
+config PROVE_SPIN_LOCKING
+	bool "Prove spin-locking correctness"
+	default y
+	help
+	 This feature enables the kernel to prove that all spinlock
+	 locking that occurs in the kernel runtime is mathematically
+	 correct: that under no circumstance could an arbitrary (and
+	 not yet triggered) combination of observed spinlock locking
+	 sequences (on an arbitrary number of CPUs, running an
+	 arbitrary number of tasks and interrupt contexts) cause a
+	 deadlock.
+
+	 In short, this feature enables the kernel to report spinlock
+	 deadlocks before they actually occur.
+
+	 The proof does not depend on how hard and complex a
+	 deadlock scenario would be to trigger: how many
+	 participant CPUs, tasks and irq-contexts would be needed
+	 for it to trigger. The proof also does not depend on
+	 timing: if a race and a resulting deadlock is possible
+	 theoretically (no matter how unlikely the race scenario
+	 is), it will be proven so and will immediately be
+	 reported by the kernel (once the event is observed that
+	 makes the deadlock theoretically possible).
+
+	 If a deadlock is impossible (i.e. the locking rules, as
+	 observed by the kernel, are mathematically correct), the
+	 kernel reports nothing.
+
+	 NOTE: this feature can also be enabled for rwlocks, mutexes
+	 and rwsems - in which case all dependencies between these
+	 different locking variants are observed and mapped too, and
+	 the proof of observed correctness is also maintained for an
+	 arbitrary combination of these separate locking variants.
+
+	 For more details, see Documentation/locking-correctness.txt.
+
+config PROVE_RW_LOCKING
+	bool "Prove rw-locking correctness"
+	default y
+	help
+	 This feature enables the kernel to prove that all rwlock
+	 locking that occurs in the kernel runtime is mathematically
+	 correct: that under no circumstance could an arbitrary (and
+	 not yet triggered) combination of observed rwlock locking
+	 sequences (on an arbitrary number of CPUs, running an
+	 arbitrary number of tasks and interrupt contexts) cause a
+	 deadlock.
+
+	 In short, this feature enables the kernel to report rwlock
+	 deadlocks before they actually occur.
+
+	 The proof does not depend on how hard and complex a
+	 deadlock scenario would be to trigger: how many
+	 participant CPUs, tasks and irq-contexts would be needed
+	 for it to trigger. The proof also does not depend on
+	 timing: if a race and a resulting deadlock is possible
+	 theoretically (no matter how unlikely the race scenario
+	 is), it will be proven so and will immediately be
+	 reported by the kernel (once the event is observed that
+	 makes the deadlock theoretically possible).
+
+	 If a deadlock is impossible (i.e. the locking rules, as
+	 observed by the kernel, are mathematically correct), the
+	 kernel reports nothing.
+
+	 NOTE: this feature can also be enabled for spinlocks, mutexes
+	 and rwsems - in which case all dependencies between these
+	 different locking variants are observed and mapped too, and
+	 the proof of observed correctness is also maintained for an
+	 arbitrary combination of these separate locking variants.
+
+	 For more details, see Documentation/locking-correctness.txt.
+
+config PROVE_MUTEX_LOCKING
+	bool "Prove mutex-locking correctness"
+	default y
+	help
+	 This feature enables the kernel to prove that all mutexlock
+	 locking that occurs in the kernel runtime is mathematically
+	 correct: that under no circumstance could an arbitrary (and
+	 not yet triggered) combination of observed mutexlock locking
+	 sequences (on an arbitrary number of CPUs, running an
+	 arbitrary number of tasks and interrupt contexts) cause a
+	 deadlock.
+
+	 In short, this feature enables the kernel to report mutexlock
+	 deadlocks before they actually occur.
+
+	 The proof does not depend on how hard and complex a
+	 deadlock scenario would be to trigger: how many
+	 participant CPUs, tasks and irq-contexts would be needed
+	 for it to trigger. The proof also does not depend on
+	 timing: if a race and a resulting deadlock is possible
+	 theoretically (no matter how unlikely the race scenario
+	 is), it will be proven so and will immediately be
+	 reported by the kernel (once the event is observed that
+	 makes the deadlock theoretically possible).
+
+	 If a deadlock is impossible (i.e. the locking rules, as
+	 observed by the kernel, are mathematically correct), the
+	 kernel reports nothing.
+
+	 NOTE: this feature can also be enabled for spinlock, rwlocks
+	 and rwsems - in which case all dependencies between these
+	 different locking variants are observed and mapped too, and
+	 the proof of observed correctness is also maintained for an
+	 arbitrary combination of these separate locking variants.
+
+	 For more details, see Documentation/locking-correctness.txt.
+
+config PROVE_RWSEM_LOCKING
+	bool "Prove rwsem-locking correctness"
+	default y
+	help
+	 This feature enables the kernel to prove that all rwsemlock
+	 locking that occurs in the kernel runtime is mathematically
+	 correct: that under no circumstance could an arbitrary (and
+	 not yet triggered) combination of observed rwsemlock locking
+	 sequences (on an arbitrary number of CPUs, running an
+	 arbitrary number of tasks and interrupt contexts) cause a
+	 deadlock.
+
+	 In short, this feature enables the kernel to report rwsemlock
+	 deadlocks before they actually occur.
+
+	 The proof does not depend on how hard and complex a
+	 deadlock scenario would be to trigger: how many
+	 participant CPUs, tasks and irq-contexts would be needed
+	 for it to trigger. The proof also does not depend on
+	 timing: if a race and a resulting deadlock is possible
+	 theoretically (no matter how unlikely the race scenario
+	 is), it will be proven so and will immediately be
+	 reported by the kernel (once the event is observed that
+	 makes the deadlock theoretically possible).
+
+	 If a deadlock is impossible (i.e. the locking rules, as
+	 observed by the kernel, are mathematically correct), the
+	 kernel reports nothing.
+
+	 NOTE: this feature can also be enabled for spinlocks, rwlocks
+	 and mutexes - in which case all dependencies between these
+	 different locking variants are observed and mapped too, and
+	 the proof of observed correctness is also maintained for an
+	 arbitrary combination of these separate locking variants.
+
+	 For more details, see Documentation/locking-correctness.txt.
+
+config LOCKDEP
+	bool
+	default y
+	depends on PROVE_SPIN_LOCKING || PROVE_RW_LOCKING || PROVE_MUTEX_LOCKING || PROVE_RWSEM_LOCKING
+
+config DEBUG_LOCKDEP
+	bool "Lock dependency engine debugging"
+	depends on LOCKDEP
+	default y
+	help
+	  If you say Y here, the lock dependency engine will do
+	  additional runtime checks to debug itself, at the price
+	  of more runtime overhead.
+
+config TRACE_IRQFLAGS
+	bool
+	default y
+	depends on PROVE_SPIN_LOCKING || PROVE_RW_LOCKING
+
 config DEBUG_SPINLOCK_SLEEP
 	bool "Sleep-inside-spinlock checking"
 	depends on DEBUG_KERNEL
