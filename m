Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269891AbRHMWyz>; Mon, 13 Aug 2001 18:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269892AbRHMWyq>; Mon, 13 Aug 2001 18:54:46 -0400
Received: from mark.qldnet.com.au ([203.16.61.203]:22278 "EHLO
	mark.qldnet.com.au") by vger.kernel.org with ESMTP
	id <S269891AbRHMWyk>; Mon, 13 Aug 2001 18:54:40 -0400
Date: Tue, 14 Aug 2001 08:54:48 +1000 (EST)
From: Adam Hynes <networks@consultant.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.8 linux/drivers/sound/esssolo1.c
Message-ID: <Pine.LNX.4.20.0108140853510.25171-100000@mark.qldnet.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the Unresolved symbols error with esssolo1.c
kernel 2.4.8



--- linux/drivers/sound/esssolo1.c.orig	Tue Aug 14 08:36:59 2001
+++ linux/drivers/sound/esssolo1.c	Tue Aug 14 08:49:22 2001
@@ -82,6 +82,8 @@
  *    22.05.2001   0.19  more cleanups, changed PM to PCI 2.4 style, got rid
  *                       of global list of devices, using pci device data.
  *                       Marcus Meissner <mm@caldera.de>
+ *    14.08.2001         Patched to stop Unresolved symbols error.
+ *                       Adam Hynes <networks@consultant.com>
  */
 
 /*****************************************************************************/
@@ -106,9 +108,27 @@
 #include <linux/wrapper.h>
 #include <asm/uaccess.h>
 #include <asm/hardirq.h>
-#include <linux/gameport.h>
 
 #include "dm.h"
+
+#if defined(CONFIG_INPUT_ANALOG) || defined(CONFIG_INPUT_ANALOG_MODULE)
+#include <linux/gameport.h>
+#else
+struct gameport {
+	int io;
+	int size;
+};
+
+extern inline void gameport_register_port(struct gameport *gameport)
+{
+}
+
+extern inline void gameport_unregister_port(struct gameport *gameport)
+{
+}
+#endif
+
+
 
 /* --------------------------------------------------------------------- */
 

---------------------------------
 Adam Hynes
 Email: networks@consultant.com
 ICQ: 37561700
---------------------------------

