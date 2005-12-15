Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965176AbVLOIyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbVLOIyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 03:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbVLOIyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 03:54:04 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:8122 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965176AbVLOIyD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 03:54:03 -0500
Date: Thu, 15 Dec 2005 08:54:02 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Subject: [PATCH 1/3] m68k: compile fix - hardirq checks were in wrong place
Message-ID: <20051215085402.GT27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the sanity check for NR_IRQS being no more than 1<<HARDIRQ_BITS
from asm-m68k/hardirq.h to asm-m68k/irq.h; needed since NR_IRQS is
not necessary know at the points of inclusion of asm/hardirq.h due
to the rather ugly header dependencies on m68k.  Fix is by far simpler
than trying to massage those dependencies...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 include/asm-m68k/hardirq.h |    9 ---------
 include/asm-m68k/irq.h     |    9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

69139a634877359d1bd7b19c2862c9a01468b614
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

