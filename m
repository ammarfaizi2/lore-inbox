Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbUKCRji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbUKCRji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 12:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUKCRjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 12:39:37 -0500
Received: from verein.lst.de ([213.95.11.210]:44773 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261798AbUKCRbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 12:31:03 -0500
Date: Wed, 3 Nov 2004 18:30:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more hardirq.h consolidation
Message-ID: <20041103173045.GB23312@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PREEMPT_BITS, SOFTIRQ_BITS, PREEMPT_SHIFT, SOFTIRQ_SHIFT and
HARDIRQ_SHIFT are the same for all architectures (and chaning them in
future ports doesn't make a lot of sense), so move them to
<linux/hardirq.h>.

Make the HARDIRQ_BITS definition guarded by #ifndef HARDIRQ_BITS instead
of CONFIG_GENERIC_HARDIRQS so we have a saner way to override it once
ports with lots of irq sources are changed to use the generic hardirq
framework.

Ingo, maybe we should change the default for it back to 8 as that's what
most ports use?


Signed-off-by: Christoph Hellwig <hch@lst.de>


--- 1.9/include/asm-alpha/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-alpha/hardirq.h	2004-11-03 17:59:23 +01:00
@@ -16,28 +16,7 @@
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-/*
- * We put the hardirq and softirq counter into the preemption
- * counter. The bitmask has the following meaning:
- *
- * - bits 0-7 are the preemption count (max preemption depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-27 are the hardirq count (max # of hardirqs: 4096)
- *
- * - ( bit 30 is the PREEMPT_ACTIVE flag. )
- *
- * PREEMPT_MASK: 0x000000ff
- * SOFTIRQ_MASK: 0x0000ff00
- * HARDIRQ_MASK: 0x0fff0000
- */
-
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	12
-
-#define PREEMPT_SHIFT	0
-#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
 /*
  * The hardirq mask has to be large enough to have
--- 1.14/include/asm-arm/hardirq.h	2004-10-20 15:43:53 +02:00
+++ edited/include/asm-arm/hardirq.h	2004-11-03 17:59:35 +01:00
@@ -12,30 +12,11 @@
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-/*
- * We put the hardirq and softirq counter into the preemption
- * counter.  The bitmask has the following meaning:
- *
- * - bits 0-7 are the preemption count (max depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-24 are the hardirq count (max # of hardirqs: 512)
- * - bit 26 is the PREEMPT_ACTIVE flag
- *
- * We optimize HARDIRQ_BITS for immediate constant, and only
- * increase it if really needed.
- */
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
-
 #if NR_IRQS > 256
 #define HARDIRQ_BITS	9
 #else
 #define HARDIRQ_BITS	8
 #endif
-
-#define PREEMPT_SHIFT	0
-#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
 /*
  * The hardirq mask has to be large enough to have space
--- 1.3/include/asm-arm26/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-arm26/hardirq.h	2004-11-03 17:59:42 +01:00
@@ -15,22 +15,7 @@
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-/*
- * We put the hardirq and softirq counter into the preemption
- * counter.  The bitmask has the following meaning:
- *
- * - bits 0-7 are the preemption count (max depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-23 are the hardirq count (max # of hardirqs: 256)
- * - bit 26 is the PREEMPT_ACTIVE flag
- */
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	8
-
-#define PREEMPT_SHIFT	0
-#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
 /*
  * The hardirq mask has to be large enough to have space
--- 1.4/include/asm-cris/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-cris/hardirq.h	2004-11-03 17:59:48 +01:00
@@ -17,28 +17,7 @@
 
 #include <linux/irq_cpustat.h> /* Standard mappings for irq_cpustat_t above */
 
-/*
- * We put the hardirq and softirq counter into the preemption
- * counter. The bitmask has the following meaning:
- *
- * - bits 0-7 are the preemption count (max preemption depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-23 are the hardirq count (max # of hardirqs: 256)
- *
- * - ( bit 26 is the PREEMPT_ACTIVE flag. )
- *
- * PREEMPT_MASK: 0x000000ff
- * SOFTIRQ_MASK: 0x0000ff00
- * HARDIRQ_MASK: 0x00ff0000
- */
-
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	8
-
-#define PREEMPT_SHIFT	0
-#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
 /*
  * The hardirq mask has to be large enough to have
--- 1.5/include/asm-h8300/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-h8300/hardirq.h	2004-11-03 17:59:55 +01:00
@@ -15,28 +15,7 @@
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-/*
- * We put the hardirq and softirq counter into the preemption
- * counter. The bitmask has the following meaning:
- *
- * - bits 0-7 are the preemption count (max preemption depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-23 are the hardirq count (max # of hardirqs: 256)
- *
- * - ( bit 26 is the PREEMPT_ACTIVE flag. )
- *
- * PREEMPT_MASK: 0x000000ff
- * HARDIRQ_MASK: 0x0000ff00
- * SOFTIRQ_MASK: 0x00ff0000
- */
-
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	8
-
-#define PREEMPT_SHIFT	0
-#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
 /*
  * The hardirq mask has to be large enough to have
--- 1.17/include/asm-ia64/hardirq.h	2004-10-06 19:31:43 +02:00
+++ edited/include/asm-ia64/hardirq.h	2004-11-03 18:00:05 +01:00
@@ -29,28 +29,7 @@
 #define local_ksoftirqd_task()		(local_cpu_data->ksoftirqd)
 #define local_nmi_count()		0
 
-/*
- * We put the hardirq and softirq counter into the preemption counter. The bitmask has the
- * following meaning:
- *
- * - bits 0-7 are the preemption count (max preemption depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-29 are the hardirq count (max # of hardirqs: 16384)
- *
- * - (bit 63 is the PREEMPT_ACTIVE flag---not currently implemented.)
- *
- * PREEMPT_MASK: 0x000000ff
- * SOFTIRQ_MASK: 0x0000ff00
- * HARDIRQ_MASK: 0x3fff0000
- */
-
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	14
-
-#define PREEMPT_SHIFT	0
-#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
 /*
  * The hardirq mask has to be large enough to have space for potentially all IRQ sources
--- 1.3/include/asm-m32r/hardirq.h	2004-10-03 06:05:09 +02:00
+++ edited/include/asm-m32r/hardirq.h	2004-11-03 18:00:16 +01:00
@@ -13,33 +13,11 @@
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-/*
- * We put the hardirq and softirq counter into the preemption
- * counter. The bitmask has the following meaning:
- *
- * - bits 0-7 are the preemption count (max preemption depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-23 are the hardirq count (max # of hardirqs: 256)
- *
- * - ( bit 26 is the PREEMPT_ACTIVE flag. )
- *
- * PREEMPT_MASK: 0x000000ff
- * SOFTIRQ_MASK: 0x0000ff00
- * HARDIRQ_MASK: 0x00ff0000
- */
-
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
-
 #if NR_IRQS > 256
 #define HARDIRQ_BITS	9
 #else
 #define HARDIRQ_BITS	8
 #endif
-
-#define PREEMPT_SHIFT	0
-#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
 /*
  * The hardirq mask has to be large enough to have
--- 1.7/include/asm-m68k/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-m68k/hardirq.h	2004-11-03 18:00:23 +01:00
@@ -12,28 +12,7 @@
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-/*
- * We put the hardirq and softirq counter into the preemption
- * counter. The bitmask has the following meaning:
- *
- * - bits 0-7 are the preemption count (max preemption depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-23 are the hardirq count (max # of hardirqs: 256)
- *
- * - ( bit 26 is the PREEMPT_ACTIVE flag. )
- *
- * PREEMPT_MASK: 0x000000ff
- * HARDIRQ_MASK: 0x0000ff00
- * SOFTIRQ_MASK: 0x00ff0000
- */
-
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	8
-
-#define PREEMPT_SHIFT	0
-#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
 /*
  * The hardirq mask has to be large enough to have
--- 1.4/include/asm-m68knommu/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-m68knommu/hardirq.h	2004-11-03 18:00:29 +01:00
@@ -13,28 +13,7 @@
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-/*
- * We put the hardirq and softirq counter into the preemption
- * counter. The bitmask has the following meaning:
- *
- * - bits 0-7 are the preemption count (max preemption depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-23 are the hardirq count (max # of hardirqs: 256)
- *
- * - ( bit 26 is the PREEMPT_ACTIVE flag. )
- *
- * PREEMPT_MASK: 0x000000ff
- * HARDIRQ_MASK: 0x0000ff00
- * SOFTIRQ_MASK: 0x00ff0000
- */
-
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	8
-
-#define PREEMPT_SHIFT	0
-#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
 /*
  * The hardirq mask has to be large enough to have
--- 1.9/include/asm-mips/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-mips/hardirq.h	2004-11-03 18:00:35 +01:00
@@ -20,28 +20,7 @@
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-/*
- * We put the hardirq and softirq counter into the preemption
- * counter. The bitmask has the following meaning:
- *
- * - bits 0-7 are the preemption count (max preemption depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-23 are the hardirq count (max # of hardirqs: 256)
- *
- * - ( bit 26 is the PREEMPT_ACTIVE flag. )
- *
- * PREEMPT_MASK: 0x000000ff
- * SOFTIRQ_MASK: 0x0000ff00
- * HARDIRQ_MASK: 0x00ff0000
- */
-
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	8
-
-#define PREEMPT_SHIFT	0
-#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
 /*
  * The hardirq mask has to be large enough to have
--- 1.4/include/asm-parisc/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-parisc/hardirq.h	2004-11-03 18:00:42 +01:00
@@ -28,28 +28,7 @@
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-/*
- * We put the hardirq and softirq counter into the preemption counter. The bitmask has the
- * following meaning:
- *
- * - bits 0-7 are the preemption count (max preemption depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-31 are the hardirq count (max # of hardirqs: 65536)
- *
- * - (bit 63 is the PREEMPT_ACTIVE flag---not currently implemented.)
- *
- * PREEMPT_MASK: 0x000000ff
- * SOFTIRQ_MASK: 0x0000ff00
- * HARDIRQ_MASK: 0xffff0000
- */
-
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	16
-
-#define PREEMPT_SHIFT	0
-#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
 /*
  * The hardirq mask has to be large enough to have space for potentially all IRQ sources
--- 1.15/include/asm-s390/hardirq.h	2004-09-22 22:34:32 +02:00
+++ edited/include/asm-s390/hardirq.h	2004-11-03 18:00:52 +01:00
@@ -38,28 +38,7 @@
 
 #define __ARCH_IRQ_STAT
 
-/*
- * We put the hardirq and softirq counter into the preemption
- * counter. The bitmask has the following meaning:
- *
- * - bits 0-7 are the preemption count (max preemption depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-23 are the hardirq count (max # of hardirqs: 256)
- *
- * - ( bit 26 is the PREEMPT_ACTIVE flag. )
- *
- * PREEMPT_MASK: 0x000000ff
- * SOFTIRQ_MASK: 0x0000ff00
- * HARDIRQ_MASK: 0x00ff0000
- */
-
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	8
-
-#define PREEMPT_SHIFT	0
-#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
 extern void account_ticks(struct pt_regs *);
 
--- 1.7/include/asm-sh/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-sh/hardirq.h	2004-11-03 18:00:58 +01:00
@@ -12,28 +12,7 @@
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-/*
- * We put the hardirq and softirq counter into the preemption
- * counter. The bitmask has the following meaning:
- *
- * - bits 0-7 are the preemption count (max preemption depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-23 are the hardirq count (max # of hardirqs: 256)
- *
- * - ( bit 26 is the PREEMPT_ACTIVE flag. )
- *
- * PREEMPT_MASK: 0x000000ff
- * SOFTIRQ_MASK: 0x0000ff00
- * HARDIRQ_MASK: 0x00ff0000
- */
-
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	8
-
-#define PREEMPT_SHIFT	0
-#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
 /*
  * The hardirq mask has to be large enough to have
--- 1.15/include/asm-sparc/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-sparc/hardirq.h	2004-11-03 18:01:07 +01:00
@@ -19,28 +19,7 @@
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-/*
- * We put the hardirq and softirq counter into the preemption
- * counter. The bitmask has the following meaning:
- *
- * - bits 0-7 are the preemption count (max preemption depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-23 are the hardirq count (max # of hardirqs: 256)
- *
- * - ( bit 26 is the PREEMPT_ACTIVE flag. )
- *
- * PREEMPT_MASK: 0x000000ff
- * SOFTIRQ_MASK: 0x0000ff00
- * HARDIRQ_MASK: 0x00ff0000
- */
-
-#define PREEMPT_BITS    8
-#define SOFTIRQ_BITS    8
 #define HARDIRQ_BITS    8
-
-#define PREEMPT_SHIFT   0
-#define SOFTIRQ_SHIFT   (PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT   (SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
 #define irq_enter()             (preempt_count() += HARDIRQ_OFFSET)
 #define irq_exit()                                                      \
--- 1.19/include/asm-sparc64/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-sparc64/hardirq.h	2004-11-03 18:01:14 +01:00
@@ -18,28 +18,7 @@
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-/*
- * We put the hardirq and softirq counter into the preemption
- * counter. The bitmask has the following meaning:
- *
- * - bits 0-7 are the preemption count (max preemption depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-23 are the hardirq count (max # of hardirqs: 256)
- *
- * - ( bit 26 is the PREEMPT_ACTIVE flag. )
- *
- * PREEMPT_MASK: 0x000000ff
- * SOFTIRQ_MASK: 0x0000ff00
- * HARDIRQ_MASK: 0x00ff0000
- */
-
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	8
-
-#define PREEMPT_SHIFT	0
-#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 #define irq_exit()							\
--- 1.5/include/asm-v850/hardirq.h	2004-09-08 08:32:57 +02:00
+++ edited/include/asm-v850/hardirq.h	2004-11-03 18:01:23 +01:00
@@ -13,28 +13,7 @@
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-/*
- * We put the hardirq and softirq counter into the preemption
- * counter. The bitmask has the following meaning:
- *
- * - bits 0-7 are the preemption count (max preemption depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-23 are the hardirq count (max # of hardirqs: 256)
- *
- * - ( bit 26 is the PREEMPT_ACTIVE flag. )
- *
- * PREEMPT_MASK: 0x000000ff
- * HARDIRQ_MASK: 0x0000ff00
- * SOFTIRQ_MASK: 0x00ff0000
- */
-
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	8
-
-#define PREEMPT_SHIFT	0
-#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
 /*
  * The hardirq mask has to be large enough to have
--- 1.4/include/linux/hardirq.h	2004-10-20 18:07:50 +02:00
+++ edited/include/linux/hardirq.h	2004-11-03 18:05:27 +01:00
@@ -5,39 +5,39 @@
 #include <linux/smp_lock.h>
 #include <asm/hardirq.h>
 
-#ifdef CONFIG_GENERIC_HARDIRQS
 /*
  * We put the hardirq and softirq counter into the preemption
  * counter. The bitmask has the following meaning:
  *
  * - bits 0-7 are the preemption count (max preemption depth: 256)
  * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-27 are the hardirq count (max # of hardirqs: 4096)
  *
+ * The hardirq count can be overridden per architecture, the default is:
+ *
+ * - bits 16-27 are the hardirq count (max # of hardirqs: 4096)
  * - ( bit 28 is the PREEMPT_ACTIVE flag. )
  *
  * PREEMPT_MASK: 0x000000ff
  * SOFTIRQ_MASK: 0x0000ff00
  * HARDIRQ_MASK: 0x0fff0000
  */
-
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
-#define HARDIRQ_BITS	12
-
-#define PREEMPT_SHIFT	0
-#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
+#ifndef HARDIRQ_BITS
+#define HARDIRQ_BITS	12
 /*
- * The hardirq mask has to be large enough to have
- * space for potentially all IRQ sources in the system
- * nesting on a single CPU:
+ * The hardirq mask has to be large enough to have space for potentially
+ * all IRQ sources in the system nesting on a single CPU.
  */
 #if (1 << HARDIRQ_BITS) < NR_IRQS
 # error HARDIRQ_BITS is too low!
 #endif
-#endif /* CONFIG_GENERIC_HARDIRQS */
+#endif 
+
+#define PREEMPT_SHIFT	0
+#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
+#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
 #define __IRQ_MASK(x)	((1UL << (x))-1)
 
