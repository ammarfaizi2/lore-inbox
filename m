Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269519AbUIZMWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269519AbUIZMWc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 08:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269518AbUIZMWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 08:22:32 -0400
Received: from verein.lst.de ([213.95.11.210]:39052 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S269519AbUIZMWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 08:22:13 -0400
Date: Sun, 26 Sep 2004 14:22:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: anton@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] reduce ifdef clutter in arch/ppc64/kernel/sysfs.c
Message-ID: <20040926122209.GC2179@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.12/arch/ppc64/kernel/sysfs.c	2004-09-21 09:22:33 +02:00
+++ edited/arch/ppc64/kernel/sysfs.c	2004-09-25 17:19:25 +02:00
@@ -15,8 +15,7 @@
 
 /* SMT stuff */
 
-#ifndef CONFIG_PPC_ISERIES
-
+#ifdef CONFIG_PPC_MULTIPLATFORM
 /* default to snooze disabled */
 DEFINE_PER_CPU(unsigned long, smt_snooze_delay);
 
@@ -92,19 +91,6 @@
 }
 __setup("smt-snooze-delay=", setup_smt_snooze_delay);
 
-#endif
-
-
-/* PMC stuff */
-
-#ifdef CONFIG_PPC_ISERIES
-void ppc64_enable_pmcs(void)
-{
-	/* XXX Implement for iseries */
-}
-#endif
-
-#ifdef CONFIG_PPC_MULTIPLATFORM
 /*
  * Enabling PMCs will slow partition context switch times so we only do
  * it the first time we write to the PMCs.
@@ -180,6 +166,14 @@
 		mtspr(CTRLT, ctrl);
 	}
 #endif /* CONFIG_PPC_PSERIES */
+}
+
+#else
+
+/* PMC stuff */
+void ppc64_enable_pmcs(void)
+{
+	/* XXX Implement for iseries */
 }
 #endif /* CONFIG_PPC_MULTIPLATFORM */
 
