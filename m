Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266878AbUI0Rw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266878AbUI0Rw6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 13:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266876AbUI0RwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 13:52:22 -0400
Received: from loncoche.terra.com.br ([200.154.55.229]:6578 "EHLO
	loncoche.terra.com.br") by vger.kernel.org with ESMTP
	id S266878AbUI0Ru5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 13:50:57 -0400
Date: Mon, 27 Sep 2004 13:54:59 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5]: usb-serial: usb_serial_register() cleanup.
Message-Id: <20040927135459.22430979.lcapitulino@conectiva.com.br>
Organization: Conectiva S/A.
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 usb_serial_register() cleanup

1) CodingStyle in the call of usb_serial_bus_register()
2) The goto and the duplicate `return retval' are not necessary

(against 2.6.9-rc2-mm4)

Signed-off-by: Luiz Capitulino <lcapitulino@conectiva.com.br>

 drivers/usb/serial/usb-serial.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)


diff -X /home/lcapitulino/kernels/2.6/dontdiff -Nparu a/drivers/usb/serial/usb-serial.c a~/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	2004-09-26 13:42:29.000000000 -0300
+++ a~/drivers/usb/serial/usb-serial.c	2004-09-26 13:43:27.000000000 -0300
@@ -1338,17 +1338,13 @@ int usb_serial_register(struct usb_seria
 	/* Add this device to our list of devices */
 	list_add(&new_device->driver_list, &usb_serial_driver_list);
 
-	retval =  usb_serial_bus_register (new_device);
-
-	if (retval)
-		goto error;
-
-	info("USB Serial support registered for %s", new_device->name);
-
-	return retval;
-error:
-	err("problem %d when registering driver %s", retval, new_device->name);
-	list_del(&new_device->driver_list);
+	retval = usb_serial_bus_register(new_device);
+	if (retval) {
+		err("problem %d when registering driver %s", retval, new_device->name);
+		list_del(&new_device->driver_list);
+	}
+	else
+		info("USB Serial support registered for %s", new_device->name);
 
 	return retval;
 }
