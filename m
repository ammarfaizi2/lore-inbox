Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbWEYHWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWEYHWH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 03:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbWEYHWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 03:22:04 -0400
Received: from mkedef2.rockwellautomation.com ([63.161.86.254]:26691 "EHLO
	ramilwsmtp01.ra.rockwell.com") by vger.kernel.org with ESMTP
	id S965069AbWEYHVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 03:21:46 -0400
Message-ID: <44755B33.3080302@ra.rockwell.com>
Date: Thu, 25 May 2006 09:22:27 +0200
From: Milan Svoboda <msvoboda@ra.rockwell.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] usb gadget: clean udc.h
X-MIMETrack: Itemize by SMTP Server on RAMilwSMTP01/Milwaukee/RA/Rockwell(Release
 6.5.4FP1|June 19, 2005) at 05/25/2006 02:22:28 AM,
	Serialize by Router on RAMilwSMTP01/Milwaukee/RA/Rockwell(Release 6.5.4FP1|June
 19, 2005) at 05/25/2006 02:22:30 AM,
	Serialize complete at 05/25/2006 02:22:30 AM
Content-Type: multipart/mixed;
 boundary="------------000901010402070402010100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000901010402070402010100
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

From: Milan Svoboda <msvoboda@ra.rockwell.com>

This patch deletes file udc.h in include/asm-arm/arch-pxa and
include/asm-arm/arch-ixp4xx
and creates the same file in include/asm-arm.

I'm not sure if this change is correct, but this header is same for
those two architectures
and it's used by pxa2xx_udc driver only. Do you have better ideas?

This patch is against 2.6.16.13 with previous patches applied.

Signed-off-by: Milan Svoboda <msvoboda@ra.rockwell.com>
---




--------------000901010402070402010100
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="beautify.patch"
Content-Disposition: inline;
 filename="beautify.patch"

diff -urpN -X orig/Documentation/dontdiff orig/arch/arm/mach-ixp4xx/common.c new_gadget/arch/arm/mach-ixp4xx/common.c
--- orig/arch/arm/mach-ixp4xx/common.c	2006-05-15 14:45:52.000000000 +0000
+++ new_gadget/arch/arm/mach-ixp4xx/common.c	2006-05-15 15:17:15.000000000 +0000
@@ -34,13 +34,12 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <asm/irq.h>
+#include <asm/udc.h>
 
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
-#include <asm/arch/udc.h>
-
 /*************************************************************************
  * IXP4xx chipset I/O mapping
  *************************************************************************/
diff -urpN -X orig/Documentation/dontdiff orig/drivers/usb/gadget/pxa2xx_udc.c new_gadget/drivers/usb/gadget/pxa2xx_udc.c
--- orig/drivers/usb/gadget/pxa2xx_udc.c	2006-05-15 14:45:52.000000000 +0000
+++ new_gadget/drivers/usb/gadget/pxa2xx_udc.c	2006-05-15 15:11:55.000000000 +0000
@@ -60,7 +60,7 @@
 #include <linux/usb_ch9.h>
 #include <linux/usb_gadget.h>
 
-#include <asm/arch/udc.h>
+#include <asm/udc.h>
 
 
 /*
diff -urpN -X orig/Documentation/dontdiff orig/include/asm-arm/arch-ixp4xx/udc.h new_gadget/include/asm-arm/arch-ixp4xx/udc.h
--- orig/include/asm-arm/arch-ixp4xx/udc.h	2006-05-15 14:45:52.000000000 +0000
+++ new_gadget/include/asm-arm/arch-ixp4xx/udc.h	1970-01-01 00:00:00.000000000 +0000
@@ -1,18 +0,0 @@
-/*
- * linux/include/asm-arm/arch-pxa/udc.h
- *
- * This supports machine-specific differences in how the PXA2xx
- * USB Device Controller (UDC) is wired.
- *
- * It is set in linux/arch/arm/mach-pxa/<machine>.c and used in
- * the probe routine of linux/drivers/usb/gadget/pxa2xx_udc.c
- */
-struct pxa2xx_udc_mach_info {
-        int  (*udc_is_connected)(void);		/* do we see host? */
-        void (*udc_command)(int cmd);
-#define	PXA2XX_UDC_CMD_CONNECT		0	/* let host see us */
-#define	PXA2XX_UDC_CMD_DISCONNECT	1	/* so host won't see us */
-};
-
-extern void pxa_set_udc_info(struct pxa2xx_udc_mach_info *info);
-
diff -urpN -X orig/Documentation/dontdiff orig/include/asm-arm/arch-pxa/udc.h new_gadget/include/asm-arm/arch-pxa/udc.h
--- orig/include/asm-arm/arch-pxa/udc.h	2005-03-02 07:38:17.000000000 +0000
+++ new_gadget/include/asm-arm/arch-pxa/udc.h	2006-05-15 15:13:26.000000000 +0000
@@ -1,18 +1,4 @@
-/*
- * linux/include/asm-arm/arch-pxa/udc.h
- *
- * This supports machine-specific differences in how the PXA2xx
- * USB Device Controller (UDC) is wired.
- *
- * It is set in linux/arch/arm/mach-pxa/<machine>.c and used in
- * the probe routine of linux/drivers/usb/gadget/pxa2xx_udc.c
- */
-struct pxa2xx_udc_mach_info {
-        int  (*udc_is_connected)(void);		/* do we see host? */
-        void (*udc_command)(int cmd);
-#define	PXA2XX_UDC_CMD_CONNECT		0	/* let host see us */
-#define	PXA2XX_UDC_CMD_DISCONNECT	1	/* so host won't see us */
-};
+#include <asm/udc.h>
 
 extern void pxa_set_udc_info(struct pxa2xx_udc_mach_info *info);
 
diff -urpN -X orig/Documentation/dontdiff orig/include/asm-arm/udc.h new_gadget/include/asm-arm/udc.h
--- orig/include/asm-arm/udc.h	1970-01-01 00:00:00.000000000 +0000
+++ new_gadget/include/asm-arm/udc.h	2006-05-15 15:12:43.000000000 +0000
@@ -0,0 +1,13 @@
+/*
+ * linux/include/asm-arm/udc.h
+ *
+ * This supports machine-specific differences in how the PXA2xx
+ * USB Device Controller (UDC) is wired.
+ *
+ */
+struct pxa2xx_udc_mach_info {
+        int  (*udc_is_connected)(void);		/* do we see host? */
+        void (*udc_command)(int cmd);
+#define	PXA2XX_UDC_CMD_CONNECT		0	/* let host see us */
+#define	PXA2XX_UDC_CMD_DISCONNECT	1	/* so host won't see us */
+};





--------------000901010402070402010100--
