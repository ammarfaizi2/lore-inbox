Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbUCOVra (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 16:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbUCOVra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 16:47:30 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:45535 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262811AbUCOVr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 16:47:29 -0500
Date: Mon, 15 Mar 2004 21:47:00 GMT
Message-Id: <200403152147.i2FLl09s002942@delerium.codemonkey.org.uk>
To: linux-kernel@vger.kernel.org
From: davej@redhat.com
Cc: torvalds@osdl.org, akpm@osdl.org, jgarzik@pobox.com
Subject: [3C509] Fix sysfs leak.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the driver fails to load, we leave a 3c509 eisa directory
in sysfs.

		Dave

--- linux-2.6.4/drivers/net/3c509.c~	2004-03-15 21:23:55.000000000 +0000
+++ linux-2.6.4/drivers/net/3c509.c	2004-03-15 21:24:30.000000000 +0000
@@ -1657,7 +1655,7 @@
 	}
 
 #ifdef CONFIG_EISA
-	if (eisa_driver_register (&el3_eisa_driver) < 0) {
+	if (eisa_driver_register (&el3_eisa_driver) <= 0) {
 		eisa_driver_unregister (&el3_eisa_driver);
 	}
 #endif
