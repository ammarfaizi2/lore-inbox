Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131376AbRC3NDs>; Fri, 30 Mar 2001 08:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131392AbRC3NDi>; Fri, 30 Mar 2001 08:03:38 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:30478 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S131376AbRC3NDX>;
	Fri, 30 Mar 2001 08:03:23 -0500
Date: Fri, 30 Mar 2001 16:00:02 +0300 (EEST)
From: Jani Monoses <jani@virtualro.ic.ro>
To: linux-kernel@vger.kernel.org
Subject: OOM killer ultimate patch...
Message-ID: <Pine.LNX.4.10.10103301556210.21061-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi 

here's the patch that will solve all OOM killer problems out
there...someone had to do it.

Jani.

--- linux/mm/oom_kill.c.orig	Fri Mar 30 11:06:24 2001
+++ linux/mm/oom_kill.c	Fri Mar 30 14:49:56 2001
@@ -147,6 +147,16 @@
  * CAP_SYS_RAW_IO set, send SIGTERM instead (but it's unlikely that
  * we select a process with CAP_SYS_RAW_IO set).
  */
+
+/*
+ * Even if these new signals are not (yet) required by SuS or POSIX ,
+ * Linux should be able to handle them...
+ * PIGTERM and PIGKILL are similar to SIGTERM and SIGKILL.The difference is that they are
+ * only sent to memory hogs, hence their name.
+ */ 
+#define PIGTERM	SIGTERM
+#define PIGKILL	SIGKILL
+
 void oom_kill(void)
 {
 
@@ -168,9 +178,9 @@
 
 	/* This process has hardware access, be more careful. */
 	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
-		force_sig(SIGTERM, p);
+		force_sig(PIGTERM, p);
 	} else {
-		force_sig(SIGKILL, p);
+		force_sig(PIGKILL, p);
 	}
 
 	/*

