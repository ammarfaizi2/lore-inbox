Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbVEAVAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbVEAVAX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVEAVAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:00:23 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15629 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262672AbVEAVAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:00:14 -0400
Date: Sun, 1 May 2005 23:00:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: [-mm patch] kernel/irq/manage.c: remove the empty set_irq_info()
Message-ID: <20050501210011.GY3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do still not like an empty global function.

All other cases are already handled by static inline's, so let's do the 
same with this one.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/irq.h |    8 +++++++-
 kernel/irq/manage.c |    4 ----
 2 files changed, 7 insertions(+), 5 deletions(-)

--- linux-2.6.12-rc3-mm2-full/include/linux/irq.h.old	2005-05-01 14:55:16.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/include/linux/irq.h	2005-05-01 17:56:12.000000000 +0200
@@ -158,10 +158,16 @@
 	set_native_irq_info(irq, mask);
 }
 #endif // CONFIG_PCI_MSI
+
 #else
+
 #define move_irq(x)
 #define move_native_irq(x)
-extern void set_irq_info(unsigned int irq, cpumask_t mask);
+
+static inline void set_irq_info(int irq, cpumask_t mask)
+{
+}
+
 #endif // CONFIG_GENERIC_PENDING_IRQ
 
 extern int no_irq_affinity;
--- linux-2.6.12-rc3-mm2-full/kernel/irq/manage.c.old	2005-05-01 14:56:11.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/kernel/irq/manage.c	2005-05-01 14:56:24.000000000 +0200
@@ -40,10 +40,6 @@
 
 EXPORT_SYMBOL(synchronize_irq);
 
-#else
-void set_irq_info(unsigned int irq, cpumask_t mask)
-{
-}
 #endif
 
 /**

