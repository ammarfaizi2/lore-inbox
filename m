Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVCJFCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVCJFCQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 00:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVCJFBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 00:01:18 -0500
Received: from fmr22.intel.com ([143.183.121.14]:25728 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262362AbVCJE4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 23:56:31 -0500
Date: Wed, 9 Mar 2005 20:55:54 -0800
From: Luming Yu <luming@unix-os.sc.intel.com>
To: ak@muc.de
Cc: luming.yu@intel.com, linux-kernel@vger.kernel.org
Subject: [Patch] resume PIT  
Message-ID: <20050309205554.A29484@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AWniW0JNca5xppdA"
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AWniW0JNca5xppdA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit



[PATCH] resume PIT for x86_64


Signed-off-by: Luming Yu <luming.yu@intel.com>




diff -BruN 0/arch/x86_64/kernel/i8259.c 1/arch/x86_64/kernel/i8259.c
--- 0/arch/x86_64/kernel/i8259.c	2005-03-07 23:29:42.000000000 +0800
+++ 1/arch/x86_64/kernel/i8259.c	2005-03-09 12:53:10.000000000 +0800
@@ -477,6 +477,7 @@
 void call_function_interrupt(void);
 void invalidate_interrupt(void);
 void thermal_interrupt(void);
+void i8254_timer_resume(void);
 
 static void setup_timer(void)
 {
@@ -493,6 +494,11 @@
 	return 0;
 }
 
+void i8254_timer_resume(void)
+{
+	setup_timer();
+}
+
 static struct sysdev_class timer_sysclass = {
 	set_kset_name("timer"),
 	.resume		= timer_resume,
diff -BruN 0/arch/x86_64/kernel/time.c 1/arch/x86_64/kernel/time.c
--- 0/arch/x86_64/kernel/time.c	2005-03-07 23:32:23.000000000 +0800
+++ 1/arch/x86_64/kernel/time.c	2005-03-09 12:53:10.000000000 +0800
@@ -46,7 +46,7 @@
 #ifdef CONFIG_CPU_FREQ
 static void cpufreq_delayed_get(void);
 #endif
-
+extern void i8254_timer_resume(void);
 extern int using_apic_timer;
 
 DEFINE_SPINLOCK(rtc_lock);
@@ -980,6 +980,8 @@
 
 	if (vxtime.hpet_address)
 		hpet_reenable();
+	else
+		i8254_timer_resume();
 
 	sec = ctime + clock_cmos_diff;
 	write_seqlock_irqsave(&xtime_lock,flags);

--AWniW0JNca5xppdA
Content-Type: application/octet-stream; charset=us-ascii
Content-Disposition: attachment; filename="i8254.patch"

diff -BruN 0/arch/x86_64/kernel/i8259.c 1/arch/x86_64/kernel/i8259.c
--- 0/arch/x86_64/kernel/i8259.c	2005-03-07 23:29:42.000000000 +0800
+++ 1/arch/x86_64/kernel/i8259.c	2005-03-09 12:53:10.000000000 +0800
@@ -477,6 +477,7 @@
 void call_function_interrupt(void);
 void invalidate_interrupt(void);
 void thermal_interrupt(void);
+void i8254_timer_resume(void);
 
 static void setup_timer(void)
 {
@@ -493,6 +494,11 @@
 	return 0;
 }
 
+void i8254_timer_resume(void)
+{
+	setup_timer();
+}
+
 static struct sysdev_class timer_sysclass = {
 	set_kset_name("timer"),
 	.resume		= timer_resume,
diff -BruN 0/arch/x86_64/kernel/time.c 1/arch/x86_64/kernel/time.c
--- 0/arch/x86_64/kernel/time.c	2005-03-07 23:32:23.000000000 +0800
+++ 1/arch/x86_64/kernel/time.c	2005-03-09 12:53:10.000000000 +0800
@@ -46,7 +46,7 @@
 #ifdef CONFIG_CPU_FREQ
 static void cpufreq_delayed_get(void);
 #endif
-
+extern void i8254_timer_resume(void);
 extern int using_apic_timer;
 
 DEFINE_SPINLOCK(rtc_lock);
@@ -980,6 +980,8 @@
 
 	if (vxtime.hpet_address)
 		hpet_reenable();
+	else
+		i8254_timer_resume();
 
 	sec = ctime + clock_cmos_diff;
 	write_seqlock_irqsave(&xtime_lock,flags);

--AWniW0JNca5xppdA--
