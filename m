Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWFZQRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWFZQRP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWFZQRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:17:15 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:23684 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1750748AbWFZQRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:17:14 -0400
Date: Mon, 26 Jun 2006 09:16:37 -0700
From: Daniel Walker <dwalker@dwalker1.mvista.com>
Message-Id: <200606261616.k5QGGbem016569@dwalker1.mvista.com>
To: tglx@linutronix.de
Cc: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: NO_HZ Kconfig rework
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got NO_HZ working on ARM, but because the ARM tree already
extensively implements NO_IDLE_HZ I had to make NO_HZ a
completely seprate option.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 kernel/sysctl.c     |    2 +-
 kernel/time/Kconfig |    5 -----
 kernel/timer.c      |    2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

Index: linux-2.6.17/kernel/sysctl.c
===================================================================
--- linux-2.6.17.orig/kernel/sysctl.c
+++ linux-2.6.17/kernel/sysctl.c
@@ -581,7 +581,7 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_NO_IDLE_HZ
+#ifdef CONFIG_NO_HZ
 	{
 		.ctl_name       = KERN_TIMEOUT_GRANULARITY,
 		.procname       = "timeout_granularity",
Index: linux-2.6.17/kernel/time/Kconfig
===================================================================
--- linux-2.6.17.orig/kernel/time/Kconfig
+++ linux-2.6.17/kernel/time/Kconfig
@@ -17,11 +17,6 @@ config NO_HZ
 	  only trigger on an as-needed basis both when the system is
 	  busy and when the system is idle.
 
-config NO_IDLE_HZ
-	bool
-	default y
-	depends on NO_HZ
-
 config HIGH_RES_RESOLUTION
 	int "High Resolution Timer resolution (nanoseconds)"
 	depends on HIGH_RES_TIMERS
Index: linux-2.6.17/kernel/timer.c
===================================================================
--- linux-2.6.17.orig/kernel/timer.c
+++ linux-2.6.17/kernel/timer.c
@@ -484,7 +484,7 @@ static inline void __run_timers(tvec_bas
 	set_running_timer(base, NULL);
 }
 
-#ifdef CONFIG_NO_IDLE_HZ
+#if defined(CONFIG_NO_IDLE_HZ) || defined(CONFIG_NO_HZ)
 /*
  * Find out when the next timer event is due to happen. This
  * is used on S/390 to stop all activity when a cpus is idle.
