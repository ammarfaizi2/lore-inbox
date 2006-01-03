Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbWACX0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWACX0d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWACX0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:26:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52443 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964988AbWACX0b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:26:31 -0500
To: torvalds@osdl.org
Subject: [PATCH 01/41] m68k: compile fix - hardirq checks were in wrong place
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1EtvXy-0003Ks-E9@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:26:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133435630 -0500

move the sanity check for NR_IRQS being no more than 1<<HARDIRQ_BITS
from asm-m68k/hardirq.h to asm-m68k/irq.h; needed since NR_IRQS is
not necessary know at the points of inclusion of asm/hardirq.h due
to the rather ugly header dependencies on m68k.  Fix is by far simpler
than trying to massage those dependencies...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-m68k/hardirq.h |    9 ---------
 include/asm-m68k/irq.h     |    9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

f272efd87cbac37d0a113753175a499ea0bbfa30
diff --git a/include/asm-m68k/hardirq.h b/include/asm-m68k/hardirq.h
index 728318b..5e1c582 100644
--- a/include/asm-m68k/hardirq.h
+++ b/include/asm-m68k/hardirq.h
@@ -14,13 +14,4 @@ typedef struct {
 
 #define HARDIRQ_BITS	8
 
-/*
- * The hardirq mask has to be large enough to have
- * space for potentially all IRQ sources in the system
- * nesting on a single CPU:
- */
-#if (1 << HARDIRQ_BITS) < NR_IRQS
-# error HARDIRQ_BITS is too low!
-#endif
-
 #endif
diff --git a/include/asm-m68k/irq.h b/include/asm-m68k/irq.h
index 1f56990..d312674 100644
--- a/include/asm-m68k/irq.h
+++ b/include/asm-m68k/irq.h
@@ -23,6 +23,15 @@
 #endif
 
 /*
+ * The hardirq mask has to be large enough to have
+ * space for potentially all IRQ sources in the system
+ * nesting on a single CPU:
+ */
+#if (1 << HARDIRQ_BITS) < NR_IRQS
+# error HARDIRQ_BITS is too low!
+#endif
+
+/*
  * Interrupt source definitions
  * General interrupt sources are the level 1-7.
  * Adding an interrupt service routine for one of these sources
-- 
0.99.9.GIT

