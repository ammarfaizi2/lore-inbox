Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266761AbTBLGTO>; Wed, 12 Feb 2003 01:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266938AbTBLGTO>; Wed, 12 Feb 2003 01:19:14 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:23564
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S266761AbTBLGTN>; Wed, 12 Feb 2003 01:19:13 -0500
Subject: [patch] kernel_flag is not needed on UP+preempt
From: Robert Love <rml@tech9.net>
To: akpm@digeo.com, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1045031340.786.89.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-1) 
Date: 12 Feb 2003 01:29:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to define and declare the actual kernel_flag spinlock
on UP systems, even if kernel preemption is enabled.

Preempt needs to use the lock_kernel() calls, but it does not need the
actual lock to exist.

So change the check from SMP || PREEMPT to just SMP.  Tests fine.  Patch
is against 2.5.60.

	Robert Love

 kernel/sched.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -urN linux-2.5.60-mm1/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.60-mm1/kernel/sched.c	2003-02-12 00:28:51.788915192 -0500
+++ linux/kernel/sched.c	2003-02-12 00:29:10.539064736 -0500
@@ -2644,7 +2644,7 @@
 
 #endif
 
-#if CONFIG_SMP || CONFIG_PREEMPT
+#if CONFIG_SMP
 /*
  * The 'big kernel lock'
  *



