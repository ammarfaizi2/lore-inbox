Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbTEBPZt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 11:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbTEBPZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 11:25:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:22725 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262946AbTEBPZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 11:25:19 -0400
Date: Fri, 2 May 2003 17:37:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: viro@parcelfarce.linux.theplanet.co.uk, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] kill the last occurances of usb_serial_get_by_minor
Message-ID: <20030502153723.GS21168@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got an error at the final linking of 2.5.68-bk11. It seems the patch 
below is needed.

cu
Adrian


--- linux-2.5.68-bk11/drivers/usb/serial/console.c.old	2003-05-02 17:27:06.000000000 +0200
+++ linux-2.5.68-bk11/drivers/usb/serial/console.c	2003-05-02 17:27:34.000000000 +0200
@@ -133,7 +133,7 @@
 	co->cflag = cflag;
 
 	/* grab the first serial port that happens to be connected */
-	serial = usb_serial_get_by_minor (0);
+	serial = usb_serial_get_by_index(0);
 	if (serial_paranoia_check (serial, __FUNCTION__)) {
 		/* no device is connected yet, sorry :( */
 		err ("No USB device connected to ttyUSB0");
--- linux-2.5.68-bk11/drivers/usb/serial/usb-serial.h.old	2003-05-02 17:27:43.000000000 +0200
+++ linux-2.5.68-bk11/drivers/usb/serial/usb-serial.h	2003-05-02 17:28:13.000000000 +0200
@@ -280,7 +280,7 @@
 #endif
 
 /* Functions needed by other parts of the usbserial core */
-extern struct usb_serial *usb_serial_get_by_minor (unsigned int minor);
+extern struct usb_serial *usb_serial_get_by_index (unsigned int minor);
 extern int usb_serial_generic_open (struct usb_serial_port *port, struct file *filp);
 extern int usb_serial_generic_write (struct usb_serial_port *port, int from_user, const unsigned char *buf, int count);
 extern void usb_serial_generic_close (struct usb_serial_port *port, struct file *filp);
