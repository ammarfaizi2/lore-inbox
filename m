Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266367AbSLTWwo>; Fri, 20 Dec 2002 17:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266411AbSLTWwo>; Fri, 20 Dec 2002 17:52:44 -0500
Received: from dp.samba.org ([66.70.73.150]:1246 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266367AbSLTWwm>;
	Fri, 20 Dec 2002 17:52:42 -0500
Date: Sat, 21 Dec 2002 09:57:14 +1100
From: Anton Blanchard <anton@samba.org>
To: William Lee Irwin III <wli@holomorphy.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, bjorn_helgaas@hp.com
Subject: Re: [PATCH] Fix CPU bitmask truncation
Message-ID: <20021220225714.GA10263@krispykreme>
References: <200212161213.29230.bjorn_helgaas@hp.com> <20021220103028.GB9704@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021220103028.GB9704@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Linus, this is the 2.5.x version of the same patch originally by Bjorn
> for 2.4.x. This fixes an entire class of critical 64-bit bugs.
> 
> Against 2.5.52-bk as of 2:25AM 20 Dec 2002. Please apply.

Here's one in 2.5, found when adding 64 CPU support to ppc64.

Anton

===== kernel/module.c 1.31 vs edited =====
--- 1.31/kernel/module.c	Mon Dec  2 17:44:11 2002
+++ edited/kernel/module.c	Tue Dec 17 10:29:27 2002
@@ -210,7 +210,7 @@
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO-1 };
 	setscheduler(current->pid, SCHED_FIFO, &param);
 #endif
-	set_cpus_allowed(current, 1 << (unsigned long)cpu);
+	set_cpus_allowed(current, 1UL << (unsigned long)cpu);
 
 	/* Ack: we are alive */
 	atomic_inc(&stopref_thread_ack);
@@ -271,7 +271,7 @@
 
 	/* FIXME: racy with set_cpus_allowed. */
 	old_allowed = current->cpus_allowed;
-	set_cpus_allowed(current, 1 << (unsigned long)cpu);
+	set_cpus_allowed(current, 1UL << (unsigned long)cpu);
 
 	atomic_set(&stopref_thread_ack, 0);
 	stopref_num_threads = 0;
