Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSLEPXO>; Thu, 5 Dec 2002 10:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbSLEPXO>; Thu, 5 Dec 2002 10:23:14 -0500
Received: from verein.lst.de ([212.34.181.86]:10513 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261615AbSLEPXM>;
	Thu, 5 Dec 2002 10:23:12 -0500
Date: Thu, 5 Dec 2002 16:30:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] hardirq.h needs smp_lock.h
Message-ID: <20021205163043.A27618@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many architectures use kernel_locked() in the defintion of in_atomic()
in hardirq.h, but only ppc actually includes smp_lock.h to get it.

Fix up the others.


--- 1.6/include/asm-alpha/hardirq.h	Mon Nov 18 19:08:15 2002
+++ edited/include/asm-alpha/hardirq.h	Thu Dec  5 16:10:36 2002
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/threads.h>
 #include <linux/cache.h>
+#include <linux/smp_lock.h>
 
 
 /* entry.S is sensitive to the offsets of these fields */
--- 1.7/include/asm-arm/hardirq.h	Sun Oct 13 13:04:25 2002
+++ edited/include/asm-arm/hardirq.h	Thu Dec  5 16:10:05 2002
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/cache.h>
 #include <linux/threads.h>
+#include <linux/smp_lock.h>
 
 /* softirq.h is sensitive to the offsets of these fields */
 typedef struct {
--- 1.16/include/asm-i386/hardirq.h	Sat Nov  9 07:31:03 2002
+++ edited/include/asm-i386/hardirq.h	Thu Dec  5 16:10:07 2002
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/threads.h>
 #include <linux/irq.h>
+#include <linux/smp_lock.h>
 
 /* assembly code in softirq.h is sensitive to the offsets of these fields */
 typedef struct {
--- 1.3/include/asm-m68k/hardirq.h	Tue Sep 17 13:32:36 2002
+++ edited/include/asm-m68k/hardirq.h	Thu Dec  5 16:10:10 2002
@@ -3,6 +3,7 @@
 
 #include <linux/threads.h>
 #include <linux/cache.h>
+#include <linux/smp_lock.h>
 
 /* entry.S is sensitive to the offsets of these fields */
 typedef struct {
--- 1.1/include/asm-m68knommu/hardirq.h	Fri Nov  1 17:37:46 2002
+++ edited/include/asm-m68knommu/hardirq.h	Thu Dec  5 16:10:13 2002
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <linux/threads.h>
+#include <linux/smp_lock.h>
 
 typedef struct {
 	unsigned int __softirq_pending;
--- 1.10/include/asm-ppc64/hardirq.h	Fri Nov 22 06:33:12 2002
+++ edited/include/asm-ppc64/hardirq.h	Thu Dec  5 16:10:21 2002
@@ -12,6 +12,7 @@
 #include <linux/config.h>
 #include <linux/cache.h>
 #include <linux/preempt.h>
+#include <linux/smp_lock.h>
 
 typedef struct {
 	unsigned int __softirq_pending;
--- 1.10/include/asm-sparc/hardirq.h	Mon Dec  2 09:21:26 2002
+++ edited/include/asm-sparc/hardirq.h	Thu Dec  5 16:10:24 2002
@@ -12,6 +12,7 @@
 #include <linux/brlock.h>
 #include <linux/spinlock.h>
 #include <linux/cache.h>
+#include <linux/smp_lock.h>
 
 /* entry.S is sensitive to the offsets of these fields */ /* XXX P3 Is it? */
 typedef struct {
--- 1.12/include/asm-sparc64/hardirq.h	Fri Sep 13 23:45:23 2002
+++ edited/include/asm-sparc64/hardirq.h	Thu Dec  5 16:10:28 2002
@@ -10,6 +10,7 @@
 #include <linux/threads.h>
 #include <linux/brlock.h>
 #include <linux/spinlock.h>
+#include <linux/smp_lock.h>
 
 /* entry.S is sensitive to the offsets of these fields */
 /* rtrap.S is sensitive to the size of this structure */
--- 1.2/include/asm-v850/hardirq.h	Mon Nov 25 02:34:44 2002
+++ edited/include/asm-v850/hardirq.h	Thu Dec  5 16:10:30 2002
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/threads.h>
 #include <linux/cache.h>
+#include <linux/smp_lock.h>
 
 typedef struct {
 	unsigned int __softirq_pending;
--- 1.2/include/asm-x86_64/hardirq.h	Sat Oct 12 01:54:31 2002
+++ edited/include/asm-x86_64/hardirq.h	Thu Dec  5 16:10:33 2002
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/threads.h>
 #include <linux/irq.h>
+#include <linux/smp_lock.h>
 #include <asm/pda.h>
 
 #define __ARCH_IRQ_STAT 1
