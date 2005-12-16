Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVLPAaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVLPAaj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 19:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVLPAaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 19:30:39 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:3012 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S1751218AbVLPAab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 19:30:31 -0500
Message-ID: <43A20AA4.5030707@shadowconnect.com>
Date: Fri, 16 Dec 2005 01:30:28 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] I2O: Beatifying
Content-Type: multipart/mixed;
 boundary="------------030500010703080208050702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030500010703080208050702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:
--------
- Fixed some typos and minor code beatifying.

Signed-off-by: Markus Lidel <Markus.Lidel@shadowconnect.com>

--------------030500010703080208050702
Content-Type: text/x-patch;
 name="i2o-beautifying.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o-beautifying.patch"

Index: linux-2.6/drivers/message/i2o/bus-osm.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/bus-osm.c
+++ linux-2.6/drivers/message/i2o/bus-osm.c
@@ -17,7 +17,7 @@
 #include <linux/i2o.h>
 
 #define OSM_NAME	"bus-osm"
-#define OSM_VERSION	"$Rev$"
+#define OSM_VERSION	"1.317"
 #define OSM_DESCRIPTION	"I2O Bus Adapter OSM"
 
 static struct i2o_driver i2o_bus_driver;
Index: linux-2.6/drivers/message/i2o/config-osm.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/config-osm.c
+++ linux-2.6/drivers/message/i2o/config-osm.c
@@ -22,7 +22,7 @@
 #include <asm/uaccess.h>
 
 #define OSM_NAME	"config-osm"
-#define OSM_VERSION	"1.248"
+#define OSM_VERSION	"1.317"
 #define OSM_DESCRIPTION	"I2O Configuration OSM"
 
 /* access mode user rw */
Index: linux-2.6/drivers/message/i2o/core.h
===================================================================
--- linux-2.6.orig/drivers/message/i2o/core.h
+++ linux-2.6/drivers/message/i2o/core.h
@@ -14,8 +14,6 @@
  */
 
 /* Exec-OSM */
-extern struct bus_type i2o_bus_type;
-
 extern struct i2o_driver i2o_exec_driver;
 extern int i2o_exec_lct_get(struct i2o_controller *);
 
@@ -23,6 +21,8 @@ extern int __init i2o_exec_init(void);
 extern void __exit i2o_exec_exit(void);
 
 /* driver */
+extern struct bus_type i2o_bus_type;
+
 extern int i2o_driver_dispatch(struct i2o_controller *, u32);
 
 extern int __init i2o_driver_init(void);
@@ -45,9 +45,6 @@ extern void i2o_iop_free(struct i2o_cont
 extern int i2o_iop_add(struct i2o_controller *);
 extern void i2o_iop_remove(struct i2o_controller *);
 
-/* config */
-extern int i2o_parm_issue(struct i2o_device *, int, void *, int, void *, int);
-
 /* control registers relative to c->base */
 #define I2O_IRQ_STATUS	0x30
 #define I2O_IRQ_MASK	0x34
Index: linux-2.6/drivers/message/i2o/i2o_block.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/i2o_block.c
+++ linux-2.6/drivers/message/i2o/i2o_block.c
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
@@ -845,10 +847,10 @@ static int i2o_block_transfer(struct req
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
 
Index: linux-2.6/drivers/message/i2o/i2o_proc.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/i2o_proc.c
+++ linux-2.6/drivers/message/i2o/i2o_proc.c
@@ -28,7 +28,7 @@
  */
 
 #define OSM_NAME	"proc-osm"
-#define OSM_VERSION	"1.145"
+#define OSM_VERSION	"1.316"
 #define OSM_DESCRIPTION	"I2O ProcFS OSM"
 
 #define I2O_MAX_MODULES 4
Index: linux-2.6/drivers/message/i2o/i2o_scsi.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/i2o_scsi.c
+++ linux-2.6/drivers/message/i2o/i2o_scsi.c
@@ -70,7 +70,7 @@
 #include <scsi/sg_request.h>
 
 #define OSM_NAME	"scsi-osm"
-#define OSM_VERSION	"1.282"
+#define OSM_VERSION	"1.316"
 #define OSM_DESCRIPTION	"I2O SCSI Peripheral OSM"
 
 static struct i2o_driver i2o_scsi_driver;
Index: linux-2.6/drivers/message/i2o/iop.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/iop.c
+++ linux-2.6/drivers/message/i2o/iop.c
@@ -32,7 +32,7 @@
 #include "core.h"
 
 #define OSM_NAME	"i2o"
-#define OSM_VERSION	"1.288"
+#define OSM_VERSION	"1.316"
 #define OSM_DESCRIPTION	"I2O subsystem"
 
 /* global I2O controller list */
@@ -730,10 +730,6 @@ static int i2o_iop_systab_set(struct i2o
 	 * Provide three SGL-elements:
 	 * System table (SysTab), Private memory space declaration and
 	 * Private i/o space declaration
-	 *
-	 * FIXME: is this still true?
-	 * Nasty one here. We can't use dma_alloc_coherent to send the
-	 * same table to everyone. We have to go remap it for them all
 	 */
 
 	msg->body[0] = cpu_to_le32(c->unit + 2);
@@ -756,8 +752,6 @@ static int i2o_iop_systab_set(struct i2o
 	else
 		osm_debug("%s: SysTab set.\n", c->name);
 
-	i2o_status_get(c);	// Entered READY state
-
 	return rc;
 }
 
@@ -767,7 +761,7 @@ static int i2o_iop_systab_set(struct i2o
  *
  *	Send the system table and enable the I2O controller.
  *
- *	Returns 0 on success or negativer error code on failure.
+ *	Returns 0 on success or negative error code on failure.
  */
 static int i2o_iop_online(struct i2o_controller *c)
 {
@@ -977,7 +971,7 @@ int i2o_status_get(struct i2o_controller
  *	The HRT contains information about possible hidden devices but is
  *	mostly useless to us.
  *
- *	Returns 0 on success or negativer error code on failure.
+ *	Returns 0 on success or negative error code on failure.
  */
 static int i2o_hrt_get(struct i2o_controller *c)
 {
Index: linux-2.6/drivers/message/i2o/device.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/device.c
+++ linux-2.6/drivers/message/i2o/device.c
@@ -176,6 +176,7 @@ static ssize_t i2o_device_show_tid(struc
 	return strlen(buf) + 1;
 }
 
+/* I2O device attributes */
 struct device_attribute i2o_device_attrs[] = {
 	__ATTR(class_id, S_IRUGO, i2o_device_show_class_id, NULL),
 	__ATTR(tid, S_IRUGO, i2o_device_show_tid, NULL),
@@ -505,12 +506,12 @@ int i2o_parm_field_get(struct i2o_device
  *		else return specific fields
  *			ibuf contains fieldindexes
  *
- * 	if oper == I2O_PARAMS_LIST_GET, get from specific rows
- * 		if fieldcount == -1 return all fields
+ *	if oper == I2O_PARAMS_LIST_GET, get from specific rows
+ *		if fieldcount == -1 return all fields
  *			ibuf contains rowcount, keyvalues
- * 		else return specific fields
+ *		else return specific fields
  *			fieldcount is # of fieldindexes
- *  			ibuf contains fieldindexes, rowcount, keyvalues
+ *			ibuf contains fieldindexes, rowcount, keyvalues
  *
  *	You could also use directly function i2o_issue_params().
  */
Index: linux-2.6/drivers/message/i2o/driver.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/driver.c
+++ linux-2.6/drivers/message/i2o/driver.c
@@ -64,7 +64,7 @@ static int i2o_bus_match(struct device *
 struct bus_type i2o_bus_type = {
 	.name = "i2o",
 	.match = i2o_bus_match,
-	.dev_attrs = i2o_device_attrs,
+	.dev_attrs = i2o_device_attrs
 };
 
 /**

--------------030500010703080208050702--
