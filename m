Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbTD3WqJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 18:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTD3WqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 18:46:08 -0400
Received: from pointblue.com.pl ([62.89.73.6]:14093 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262480AbTD3WqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 18:46:06 -0400
Subject: [PATCH] ieee1394.c on - compilation errors
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus <torvalds@transmeta.com>
Content-Type: multipart/mixed; boundary="=-stKVpX3efOZ9FVbDIjtP"
Organization: K4 labs
Message-Id: <1051743594.5267.7.camel@flat41>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Apr 2003 23:59:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-stKVpX3efOZ9FVbDIjtP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello there!

Another trivial, monkeys job patch.

Anyway, it is good to look at some changes and learn :)


1) dev->class_num does not exists anymore


-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

--=-stKVpX3efOZ9FVbDIjtP
Content-Description: 
Content-Disposition: inline; filename=ieee1394.patch
Content-Type: text/x-patch; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

diff -u -r org/drivers/ieee1394/nodemgr.c popsuty/drivers/ieee1394/nodemgr.c
--- org/drivers/ieee1394/nodemgr.c	2003-04-30 22:22:39.000000000 +0100
+++ popsuty/drivers/ieee1394/nodemgr.c	2003-04-30 23:41:52.000000000 +0100
@@ -364,9 +364,6 @@
         struct unit_directory *ud;
 	struct ieee1394_device_id *id;
 
-	if (dev->class_num != DEV_CLASS_UNIT_DIRECTORY)
-		return 0;
-
 	ud = container_of(dev, struct unit_directory, device);
 	driver = container_of(drv, struct hpsb_protocol_driver, driver);
 
@@ -494,18 +491,15 @@
 static struct device nodemgr_dev_template_ud = {
 	.bus		= &ieee1394_bus_type,
 	.release	= nodemgr_release_ud,
-	.class_num	= DEV_CLASS_UNIT_DIRECTORY,
 };
 
 static struct device nodemgr_dev_template_ne = {
 	.bus		= &ieee1394_bus_type,
 	.release	= nodemgr_release_ne,
-	.class_num	= DEV_CLASS_NODE,
 };
 
 static struct device nodemgr_dev_template_host = {
 	.bus		= &ieee1394_bus_type,
-	.class_num	= DEV_CLASS_HOST,
 };
 
 
@@ -727,9 +721,6 @@
         struct guid_search_baton *search = __data;
         struct node_entry *ne;
 
-        if (dev->class_num != DEV_CLASS_NODE)
-                return 0;
-
         ne = container_of(dev, struct node_entry, device);
 
         if (ne->guid == search->guid) {
@@ -764,9 +755,6 @@
 	struct nodeid_search_baton *search = __data;
 	struct node_entry *ne;
 
-	if (dev->class_num != DEV_CLASS_NODE)
-		return 0;
-
 	ne = container_of(dev, struct node_entry, device);
 
 	if (ne->host == search->host && ne->nodeid == search->nodeid) {
@@ -1131,9 +1119,6 @@
 	if (!dev)
 		return -ENODEV;
 
-	if (dev->class_num != DEV_CLASS_UNIT_DIRECTORY)
-		return -ENODEV;
-
 	ud = container_of(dev, struct unit_directory, device);
 
 	scratch = buffer;
@@ -1258,9 +1243,6 @@
 	struct node_entry *ne = __data;
 	struct unit_directory *ud;
 
-	if (dev->class_num != DEV_CLASS_UNIT_DIRECTORY)
-		return 0;
-
 	ud = container_of(dev, struct unit_directory, device);
 
 	if (&ne->device != ud->device.parent)
@@ -1446,9 +1428,6 @@
 	struct cleanup_baton *cleanup = __data;
 	struct node_entry *ne;
 
-	if (dev->class_num != DEV_CLASS_NODE)
-		return 0;
-
 	ne = container_of(dev, struct node_entry, device);
 
 	if (ne->host != cleanup->host)

--=-stKVpX3efOZ9FVbDIjtP--

