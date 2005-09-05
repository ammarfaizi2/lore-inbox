Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVIESd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVIESd1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 14:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVIESdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 14:33:16 -0400
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:56931 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932386AbVIESc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 14:32:56 -0400
Message-Id: <20050905183246.377395000@kohtala.home.org>
References: <20050905183109.284672000@kohtala.home.org>
Date: Mon, 05 Sep 2005 21:31:14 +0300
From: marko.kohtala@gmail.com
To: akpm@osdl.org
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [patch 05/10] parport: ieee1284 fixes and cleanups
Content-Disposition: inline; filename=parport-slab-alloc-size.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the complete slab buffer that is allocated by kmalloc.

Signed-off-by: Marko Kohtala <marko.kohtala@gmail.com>

---

 drivers/parport/daisy.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-dvb/drivers/parport/daisy.c
===================================================================
--- linux-dvb.orig/drivers/parport/daisy.c	2005-08-29 20:17:06.000000000 +0300
+++ linux-dvb/drivers/parport/daisy.c	2005-08-29 20:17:26.000000000 +0300
@@ -144,9 +144,9 @@ again:
 	add_dev (numdevs++, port, -1);
 
 	/* Find out the legacy device's IEEE 1284 device ID. */
-	deviceid = kmalloc (1000, GFP_KERNEL);
+	deviceid = kmalloc (1024, GFP_KERNEL);
 	if (deviceid) {
-		if (parport_device_id (numdevs - 1, deviceid, 1000) > 2)
+		if (parport_device_id (numdevs - 1, deviceid, 1024) > 2)
 			detected++;
 
 		kfree (deviceid);
@@ -508,11 +508,11 @@ static int assign_addrs (struct parport 
 		 detected);
 
 	/* Ask the new devices to introduce themselves. */
-	deviceid = kmalloc (1000, GFP_KERNEL);
+	deviceid = kmalloc (1024, GFP_KERNEL);
 	if (!deviceid) return 0;
 
 	for (daisy = 0; thisdev < numdevs; thisdev++, daisy++)
-		parport_device_id (thisdev, deviceid, 1000);
+		parport_device_id (thisdev, deviceid, 1024);
 
 	kfree (deviceid);
 	return detected;

--
