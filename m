Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVHGDFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVHGDFk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 23:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVHGDFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 23:05:40 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:20912 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750775AbVHGDFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 23:05:39 -0400
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption,
	-RT-2.6.13-rc4-V0.7.52-01]
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
In-Reply-To: <20050805105943.GA24994@elte.hu>
References: <1123186583.12009.32.camel@localhost.localdomain>
	 <20050805105943.GA24994@elte.hu>
Content-Type: text/plain
Date: Sat, 06 Aug 2005 23:05:35 -0400
Message-Id: <1123383935.17039.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zOn Fri, 2005-08-05 at 12:59 +0200, Ingo Molnar wrote:
> ok, looks good - i've applied it and released the -52-14 PREEMPT_RT 
> patch.
> 

Does not compile if RCU stats are enabled but torture test disabled.

Lee

--- linux-2.6.13-rc4/fs/proc/proc_misc.c.orig	2005-08-06 22:59:46.000000000 -0400
+++ linux-2.6.13-rc4/fs/proc/proc_misc.c	2005-08-06 23:04:42.000000000 -0400
@@ -654,6 +654,7 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+#ifdef CONFIG_RCU_TORTURE_TEST
 int rcu_read_proc_torture_writer(char *page, char **start, off_t off,
 			         int count, int *eof, void *data)
 {
@@ -683,6 +684,7 @@
 	len = rcu_read_proc_torture_stats_data(page);
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
+#endif /* #ifdef CONFIG_RCU_TORTURE_TEST */
 #endif /* #ifdef CONFIG_RCU_STATS */
 
 void __init proc_misc_init(void)
@@ -712,9 +714,11 @@
 		{"rcugp",	rcu_read_proc_gp},
 		{"rcuptrs",	rcu_read_proc_ptrs},
 		{"rcuctrs",	rcu_read_proc_ctrs},
+#ifdef CONFIG_RCU_TORTURE_TEST
 		{"rcutw",	rcu_read_proc_torture_writer},
 		{"rcutr",	rcu_read_proc_torture_reader},
 		{"rcuts",	rcu_read_proc_torture_stats},
+#endif /* #ifdef CONFIG_RCU_TORTURE_TEST */
 #endif /* #ifdef CONFIG_RCU_STATS */
 		{NULL,}
 	};


Lee

