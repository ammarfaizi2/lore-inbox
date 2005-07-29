Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbVG3Auh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbVG3Auh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbVG2TSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:18:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:27823 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262760AbVG2TRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:17:20 -0400
Date: Fri, 29 Jul 2005 12:16:52 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, abbotti@mev.co.uk
Subject: [patch 19/29] USB: ftdi_sio: fix a couple of timeouts
Message-ID: <20050729191652.GU5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-ftdi_sio-timeout-fix.patch"
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Abbott <abbotti@mev.co.uk>

ftdi_sio: Fix timeouts in a couple of usb_control_msg() calls due to
change of units from jiffies to milliseconds in 2.6.12.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/serial/ftdi_sio.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

--- gregkh-2.6.orig/drivers/usb/serial/ftdi_sio.c	2005-07-29 11:36:26.000000000 -0700
+++ gregkh-2.6/drivers/usb/serial/ftdi_sio.c	2005-07-29 11:36:27.000000000 -0700
@@ -548,6 +548,7 @@
 
 
 #define WDR_TIMEOUT 5000 /* default urb timeout */
+#define WDR_SHORT_TIMEOUT 1000	/* shorter urb timeout */
 
 /* High and low are for DTR, RTS etc etc */
 #define HIGH 1
@@ -681,7 +682,7 @@
 			    FTDI_SIO_SET_BAUDRATE_REQUEST,
 			    FTDI_SIO_SET_BAUDRATE_REQUEST_TYPE,
 			    urb_value, urb_index,
-			    buf, 0, 100);
+			    buf, 0, WDR_SHORT_TIMEOUT);
 
 	kfree(buf);
 	return rv;
@@ -1786,7 +1787,7 @@
 			    FTDI_SIO_SET_DATA_REQUEST, 
 			    FTDI_SIO_SET_DATA_REQUEST_TYPE,
 			    urb_value , priv->interface,
-			    buf, 0, 100) < 0) {
+			    buf, 0, WDR_SHORT_TIMEOUT) < 0) {
 		err("%s FAILED to set databits/stopbits/parity", __FUNCTION__);
 	}	   
 

--
