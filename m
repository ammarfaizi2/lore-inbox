Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261819AbTCGWJN>; Fri, 7 Mar 2003 17:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261813AbTCGWJJ>; Fri, 7 Mar 2003 17:09:09 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:51215
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261815AbTCGWI3>; Fri, 7 Mar 2003 17:08:29 -0500
Subject: [patch] no need for kernel_flag on UP
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1047075530.12130.8.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 07 Mar 2003 17:18:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Attached patch is a minor cleanup (and memory reduction for gcc < 3). 
We currently define and declare the BKL's kernel_flag spinlock on either
SMP or PREEMPT, which means a UP+PREEMPT machine gets it.

We only need the actual lock on SMP.

Patch is against current BK, please apply.

	Robert Love


 kernel/sched.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -urN linux-2.5.64-bk/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.64-bk/kernel/sched.c	2003-03-07 17:01:34.727552472 -0500
+++ linux/kernel/sched.c	2003-03-07 17:14:54.684940464 -0500
@@ -2405,7 +2405,7 @@
 
 #endif
 
-#if CONFIG_SMP || CONFIG_PREEMPT
+#if CONFIG_SMP
 /*
  * The 'big kernel lock'
  *



