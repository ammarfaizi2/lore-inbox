Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWIHMRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWIHMRJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 08:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWIHMRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 08:17:09 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:7887 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750904AbWIHMRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 08:17:07 -0400
Date: Fri, 8 Sep 2006 14:16:26 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch -mm] s390: fix save_stack_trace
Message-ID: <20060908121626.GC6913@osiris.boeblingen.de.ibm.com>
References: <20060908011317.6cb0495a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908011317.6cb0495a.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

x86_64-mm-stacktrace-cleanup.patch reverses the logic in s390's
save_stack_trace incorrectly. Fix this.

Cc: Andi Kleen <ak@suse.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/stacktrace.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6.17/arch/s390/kernel/stacktrace.c
===================================================================
--- linux-2.6.17.orig/arch/s390/kernel/stacktrace.c	2006-09-08 13:44:44.000000000 +0200
+++ linux-2.6.17/arch/s390/kernel/stacktrace.c	2006-09-08 14:00:36.000000000 +0200
@@ -70,12 +70,12 @@
 	sp = save_context_stack(trace, &trace->skip, sp,
 				S390_lowcore.panic_stack - PAGE_SIZE,
 				S390_lowcore.panic_stack);
-	if ((sp != orig_sp) && trace->all_contexts)
+	if ((sp != orig_sp) && !trace->all_contexts)
 		return;
 	sp = save_context_stack(trace, &trace->skip, sp,
 				S390_lowcore.async_stack - ASYNC_SIZE,
 				S390_lowcore.async_stack);
-	if ((sp != orig_sp) && trace->all_contexts)
+	if ((sp != orig_sp) && !trace->all_contexts)
 		return;
 	if (task)
 		save_context_stack(trace, &trace->skip, sp,
@@ -85,5 +85,4 @@
 		save_context_stack(trace, &trace->skip, sp,
 				   S390_lowcore.thread_info,
 				   S390_lowcore.thread_info + THREAD_SIZE);
-	return;
 }
