Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266891AbUI0Rw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbUI0Rw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 13:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUI0Rvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 13:51:46 -0400
Received: from loncoche.terra.com.br ([200.154.55.229]:18861 "EHLO
	loncoche.terra.com.br") by vger.kernel.org with ESMTP
	id S266864AbUI0Ruh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 13:50:37 -0400
Date: Mon, 27 Sep 2004 13:54:38 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5]: usb-serial: create_serial() return value trivial fix.
Message-Id: <20040927135438.10db8e54.lcapitulino@conectiva.com.br>
Organization: Conectiva S/A.
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 create_serial() only returns NULL if there is no memory enough
to a new `usb_serial' structure, thus, the right error code to
return is -ENOMEM.

(against 2.6.9-rc2-mm4)


Signed-off-by: Luiz Capitulino <lcapitulino@conectiva.com.br>

 drivers/usb/serial/usb-serial.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -X /home/lcapitulino/kernels/2.6/dontdiff -Nparu a/drivers/usb/serial/usb-serial.c a~/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	2004-09-26 13:13:21.000000000 -0300
+++ a~/drivers/usb/serial/usb-serial.c	2004-09-26 13:14:09.000000000 -0300
@@ -896,7 +896,7 @@ int usb_serial_probe(struct usb_interfac
 	serial = create_serial (dev, interface, type);
 	if (!serial) {
 		dev_err(&interface->dev, "%s - out of memory\n", __FUNCTION__);
-		return -ENODEV;
+		return -ENOMEM;
 	}
 
 	/* if this device type has a probe function, call it */
