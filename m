Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbVBKVtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbVBKVtR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 16:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbVBKVtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 16:49:17 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:31669 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262352AbVBKVtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 16:49:13 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050211100405.GA7452@elte.hu>
References: <20050211082841.GA3349@elte.hu>
	 <000601c5101f$8ca3c1e0$c800a8c0@mvista.com> <20050211100405.GA7452@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 11 Feb 2005 16:49:07 -0500
Message-Id: <1108158547.21183.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Here's a trivial patch to help others from freaking out when they see on
a show_trace that most of their processes are TASK_UNINTERRUPTIBLE. 

Index: kernel/sched.c
===================================================================
--- kernel/sched.c	(revision 75)
+++ kernel/sched.c	(working copy)
@@ -4489,7 +4489,7 @@
 	task_t *relative;
 	unsigned state;
 	unsigned long free = 0;
-	static const char *stat_nam[] = { "R", "S", "D", "T", "t", "Z", "X" };
+	static const char *stat_nam[] = { "R", "M", "S", "D", "T", "t", "Z", "X" };
 
 	printk("%-13.13s [%p]", p->comm, p);
 	state = p->state ? __ffs(p->state) + 1 : 0;


I figure that "M" would be a good fit for TASK_RUNNING_MUTEX.

-- Steve


