Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVCCGIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVCCGIe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 01:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVCCFec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:34:32 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:54897 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261365AbVCCFbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 00:31:45 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][8/11] IB/ipoib: rename global symbols
In-Reply-To: <2005322131.K2SnvQsocHnkTwPm@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 2 Mar 2005 21:31:22 -0800
Message-Id: <2005322131.OKEJHXn13XfMX2Aa@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 05:31:22.0898 (UTC) FILETIME=[3C76B720:01C51FB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make IPoIB data_debug_level module parameter static to the single file
where it is used.  Also Rename IPoIB module parameter variable from
"debug_level" to "ipoib_debug_level".  This avoids possible name
clashes if IPoIB is built into the kernel.  We use module_param_named
so that the user-visible parameter names remain the same.

Signed-off-by: Tom Duffy <tduffy@sun.com>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/ulp/ipoib/ipoib.h	2005-03-02 20:26:02.744892334 -0800
+++ linux-export/drivers/infiniband/ulp/ipoib/ipoib.h	2005-03-02 20:26:13.207621227 -0800
@@ -308,11 +308,11 @@
 
 
 #ifdef CONFIG_INFINIBAND_IPOIB_DEBUG
-extern int debug_level;
+extern int ipoib_debug_level;
 
 #define ipoib_dbg(priv, format, arg...)			\
 	do {					        \
-		if (debug_level > 0)			\
+		if (ipoib_debug_level > 0)			\
 			ipoib_printk(KERN_DEBUG, priv, format , ## arg); \
 	} while (0)
 #define ipoib_dbg_mcast(priv, format, arg...)		\
--- linux-export.orig/drivers/infiniband/ulp/ipoib/ipoib_ib.c	2005-03-02 20:26:12.514771621 -0800
+++ linux-export/drivers/infiniband/ulp/ipoib/ipoib_ib.c	2005-03-02 20:26:13.208621010 -0800
@@ -40,7 +40,7 @@
 #include "ipoib.h"
 
 #ifdef CONFIG_INFINIBAND_IPOIB_DEBUG_DATA
-int data_debug_level;
+static int data_debug_level;
 
 module_param(data_debug_level, int, 0644);
 MODULE_PARM_DESC(data_debug_level,
--- linux-export.orig/drivers/infiniband/ulp/ipoib/ipoib_main.c	2005-03-02 20:26:02.744892334 -0800
+++ linux-export/drivers/infiniband/ulp/ipoib/ipoib_main.c	2005-03-02 20:26:13.207621227 -0800
@@ -51,9 +51,9 @@
 MODULE_LICENSE("Dual BSD/GPL");
 
 #ifdef CONFIG_INFINIBAND_IPOIB_DEBUG
-int debug_level;
+int ipoib_debug_level;
 
-module_param(debug_level, int, 0644);
+module_param_named(debug_level, ipoib_debug_level, int, 0644);
 MODULE_PARM_DESC(debug_level, "Enable debug tracing if > 0");
 #endif
 

