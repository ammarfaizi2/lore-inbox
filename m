Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261232AbVCEX7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVCEX7c (ORCPT <rfc822;akpm@zip.com.au>);
	Sat, 5 Mar 2005 18:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVCEX4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 18:56:19 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:16104 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S261229AbVCEXhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:37:13 -0500
Date: Sat, 05 Mar 2005 17:37:13 -0600 (CST)
Date-warning: Date header was inserted by vms046.mailsrvcs.net
From: James Nelson <james4765@cwazy.co.uk>
Subject: [PATCH 1/13] speedtch: Clean up printk()'s in
 drivers/usb/atm/speedtch.c
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-id: <20050305233712.7648.24364.93822@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a KERN_WARNING constant to a printk() that is missing it, and add a driver
prefix to another two in drivers/usb/atm/speedtch.c

Signed-off-by: James Nelson <james4765@gmail.com>

diff -Nurp -x dontdiff-osdl --exclude='*~' linux-2.6.11-mm1-original/drivers/usb/atm/speedtch.c linux-2.6.11-mm1/drivers/usb/atm/speedtch.c
--- linux-2.6.11-mm1-original/drivers/usb/atm/speedtch.c	2005-03-05 13:29:48.000000000 -0500
+++ linux-2.6.11-mm1/drivers/usb/atm/speedtch.c	2005-03-05 13:36:44.000000000 -0500
@@ -192,8 +192,8 @@ static int speedtch_set_swbuff(struct sp
 			      0x32, 0x40, state ? 0x01 : 0x00,
 			      0x00, NULL, 0, 100);
 	if (ret < 0) {
-		printk("Warning: %sabling SW buffering: usb_control_msg returned %d\n",
-		     state ? "En" : "Dis", ret);
+		printk(KERN_WARNING "%s: %sabling SW buffering: usb_control_msg returned %d\n",
+		     speedtch_driver_name, state ? "En" : "Dis", ret);
 		return ret;
 	}
 
@@ -252,7 +252,8 @@ static int speedtch_start_synchro(struct
 			      0x12, 0xc0, 0x04, 0x00,
 			      buf, sizeof(buf), CTRL_TIMEOUT);
 	if (ret < 0) {
-		printk(KERN_WARNING "SpeedTouch: Failed to start ADSL synchronisation: %d\n", ret);
+		printk(KERN_WARNING "%s: Failed to start ADSL synchronisation: %d\n",
+			speedtch_driver_name, ret);
 		return ret;
 	}
 
@@ -374,8 +375,8 @@ static void speedtch_poll_status(struct 
 
 	ret = speedtch_get_status(instance, buf);
 	if (ret) {
-		printk(KERN_WARNING
-		       "SpeedTouch: Error %d fetching device status\n", ret);
+		printk(KERN_WARNING "%s: Error %d fetching device status\n",
+			speedtch_driver_name, ret);
 		return;
 	}
 
