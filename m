Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262828AbSKTWtM>; Wed, 20 Nov 2002 17:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbSKTWtM>; Wed, 20 Nov 2002 17:49:12 -0500
Received: from verein.lst.de ([212.34.181.86]:21262 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S262828AbSKTWtJ>;
	Wed, 20 Nov 2002 17:49:09 -0500
Date: Wed, 20 Nov 2002 23:56:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] include smp_lock.h in hardirq.h
Message-ID: <20021120235602.A8246@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if CONFIG_PREEMPT is set many of the hardirq.h implementations require
lock_kernel() to be present.  Include it directly instead of letting
each source file fix it (especially as sane configs without preemt
enabled don't require it)


--- 1.5/include/asm-alpha/hardirq.h	Sun Sep 22 04:01:47 2002
+++ edited/include/asm-alpha/hardirq.h	Wed Nov 20 22:31:38 2002
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <linux/threads.h>
+#include <linux/smp_lock.h>
 
 /* entry.S is sensitive to the offsets of these fields */
 typedef struct {
--- 1.7/include/asm-arm/hardirq.h	Sun Oct 13 07:04:25 2002
+++ edited/include/asm-arm/hardirq.h	Wed Nov 20 22:30:25 2002
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/cache.h>
 #include <linux/threads.h>
+#include <linux/smp_lock.h>
 
 /* softirq.h is sensitive to the offsets of these fields */
 typedef struct {
--- 1.16/include/asm-i386/hardirq.h	Sat Nov  9 01:31:03 2002
+++ edited/include/asm-i386/hardirq.h	Wed Nov 20 22:30:33 2002
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/threads.h>
 #include <linux/irq.h>
+#include <linux/smp_lock.h>
 
 /* assembly code in softirq.h is sensitive to the offsets of these fields */
 typedef struct {
--- 1.3/include/asm-m68k/hardirq.h	Tue Sep 17 07:32:36 2002
+++ edited/include/asm-m68k/hardirq.h	Wed Nov 20 22:30:40 2002
@@ -3,6 +3,7 @@
 
 #include <linux/threads.h>
 #include <linux/cache.h>
+#include <linux/smp_lock.h>
 
 /* entry.S is sensitive to the offsets of these fields */
 typedef struct {
--- 1.1/include/asm-m68knommu/hardirq.h	Fri Nov  1 11:37:46 2002
+++ edited/include/asm-m68knommu/hardirq.h	Wed Nov 20 22:30:44 2002
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <linux/threads.h>
+#include <linux/smp_lock.h>
 
 typedef struct {
 	unsigned int __softirq_pending;
--- 1.16/include/asm-ppc/hardirq.h	Mon Oct  7 05:07:44 2002
+++ edited/include/asm-ppc/hardirq.h	Wed Nov 20 22:31:00 2002
@@ -3,6 +3,7 @@
 #define __ASM_HARDIRQ_H
 
 #include <linux/config.h>
+#include <linux/smp_lock.h>
 #include <asm/smp.h>
 
 /* The __last_jiffy_stamp field is needed to ensure that no decrementer 
--- 1.9/include/asm-ppc64/hardirq.h	Wed Oct  2 05:29:53 2002
+++ edited/include/asm-ppc64/hardirq.h	Wed Nov 20 22:30:55 2002
@@ -11,6 +11,7 @@
 
 #include <linux/config.h>
 #include <linux/preempt.h>
+#include <linux/smp_lock.h>
 
 typedef struct {
 	unsigned int __softirq_pending;
--- 1.9/include/asm-sparc/hardirq.h	Fri Sep 13 18:49:50 2002
+++ edited/include/asm-sparc/hardirq.h	Wed Nov 20 22:31:17 2002
@@ -11,6 +11,7 @@
 #include <linux/threads.h>
 #include <linux/brlock.h>
 #include <linux/spinlock.h>
+#include <linux/smp_lock.h>
 
 /* entry.S is sensitive to the offsets of these fields */ /* XXX P3 Is it? */
 typedef struct {
--- 1.12/include/asm-sparc64/hardirq.h	Fri Sep 13 17:45:23 2002
+++ edited/include/asm-sparc64/hardirq.h	Wed Nov 20 22:31:12 2002
@@ -10,6 +10,7 @@
 #include <linux/threads.h>
 #include <linux/brlock.h>
 #include <linux/spinlock.h>
+#include <linux/smp_lock.h>
 
 /* entry.S is sensitive to the offsets of these fields */
 /* rtrap.S is sensitive to the size of this structure */
--- 1.1/include/asm-v850/hardirq.h	Fri Nov  1 11:38:12 2002
+++ edited/include/asm-v850/hardirq.h	Wed Nov 20 22:31:24 2002
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <linux/threads.h>
+#include <linux/smp_lock.h>
 
 typedef struct {
 	unsigned int __softirq_pending;
--- 1.2/include/asm-x86_64/hardirq.h	Fri Oct 11 19:54:31 2002
+++ edited/include/asm-x86_64/hardirq.h	Wed Nov 20 22:31:29 2002
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/threads.h>
 #include <linux/irq.h>
+#include <linux/smp_lock.h>
 #include <asm/pda.h>
 
 #define __ARCH_IRQ_STAT 1
--- 1.5/include/linux/smp_lock.h	Fri Aug 23 07:56:39 2002
+++ edited/include/linux/smp_lock.h	Wed Nov 20 22:31:35 2002
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/smp_lock.h>
 
 #if CONFIG_SMP || CONFIG_PREEMPT
 
