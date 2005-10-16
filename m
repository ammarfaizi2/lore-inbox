Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbVJPTAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbVJPTAY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 15:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbVJPTAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 15:00:24 -0400
Received: from xenotime.net ([66.160.160.81]:52642 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751356AbVJPTAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 15:00:24 -0400
Date: Sun, 16 Oct 2005 12:00:19 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] firmware: fix all kernel-doc warnings
Message-Id: <20051016120019.49fdd385.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Convert existing function docs to kernel-doc format.
Eliminate all kernel-doc warnings.
Fix some doc typos and a little whitespace cleanup.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 drivers/base/firmware_class.c |   69 +++++++++++++++++++-------------
 1 files changed, 41 insertions(+), 28 deletions(-)

diff -Naurp linux-2614-rc4/drivers/base/firmware_class.c~doc_firmware_api linux-2614-rc4/drivers/base/firmware_class.c
--- linux-2614-rc4/drivers/base/firmware_class.c~doc_firmware_api	2005-10-14 17:31:23.000000000 -0700
+++ linux-2614-rc4/drivers/base/firmware_class.c	2005-10-16 11:47:52.000000000 -0700
@@ -62,14 +62,16 @@ firmware_timeout_show(struct class *clas
 }
 
 /**
- * firmware_timeout_store:
- * Description:
+ * firmware_timeout_store - set number of seconds to wait for firmware
+ * @class: device class pointer
+ * @buf: buffer to scan for timeout value
+ * @count: number of bytes in @buf
+ *
  *	Sets the number of seconds to wait for the firmware.  Once
- *	this expires an error will be return to the driver and no
+ *	this expires an error will be returned to the driver and no
  *	firmware will be provided.
  *
- *	Note: zero means 'wait for ever'
- *
+ *	Note: zero means 'wait forever'.
  **/
 static ssize_t
 firmware_timeout_store(struct class *class, const char *buf, size_t count)
@@ -123,12 +125,15 @@ firmware_loading_show(struct class_devic
 }
 
 /**
- * firmware_loading_store: - loading control file
- * Description:
+ * firmware_loading_store - set value in the 'loading' control file
+ * @class_dev: class_device pointer
+ * @buf: buffer to scan for loading control value
+ * @count: number of bytes in @buf
+ *
  *	The relevant values are:
  *
  *	 1: Start a load, discarding any previous partial load.
- *	 0: Conclude the load and handle the data to the driver code.
+ *	 0: Conclude the load and hand the data to the driver code.
  *	-1: Conclude the load with an error and discard any written data.
  **/
 static ssize_t
@@ -201,6 +206,7 @@ out:
 	up(&fw_lock);
 	return ret_count;
 }
+
 static int
 fw_realloc_buffer(struct firmware_priv *fw_priv, int min_size)
 {
@@ -227,11 +233,13 @@ fw_realloc_buffer(struct firmware_priv *
 }
 
 /**
- * firmware_data_write:
+ * firmware_data_write - write method for firmware
+ * @kobj: kobject for the class_device
+ * @buffer: buffer being written
+ * @offset: buffer offset for write in total data store area
+ * @count: buffer size
  *
- * Description:
- *
- *	Data written to the 'data' attribute will be later handled to
+ *	Data written to the 'data' attribute will be later handed to
  *	the driver as a firmware image.
  **/
 static ssize_t
@@ -264,6 +272,7 @@ out:
 	up(&fw_lock);
 	return retval;
 }
+
 static struct bin_attribute firmware_attr_data_tmpl = {
 	.attr = {.name = "data", .mode = 0644, .owner = THIS_MODULE},
 	.size = 0,
@@ -448,13 +457,16 @@ out:
 
 /**
  * request_firmware: - request firmware to hotplug and wait for it
- * Description:
- *      @firmware will be used to return a firmware image by the name
+ * @firmware_p: pointer to firmware image
+ * @name: name of firmware file
+ * @device: device for which firmware is being loaded
+ *
+ *      @firmware_p will be used to return a firmware image by the name
  *      of @name for device @device.
  *
  *      Should be called from user context where sleeping is allowed.
  *
- *      @name will be use as $FIRMWARE in the hotplug environment and
+ *      @name will be used as $FIRMWARE in the hotplug environment and
  *      should be distinctive enough not to be confused with any other
  *      firmware image for this or any other device.
  **/
@@ -468,6 +480,7 @@ request_firmware(const struct firmware *
 
 /**
  * release_firmware: - release the resource associated with a firmware image
+ * @fw: firmware resource to release
  **/
 void
 release_firmware(const struct firmware *fw)
@@ -480,8 +493,10 @@ release_firmware(const struct firmware *
 
 /**
  * register_firmware: - provide a firmware image for later usage
+ * @name: name of firmware image file
+ * @data: buffer pointer for the firmware image
+ * @size: size of the data buffer area
  *
- * Description:
  *	Make sure that @data will be available by requesting firmware @name.
  *
  *	Note: This will not be possible until some kind of persistence
@@ -526,21 +541,19 @@ request_firmware_work_func(void *arg)
 }
 
 /**
- * request_firmware_nowait:
+ * request_firmware_nowait: asynchronous version of request_firmware
+ * @module: module requesting the firmware
+ * @hotplug: invokes hotplug event to copy the firmware image if this flag
+ *	is non-zero else the firmware copy must be done manually.
+ * @name: name of firmware file
+ * @device: device for which firmware is being loaded
+ * @context: will be passed over to @cont, and
+ *	@fw may be %NULL if firmware request fails.
+ * @cont: function will be called asynchronously when the firmware
+ *	request is over.
  *
- * Description:
  *	Asynchronous variant of request_firmware() for contexts where
  *	it is not possible to sleep.
- *
- *      @hotplug invokes hotplug event to copy the firmware image if this flag
- *      is non-zero else the firmware copy must be done manually.
- *
- *	@cont will be called asynchronously when the firmware request is over.
- *
- *	@context will be passed over to @cont.
- *
- *	@fw may be %NULL if firmware request fails.
- *
  **/
 int
 request_firmware_nowait(


---
