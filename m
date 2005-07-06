Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbVGFCqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVGFCqP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVGFCmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:42:20 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:7833 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262064AbVGFCTX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:23 -0400
Subject: [PATCH] [24/48] Suspend2 2.1.9.8 for 2.6.12: 601-kernel_power_power-header.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:42 +1000
Message-Id: <11206164422542@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 602-smp.patch-old/kernel/power/suspend2_core/smp.c 602-smp.patch-new/kernel/power/suspend2_core/smp.c
--- 602-smp.patch-old/kernel/power/suspend2_core/smp.c	1970-01-01 10:00:00.000000000 +1000
+++ 602-smp.patch-new/kernel/power/suspend2_core/smp.c	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,12 @@
+#include <linux/sched.h>
+
+void ensure_on_processor_zero(void)
+{
+	set_cpus_allowed(current, cpumask_of_cpu(0));
+	BUG_ON(smp_processor_id() != 0);
+}
+
+void return_to_all_processors(void)
+{
+	set_cpus_allowed(current, CPU_MASK_ALL);
+}
diff -ruNp 602-smp.patch-old/kernel/power/suspend2_core/smp.h 602-smp.patch-new/kernel/power/suspend2_core/smp.h
--- 602-smp.patch-old/kernel/power/suspend2_core/smp.h	1970-01-01 10:00:00.000000000 +1000
+++ 602-smp.patch-new/kernel/power/suspend2_core/smp.h	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,7 @@
+#ifdef CONFIG_SMP
+extern void ensure_on_processor_zero(void);
+extern void return_to_all_processors(void);
+#else
+#define ensure_on_processor_zero() do { } while(0)
+#define return_to_all_processors() do { } while(0)
+#endif

