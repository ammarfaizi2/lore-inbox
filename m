Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319682AbSH3Viq>; Fri, 30 Aug 2002 17:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319667AbSH3Vin>; Fri, 30 Aug 2002 17:38:43 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44043 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319680AbSH3Ve4>; Fri, 30 Aug 2002 17:34:56 -0400
To: LKML <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 2.5.32-smph
Message-Id: <E17ktU3-00035O-00@flint.arm.linux.org.uk>
Date: Fri, 30 Aug 2002 22:39:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch appears not to be in 2.5.32, but applies cleanly.

Use of cpu_online on UP causes the following warnings:

page_alloc.c:555: warning: statement with no effect
proc_misc.c:297: warning: statement with no effect
proc_misc.c:313: warning: statement with no effect
dev.c:1824: warning: statement with no effect

This patch fixes these warnings.

 include/linux/smp.h |    2 +-
 1 files changed, 1 insertion, 1 deletion

--- orig/include/linux/smp.h	Fri Aug 30 14:53:33 2002
+++ linux/include/linux/smp.h	Fri Aug 30 14:51:19 2002
@@ -94,7 +94,7 @@
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
 #define cpu_online_map				1
-#define cpu_online(cpu)				({ cpu; 1; })
+#define cpu_online(cpu)				({ (void)cpu; 1; })
 #define num_online_cpus()			1
 #define num_booting_cpus()			1
 
