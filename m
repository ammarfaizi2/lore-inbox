Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVCaLqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVCaLqX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVCaLqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:46:23 -0500
Received: from gsecone.com ([59.144.0.4]:49541 "EHLO gsecone.com")
	by vger.kernel.org with ESMTP id S261376AbVCaLp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:45:57 -0500
Subject: [PATCH][2.2.27-rc2] memset usage fix
From: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Global Security One
Date: Thu, 31 Mar 2005 17:13:07 +0530
Message-Id: <1112269387.14917.25.camel@vinay.gsecone.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Using Dave Jones memset script to detect swapped arguments, I found two
such instances. Patch attached.

Thanks
Vinay

 nubus/nubus.c |    2 +-
 usb/dabusb.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

=========================================================================
diff -urN linux-2.2.26/drivers/usb/dabusb.c linux-2.2.26-m/drivers/usb/dabusb.c
--- linux-2.2.26/drivers/usb/dabusb.c	2001-11-02 22:09:08.000000000 +0530
+++ linux-2.2.26-m/drivers/usb/dabusb.c	2005-03-31 17:03:23.335520936 +0530
@@ -224,7 +224,7 @@
 			err("kmalloc(sizeof(buff_t))==NULL");
 			goto err;
 		}
-		memset (b, sizeof (buff_t), 0);
+		memset (b, 0, sizeof (buff_t));
 		b->s = s;
 		b->purb = usb_alloc_urb(packets);
 		if (!b->purb) {
diff -urN linux-2.2.26/drivers/nubus/nubus.c linux-2.2.26-m/drivers/nubus/nubus.c
--- linux-2.2.26/drivers/nubus/nubus.c	2001-03-25 22:01:42.000000000 +0530
+++ linux-2.2.26-m/drivers/nubus/nubus.c	2005-03-31 17:02:40.908970752 +0530
@@ -563,7 +563,7 @@
 		/* Now clobber the whole thing */
 		if (size > sizeof(mode) - 1)
 			size = sizeof(mode) - 1;
-		memset(&mode, sizeof(mode), 0);
+		memset(&mode, 0, sizeof(mode));
 		nubus_get_rsrc_mem(&mode, &ent, size);
 		printk (KERN_INFO "      %02X: (%02X) %s\n", ent.type,
 			mode.id, mode.name);

=========================================================================
-- 
Views expressed in this mail are those of the individual sender and 
do not bind Gsec1 Limited. or its subsidiary, unless the sender has done
so expressly with due authority of Gsec1.
_________________________________________________________________________


