Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbUKCUgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbUKCUgZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbUKCUgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:36:25 -0500
Received: from verein.lst.de ([213.95.11.210]:30441 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261854AbUKCUfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:35:45 -0500
Date: Wed, 3 Nov 2004 21:35:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deprecate cli, sti & friends
Message-ID: <20041103203537.GA25947@lst.de>
References: <20041103184625.GA24462@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103184625.GA24462@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 07:46:25PM +0100, Christoph Hellwig wrote:
> We provided compat wrappers for !CONFIG_SMP builds for ages, but I think
> it's time to get the last folks to notice this can't stay so forever..
> 
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Mitchell Blank Jr found a small typo, so here's a new version:

--------
We provided compat wrappers for !CONFIG_SMP builds for ages, but I think
it's time to get the last folks to notice this can't stay so forever..
 

Signed-off-by: Christoph Hellwig <hch@lst.de>



--- 1.33/include/linux/interrupt.h	2004-10-28 09:40:01 +02:00
+++ edited/include/linux/interrupt.h	2004-11-03 21:31:02 +01:00
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
+#define save_and_cli(x) save_and_cli(&x)
+#endif /* CONFIG_SMP */
 
 /* SoftIRQ primitives.  */
 #define local_bh_disable() \
