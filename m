Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316887AbSGHMvX>; Mon, 8 Jul 2002 08:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316889AbSGHMvX>; Mon, 8 Jul 2002 08:51:23 -0400
Received: from gherkin.frus.com ([192.158.254.49]:40576 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S316887AbSGHMvV>;
	Mon, 8 Jul 2002 08:51:21 -0400
Message-Id: <m17RY1h-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: [PATCH] 2.5.25: IFORCE joystick code buglets
To: linux-kernel@vger.kernel.org
Date: Mon, 8 Jul 2002 07:54:01 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll include the following patches in-line since they are both small
and obvious.  For what it's worth, I wouldn't have found the first bug
if the second hadn't existed :-).


====--CUT HERE--====
--- linux/drivers/input/joystick/iforce/iforce-packets.c.orig	Sun Jul  7 20:42:42 2002
+++ linux/drivers/input/joystick/iforce/iforce-packets.c	Sun Jul  7 20:45:28 2002
@@ -249,9 +249,8 @@
 
 	switch (iforce->bus) {
 
-	case IFORCE_USB:
-
 #ifdef IFORCE_USB
+	case IFORCE_USB:
 		iforce->cr.bRequest = packet[0];
 		iforce->ctrl->dev = iforce->usbdev;
 
@@ -274,14 +273,11 @@
 			usb_unlink_urb(iforce->ctrl);
 			return -1;
 		}
-#else
-		printk(KERN_ERR "iforce_get_id_packet: iforce->bus = USB!\n");
-#endif
 		break;
-
-	case IFORCE_232: +#endif
 
 #ifdef IFORCE_232
+	case IFORCE_232:
 		iforce->expect_packet = FF_CMD_QUERY;
 		iforce_send_packet(iforce, FF_CMD_QUERY, packet);
 
@@ -298,10 +294,8 @@
 			iforce->expect_packet = 0;
 			return -1;
 		}
-#else
-		printk(KERN_ERR "iforce_get_id_packet: iforce->bus = SERIO!\n");
-#endif
 		break;
+#endif
 
 	default:
 		printk(KERN_ERR "iforce_get_id_packet: iforce->bus = %d\n",
====--TUC EREH--====

====--CUT HERE--====
--- linux/drivers/input/joystick/iforce/iforce.h.orig	Sun Jul  7 15:18:26 2002
+++ linux/drivers/input/joystick/iforce/iforce.h	Sun Jul  7 16:35:43 2002
@@ -47,10 +47,10 @@
 
 #define IFORCE_MAX_LENGTH	16
 
-#if defined(CONFIG_JOYSTICK_IFORCE_232)
+#if defined(CONFIG_JOYSTICK_IFORCE_232) || defined(CONFIG_JOYSTICK_IFORCE_232_MODULE)
 #define IFORCE_232	1
 #endif
-#if defined(CONFIG_JOYSTICK_IFORCE_USB)
+#if defined(CONFIG_JOYSTICK_IFORCE_USB) || defined(CONFIG_JOYSTICK_IFORCE_USB_MODULE)
 #define IFORCE_USB	2
 #endif
 
====--TUC EREH--====

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
