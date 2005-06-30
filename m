Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262959AbVF3KzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262959AbVF3KzP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbVF3Kym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:54:42 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:15517 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S262941AbVF3KVD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:21:03 -0400
Date: Thu, 30 Jun 2005 20:20:39 +1000
To: linuxppc64-dev@ozlabs.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/12] iseries_veth: Make error messages more user friendly, and add a debug macro
In-Reply-To: <200506302016.55125.michael@ellerman.id.au>
Message-Id: <1120126839.106943.128468321759.qpatch@concordia>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the iseries_veth driver prints the file name and line number in its
error messages. This isn't very useful for most users, so just print
"iseries_veth: message" instead.

Also add a veth_debug() and veth_info() macro to replace the current
veth_printk().


---

 drivers/net/iseries_veth.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

Index: veth-dev/drivers/net/iseries_veth.c
===================================================================
--- veth-dev.orig/drivers/net/iseries_veth.c
+++ veth-dev/drivers/net/iseries_veth.c
@@ -79,6 +79,8 @@
 #include <asm/iommu.h>
 #include <asm/vio.h>
 
+#define DEBUG	1
+
 #include "iseries_veth.h"
 
 MODULE_AUTHOR("Kyle Lucke <klucke@us.ibm.com>");
@@ -176,11 +178,18 @@ static void veth_timed_ack(unsigned long
  * Utility functions
  */
 
-#define veth_printk(prio, fmt, args...) \
-	printk(prio "%s: " fmt, __FILE__, ## args)
+#define veth_info(fmt, args...) \
+	printk(KERN_INFO "iseries_veth: " fmt, ## args)
 
 #define veth_error(fmt, args...) \
-	printk(KERN_ERR "(%s:%3.3d) ERROR: " fmt, __FILE__, __LINE__ , ## args)
+	printk(KERN_ERR "iseries_veth: Error: " fmt, ## args)
+
+#ifdef DEBUG
+#define veth_debug(fmt, args...) \
+	printk(KERN_DEBUG "iseries_veth: " fmt, ## args)
+#else
+#define veth_debug(fmt, args...) do {} while (0)
+#endif
 
 static inline void veth_stack_push(struct veth_lpar_connection *cnx,
 				   struct veth_msg *msg)
