Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbVKOJb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbVKOJb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 04:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbVKOJb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 04:31:56 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:19622 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S1751412AbVKOJbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 04:31:36 -0500
Message-ID: <4379AAF6.30709@shadowconnect.com>
Date: Tue, 15 Nov 2005 10:31:34 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] I2O: Beatifying
Content-Type: multipart/mixed;
 boundary="------------060802070001030002000302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060802070001030002000302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:
--------
- Fixed some typos and minor code beatifying.

Signed-off-by: Markus Lidel <Markus.Lidel@shadowconnect.com>

--------------060802070001030002000302
Content-Type: text/x-patch;
 name="i2o-beautifying.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o-beautifying.patch"

Index: linux-2.6.14/drivers/message/i2o/bus-osm.c
===================================================================
--- linux-2.6.14.orig/drivers/message/i2o/bus-osm.c	2005-11-15 10:24:36.154999320 +0100
+++ linux-2.6.14/drivers/message/i2o/bus-osm.c	2005-11-15 10:24:50.047736830 +0100
@@ -17,7 +17,7 @@
 #include <linux/i2o.h>
 
 #define OSM_NAME	"bus-osm"
-#define OSM_VERSION	"$Rev$"
+#define OSM_VERSION	"1.317"
 #define OSM_DESCRIPTION	"I2O Bus Adapter OSM"
 
 static struct i2o_driver i2o_bus_driver;
Index: linux-2.6.14/drivers/message/i2o/config-osm.c
===================================================================
--- linux-2.6.14.orig/drivers/message/i2o/config-osm.c	2005-11-15 10:24:32.562808623 +0100
+++ linux-2.6.14/drivers/message/i2o/config-osm.c	2005-11-15 10:24:50.047736830 +0100
@@ -22,7 +22,7 @@
 #include <asm/uaccess.h>
 
 #define OSM_NAME	"config-osm"
-#define OSM_VERSION	"1.248"
+#define OSM_VERSION	"1.317"
 #define OSM_DESCRIPTION	"I2O Configuration OSM"
 
 /* access mode user rw */
Index: linux-2.6.14/drivers/message/i2o/core.h
===================================================================
--- linux-2.6.14.orig/drivers/message/i2o/core.h	2005-11-15 10:24:38.059100401 +0100
+++ linux-2.6.14/drivers/message/i2o/core.h	2005-11-15 10:24:50.047736830 +0100
@@ -43,9 +43,6 @@
 extern int i2o_iop_add(struct i2o_controller *);
 extern void i2o_iop_remove(struct i2o_controller *);
 
-/* config */
-extern int i2o_parm_issue(struct i2o_device *, int, void *, int, void *, int);
-
 /* control registers relative to c->base */
 #define I2O_IRQ_STATUS	0x30
 #define I2O_IRQ_MASK	0x34
Index: linux-2.6.14/drivers/message/i2o/i2o_block.c
===================================================================
--- linux-2.6.14.orig/drivers/message/i2o/i2o_block.c	2005-11-15 10:24:37.347062602 +0100
+++ linux-2.6.14/drivers/message/i2o/i2o_block.c	2005-11-15 10:24:50.051737043 +0100
@@ -59,10 +59,12 @@
 #include <linux/blkdev.h>
 #include <linux/hdreg.h>
 
+#include <scsi/scsi.h>
+
 #include "i2o_block.h"
 
 #define OSM_NAME	"block-osm"
-#define OSM_VERSION	"1.287"
+#define OSM_VERSION	"1.316"
 #define OSM_DESCRIPTION	"I2O Block Device OSM"
 
 static struct i2o_driver i2o_block_driver;
@@ -845,10 +847,10 @@
 		 * RETURN_SENSE_DATA_IN_REPLY_MESSAGE_FRAME
 		 */
 		if (rq_data_dir(req) == READ) {
-			cmd[0] = 0x28;
+			cmd[0] = READ_10;
 			scsi_flags = 0x60a0000a;
 		} else {
-			cmd[0] = 0x2A;
+			cmd[0] = WRITE_10;
 			scsi_flags = 0xa0a0000a;
 		}
 
Index: linux-2.6.14/drivers/message/i2o/i2o_proc.c
===================================================================
--- linux-2.6.14.orig/drivers/message/i2o/i2o_proc.c	2005-11-15 10:24:32.582809685 +0100
+++ linux-2.6.14/drivers/message/i2o/i2o_proc.c	2005-11-15 10:24:50.051737043 +0100
@@ -28,7 +28,7 @@
  */
 
 #define OSM_NAME	"proc-osm"
-#define OSM_VERSION	"1.145"
+#define OSM_VERSION	"1.316"
 #define OSM_DESCRIPTION	"I2O ProcFS OSM"
 
 #define I2O_MAX_MODULES 4
Index: linux-2.6.14/drivers/message/i2o/i2o_scsi.c
===================================================================
--- linux-2.6.14.orig/drivers/message/i2o/i2o_scsi.c	2005-11-15 10:24:44.423438260 +0100
+++ linux-2.6.14/drivers/message/i2o/i2o_scsi.c	2005-11-15 10:24:50.055737255 +0100
@@ -70,7 +70,7 @@
 #include <scsi/sg_request.h>
 
 #define OSM_NAME	"scsi-osm"
-#define OSM_VERSION	"1.282"
+#define OSM_VERSION	"1.316"
 #define OSM_DESCRIPTION	"I2O SCSI Peripheral OSM"
 
 static struct i2o_driver i2o_scsi_driver;
Index: linux-2.6.14/drivers/message/i2o/iop.c
===================================================================
--- linux-2.6.14.orig/drivers/message/i2o/iop.c	2005-11-15 10:24:38.063100614 +0100
+++ linux-2.6.14/drivers/message/i2o/iop.c	2005-11-15 10:24:50.055737255 +0100
@@ -32,7 +32,7 @@
 #include "core.h"
 
 #define OSM_NAME	"i2o"
-#define OSM_VERSION	"1.288"
+#define OSM_VERSION	"1.316"
 #define OSM_DESCRIPTION	"I2O subsystem"
 
 /* global I2O controller list */
@@ -732,10 +732,6 @@
 	 * Provide three SGL-elements:
 	 * System table (SysTab), Private memory space declaration and
 	 * Private i/o space declaration
-	 *
-	 * FIXME: is this still true?
-	 * Nasty one here. We can't use dma_alloc_coherent to send the
-	 * same table to everyone. We have to go remap it for them all
 	 */
 
 	msg->body[0] = cpu_to_le32(c->unit + 2);
@@ -758,8 +754,6 @@
 	else
 		osm_debug("%s: SysTab set.\n", c->name);
 
-	i2o_status_get(c);	// Entered READY state
-
 	return rc;
 }
 
@@ -769,7 +763,7 @@
  *
  *	Send the system table and enable the I2O controller.
  *
- *	Returns 0 on success or negativer error code on failure.
+ *	Returns 0 on success or negative error code on failure.
  */
 static int i2o_iop_online(struct i2o_controller *c)
 {
@@ -979,7 +973,7 @@
  *	The HRT contains information about possible hidden devices but is
  *	mostly useless to us.
  *
- *	Returns 0 on success or negativer error code on failure.
+ *	Returns 0 on success or negative error code on failure.
  */
 static int i2o_hrt_get(struct i2o_controller *c)
 {

--------------060802070001030002000302--
