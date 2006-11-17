Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753711AbWKQQtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbWKQQtG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753728AbWKQQtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:49:06 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:50439 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1753711AbWKQQtE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:49:04 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Lonnie Mendez <dignome@gmail.com>, Neil Whelchel <koyama@firstlight.net>
Subject: [PATCH] usb: cypress_m8 init error path fix
Date: Fri, 17 Nov 2006 17:49:22 +0100
User-Agent: KMail/1.9.5
Cc: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611171749.22486.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	If at some point cypress_init() fails deregister
only the resources that were registered until that point.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/usb/serial/cypress_m8.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- linux-2.6.19-rc5-mm2-a/drivers/usb/serial/cypress_m8.c	2006-11-15 11:24:24.000000000 +0100
+++ linux-2.6.19-rc5-mm2-b/drivers/usb/serial/cypress_m8.c	2006-11-17 17:40:21.000000000 +0100
@@ -1684,15 +1684,14 @@ static int __init cypress_init(void)

 	info(DRIVER_DESC " " DRIVER_VERSION);
 	return 0;
+
 failed_usb_register:
-	usb_deregister(&cypress_driver);
-failed_ca42v2_register:
 	usb_serial_deregister(&cypress_ca42v2_device);
-failed_hidcom_register:
+failed_ca42v2_register:
 	usb_serial_deregister(&cypress_hidcom_device);
-failed_em_register:
+failed_hidcom_register:
 	usb_serial_deregister(&cypress_earthmate_device);
-
+failed_em_register:
 	return retval;
 }


-- 
Regards,

	Mariusz Kozlowski
