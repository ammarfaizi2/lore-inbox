Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVAaNDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVAaNDg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 08:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVAaNDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 08:03:36 -0500
Received: from moutng.kundenserver.de ([212.227.126.189]:30432 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261178AbVAaNCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 08:02:34 -0500
Date: Mon, 31 Jan 2005 14:02:27 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, developers@melware.de
Subject: [PATCH 1/3] 2.6 ISDN Eicon driver: add missing uaccess
Message-ID: <41FE2C63.mailD8U11TTK4@phoenix.one.melware.de>
User-Agent: nail 11.4 8/29/04
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: armin@melware.de (Armin Schindler)
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds asm/uaccess.h to files which uses copy_to/from_user()
and adds the use of the drivers internal API call to copy_to/from_user()
in platform independent code.

Signed-off-by: Armin Schindler <armin@melware.de>


diff -Nur linux.orig/drivers/isdn/hardware/eicon/divamnt.c linux/drivers/isdn/hardware/eicon/divamnt.c
--- linux.orig/drivers/isdn/hardware/eicon/divamnt.c	2005-01-31 12:34:17.668288724 +0100
+++ linux/drivers/isdn/hardware/eicon/divamnt.c	2005-01-31 13:22:46.887318527 +0100
@@ -1,4 +1,4 @@
-/* $Id: divamnt.c,v 1.32.6.5 2004/08/28 20:03:53 armin Exp $
+/* $Id: divamnt.c,v 1.32.6.9 2005/01/31 12:22:20 armin Exp $
  *
  * Driver for Eicon DIVA Server ISDN cards.
  * Maint module
@@ -18,13 +18,14 @@
 #include <linux/smp_lock.h>
 #include <linux/poll.h>
 #include <linux/devfs_fs_kernel.h>
+#include <asm/uaccess.h>
 
 #include "platform.h"
 #include "di_defs.h"
 #include "divasync.h"
 #include "debug_if.h"
 
-static char *main_revision = "$Revision: 1.32.6.5 $";
+static char *main_revision = "$Revision: 1.32.6.9 $";
 
 static int major;
 
diff -Nur linux.orig/drivers/isdn/hardware/eicon/divasi.c linux/drivers/isdn/hardware/eicon/divasi.c
--- linux.orig/drivers/isdn/hardware/eicon/divasi.c	2005-01-31 12:33:40.075790246 +0100
+++ linux/drivers/isdn/hardware/eicon/divasi.c	2005-01-31 13:22:46.887318527 +0100
@@ -1,4 +1,4 @@
-/* $Id: divasi.c,v 1.25 2003/09/09 06:46:29 schindler Exp $
+/* $Id: divasi.c,v 1.25.6.2 2005/01/31 12:22:20 armin Exp $
  *
  * Driver for Eicon DIVA Server ISDN cards.
  * User Mode IDI Interface 
@@ -20,6 +20,7 @@
 #include <linux/proc_fs.h>
 #include <linux/skbuff.h>
 #include <linux/devfs_fs_kernel.h>
+#include <asm/uaccess.h>
 
 #include "platform.h"
 #include "di_defs.h"
@@ -27,7 +28,7 @@
 #include "um_xdi.h"
 #include "um_idi.h"
 
-static char *main_revision = "$Revision: 1.25 $";
+static char *main_revision = "$Revision: 1.25.6.2 $";
 
 static int major;
 
diff -Nur linux.orig/drivers/isdn/hardware/eicon/divasproc.c linux/drivers/isdn/hardware/eicon/divasproc.c
--- linux.orig/drivers/isdn/hardware/eicon/divasproc.c	2005-01-31 12:35:17.717098225 +0100
+++ linux/drivers/isdn/hardware/eicon/divasproc.c	2005-01-31 13:22:46.888318407 +0100
@@ -1,4 +1,4 @@
-/* $Id: divasproc.c,v 1.19 2004/03/21 17:26:01 armin Exp $
+/* $Id: divasproc.c,v 1.19.4.3 2005/01/31 12:22:20 armin Exp $
  *
  * Low level driver for Eicon DIVA Server ISDN cards.
  * /proc functions
@@ -16,6 +16,7 @@
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
 #include <linux/list.h>
+#include <asm/uaccess.h>
 
 #include "platform.h"
 #include "debuglib.h"
diff -Nur linux.orig/drivers/isdn/hardware/eicon/mntfunc.c linux/drivers/isdn/hardware/eicon/mntfunc.c
--- linux.orig/drivers/isdn/hardware/eicon/mntfunc.c	2005-01-31 12:32:26.210635302 +0100
+++ linux/drivers/isdn/hardware/eicon/mntfunc.c	2005-01-31 13:22:46.896317449 +0100
@@ -1,4 +1,4 @@
-/* $Id: mntfunc.c,v 1.19.6.2 2004/08/28 20:03:53 armin Exp $
+/* $Id: mntfunc.c,v 1.19.6.4 2005/01/31 12:22:20 armin Exp $
  *
  * Driver for Eicon DIVA Server ISDN cards.
  * Maint module
@@ -187,7 +187,7 @@
 		if (!mask) {
 			ret = diva_set_trace_filter (1, "*");
 		} else if (mask < sizeof(data)) {
-			if (copy_from_user(data, (char __user *)buf+12, mask)) {
+			if (diva_os_copy_from_user(NULL, data, (char __user *)buf+12, mask)) {
 				ret = -EFAULT;
 			} else {
 				ret = diva_set_trace_filter ((int)mask, data);
@@ -199,7 +199,7 @@
 
 	case DITRACE_READ_SELECTIVE_TRACE_FILTER:
 		if ((ret = diva_get_trace_filter (sizeof(data), data)) > 0) {
-			if (copy_to_user (buf, data, ret))
+			if (diva_os_copy_to_user (NULL, buf, data, ret))
 				ret = -EFAULT;
 		} else {
 			ret = -ENODEV;
