Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWC1Llw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWC1Llw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 06:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWC1Llw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 06:41:52 -0500
Received: from main.gmane.org ([80.91.229.2]:56490 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932184AbWC1Llv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 06:41:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: [2.6 PATCH] add support for Papouch TMU (USB thermometer)
Date: Tue, 28 Mar 2006 20:41:26 +0900
Message-ID: <442920E6.3020603@thinrope.net>
References: <4426BD1A.7070204@thinrope.net> <4426C1BF.90802@thinrope.net> <20060326180309.GD3569@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: Greg KH <greg@kroah.com>, Folkert van Heusden <folkert@vanheusden.com>
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060324)
In-Reply-To: <20060326180309.GD3569@vanheusden.com>
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Greg,

As the time flies by, I think it is better to have this patch in for now
and leave the "big mess" for later and another thread...
(the "big mess" refers as UTF-8 and other soup of encodings in kernel
code + tab and space usage).

The patch below applies (with fuzz 2, which I hope is OK) to 2.6.16 and
2.6.16.1 vanilla. The original submitter to LKML was Folkert van Heusden
and that is why I have included his name in the code. I have just
cleaned his code and fixed the style. Not sure of the order of
Signed-off-by lines, change it if you need.

The patch as submitted below was tested with the actual device by
Folkert and reported working.




This patch adds support for new vendor (papouch) and one of their
devices - TMU (a USB thermometer).

More information:
vendor homepage:
	http://www.papouch.com/en/
product homepage (Polish):
	http://www.papouch.com/shop/scripts/_detail.asp?katcislo=0188

This patch is based on the submission from Folkert van Heusden [1].
Then reviseted by Kalin KOZHUHAROV [2] and retested by Folkert.

[1]	http://article.gmane.org/gmane.linux.kernel/392970
[2]	http://article.gmane.org/gmane.linux.kernel/393386



Signed-off-by: Folkert van Heusden <folkert@vanheusden.com>
Signed-off-by: Kalin KOZHUHAROV <kalin@thinrope.net>


diff -pruN linux-2.6.16-K01/drivers/usb/serial/ftdi_sio.c linux-2.6.16-tmp/drivers/usb/serial/ftdi_sio.c
--- linux-2.6.16-K01/drivers/usb/serial/ftdi_sio.c	2006-03-20 14:53:29.000000000 +0900
+++ linux-2.6.16-tmp/drivers/usb/serial/ftdi_sio.c	2006-03-27 00:52:20.000000000 +0900
@@ -492,6 +492,7 @@ static struct usb_device_id id_table_com
 	{ USB_DEVICE(FTDI_VID, FTDI_WESTREX_MODEL_777_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_WESTREX_MODEL_8900F_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_PCDJ_DAC2_PID) },
+	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_TMU_PID) },
 	{ },					/* Optional parameter entry */
 	{ }					/* Terminating entry */
 };
diff -pruN linux-2.6.16-K01/drivers/usb/serial/ftdi_sio.h linux-2.6.16-tmp/drivers/usb/serial/ftdi_sio.h
--- linux-2.6.16-K01/drivers/usb/serial/ftdi_sio.h	2006-03-27 00:49:43.000000000 +0900
+++ linux-2.6.16-tmp/drivers/usb/serial/ftdi_sio.h	2006-03-27 00:46:55.000000000 +0900
@@ -392,6 +392,15 @@
 #define FTDI_WESTREX_MODEL_777_PID	0xDC00	/* Model 777 */
 #define FTDI_WESTREX_MODEL_8900F_PID	0xDC01	/* Model 8900F */
 
+/*
+ * Papouch products (http://www.papouch.com/)
+ * Submitted by Folkert van Heusden
+ */
+
+#define PAPOUCH_VID			0x5050	/* Vendor ID */
+#define PAPOUCH_TMU_PID			0x0400	/* TMU USB Thermometer */
+
+
 /* Commands */
 #define FTDI_SIO_RESET			0	/* Reset the port */
 #define FTDI_SIO_MODEM_CTRL		1	/* Set the modem control register */


-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

