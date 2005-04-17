Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVDQXci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVDQXci (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 19:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVDQXch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 19:32:37 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50437 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261552AbVDQXbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 19:31:47 -0400
Date: Mon, 18 Apr 2005 01:31:45 +0200
From: Adrian Bunk <bunk@stusta.de>
To: johnpol@2ka.mipt.ru
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/w1/: possible cleanups
Message-ID: <20050417233145.GX3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 unused functions
- remove unused EXPORT_SYMBOL's

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/w1/dscore.c    |   35 ++++++++++++++++++++++-------------
 drivers/w1/dscore.h    |    4 ----
 drivers/w1/w1.c        |   10 +++++-----
 drivers/w1/w1.h        |    1 -
 drivers/w1/w1_family.c |   17 ++++++++---------
 drivers/w1/w1_family.h |    2 --
 drivers/w1/w1_int.c    |    7 ++++---
 drivers/w1/w1_int.h    |    2 --
 drivers/w1/w1_io.c     |   15 ++++++---------
 drivers/w1/w1_io.h     |    3 ---
 10 files changed, 45 insertions(+), 51 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/w1/dscore.h.old	2005-04-18 00:17:43.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/w1/dscore.h	2005-04-18 00:23:28.000000000 +0200
@@ -156,11 +156,7 @@
 int ds_read_bit(struct ds_device *, u8 *);
 int ds_write_byte(struct ds_device *, u8);
 int ds_write_bit(struct ds_device *, u8);
-int ds_start_pulse(struct ds_device *, int);
-int ds_set_speed(struct ds_device *, int);
 int ds_reset(struct ds_device *, struct ds_status *);
-int ds_detect(struct ds_device *, struct ds_status *);
-int ds_stop_pulse(struct ds_device *, int);
 struct ds_device * ds_get_device(void);
 void ds_put_device(struct ds_device *);
 int ds_write_block(struct ds_device *, u8 *, int);
--- linux-2.6.12-rc2-mm3-full/drivers/w1/dscore.c.old	2005-04-18 00:18:43.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/w1/dscore.c	2005-04-18 00:56:47.000000000 +0200
@@ -32,19 +32,16 @@
 };
 MODULE_DEVICE_TABLE(usb, ds_id_table);
 
-int ds_probe(struct usb_interface *, const struct usb_device_id *);
-void ds_disconnect(struct usb_interface *);
+static int ds_probe(struct usb_interface *, const struct usb_device_id *);
+static void ds_disconnect(struct usb_interface *);
 
 int ds_touch_bit(struct ds_device *, u8, u8 *);
 int ds_read_byte(struct ds_device *, u8 *);
 int ds_read_bit(struct ds_device *, u8 *);
 int ds_write_byte(struct ds_device *, u8);
 int ds_write_bit(struct ds_device *, u8);
-int ds_start_pulse(struct ds_device *, int);
-int ds_set_speed(struct ds_device *, int);
+static int ds_start_pulse(struct ds_device *, int);
 int ds_reset(struct ds_device *, struct ds_status *);
-int ds_detect(struct ds_device *, struct ds_status *);
-int ds_stop_pulse(struct ds_device *, int);
 struct ds_device * ds_get_device(void);
 void ds_put_device(struct ds_device *);
 
@@ -126,7 +123,8 @@
 	printk("%45s: %8x\n", str, buf[off]);
 }
 
-int ds_recv_status_nodump(struct ds_device *dev, struct ds_status *st, unsigned char *buf, int size)
+static int ds_recv_status_nodump(struct ds_device *dev, struct ds_status *st,
+				 unsigned char *buf, int size)
 {
 	int count, err;
 		
@@ -245,6 +243,8 @@
 	return err;
 }
 
+#if 0
+
 int ds_stop_pulse(struct ds_device *dev, int limit)
 {
 	struct ds_status st;
@@ -297,7 +297,9 @@
 	return err;
 }
 
-int ds_wait_status(struct ds_device *dev, struct ds_status *st)
+#endif  /*  0  */
+
+static int ds_wait_status(struct ds_device *dev, struct ds_status *st)
 {
 	u8 buf[0x20];
 	int err, count = 0;
@@ -345,6 +347,7 @@
 	return 0;
 }
 
+#if 0
 int ds_set_speed(struct ds_device *dev, int speed)
 {
 	int err;
@@ -363,8 +366,9 @@
 
 	return err;
 }
+#endif  /*  0  */
 
-int ds_start_pulse(struct ds_device *dev, int delay)
+static int ds_start_pulse(struct ds_device *dev, int delay)
 {
 	int err;
 	u8 del = 1 + (u8)(delay >> 4);
@@ -552,6 +556,8 @@
 	return !(err == len);
 }
 
+#if 0
+
 int ds_search(struct ds_device *dev, u64 init, u64 *buf, u8 id_number, int conditional_search)
 {
 	int err;
@@ -625,7 +631,10 @@
 	return 0;
 }
 
-int ds_probe(struct usb_interface *intf, const struct usb_device_id *udev_id)
+#endif  /*  0  */
+
+static int ds_probe(struct usb_interface *intf,
+		    const struct usb_device_id *udev_id)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct usb_endpoint_descriptor *endpoint;
@@ -720,7 +729,7 @@
 	return 0;
 }
 
-void ds_disconnect(struct usb_interface *intf)
+static void ds_disconnect(struct usb_interface *intf)
 {
 	struct ds_device *dev;
 	
@@ -740,7 +749,7 @@
 	ds_dev = NULL;
 }
 
-int ds_init(void)
+static int ds_init(void)
 {
 	int err;
 
@@ -753,7 +762,7 @@
 	return 0;
 }
 
-void ds_fini(void)
+static void ds_fini(void)
 {
 	usb_deregister(&ds_driver);
 }
--- linux-2.6.12-rc2-mm3-full/drivers/w1/w1.h.old	2005-04-18 00:24:29.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/w1/w1.h	2005-04-18 00:24:34.000000000 +0200
@@ -137,7 +137,6 @@
 };
 
 int w1_create_master_attributes(struct w1_master *);
-void w1_destroy_master_attributes(struct w1_master *);
 void w1_search(struct w1_master *dev);
 
 #endif /* __KERNEL__ */
--- linux-2.6.12-rc2-mm3-full/drivers/w1/w1.c.old	2005-04-18 00:23:55.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/w1/w1.c	2005-04-18 00:25:44.000000000 +0200
@@ -485,7 +485,7 @@
 	return (found)?dev:NULL;
 }
 
-void w1_slave_found(unsigned long data, u64 rn)
+static void w1_slave_found(unsigned long data, u64 rn)
 {
 	int slave_count;
 	struct w1_slave *sl;
@@ -634,7 +634,7 @@
 	return 0;
 }
 
-void w1_destroy_master_attributes(struct w1_master *dev)
+static void w1_destroy_master_attributes(struct w1_master *dev)
 {
 	device_remove_file(&dev->dev, &w1_master_attribute_slaves);
 	device_remove_file(&dev->dev, &w1_master_attribute_slave_count);
@@ -646,7 +646,7 @@
 }
 
 
-int w1_control(void *data)
+static int w1_control(void *data)
 {
 	struct w1_slave *sl;
 	struct w1_master *dev;
@@ -774,7 +774,7 @@
 	return 0;
 }
 
-int w1_init(void)
+static int w1_init(void)
 {
 	int retval;
 
@@ -814,7 +814,7 @@
 	return retval;
 }
 
-void w1_fini(void)
+static void w1_fini(void)
 {
 	struct w1_master *dev;
 	struct list_head *ent, *n;
--- linux-2.6.12-rc2-mm3-full/drivers/w1/w1_family.h.old	2005-04-18 00:25:57.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/w1/w1_family.h	2005-04-18 00:26:56.000000000 +0200
@@ -54,10 +54,8 @@
 
 extern spinlock_t w1_flock;
 
-void w1_family_get(struct w1_family *);
 void w1_family_put(struct w1_family *);
 void __w1_family_get(struct w1_family *);
-void __w1_family_put(struct w1_family *);
 struct w1_family * w1_family_registered(u8);
 void w1_unregister_family(struct w1_family *);
 int w1_register_family(struct w1_family *);
--- linux-2.6.12-rc2-mm3-full/drivers/w1/w1_family.c.old	2005-04-18 00:26:08.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/w1/w1_family.c	2005-04-18 00:33:23.000000000 +0200
@@ -115,6 +115,12 @@
 	return (ret) ? f : NULL;
 }
 
+static void __w1_family_put(struct w1_family *f)
+{
+	if (atomic_dec_and_test(&f->refcnt))
+		f->need_exit = 1;
+}
+
 void w1_family_put(struct w1_family *f)
 {
 	spin_lock(&w1_flock);
@@ -122,12 +128,7 @@
 	spin_unlock(&w1_flock);
 }
 
-void __w1_family_put(struct w1_family *f)
-{
-	if (atomic_dec_and_test(&f->refcnt))
-		f->need_exit = 1;
-}
-
+#if 0
 void w1_family_get(struct w1_family *f)
 {
 	spin_lock(&w1_flock);
@@ -135,6 +136,7 @@
 	spin_unlock(&w1_flock);
 
 }
+#endif  /*  0  */
 
 void __w1_family_get(struct w1_family *f)
 {
@@ -143,8 +145,5 @@
 	smp_mb__after_atomic_inc();
 }
 
-EXPORT_SYMBOL(w1_family_get);
-EXPORT_SYMBOL(w1_family_put);
-EXPORT_SYMBOL(w1_family_registered);
 EXPORT_SYMBOL(w1_unregister_family);
 EXPORT_SYMBOL(w1_register_family);
--- linux-2.6.12-rc2-mm3-full/drivers/w1/w1_int.h.old	2005-04-18 00:28:14.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/w1/w1_int.h	2005-04-18 00:28:50.000000000 +0200
@@ -27,8 +27,6 @@
 
 #include "w1.h"
 
-struct w1_master * w1_alloc_dev(u32, int, int, struct device_driver *, struct device *);
-void w1_free_dev(struct w1_master *dev);
 int w1_add_master_device(struct w1_bus_master *);
 void w1_remove_master_device(struct w1_bus_master *);
 void __w1_remove_master_device(struct w1_master *);
--- linux-2.6.12-rc2-mm3-full/drivers/w1/w1_int.c.old	2005-04-18 00:28:28.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/w1/w1_int.c	2005-04-18 00:28:56.000000000 +0200
@@ -39,8 +39,9 @@
 
 extern int w1_process(void *);
 
-struct w1_master * w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
-	      struct device_driver *driver, struct device *device)
+static struct w1_master * w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
+				       struct device_driver *driver,
+				       struct device *device)
 {
 	struct w1_master *dev;
 	int err;
@@ -105,7 +106,7 @@
 	return dev;
 }
 
-void w1_free_dev(struct w1_master *dev)
+static void w1_free_dev(struct w1_master *dev)
 {
 	device_unregister(&dev->dev);
 	if (dev->nls && dev->nls->sk_socket)
--- linux-2.6.12-rc2-mm3-full/drivers/w1/w1_io.h.old	2005-04-18 00:29:14.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/w1/w1_io.h	2005-04-18 00:30:32.000000000 +0200
@@ -24,12 +24,9 @@
 
 #include "w1.h"
 
-void w1_delay(unsigned long);
 u8 w1_touch_bit(struct w1_master *, int);
 void w1_write_bit(struct w1_master *, int);
 void w1_write_8(struct w1_master *, u8);
-u8 w1_read_bit(struct w1_master *);
-u8 w1_read_8(struct w1_master *);
 int w1_reset_bus(struct w1_master *);
 u8 w1_calc_crc8(u8 *, int);
 void w1_write_block(struct w1_master *, u8 *, int);
--- linux-2.6.12-rc2-mm3-full/drivers/w1/w1_io.c.old	2005-04-18 00:29:28.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/w1/w1_io.c	2005-04-18 00:34:41.000000000 +0200
@@ -28,7 +28,9 @@
 #include "w1_log.h"
 #include "w1_io.h"
 
-int w1_delay_parm = 1;
+static u8 w1_read_bit(struct w1_master *dev);
+
+static int w1_delay_parm = 1;
 module_param_named(delay_coef, w1_delay_parm, int, 0);
 
 static u8 w1_crc8_table[] = {
@@ -50,7 +52,7 @@
 	116, 42, 200, 150, 21, 75, 169, 247, 182, 232, 10, 84, 215, 137, 107, 53
 };
 
-void w1_delay(unsigned long tm)
+static void w1_delay(unsigned long tm)
 {
 	udelay(tm * w1_delay_parm);
 }
@@ -89,7 +91,7 @@
 			w1_write_bit(dev, (byte >> i) & 0x1);
 }
 
-u8 w1_read_bit(struct w1_master *dev)
+static u8 w1_read_bit(struct w1_master *dev)
 {
 	int result;
 
@@ -104,7 +106,7 @@
 	return result & 0x1;
 }
 
-u8 w1_read_8(struct w1_master * dev)
+static u8 w1_read_8(struct w1_master * dev)
 {
 	int i;
 	u8 res = 0;
@@ -183,13 +185,8 @@
 		w1_search(dev);
 }
 
-EXPORT_SYMBOL(w1_write_bit);
 EXPORT_SYMBOL(w1_write_8);
-EXPORT_SYMBOL(w1_read_bit);
-EXPORT_SYMBOL(w1_read_8);
 EXPORT_SYMBOL(w1_reset_bus);
 EXPORT_SYMBOL(w1_calc_crc8);
-EXPORT_SYMBOL(w1_delay);
 EXPORT_SYMBOL(w1_read_block);
 EXPORT_SYMBOL(w1_write_block);
-EXPORT_SYMBOL(w1_search_devices);

