Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVHHSLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVHHSLt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 14:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVHHSLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 14:11:49 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:43667 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932173AbVHHSLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 14:11:48 -0400
Subject: [PATCH] Custom IORESOURCE Class
From: Matthew Gilbert <mgilbert@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Patrick Mochel <mochel@digitalimplant.org>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 11:11:45 -0700
Message-Id: <1123524705.7951.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a patch that adds an additional resource class to the platform 
resource types. This is to support additional resources that need to be passed
to drivers without overloading the existing specific types. In my case, I need
to send clock information to the driver to enable power management. 

Signed-off-by: Matthew Gilbert <mgilbert@mvista.com>

diff -uprN -X dontdiff linux-2.6.12.3.orig/drivers/base/platform.c linux-2.6.12.3/drivers/base/platform.c
--- linux-2.6.12.3.orig/drivers/base/platform.c	2005-07-15 14:18:57.000000000 -0700
+++ linux-2.6.12.3/drivers/base/platform.c	2005-08-04 10:54:59.706802768 -0700
@@ -37,7 +37,7 @@ platform_get_resource(struct platform_de
 		struct resource *r = &dev->resource[i];
 
 		if ((r->flags & (IORESOURCE_IO|IORESOURCE_MEM|
-				 IORESOURCE_IRQ|IORESOURCE_DMA))
+				 IORESOURCE_IRQ|IORESOURCE_DMA|IORESOURCE_OTHER))
 		    == type)
 			if (num-- == 0)
 				return r;
@@ -73,7 +73,7 @@ platform_get_resource_byname(struct plat
 		struct resource *r = &dev->resource[i];
 
 		if ((r->flags & (IORESOURCE_IO|IORESOURCE_MEM|
-				 IORESOURCE_IRQ|IORESOURCE_DMA)) == type)
+				 IORESOURCE_IRQ|IORESOURCE_DMA|IORESOURCE_OTHER)) == type)
 			if (!strcmp(r->name, name))
 				return r;
 	}
diff -uprN -X dontdiff linux-2.6.12.3.orig/include/linux/ioport.h linux-2.6.12.3/include/linux/ioport.h
--- linux-2.6.12.3.orig/include/linux/ioport.h	2005-07-15 14:18:57.000000000 -0700
+++ linux-2.6.12.3/include/linux/ioport.h	2005-08-04 10:31:14.099528016 -0700
@@ -35,13 +35,14 @@ struct resource_list {
 #define IORESOURCE_MEM		0x00000200
 #define IORESOURCE_IRQ		0x00000400
 #define IORESOURCE_DMA		0x00000800
+#define IORESOURCE_OTHER	0x00001000
 
-#define IORESOURCE_PREFETCH	0x00001000	/* No side effects */
-#define IORESOURCE_READONLY	0x00002000
-#define IORESOURCE_CACHEABLE	0x00004000
-#define IORESOURCE_RANGELENGTH	0x00008000
-#define IORESOURCE_SHADOWABLE	0x00010000
-#define IORESOURCE_BUS_HAS_VGA	0x00080000
+#define IORESOURCE_PREFETCH	0x00010000	/* No side effects */
+#define IORESOURCE_READONLY	0x00020000
+#define IORESOURCE_CACHEABLE	0x00040000
+#define IORESOURCE_RANGELENGTH	0x00080000
+#define IORESOURCE_SHADOWABLE	0x00100000
+#define IORESOURCE_BUS_HAS_VGA	0x00800000
 
 #define IORESOURCE_DISABLED	0x10000000
 #define IORESOURCE_UNSET	0x20000000


