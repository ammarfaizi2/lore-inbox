Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbTLKBqJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264327AbTLKBbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:31:05 -0500
Received: from mail.kroah.org ([65.200.24.183]:59599 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264329AbTLKBaN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:30:13 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10711061453801@kroah.com>
Subject: [PATCH] USB Fixes for 2.6.0-test11
In-Reply-To: <20031211012731.GA10632@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 10 Dec 2003 17:29:05 -0800
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1516, 2003/12/08 11:10:51-08:00, greg@kroah.com

[PATCH] USB: register usb-serial ports in the proper place in sysfs

They should be bound to the interface the driver is attached to, not
the device.


 drivers/usb/serial/usb-serial.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	Wed Dec 10 16:48:06 2003
+++ b/drivers/usb/serial/usb-serial.c	Wed Dec 10 16:48:06 2003
@@ -1242,7 +1242,7 @@
 	/* register all of the individual ports with the driver core */
 	for (i = 0; i < num_ports; ++i) {
 		port = serial->port[i];
-		port->dev.parent = &serial->dev->dev;
+		port->dev.parent = &interface->dev;
 		port->dev.driver = NULL;
 		port->dev.bus = &usb_serial_bus_type;
 		port->dev.release = &port_release;

