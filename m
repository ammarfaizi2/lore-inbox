Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWGKJg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWGKJg7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 05:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWGKJg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 05:36:59 -0400
Received: from paperstreet.colino.net ([213.41.244.236]:9382 "EHLO
	paperstreet.colino.net") by vger.kernel.org with ESMTP
	id S1750857AbWGKJg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 05:36:58 -0400
Date: Tue, 11 Jul 2006 11:36:43 +0200
From: Colin Leroy <colin@colino.net>
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: [PATCH] Add one VID/PID to ftdi_sio
Message-ID: <20060711113643.241cdf58@colin.toulouse>
X-Mailer: Sylpheed-Claws 2.3.1cvs78 (GTK+ 2.8.18; i686-pc-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAIVBMVEUqKio4ODhMTExhYWFwcHCEhISYmJinp6e7u7va2tr8/PzqsOQcAAACXElEQVQ4y2WUz2/TMBTHkwnGNY5aiSNxgFXclk4T2omu3WCcYG2iiRNqyQ96nGBtuaGtidMjUlvbd6DOX8mzE6fd6Kl6n3zf9z37PRvFzo8xJvR/o46KNOy1e+P/wLrvYYw9/O4BEGEQhQMP4PgeEHRGCbnpGobt3gfgy/LUM4Cc7AAVZ2x+CMBs7iogSll+9wyAgRdbUArY0JLAONkBKhftq7j5pAaVxbqrgGFvgSgVnRIYiweK7GMF3teAK/D9TRk3n2pQeZ8eVorHFRCUcWXhVKCpQQd/BRW9dMo+jD2d6vr5eQ7ZRhpYGtDLswRSfXEQKhHX5ks/kI3jRjxUigoItpzRnFGvMe0eWzseQqyJKvft+iD7AOBRpYBYLhsJk/SKfJYdloBVJwJXuHxNJdirAK/iJP+ZZ3As5n7pQWOqySCfyF5aJdhEU65ENEvY3EampU9X6GRQ23XDs4xxoasq/UnOVvj81JKNKzBllYTEnZfZyDH11d4Fqg0YxbCdTPq4qRWEyrOljGRXckydV1qxTKj0ICSbkuybZ9cDJxJSZgKQto869cAJSnMIAyBpbzJE+7zug2WETADcBGxko3rgNjDnfhTFcRSwW4xsa1x7ZIOeH/hRzJewbgi19J3P+0cD3/cDvvFk3GrW0752IX6WF7cgcBxkf6oXZ9Xzw1nxF5bTRgh7L7ZbS/1pUYxcADaoYKnqdU55sQIHG4Dr4ovtA8CEGHoYOfIRwN5xDTYL8Vsa2+p5wO2FBozzoQMFYexK5F5owIs/YIDk565EB3rPf/Bf0JpTJgJF6x8QmAmhnJ3GRAAAAABJRU5ErkJggg==
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds the Testo USB interface to the list of devices
recognized by the ftdi_sio module. This device is based on a FT232BL
chip, and is used as an interface to get data from digital sensors
(thermometer, etc). See http://www.testo.com/

Signed-Off-By: Colin Leroy <colin@colino.net>

--- a/drivers/usb/serial/ftdi_sio.h	2006-07-11 11:17:41.000000000 +0200
+++ b/drivers/usb/serial/ftdi_sio.h	2006-07-11 11:19:43.000000000 +0200
@@ -436,6 +436,13 @@
  */
 #define FTDI_ACG_HFDUAL_PID		0xDD20	/* HF Dual ISO Reader (RFID) */
 
+/*
+ * Testo products (http://www.testo.com/)
+ * Submitted by Colin Leroy
+ */
+#define TESTO_VID			0x128D
+#define TESTO_USB_INTERFACE_PID		0x0001
+
 /* Commands */
 #define FTDI_SIO_RESET 		0 /* Reset the port */
 #define FTDI_SIO_MODEM_CTRL 	1 /* Set the modem control register */
--- a/drivers/usb/serial/ftdi_sio.c	2006-07-11 11:17:30.000000000 +0200
+++ b/drivers/usb/serial/ftdi_sio.c	2006-07-11 11:20:01.000000000 +0200
@@ -500,6 +500,7 @@
 	{ USB_DEVICE(ICOM_ID1_VID, ICOM_ID1_PID) },
 	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_TMU_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_ACG_HFDUAL_PID) },
+	{ USB_DEVICE(TESTO_VID, TESTO_USB_INTERFACE_PID) },
 	{ },					/* Optional parameter entry */
 	{ }					/* Terminating entry */
 };

-- 
Colin
