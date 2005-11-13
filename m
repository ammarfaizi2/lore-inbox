Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbVKMIAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbVKMIAF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 03:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVKMIAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 03:00:01 -0500
Received: from verein.lst.de ([213.95.11.210]:15284 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S964903AbVKMIAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 03:00:01 -0500
Date: Sun, 13 Nov 2005 08:59:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove enable_irq_nosync
Message-ID: <20051113075956.GA987@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

m68k, m68knommu and h8300 define this, but it's not actually used
anywhere.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/include/asm-h8300/irq.h
===================================================================
--- linux-2.6.orig/include/asm-h8300/irq.h	2005-11-13 00:06:45.000000000 +0100
+++ linux-2.6/include/asm-h8300/irq.h	2005-11-13 00:07:53.000000000 +0100
@@ -61,11 +61,6 @@
 
 extern void enable_irq(unsigned int);
 extern void disable_irq(unsigned int);
-
-/*
- * Some drivers want these entry points
- */
-#define enable_irq_nosync(x)	enable_irq(x)
 #define disable_irq_nosync(x)	disable_irq(x)
 
 struct irqaction;
Index: linux-2.6/include/asm-m68k/irq.h
===================================================================
--- linux-2.6.orig/include/asm-m68k/irq.h	2005-11-13 00:06:45.000000000 +0100
+++ linux-2.6/include/asm-m68k/irq.h	2005-11-13 00:07:53.000000000 +0100
@@ -70,8 +70,6 @@
 
 extern void (*enable_irq)(unsigned int);
 extern void (*disable_irq)(unsigned int);
-
-#define disable_irq_nosync	disable_irq
 #define enable_irq_nosync	enable_irq
 
 struct pt_regs;
Index: linux-2.6/include/asm-m68knommu/irq.h
===================================================================
--- linux-2.6.orig/include/asm-m68knommu/irq.h	2005-11-13 00:07:53.000000000 +0100
+++ linux-2.6/include/asm-m68knommu/irq.h	2005-11-13 00:08:09.000000000 +0100
@@ -86,8 +86,6 @@
  */
 #define enable_irq(x)	0
 #define disable_irq(x)	do { } while (0)
-
-#define enable_irq_nosync(x)	enable_irq(x)
 #define disable_irq_nosync(x)	disable_irq(x)
 
 struct irqaction;
