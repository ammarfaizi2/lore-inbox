Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263302AbTIVTck (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263305AbTIVTck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:32:40 -0400
Received: from verein.lst.de ([212.34.189.10]:32674 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263302AbTIVTcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 15:32:35 -0400
Date: Mon, 22 Sep 2003 21:31:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] asm/softirq.h is dead
Message-ID: <20030922193146.GA29290@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -1.6 () HTML_10_20,PATCH_UNIFIED_DIFF,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still a three arches keep an unused copy around and quite a few
places refer to it in comments still.  Two of the two arches
also include it in their _ksyms.c file, but given that softirq.h
only contains macros (which are in hardirq.c aswell) that's
just a leftover aswell.


--- 1.14/Documentation/DocBook/kernel-hacking.tmpl	Sun Mar 23 07:14:58 2003
+++ edited/Documentation/DocBook/kernel-hacking.tmpl	Mon Sep 22 21:20:47 2003
@@ -241,7 +241,7 @@
    <para>
     You can tell you are in a softirq (or bottom half, or tasklet)
     using the <function>in_softirq()</function> macro 
-    (<filename class=headerfile>include/asm/softirq.h</filename>).  
+    (<filename class=headerfile>include/asm/hardirq.h</filename>).  
    </para>
    <caution>
     <para>
@@ -690,7 +690,7 @@
 
   <sect1 id="routines-softirqs">
    <title><function>local_bh_disable()</function>/<function>local_bh_enable()</function>
-    <filename class=headerfile>include/asm/softirq.h</filename></title>
+    <filename class=headerfile>include/linux/interrupt.h</filename></title>
 
    <para>
     These routines disable soft interrupts on the local CPU, and
--- 1.8/Documentation/DocBook/kernel-locking.tmpl	Mon Sep  1 01:14:01 2003
+++ edited/Documentation/DocBook/kernel-locking.tmpl	Mon Sep 22 21:21:02 2003
@@ -306,7 +306,7 @@
       This works perfectly for <firstterm linkend="gloss-up"><acronym>UP
       </acronym></firstterm> as well: the spin lock vanishes, and this macro 
       simply becomes <function>local_bh_disable()</function>
-      (<filename class=headerfile>include/asm/softirq.h</filename>), which 
+      (<filename class=headerfile>include/linux/interrupt.h</filename>), which 
       protects you from the bottom half being run.
     </para>
    </sect1>
--- 1.15/arch/arm/kernel/entry-common.S	Wed Sep  3 19:17:54 2003
+++ edited/arch/arm/kernel/entry-common.S	Mon Sep 22 21:21:25 2003
@@ -23,7 +23,7 @@
 #endif
 
 /*
- * Our do_softirq out of line code.  See include/asm-arm/softirq.h for
+ * Our do_softirq out of line code.  See include/asm-arm/hardirq.h for
  * the calling assembly.
  */
 ENTRY(__do_softirq)
--- 1.2/arch/arm26/kernel/entry.S	Sat Sep  6 19:22:02 2003
+++ edited/arch/arm26/kernel/entry.S	Mon Sep 22 21:21:46 2003
@@ -161,7 +161,7 @@
 #endif
 
 /*
- * Our do_softirq out of line code.  See include/asm-arm/softirq.h for
+ * Our do_softirq out of line code.  See include/asm-arm26/hardirq.h for
  * the calling assembly.
  */
 ENTRY(__do_softirq)
--- 1.1/arch/h8300/kernel/h8300_ksyms.c	Mon Feb 17 01:01:58 2003
+++ edited/arch/h8300/kernel/h8300_ksyms.c	Mon Sep 22 21:22:33 2003
@@ -16,7 +16,6 @@
 #include <asm/semaphore.h>
 #include <asm/checksum.h>
 #include <asm/hardirq.h>
-#include <asm/softirq.h>
 #include <asm/current.h>
 
 //asmlinkage long long __ashrdi3 (long long, int);
--- 1.11/arch/mips/kernel/mips_ksyms.c	Tue Sep  9 23:18:36 2003
+++ edited/arch/mips/kernel/mips_ksyms.c	Mon Sep 22 21:22:43 2003
@@ -25,7 +25,6 @@
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/semaphore.h>
-#include <asm/softirq.h>
 #include <asm/uaccess.h>
 #ifdef CONFIG_BLK_DEV_FD
 #include <asm/floppy.h>
--- 1.1/include/asm-arm26/hardirq.h	Wed Jun  4 13:14:10 2003
+++ edited/include/asm-arm26/hardirq.h	Mon Sep 22 21:22:05 2003
@@ -5,7 +5,6 @@
 #include <linux/cache.h>
 #include <linux/threads.h>
 
-/* softirq.h is sensitive to the offsets of these fields */
 typedef struct {
 	unsigned int __softirq_pending;
 	unsigned int __local_irq_count;
--- 1.1/include/asm-arm26/softirq.h	Wed Jun  4 13:14:10 2003
+++ edited/include/asm-arm26/softirq.h	Mon Sep 22 21:23:21 2003
@@ -1,20 +0,0 @@
-#ifndef __ASM_SOFTIRQ_H
-#define __ASM_SOFTIRQ_H
-
-#include <linux/preempt.h>
-#include <asm/hardirq.h>
-
-#define local_bh_disable() \
-	do { preempt_count() += SOFTIRQ_OFFSET; barrier(); } while (0)
-#define __local_bh_enable() \
-	do { barrier(); preempt_count() -= SOFTIRQ_OFFSET; } while (0)
-
-#define local_bh_enable()						\
-do {									\
-	__local_bh_enable();						\
-	if (unlikely(!in_interrupt() && softirq_pending(smp_processor_id()))) \
-		__asm__("bl%? __do_softirq": : : "lr");/* out of line */\
-	preempt_check_resched();					\
-} while (0)
-
-#endif	/* __ASM_SOFTIRQ_H */
--- 1.1/include/asm-mips/softirq.h	Mon Jun 23 21:07:12 2003
+++ edited/include/asm-mips/softirq.h	Mon Sep 22 21:23:07 2003
@@ -1,20 +0,0 @@
-#ifndef __ASM_SOFTIRQ_H
-#define __ASM_SOFTIRQ_H
-
-#include <linux/preempt.h>
-#include <asm/hardirq.h>
-
-#define local_bh_disable() \
-		do { preempt_count() += SOFTIRQ_OFFSET; barrier(); } while (0)
-#define __local_bh_enable() \
-		do { barrier(); preempt_count() -= SOFTIRQ_OFFSET; } while (0)
-
-#define local_bh_enable()						\
-do {									\
-	__local_bh_enable();						\
-	if (unlikely(!in_interrupt() && softirq_pending(smp_processor_id()))) \
-		do_softirq();						\
-	preempt_check_resched();					\
-} while (0)
-
-#endif	/* __ASM_SOFTIRQ_H */
