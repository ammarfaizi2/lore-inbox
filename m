Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbUKCSqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbUKCSqf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 13:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbUKCSqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 13:46:35 -0500
Received: from verein.lst.de ([213.95.11.210]:12519 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261798AbUKCSqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 13:46:30 -0500
Date: Wed, 3 Nov 2004 19:46:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] deprecate cli, sti & friends
Message-ID: <20041103184625.GA24462@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We provided compat wrappers for !CONFIG_SMP builds for ages, but I think
it's time to get the last folks to notice this can't stay so forever..


Signed-off-by: Christoph Hellwig <hch@lst.de>


--- 1.33/include/linux/interrupt.h	2004-10-28 09:40:01 +02:00
+++ edited/include/linux/interrupt.h	2004-11-03 19:30:33 +01:00
@@ -61,12 +61,30 @@
  * Temporary defines for UP kernels, until all code gets fixed.
  */
 #ifndef CONFIG_SMP
-# define cli()			local_irq_disable()
-# define sti()			local_irq_enable()
-# define save_flags(x)		local_save_flags(x)
-# define restore_flags(x)	local_irq_restore(x)
-# define save_and_cli(x)	local_irq_save(x)
-#endif
+static inline void __deprecated cli(void)
+{
+	local_irq_disable();
+}
+static inline void __deprecated sti(void)
+{
+	local_irq_enable();
+}
+static inline void __deprecated save_flags(unsigned long *x)
+{
+	local_save_flags(*x);
+}
+#define save_flags(x) save_flags(&x);
+static inline void __deprecated restore_flags(unsigned long x)
+{
+	local_irq_restore(x);
+}
+
+static inline void __deprecated save_and_cli(unsigned long *x)
+{
+	local_irq_save(*x);
+}
+#define save_and_cli(x)	local_irq_save(&x)
+#endif /* CONFIG_SMP */
 
 /* SoftIRQ primitives.  */
 #define local_bh_disable() \
