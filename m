Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVAHJTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVAHJTq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVAHJSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:18:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:40837 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261855AbVAHFsN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:13 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163256826@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:37 -0800
Message-Id: <11051632574140@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.44, 2004/12/22 23:31:52-08:00, greg@kroah.com

Merge kroah.com:/home/greg/linux/BK/bleed-2.6
into kroah.com:/home/greg/linux/BK/usb-2.6


 drivers/usb/atm/usb_atm.c    |   17 -----------------
 drivers/usb/serial/keyspan.c |   12 ++++++------
 2 files changed, 6 insertions(+), 23 deletions(-)


diff -Nru a/drivers/usb/atm/usb_atm.c b/drivers/usb/atm/usb_atm.c
--- a/drivers/usb/atm/usb_atm.c	2005-01-07 15:39:38 -08:00
+++ b/drivers/usb/atm/usb_atm.c	2005-01-07 15:39:38 -08:00
@@ -83,23 +83,6 @@
 
 #include "usb_atm.h"
 
-/*
-#define DEBUG
-#define VERBOSE_DEBUG
-*/
-
-#if !defined (DEBUG) && defined (CONFIG_USB_DEBUG)
-#	define DEBUG
-#endif
-
-#include <linux/usb.h>
-
-#ifdef DEBUG
-#define UDSL_ASSERT(x)	BUG_ON(!(x))
-#else
-#define UDSL_ASSERT(x)	do { if (!(x)) warn("failed assertion '" #x "' at line %d", __LINE__); } while(0)
-#endif
-
 #ifdef VERBOSE_DEBUG
 static int udsl_print_packet(const unsigned char *data, int len);
 #define PACKETDEBUG(arg...)	udsl_print_packet (arg)
diff -Nru a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
--- a/drivers/usb/serial/keyspan.c	2005-01-07 15:39:38 -08:00
+++ b/drivers/usb/serial/keyspan.c	2005-01-07 15:39:38 -08:00
@@ -1174,16 +1174,16 @@
 	char				*fw_name;
 
 	dbg("Keyspan startup version %04x product %04x",
-	    serial->dev->descriptor.bcdDevice,
-	    serial->dev->descriptor.idProduct); 
+	    le16_to_cpu(serial->dev->descriptor.bcdDevice),
+	    le16_to_cpu(serial->dev->descriptor.idProduct));
 	
-	if ((serial->dev->descriptor.bcdDevice & 0x8000) != 0x8000) {
+	if ((le16_to_cpu(serial->dev->descriptor.bcdDevice) & 0x8000) != 0x8000) {
 		dbg("Firmware already loaded.  Quitting.");
 		return(1);
 	}
 
 		/* Select firmware image on the basis of idProduct */
-	switch (serial->dev->descriptor.idProduct) {
+	switch (le16_to_cpu(serial->dev->descriptor.idProduct)) {
 	case keyspan_usa28_pre_product_id:
 		record = &keyspan_usa28_firmware[0];
 		fw_name = "USA28";
@@ -2248,10 +2248,10 @@
 	dbg("%s", __FUNCTION__);
 
 	for (i = 0; (d_details = keyspan_devices[i]) != NULL; ++i)
-		if (d_details->product_id == serial->dev->descriptor.idProduct)
+		if (d_details->product_id == le16_to_cpu(serial->dev->descriptor.idProduct))
 			break;
 	if (d_details == NULL) {
-		dev_err(&serial->dev->dev, "%s - unknown product id %x\n", __FUNCTION__, serial->dev->descriptor.idProduct);
+		dev_err(&serial->dev->dev, "%s - unknown product id %x\n", __FUNCTION__, le16_to_cpu(serial->dev->descriptor.idProduct));
 		return 1;
 	}
 

