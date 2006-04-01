Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751567AbWDARtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbWDARtD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 12:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWDARtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 12:49:03 -0500
Received: from verein.lst.de ([213.95.11.210]:22173 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751567AbWDARtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 12:49:02 -0500
Date: Sat, 1 Apr 2006 19:48:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] build kernel/irq/migration.c only if CONFIG_GENERIC_PENDING_IRQ is set
Message-ID: <20060401174857.GA17530@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/kernel/irq/Makefile
===================================================================
--- linux-2.6.orig/kernel/irq/Makefile	2006-03-26 14:45:50.000000000 +0200
+++ linux-2.6/kernel/irq/Makefile	2006-03-26 14:48:32.000000000 +0200
@@ -1,4 +1,5 @@
 
-obj-y := handle.o manage.o spurious.o migration.o
+obj-y := handle.o manage.o spurious.o
 obj-$(CONFIG_GENERIC_IRQ_PROBE) += autoprobe.o
 obj-$(CONFIG_PROC_FS) += proc.o
+obj-$(CONFIG_GENERIC_PENDING_IRQ) += migration.o
Index: linux-2.6/kernel/irq/migration.c
===================================================================
--- linux-2.6.orig/kernel/irq/migration.c	2006-03-26 14:45:50.000000000 +0200
+++ linux-2.6/kernel/irq/migration.c	2006-03-26 14:48:59.000000000 +0200
@@ -1,6 +1,5 @@
-#include <linux/irq.h>
 
-#if defined(CONFIG_GENERIC_PENDING_IRQ)
+#include <linux/irq.h>
 
 void set_pending_irq(unsigned int irq, cpumask_t mask)
 {
@@ -61,5 +60,3 @@
 	}
 	cpus_clear(pending_irq_cpumask[irq]);
 }
-
-#endif
