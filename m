Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263584AbUDUSJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbUDUSJg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 14:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUDUSJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 14:09:36 -0400
Received: from waste.org ([209.173.204.2]:3740 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263584AbUDUSJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 14:09:34 -0400
Date: Wed, 21 Apr 2004 13:09:18 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] dynamic proc fallout
Message-ID: <20040421180917.GI28459@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Delete obsolete comment and kill test of obsolete define.

Index: tiny/include/linux/proc_fs.h
===================================================================
--- tiny.orig/include/linux/proc_fs.h	2004-04-21 12:49:22.000000000 -0500
+++ tiny/include/linux/proc_fs.h	2004-04-21 13:06:06.000000000 -0500
@@ -24,8 +24,6 @@
 	PROC_ROOT_INO = 1,
 };
 
-/* Finally, the dynamically allocatable proc entries are reserved: */
-
 #define PROC_SUPER_MAGIC 0x9fa0
 
 /*
Index: tiny/arch/alpha/kernel/irq.c
===================================================================
--- tiny.orig/arch/alpha/kernel/irq.c	2004-03-25 13:36:07.000000000 -0600
+++ tiny/arch/alpha/kernel/irq.c	2004-04-21 13:06:06.000000000 -0500
@@ -415,16 +415,12 @@
 #endif
 
 	/*
-	 * Create entries for all existing IRQs. If the number of IRQs
-	 * is greater the 1/4 the total dynamic inode space for /proc,
-	 * don't pollute the inode space
+	 * Create entries for all existing IRQs.
 	 */
-	if (ACTUAL_NR_IRQS < (PROC_NDYNAMIC / 4)) {
-		for (i = 0; i < ACTUAL_NR_IRQS; i++) {
-			if (irq_desc[i].handler == &no_irq_type)
-				continue;
-			register_irq_proc(i);
-		}
+	for (i = 0; i < ACTUAL_NR_IRQS; i++) {
+		if (irq_desc[i].handler == &no_irq_type)
+			continue;
+		register_irq_proc(i);
 	}
 }
 



-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
