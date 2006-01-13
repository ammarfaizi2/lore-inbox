Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161494AbWAMIgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161494AbWAMIgV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 03:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161496AbWAMIgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 03:36:21 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:46789 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161494AbWAMIgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 03:36:21 -0500
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 03/13] USBATM: remove .owner
Date: Fri, 13 Jan 2006 09:36:20 +0100
User-Agent: KMail/1.9.1
Cc: usbatm@lists.infradead.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200601121729.52596.baldrick@free.fr>
In-Reply-To: <200601121729.52596.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Fa2xDqiGJvm6D0i"
Message-Id: <200601130936.21286.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Fa2xDqiGJvm6D0i
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Remove the unused .owner field in struct usbatm_driver.

Signed-off-by:	Duncan Sands <baldrick@free.fr>

--Boundary-00=_Fa2xDqiGJvm6D0i
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="03-owner"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="03-owner"

Index: Linux/drivers/usb/atm/cxacru.c
===================================================================
--- Linux.orig/drivers/usb/atm/cxacru.c	2006-01-13 08:46:17.000000000 +0100
+++ Linux/drivers/usb/atm/cxacru.c	2006-01-13 08:48:09.000000000 +0100
@@ -833,7 +833,6 @@
 MODULE_DEVICE_TABLE(usb, cxacru_usb_ids);
 
 static struct usbatm_driver cxacru_driver = {
-	.owner		= THIS_MODULE,
 	.driver_name	= cxacru_driver_name,
 	.bind		= cxacru_bind,
 	.heavy_init	= cxacru_heavy_init,
Index: Linux/drivers/usb/atm/speedtch.c
===================================================================
--- Linux.orig/drivers/usb/atm/speedtch.c	2006-01-13 08:46:17.000000000 +0100
+++ Linux/drivers/usb/atm/speedtch.c	2006-01-13 08:48:09.000000000 +0100
@@ -793,7 +793,6 @@
 ***********/
 
 static struct usbatm_driver speedtch_usbatm_driver = {
-	.owner		= THIS_MODULE,
 	.driver_name	= speedtch_driver_name,
 	.bind		= speedtch_bind,
 	.heavy_init	= speedtch_heavy_init,
Index: Linux/drivers/usb/atm/ueagle-atm.c
===================================================================
--- Linux.orig/drivers/usb/atm/ueagle-atm.c	2006-01-13 08:46:17.000000000 +0100
+++ Linux/drivers/usb/atm/ueagle-atm.c	2006-01-13 08:48:09.000000000 +0100
@@ -1629,7 +1629,7 @@
 	if (ifnum != UEA_INTR_IFACE_NO)
 		return -ENODEV;
 
-	usbatm_instance->flags = (sync_wait[modem_index] ? 0 : UDSL_SKIP_HEAVY_INIT);
+	usbatm->flags = (sync_wait[modem_index] ? 0 : UDSL_SKIP_HEAVY_INIT);
 
 	/* interface 1 is for outbound traffic */
 	ret = claim_interface(usb, usbatm, UEA_US_IFACE_NO);
@@ -1701,7 +1701,6 @@
 
 static struct usbatm_driver uea_usbatm_driver = {
 	.driver_name = "ueagle-atm",
-	.owner = THIS_MODULE,
 	.bind = uea_bind,
 	.atm_start = uea_atm_open,
 	.unbind = uea_unbind,
Index: Linux/drivers/usb/atm/usbatm.h
===================================================================
--- Linux.orig/drivers/usb/atm/usbatm.h	2006-01-13 08:46:17.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.h	2006-01-13 08:48:09.000000000 +0100
@@ -100,8 +100,6 @@
 */
 
 struct usbatm_driver {
-	struct module *owner;
-
 	const char *driver_name;
 
 	/* init device ... can sleep, or cause probe() failure */
Index: Linux/drivers/usb/atm/xusbatm.c
===================================================================
--- Linux.orig/drivers/usb/atm/xusbatm.c	2006-01-13 08:46:17.000000000 +0100
+++ Linux/drivers/usb/atm/xusbatm.c	2006-01-13 08:48:09.000000000 +0100
@@ -166,7 +166,6 @@
 		xusbatm_usb_ids[i].idProduct	= product[i];
 
 
-		xusbatm_drivers[i].owner	= THIS_MODULE;
 		xusbatm_drivers[i].driver_name	= xusbatm_driver_name;
 		xusbatm_drivers[i].bind		= xusbatm_bind;
 		xusbatm_drivers[i].unbind	= xusbatm_unbind;

--Boundary-00=_Fa2xDqiGJvm6D0i--
