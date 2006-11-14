Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965834AbWKNRZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965834AbWKNRZe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 12:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965873AbWKNRZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 12:25:34 -0500
Received: from sardaukar.technologeek.org ([213.41.134.240]:673 "EHLO
	frigate.technologeek.org") by vger.kernel.org with ESMTP
	id S965834AbWKNRZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 12:25:33 -0500
From: Julien BLACHE <jb@jblache.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: dmitry.torokhov@gmail.com, stelian@popies.net
Subject: =?iso-8859-1?Q?=5BPATCH=5D=A0appletouch=3A?= add Geyser IV support
Date: Tue, 14 Nov 2006 18:25:34 +0100
Message-ID: <87wt5yos8h.fsf@frigate.technologeek.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

The new Core2 Duo MacBook Pro has a new keyboard+trackpad named
"Geyser IV".

According to the Info.plist in the OS X kext, it looks like the Geyser
IV trackpad is identical to the Geyser III trackpad: same IOClass
(AppleUSBGrIIITrackpad), same acceleration tables.

Signed-off-by: Julien BLACHE <jb@jblache.org>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=appletouch-geyser4-support.patch
Content-Description: appletouch: add Geyser IV support

--- appletouch.c.orig	2006-11-14 18:19:07.319174145 +0100
+++ appletouch.c	2006-11-14 18:19:12.939494428 +0100
@@ -54,6 +54,14 @@
 #define GEYSER3_ISO_PRODUCT_ID		0x0218
 #define GEYSER3_JIS_PRODUCT_ID		0x0219
 
+/* 
+ * Geyser IV: same as Geyser III according to Info.plist in AppleUSBTrackpad.kext
+ * -> same IOClass (AppleUSBGrIIITrackpad), same acceleration tables
+ */
+#define GEYSER4_ANSI_PRODUCT_ID	0x021A
+#define GEYSER4_ISO_PRODUCT_ID	0x021B
+#define GEYSER4_JIS_PRODUCT_ID	0x021C
+
 #define ATP_DEVICE(prod)					\
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |		\
 		       USB_DEVICE_ID_MATCH_INT_CLASS |		\
@@ -75,10 +83,16 @@
 	{ ATP_DEVICE(GEYSER_ISO_PRODUCT_ID) },
 	{ ATP_DEVICE(GEYSER_JIS_PRODUCT_ID) },
 
+	/* Core Duo MacBook & MacBook Pro */
 	{ ATP_DEVICE(GEYSER3_ANSI_PRODUCT_ID) },
 	{ ATP_DEVICE(GEYSER3_ISO_PRODUCT_ID) },
 	{ ATP_DEVICE(GEYSER3_JIS_PRODUCT_ID) },
 
+	/* Core2 Duo MacBook & MacBook Pro */
+	{ ATP_DEVICE(GEYSER4_ANSI_PRODUCT_ID) },
+	{ ATP_DEVICE(GEYSER4_ISO_PRODUCT_ID) },
+	{ ATP_DEVICE(GEYSER4_JIS_PRODUCT_ID) },
+
 	/* Terminating entry */
 	{ }
 };
@@ -115,7 +129,7 @@
  */
 #define ATP_THRESHOLD	 5
 
-/* MacBook Pro (Geyser 3) initialization constants */
+/* MacBook Pro (Geyser 3 & 4) initialization constants */
 #define ATP_GEYSER3_MODE_READ_REQUEST_ID 1
 #define ATP_GEYSER3_MODE_WRITE_REQUEST_ID 9
 #define ATP_GEYSER3_MODE_REQUEST_VALUE 0x300
@@ -181,7 +195,10 @@
 
 	return (productId == GEYSER3_ANSI_PRODUCT_ID) ||
 		(productId == GEYSER3_ISO_PRODUCT_ID) ||
-		(productId == GEYSER3_JIS_PRODUCT_ID);
+		(productId == GEYSER3_JIS_PRODUCT_ID) ||
+		(productId == GEYSER4_ANSI_PRODUCT_ID) ||
+		(productId == GEYSER4_ISO_PRODUCT_ID) ||
+		(productId == GEYSER4_JIS_PRODUCT_ID);
 }
 
 static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,

--=-=-=


JB.

-- 
Julien BLACHE                                   <http://www.jblache.org> 
<jb@jblache.org>                                  GPG KeyID 0xF5D65169

--=-=-=--
