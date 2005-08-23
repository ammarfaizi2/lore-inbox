Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbVHWVoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVHWVoe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbVHWVob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:44:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12470 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932438AbVHWVoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:44:19 -0400
To: torvalds@osdl.org
Subject: [PATCH] (31/43) m32r icu_data gcc4 fixes
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Message-Id: <E1E7gc6-0007Di-5x@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:47:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

either icu_data declaration for SMP case should be taken out of m32102.h,
or its declarations for m32700ut and opsput should not be static for SMP.
Patch does the latter - judging by comments in m32102.h it is intended to
be non-static.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-m32r-smp/arch/m32r/kernel/setup_m32700ut.c RC13-rc6-git13-m32r-icu_data/arch/m32r/kernel/setup_m32700ut.c
--- RC13-rc6-git13-m32r-smp/arch/m32r/kernel/setup_m32700ut.c	2005-08-10 10:37:46.000000000 -0400
+++ RC13-rc6-git13-m32r-icu_data/arch/m32r/kernel/setup_m32700ut.c	2005-08-21 13:17:13.000000000 -0400
@@ -30,9 +30,11 @@
 typedef struct {
 	unsigned long icucr;  /* ICU Control Register */
 } icu_data_t;
+static icu_data_t icu_data[M32700UT_NUM_CPU_IRQ];
+#else
+icu_data_t icu_data[M32700UT_NUM_CPU_IRQ];
 #endif /* CONFIG_SMP */
 
-static icu_data_t icu_data[M32700UT_NUM_CPU_IRQ];
 
 static void disable_m32700ut_irq(unsigned int irq)
 {
diff -urN RC13-rc6-git13-m32r-smp/arch/m32r/kernel/setup_opsput.c RC13-rc6-git13-m32r-icu_data/arch/m32r/kernel/setup_opsput.c
--- RC13-rc6-git13-m32r-smp/arch/m32r/kernel/setup_opsput.c	2005-08-10 10:37:46.000000000 -0400
+++ RC13-rc6-git13-m32r-icu_data/arch/m32r/kernel/setup_opsput.c	2005-08-21 13:17:13.000000000 -0400
@@ -31,9 +31,11 @@
 typedef struct {
 	unsigned long icucr;  /* ICU Control Register */
 } icu_data_t;
+static icu_data_t icu_data[OPSPUT_NUM_CPU_IRQ];
+#else
+icu_data_t icu_data[OPSPUT_NUM_CPU_IRQ];
 #endif /* CONFIG_SMP */
 
-static icu_data_t icu_data[OPSPUT_NUM_CPU_IRQ];
 
 static void disable_opsput_irq(unsigned int irq)
 {
