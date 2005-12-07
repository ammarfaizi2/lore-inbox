Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbVLGOfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVLGOfn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 09:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVLGOfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 09:35:42 -0500
Received: from mxb.rambler.ru ([81.19.66.30]:57092 "EHLO mxb.rambler.ru")
	by vger.kernel.org with ESMTP id S1751106AbVLGOfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 09:35:41 -0500
Message-ID: <4396F38E.1020200@rambler.ru>
Date: Wed, 07 Dec 2005 17:37:02 +0300
From: Pavel Fedin <sonic_amiga@rambler.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] support for Posiflex PP-7000 retail printer for ftdi_sio
 driver
Content-Type: multipart/mixed;
 boundary="------------090206060805060000070104"
X-Auth-User: sonic_amiga, whoson: (null)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090206060805060000070104
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

  This little patch adds an ability to recognize Posiflex PP-7000 retail printer for ftdi_sio 
driver. The printer uses FT232BM USB-serial brigde but is programmed with custom VID and PID.
  The patch is made for 2.6.11.1 kernel but is extremely easy to adapt to newer versions. I also 
posted it to "Patches" page on sf.net project. I wrote to project admin a letter asking to give me 
an access to their CVS but got no reply.

  Kind regards

--------------090206060805060000070104
Content-Type: text/x-patch;
 name="ftdi_sio_posiflex_pp7000-2.6.11.1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ftdi_sio_posiflex_pp7000-2.6.11.1.diff"

--- linux-2.6.11.1/drivers/usb/serial/ftdi_sio.c.orig	2005-03-04 20:26:42.000000000 +0300
+++ linux-2.6.11.1/drivers/usb/serial/ftdi_sio.c	2005-12-06 22:47:20.000000000 +0300
@@ -488,6 +488,7 @@
 	{ USB_DEVICE_VER(BANDB_VID, BANDB_USTL4_PID, 0x400, 0xffff) },
 	{ USB_DEVICE_VER(BANDB_VID, BANDB_USO9ML2_PID, 0x400, 0xffff) },
 	{ USB_DEVICE_VER(FTDI_VID, EVER_ECO_PRO_CDS, 0x400, 0xffff) },
+	{ USB_DEVICE(POSIFLEX_VID, POSIFLEX_PP7000_PID) },
 	{ }						/* Terminating entry */
 };
 
@@ -611,6 +612,7 @@
 	{ USB_DEVICE(BANDB_VID, BANDB_USTL4_PID) },
 	{ USB_DEVICE(BANDB_VID, BANDB_USO9ML2_PID) },
 	{ USB_DEVICE(FTDI_VID, EVER_ECO_PRO_CDS) },
+	{ USB_DEVICE(POSIFLEX_VID, POSIFLEX_PP7000_PID) },
 	{ }						/* Terminating entry */
 };
 
--- linux-2.6.11.1/drivers/usb/serial/ftdi_sio.h.orig	2005-03-04 20:26:44.000000000 +0300
+++ linux-2.6.11.1/drivers/usb/serial/ftdi_sio.h	2005-12-05 22:22:27.000000000 +0300
@@ -246,6 +246,12 @@
 
 #define	EVER_ECO_PRO_CDS	0xe520	/* RS-232 converter */
 
+/*
+ * Posiflex inc retail equipment (http://www.posiflex.com.tw)
+ */
+#define POSIFLEX_VID		0x0d3a  /* Vendor ID */
+#define POSIFLEX_PP7000_PID	0x0300  /* PP-7000II thermal printer */
+
 /* Commands */
 #define FTDI_SIO_RESET 		0 /* Reset the port */
 #define FTDI_SIO_MODEM_CTRL 	1 /* Set the modem control register */

--------------090206060805060000070104--
