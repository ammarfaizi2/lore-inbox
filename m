Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbUKAGDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbUKAGDz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 01:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUKAGDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 01:03:54 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:37257 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261390AbUKAGD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 01:03:29 -0500
Message-ID: <cone.1099288993.561400.26204.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: akpm@osdl.org, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org
Subject: [PATCH][plugsched additions 2/2] Miscellanous fixes
Date: Mon, 01 Nov 2004 17:03:13 +1100
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_pc.kolivas.org-1099288993-0000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_pc.kolivas.org-1099288993-0000
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Miscellanous fixes


--=_pc.kolivas.org-1099288993-0000
Content-Description: Miscellanous fixes
Content-Disposition: inline;
  FILENAME="misc_fixes.diff"
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Miscellanous build fixes.

Because swapper becomes the idle task we have to do some magic only on SMP
to make it boot.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.10-rc1-mm2-plugsched/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched.orig/kernel/sched.c	2004-11-01 13:03:18.000000000 +1100
+++ linux-2.6.10-rc1-mm2-plugsched/kernel/sched.c	2004-11-01 13:03:20.000000000 +1100
@@ -4076,10 +4076,10 @@ static void ingo_destroy_sched_domain_sy
 	kfree(root);
 }
 #else
-static void ingo_init_sched_domain_sysctl()
+static void ingo_init_sched_domain_sysctl(void)
 {
 }
-static void ingo_destroy_sched_domain_sysctl()
+static void ingo_destroy_sched_domain_sysctl(void)
 {
 }
 #endif
Index: linux-2.6.10-rc1-mm2-plugsched/kernel/staircase.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched.orig/kernel/staircase.c	2004-11-01 13:03:18.000000000 +1100
+++ linux-2.6.10-rc1-mm2-plugsched/kernel/staircase.c	2004-11-01 14:47:06.724113368 +1100
@@ -3676,7 +3676,14 @@ static void __init sc_sched_init(void)
 	 * when this runqueue becomes "idle".
 	 */
 	init_idle(current, smp_processor_id());
+
+#ifdef CONFIG_SMP
+	/*
+	 * SMP needs a little extra magic to work since we are now the idle
+	 * task.
+	 */
 	current->u.scsched.prio = MAX_PRIO - 1;
+#endif
 }
 
 #if defined(CONFIG_DEBUG_KERNEL)&&defined(CONFIG_SYSCTL)&&defined(CONFIG_SMP)
@@ -3808,10 +3815,10 @@ static void sc_destroy_sched_domain_sysc
 	kfree(root);
 }
 #else
-static void sc_init_sched_domain_sysctl()
+static void sc_init_sched_domain_sysctl(void)
 {
 }
-static void sc_destroy_sched_domain_sysctl()
+static void sc_destroy_sched_domain_sysctl(void)
 {
 }
 #endif

--=_pc.kolivas.org-1099288993-0000--
