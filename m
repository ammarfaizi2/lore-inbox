Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVHATlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVHATlZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 15:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVHATlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 15:41:24 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:46278 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S261177AbVHATkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 15:40:08 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH] PNP: make pnp_dbg conditional directly on CONFIG_PNP_DEBUG
Date: Mon, 1 Aug 2005 13:39:59 -0600
User-Agent: KMail/1.8.1
Cc: Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508011339.59604.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems pointless to require .c files to test CONFIG_PNP_DEBUG and
conditionally define DEBUG before including <linux/pnp.h>.  Just
test CONFIG_PNP_DEBUG directly in pnp.h.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work/drivers/pnp/card.c
===================================================================
--- work.orig/drivers/pnp/card.c	2005-08-01 09:53:38.000000000 -0600
+++ work/drivers/pnp/card.c	2005-08-01 10:04:44.000000000 -0600
@@ -8,13 +8,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-
-#ifdef CONFIG_PNP_DEBUG
-	#define DEBUG
-#else
-	#undef DEBUG
-#endif
-
 #include <linux/pnp.h>
 #include "base.h"
 
Index: work/drivers/pnp/driver.c
===================================================================
--- work.orig/drivers/pnp/driver.c	2005-08-01 09:53:38.000000000 -0600
+++ work/drivers/pnp/driver.c	2005-08-01 10:04:44.000000000 -0600
@@ -11,13 +11,6 @@
 #include <linux/module.h>
 #include <linux/ctype.h>
 #include <linux/slab.h>
-
-#ifdef CONFIG_PNP_DEBUG
-	#define DEBUG
-#else
-	#undef DEBUG
-#endif
-
 #include <linux/pnp.h>
 #include "base.h"
 
Index: work/drivers/pnp/manager.c
===================================================================
--- work.orig/drivers/pnp/manager.c	2005-08-01 09:53:38.000000000 -0600
+++ work/drivers/pnp/manager.c	2005-08-01 10:04:44.000000000 -0600
@@ -11,13 +11,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-
-#ifdef CONFIG_PNP_DEBUG
-	#define DEBUG
-#else
-	#undef DEBUG
-#endif
-
 #include <linux/pnp.h>
 #include "base.h"
 
Index: work/drivers/pnp/quirks.c
===================================================================
--- work.orig/drivers/pnp/quirks.c	2005-08-01 09:53:38.000000000 -0600
+++ work/drivers/pnp/quirks.c	2005-08-01 10:04:44.000000000 -0600
@@ -16,13 +16,6 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/slab.h>
-
-#ifdef CONFIG_PNP_DEBUG
-	#define DEBUG
-#else
-	#undef DEBUG
-#endif
-
 #include <linux/pnp.h>
 #include "base.h"
 
Index: work/drivers/pnp/support.c
===================================================================
--- work.orig/drivers/pnp/support.c	2005-08-01 09:53:38.000000000 -0600
+++ work/drivers/pnp/support.c	2005-08-01 10:04:44.000000000 -0600
@@ -8,13 +8,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/ctype.h>
-
-#ifdef CONFIG_PNP_DEBUG
-	#define DEBUG
-#else
-	#undef DEBUG
-#endif
-
 #include <linux/pnp.h>
 #include "base.h"
 
Index: work/include/linux/pnp.h
===================================================================
--- work.orig/include/linux/pnp.h	2005-08-01 09:53:38.000000000 -0600
+++ work/include/linux/pnp.h	2005-08-01 10:04:44.000000000 -0600
@@ -443,7 +443,7 @@
 #define pnp_info(format, arg...) printk(KERN_INFO "pnp: " format "\n" , ## arg)
 #define pnp_warn(format, arg...) printk(KERN_WARNING "pnp: " format "\n" , ## arg)
 
-#ifdef DEBUG
+#ifdef CONFIG_PNP_DEBUG
 #define pnp_dbg(format, arg...) printk(KERN_DEBUG "pnp: " format "\n" , ## arg)
 #else
 #define pnp_dbg(format, arg...) do {} while (0)
Index: work/drivers/pnp/pnpacpi/core.c
===================================================================
--- work.orig/drivers/pnp/pnpacpi/core.c	2005-08-01 10:04:44.000000000 -0600
+++ work/drivers/pnp/pnpacpi/core.c	2005-08-01 10:16:42.000000000 -0600
@@ -19,6 +19,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include <linux/config.h>
 #include <linux/acpi.h>
 #include <linux/pnp.h>
 #include <acpi/acpi_bus.h>
