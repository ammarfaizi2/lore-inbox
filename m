Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbUKNLAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbUKNLAb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 06:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbUKNLAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 06:00:31 -0500
Received: from verein.lst.de ([213.95.11.210]:19639 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261283AbUKNLAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 06:00:14 -0500
Date: Sun, 14 Nov 2004 12:00:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove unused irq_cpustat fields
Message-ID: <20041114110007.GA32387@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only common field in irq_cpustat is __softirq_pending, i386 and ppc
have some of their own.

Remove all unused obsolete fields from various architectures.


--- 1.10/include/asm-alpha/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-alpha/hardirq.h	2004-11-14 11:58:28 +01:00
@@ -9,9 +9,6 @@
 /* entry.S is sensitive to the offsets of these fields */
 typedef struct {
 	unsigned long __softirq_pending;
-	unsigned int __syscall_count;
-	unsigned long idle_timestamp;
-	struct task_struct * __ksoftirqd_task;
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
--- 1.4/include/asm-arm26/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-arm26/hardirq.h	2004-11-14 11:57:13 +01:00
@@ -7,10 +7,6 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
-	unsigned int __local_irq_count;
-	unsigned int __local_bh_count;
-	unsigned int __syscall_count;
-	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
--- 1.5/include/asm-cris/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-cris/hardirq.h	2004-11-14 11:57:15 +01:00
@@ -9,10 +9,6 @@
 /* entry.S is sensitive to the offsets of these fields */
 typedef struct {
 	unsigned int __softirq_pending;
-	unsigned int __local_irq_count;
-	unsigned int __local_bh_count;
-	unsigned int __syscall_count;
-	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h> /* Standard mappings for irq_cpustat_t above */
--- 1.6/include/asm-h8300/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-h8300/hardirq.h	2004-11-14 11:57:20 +01:00
@@ -9,8 +9,6 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
-	unsigned int __syscall_count;
-	struct task_struct * __ksoftirqd_task;
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
--- 1.4/include/asm-m32r/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-m32r/hardirq.h	2004-11-14 11:57:25 +01:00
@@ -7,8 +7,6 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
-	unsigned int __syscall_count;
-	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
--- 1.5/include/asm-m68knommu/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-m68knommu/hardirq.h	2004-11-14 11:57:29 +01:00
@@ -7,8 +7,6 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
-	unsigned int __syscall_count;
-	struct task_struct * __ksoftirqd_task;
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
--- 1.5/include/asm-parisc/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-parisc/hardirq.h	2004-11-14 11:58:34 +01:00
@@ -21,9 +21,6 @@
 
 typedef struct {
 	unsigned long __softirq_pending; /* set_bit is used on this */
-	unsigned int __syscall_count;
-	struct task_struct * __ksoftirqd_task;
-	unsigned long idle_timestamp;
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
--- 1.15/include/asm-ppc64/hardirq.h	2004-10-19 07:26:40 +02:00
+++ edited/include/asm-ppc64/hardirq.h	2004-11-14 11:55:29 +01:00
@@ -14,7 +14,6 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
-	struct task_struct * __ksoftirqd_task;
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
--- 1.6/include/asm-v850/hardirq.h	2004-11-08 03:08:14 +01:00
+++ edited/include/asm-v850/hardirq.h	2004-11-14 11:57:48 +01:00
@@ -7,8 +7,6 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
-	unsigned int __syscall_count;
-	struct task_struct * __ksoftirqd_task;
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
