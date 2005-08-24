Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVHXP6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVHXP6Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 11:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVHXP6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 11:58:16 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:26799 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1751087AbVHXP6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 11:58:14 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [PATCH] IDE: move CONFIG_IDE_MAX_HWIFS into linux/ide.h
Date: Wed, 24 Aug 2005 09:57:51 -0600
User-Agent: KMail/1.8.1
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, rth@twiddle.net,
       ink@jurassic.park.msu.ru, lethal@linux-sh.org, kkojima@rr.iij4u.or.jp,
       linux-sh@m17n.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508240957.51328.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_IDE_MAX_HWIFS is a generic thing, no need to have it duplicated
by every arch that uses it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-ide/include/asm-alpha/ide.h
===================================================================
--- work-ide.orig/include/asm-alpha/ide.h	2005-08-24 09:36:41.000000000 -0600
+++ work-ide/include/asm-alpha/ide.h	2005-08-24 09:37:12.000000000 -0600
@@ -15,10 +15,6 @@
 
 #include <linux/config.h>
 
-#ifndef MAX_HWIFS
-#define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
-#endif
-
 #define IDE_ARCH_OBSOLETE_DEFAULTS
 
 static inline int ide_default_irq(unsigned long base)
Index: work-ide/include/asm-sh/ide.h
===================================================================
--- work-ide.orig/include/asm-sh/ide.h	2005-08-24 09:36:41.000000000 -0600
+++ work-ide/include/asm-sh/ide.h	2005-08-24 09:37:12.000000000 -0600
@@ -16,10 +16,6 @@
 
 #include <linux/config.h>
 
-#ifndef MAX_HWIFS
-#define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
-#endif
-
 #define ide_default_io_ctl(base)	(0)
 
 #include <asm-generic/ide_iops.h>
Index: work-ide/include/asm-sh64/ide.h
===================================================================
--- work-ide.orig/include/asm-sh64/ide.h	2005-08-24 09:36:41.000000000 -0600
+++ work-ide/include/asm-sh64/ide.h	2005-08-24 09:37:12.000000000 -0600
@@ -17,10 +17,6 @@
 
 #include <linux/config.h>
 
-#ifndef MAX_HWIFS
-#define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
-#endif
-
 /* Without this, the initialisation of PCI IDE cards end up calling
  * ide_init_hwif_ports, which won't work. */
 #ifdef CONFIG_BLK_DEV_IDEPCI
Index: work-ide/include/linux/ide.h
===================================================================
--- work-ide.orig/include/linux/ide.h	2005-08-24 09:37:03.000000000 -0600
+++ work-ide/include/linux/ide.h	2005-08-24 09:37:24.000000000 -0600
@@ -266,6 +266,10 @@
 
 #include <asm/ide.h>
 
+#ifndef MAX_HWIFS
+#define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
+#endif
+
 /* needed on alpha, x86/x86_64, ia64, mips, ppc32 and sh */
 #ifndef IDE_ARCH_OBSOLETE_DEFAULTS
 # define ide_default_io_base(index)	(0)
