Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbVIHWX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbVIHWX7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbVIHWW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:22:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:35262 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965044AbVIHWWy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:22:54 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] W1: Sync with w1/ds9490 tree.
In-Reply-To: <11262181612005@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 8 Sep 2005 15:22:41 -0700
Message-Id: <11262181613204@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] W1: Sync with w1/ds9490 tree.

Whitespace, static/nonstatic cleanups.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 8949d2aa05ddf5e9a31d738568a79915970cb38e
tree bb5c18d4a5ff014a4a521fb5817ad231e8d0c81f
parent 2d8331792ea3f5ccfd147288afba148537337019
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Wed, 03 Aug 2005 15:14:50 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 08 Sep 2005 14:41:26 -0700

 drivers/w1/ds_w1_bridge.c |   24 +++----
 drivers/w1/dscore.c       |  161 +++++++++++++++++++++++----------------------
 drivers/w1/dscore.h       |   10 +--
 3 files changed, 99 insertions(+), 96 deletions(-)

diff --git a/drivers/w1/ds_w1_bridge.c b/drivers/w1/ds_w1_bridge.c
--- a/drivers/w1/ds_w1_bridge.c
+++ b/drivers/w1/ds_w1_bridge.c
@@ -1,8 +1,8 @@
 /*
- * 	ds_w1_bridge.c
+ *	ds_w1_bridge.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -25,7 +25,7 @@
 #include "../w1/w1.h"
 #include "../w1/w1_int.h"
 #include "dscore.h"
-	
+
 static struct ds_device *ds_dev;
 static struct w1_bus_master *ds_bus_master;
 
@@ -120,7 +120,7 @@ static u8 ds9490r_reset(unsigned long da
 static int __devinit ds_w1_init(void)
 {
 	int err;
-	
+
 	ds_bus_master = kmalloc(sizeof(*ds_bus_master), GFP_KERNEL);
 	if (!ds_bus_master) {
 		printk(KERN_ERR "Failed to allocate DS9490R USB<->W1 bus_master structure.\n");
@@ -136,14 +136,14 @@ static int __devinit ds_w1_init(void)
 
 	memset(ds_bus_master, 0, sizeof(*ds_bus_master));
 
-	ds_bus_master->data 		= (unsigned long)ds_dev;
-	ds_bus_master->touch_bit 	= &ds9490r_touch_bit;
-	ds_bus_master->read_bit 	= &ds9490r_read_bit;
-	ds_bus_master->write_bit 	= &ds9490r_write_bit;
-	ds_bus_master->read_byte 	= &ds9490r_read_byte;
-	ds_bus_master->write_byte 	= &ds9490r_write_byte;
-	ds_bus_master->read_block 	= &ds9490r_read_block;
-	ds_bus_master->write_block 	= &ds9490r_write_block;
+	ds_bus_master->data		= (unsigned long)ds_dev;
+	ds_bus_master->touch_bit	= &ds9490r_touch_bit;
+	ds_bus_master->read_bit		= &ds9490r_read_bit;
+	ds_bus_master->write_bit	= &ds9490r_write_bit;
+	ds_bus_master->read_byte	= &ds9490r_read_byte;
+	ds_bus_master->write_byte	= &ds9490r_write_byte;
+	ds_bus_master->read_block	= &ds9490r_read_block;
+	ds_bus_master->write_block	= &ds9490r_write_block;
 	ds_bus_master->reset_bus	= &ds9490r_reset;
 
 	err = w1_add_master_device(ds_bus_master);
diff --git a/drivers/w1/dscore.c b/drivers/w1/dscore.c
--- a/drivers/w1/dscore.c
+++ b/drivers/w1/dscore.c
@@ -1,8 +1,8 @@
 /*
- * 	dscore.c
+ *	dscore.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -32,19 +32,16 @@ static struct usb_device_id ds_id_table 
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
 
@@ -79,11 +76,11 @@ void ds_put_device(struct ds_device *dev
 static int ds_send_control_cmd(struct ds_device *dev, u16 value, u16 index)
 {
 	int err;
-	
-	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]), 
+
+	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]),
 			CONTROL_CMD, 0x40, value, index, NULL, 0, 1000);
 	if (err < 0) {
-		printk(KERN_ERR "Failed to send command control message %x.%x: err=%d.\n", 
+		printk(KERN_ERR "Failed to send command control message %x.%x: err=%d.\n",
 				value, index, err);
 		return err;
 	}
@@ -94,11 +91,11 @@ static int ds_send_control_cmd(struct ds
 static int ds_send_control_mode(struct ds_device *dev, u16 value, u16 index)
 {
 	int err;
-	
-	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]), 
+
+	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]),
 			MODE_CMD, 0x40, value, index, NULL, 0, 1000);
 	if (err < 0) {
-		printk(KERN_ERR "Failed to send mode control message %x.%x: err=%d.\n", 
+		printk(KERN_ERR "Failed to send mode control message %x.%x: err=%d.\n",
 				value, index, err);
 		return err;
 	}
@@ -109,11 +106,11 @@ static int ds_send_control_mode(struct d
 static int ds_send_control(struct ds_device *dev, u16 value, u16 index)
 {
 	int err;
-	
-	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]), 
+
+	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]),
 			COMM_CMD, 0x40, value, index, NULL, 0, 1000);
 	if (err < 0) {
-		printk(KERN_ERR "Failed to send control message %x.%x: err=%d.\n", 
+		printk(KERN_ERR "Failed to send control message %x.%x: err=%d.\n",
 				value, index, err);
 		return err;
 	}
@@ -126,19 +123,20 @@ static inline void ds_dump_status(unsign
 	printk("%45s: %8x\n", str, buf[off]);
 }
 
-int ds_recv_status_nodump(struct ds_device *dev, struct ds_status *st, unsigned char *buf, int size)
+static int ds_recv_status_nodump(struct ds_device *dev, struct ds_status *st,
+				 unsigned char *buf, int size)
 {
 	int count, err;
-		
+
 	memset(st, 0, sizeof(st));
-	
+
 	count = 0;
 	err = usb_bulk_msg(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_STATUS]), buf, size, &count, 100);
 	if (err < 0) {
 		printk(KERN_ERR "Failed to read 1-wire data from 0x%x: err=%d.\n", dev->ep[EP_STATUS], err);
 		return err;
 	}
-	
+
 	if (count >= sizeof(*st))
 		memcpy(st, buf, sizeof(*st));
 
@@ -149,13 +147,13 @@ static int ds_recv_status(struct ds_devi
 {
 	unsigned char buf[64];
 	int count, err = 0, i;
-	
+
 	memcpy(st, buf, sizeof(*st));
-		
+
 	count = ds_recv_status_nodump(dev, st, buf, sizeof(buf));
 	if (count < 0)
 		return err;
-	
+
 	printk("0x%x: count=%d, status: ", dev->ep[EP_STATUS], count);
 	for (i=0; i<count; ++i)
 		printk("%02x ", buf[i]);
@@ -199,7 +197,7 @@ static int ds_recv_status(struct ds_devi
 			return err;
 	}
 #endif
-	
+
 	return err;
 }
 
@@ -207,9 +205,9 @@ static int ds_recv_data(struct ds_device
 {
 	int count, err;
 	struct ds_status st;
-	
+
 	count = 0;
-	err = usb_bulk_msg(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_DATA_IN]), 
+	err = usb_bulk_msg(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_DATA_IN]),
 				buf, size, &count, 1000);
 	if (err < 0) {
 		printk(KERN_INFO "Clearing ep0x%x.\n", dev->ep[EP_DATA_IN]);
@@ -234,7 +232,7 @@ static int ds_recv_data(struct ds_device
 static int ds_send_data(struct ds_device *dev, unsigned char *buf, int len)
 {
 	int count, err;
-	
+
 	count = 0;
 	err = usb_bulk_msg(dev->udev, usb_sndbulkpipe(dev->udev, dev->ep[EP_DATA_OUT]), buf, len, &count, 1000);
 	if (err < 0) {
@@ -245,12 +243,14 @@ static int ds_send_data(struct ds_device
 	return err;
 }
 
+#if 0
+
 int ds_stop_pulse(struct ds_device *dev, int limit)
 {
 	struct ds_status st;
 	int count = 0, err = 0;
 	u8 buf[0x20];
-	
+
 	do {
 		err = ds_send_control(dev, CTL_HALT_EXE_IDLE, 0);
 		if (err)
@@ -275,7 +275,7 @@ int ds_stop_pulse(struct ds_device *dev,
 int ds_detect(struct ds_device *dev, struct ds_status *st)
 {
 	int err;
-	
+
 	err = ds_send_control_cmd(dev, CTL_RESET_DEVICE, 0);
 	if (err)
 		return err;
@@ -283,11 +283,11 @@ int ds_detect(struct ds_device *dev, str
 	err = ds_send_control(dev, COMM_SET_DURATION | COMM_IM, 0);
 	if (err)
 		return err;
-	
+
 	err = ds_send_control(dev, COMM_SET_DURATION | COMM_IM | COMM_TYPE, 0x40);
 	if (err)
 		return err;
-	
+
 	err = ds_send_control_mode(dev, MOD_PULSE_EN, PULSE_PROG);
 	if (err)
 		return err;
@@ -297,7 +297,9 @@ int ds_detect(struct ds_device *dev, str
 	return err;
 }
 
-int ds_wait_status(struct ds_device *dev, struct ds_status *st)
+#endif  /*  0  */
+
+static int ds_wait_status(struct ds_device *dev, struct ds_status *st)
 {
 	u8 buf[0x20];
 	int err, count = 0;
@@ -305,7 +307,7 @@ int ds_wait_status(struct ds_device *dev
 	do {
 		err = ds_recv_status_nodump(dev, st, buf, sizeof(buf));
 #if 0
-		if (err >= 0) {	
+		if (err >= 0) {
 			int i;
 			printk("0x%x: count=%d, status: ", dev->ep[EP_STATUS], err);
 			for (i=0; i<err; ++i)
@@ -319,10 +321,8 @@ int ds_wait_status(struct ds_device *dev
 	if (((err > 16) && (buf[0x10] & 0x01)) || count >= 100 || err < 0) {
 		ds_recv_status(dev, st);
 		return -1;
-	}
-	else {
+	} else
 		return 0;
-	}
 }
 
 int ds_reset(struct ds_device *dev, struct ds_status *st)
@@ -345,6 +345,7 @@ int ds_reset(struct ds_device *dev, stru
 	return 0;
 }
 
+#if 0
 int ds_set_speed(struct ds_device *dev, int speed)
 {
 	int err;
@@ -356,20 +357,21 @@ int ds_set_speed(struct ds_device *dev, 
 		speed = SPEED_FLEXIBLE;
 
 	speed &= 0xff;
-	
+
 	err = ds_send_control_mode(dev, MOD_1WIRE_SPEED, speed);
 	if (err)
 		return err;
 
 	return err;
 }
+#endif  /*  0  */
 
-int ds_start_pulse(struct ds_device *dev, int delay)
+static int ds_start_pulse(struct ds_device *dev, int delay)
 {
 	int err;
 	u8 del = 1 + (u8)(delay >> 4);
 	struct ds_status st;
-	
+
 #if 0
 	err = ds_stop_pulse(dev, 10);
 	if (err)
@@ -390,7 +392,7 @@ int ds_start_pulse(struct ds_device *dev
 	mdelay(delay);
 
 	ds_wait_status(dev, &st);
-	
+
 	return err;
 }
 
@@ -400,7 +402,7 @@ int ds_touch_bit(struct ds_device *dev, 
 	struct ds_status st;
 	u16 value = (COMM_BIT_IO | COMM_IM) | ((bit) ? COMM_D : 0);
 	u16 cmd;
-	
+
 	err = ds_send_control(dev, value, 0);
 	if (err)
 		return err;
@@ -430,7 +432,7 @@ int ds_write_bit(struct ds_device *dev, 
 {
 	int err;
 	struct ds_status st;
-	
+
 	err = ds_send_control(dev, COMM_BIT_IO | COMM_IM | (bit) ? COMM_D : 0, 0);
 	if (err)
 		return err;
@@ -445,7 +447,7 @@ int ds_write_byte(struct ds_device *dev,
 	int err;
 	struct ds_status st;
 	u8 rbyte;
-	
+
 	err = ds_send_control(dev, COMM_BYTE_IO | COMM_IM | COMM_SPU, byte);
 	if (err)
 		return err;
@@ -453,11 +455,11 @@ int ds_write_byte(struct ds_device *dev,
 	err = ds_wait_status(dev, &st);
 	if (err)
 		return err;
-		
+
 	err = ds_recv_data(dev, &rbyte, sizeof(rbyte));
 	if (err < 0)
 		return err;
-	
+
 	ds_start_pulse(dev, PULLUP_PULSE_DURATION);
 
 	return !(byte == rbyte);
@@ -470,11 +472,11 @@ int ds_read_bit(struct ds_device *dev, u
 	err = ds_send_control_mode(dev, MOD_PULSE_EN, PULSE_SPUE);
 	if (err)
 		return err;
-	
+
 	err = ds_send_control(dev, COMM_BIT_IO | COMM_IM | COMM_SPU | COMM_D, 0);
 	if (err)
 		return err;
-	
+
 	err = ds_recv_data(dev, bit, sizeof(*bit));
 	if (err < 0)
 		return err;
@@ -492,7 +494,7 @@ int ds_read_byte(struct ds_device *dev, 
 		return err;
 
 	ds_wait_status(dev, &st);
-	
+
 	err = ds_recv_data(dev, byte, sizeof(*byte));
 	if (err < 0)
 		return err;
@@ -509,17 +511,17 @@ int ds_read_block(struct ds_device *dev,
 		return -E2BIG;
 
 	memset(buf, 0xFF, len);
-	
+
 	err = ds_send_data(dev, buf, len);
 	if (err < 0)
 		return err;
-	
+
 	err = ds_send_control(dev, COMM_BLOCK_IO | COMM_IM | COMM_SPU, len);
 	if (err)
 		return err;
 
 	ds_wait_status(dev, &st);
-	
+
 	memset(buf, 0x00, len);
 	err = ds_recv_data(dev, buf, len);
 
@@ -530,11 +532,11 @@ int ds_write_block(struct ds_device *dev
 {
 	int err;
 	struct ds_status st;
-	
+
 	err = ds_send_data(dev, buf, len);
 	if (err < 0)
 		return err;
-	
+
 	ds_wait_status(dev, &st);
 
 	err = ds_send_control(dev, COMM_BLOCK_IO | COMM_IM | COMM_SPU, len);
@@ -548,10 +550,12 @@ int ds_write_block(struct ds_device *dev
 		return err;
 
 	ds_start_pulse(dev, PULLUP_PULSE_DURATION);
-	
+
 	return !(err == len);
 }
 
+#if 0
+
 int ds_search(struct ds_device *dev, u64 init, u64 *buf, u8 id_number, int conditional_search)
 {
 	int err;
@@ -559,11 +563,11 @@ int ds_search(struct ds_device *dev, u64
 	struct ds_status st;
 
 	memset(buf, 0, sizeof(buf));
-	
+
 	err = ds_send_data(ds_dev, (unsigned char *)&init, 8);
 	if (err)
 		return err;
-	
+
 	ds_wait_status(ds_dev, &st);
 
 	value = COMM_SEARCH_ACCESS | COMM_IM | COMM_SM | COMM_F | COMM_RTS;
@@ -589,7 +593,7 @@ int ds_match_access(struct ds_device *de
 	err = ds_send_data(dev, (unsigned char *)&init, sizeof(init));
 	if (err)
 		return err;
-	
+
 	ds_wait_status(dev, &st);
 
 	err = ds_send_control(dev, COMM_MATCH_ACCESS | COMM_IM | COMM_RST, 0x0055);
@@ -609,11 +613,11 @@ int ds_set_path(struct ds_device *dev, u
 
 	memcpy(buf, &init, 8);
 	buf[8] = BRANCH_MAIN;
-	
+
 	err = ds_send_data(dev, buf, sizeof(buf));
 	if (err)
 		return err;
-	
+
 	ds_wait_status(dev, &st);
 
 	err = ds_send_control(dev, COMM_SET_PATH | COMM_IM | COMM_RST, 0);
@@ -625,7 +629,10 @@ int ds_set_path(struct ds_device *dev, u
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
@@ -653,7 +660,7 @@ int ds_probe(struct usb_interface *intf,
 		printk(KERN_ERR "Failed to reset configuration: err=%d.\n", err);
 		return err;
 	}
-	
+
 	iface_desc = &intf->altsetting[0];
 	if (iface_desc->desc.bNumEndpoints != NUM_EP-1) {
 		printk(KERN_INFO "Num endpoints=%d. It is not DS9490R.\n", iface_desc->desc.bNumEndpoints);
@@ -662,37 +669,37 @@ int ds_probe(struct usb_interface *intf,
 
 	atomic_set(&ds_dev->refcnt, 0);
 	memset(ds_dev->ep, 0, sizeof(ds_dev->ep));
-	
+
 	/*
-	 * This loop doesn'd show control 0 endpoint, 
+	 * This loop doesn'd show control 0 endpoint,
 	 * so we will fill only 1-3 endpoints entry.
 	 */
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		endpoint = &iface_desc->endpoint[i].desc;
 
 		ds_dev->ep[i+1] = endpoint->bEndpointAddress;
-		
+
 		printk("%d: addr=%x, size=%d, dir=%s, type=%x\n",
 			i, endpoint->bEndpointAddress, le16_to_cpu(endpoint->wMaxPacketSize),
 			(endpoint->bEndpointAddress & USB_DIR_IN)?"IN":"OUT",
 			endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK);
 	}
-	
+
 #if 0
 	{
 		int err, i;
 		u64 buf[3];
 		u64 init=0xb30000002078ee81ull;
 		struct ds_status st;
-		
+
 		ds_reset(ds_dev, &st);
 		err = ds_search(ds_dev, init, buf, 3, 0);
 		if (err < 0)
 			return err;
 		for (i=0; i<err; ++i)
 			printk("%d: %llx\n", i, buf[i]);
-		
-		printk("Resetting...\n");	
+
+		printk("Resetting...\n");
 		ds_reset(ds_dev, &st);
 		printk("Setting path for %llx.\n", init);
 		err = ds_set_path(ds_dev, init);
@@ -707,12 +714,12 @@ int ds_probe(struct usb_interface *intf,
 		err = ds_search(ds_dev, init, buf, 3, 0);
 
 		printk("ds_search() returned %d\n", err);
-		
+
 		if (err < 0)
 			return err;
 		for (i=0; i<err; ++i)
 			printk("%d: %llx\n", i, buf[i]);
-		
+
 		return 0;
 	}
 #endif
@@ -720,10 +727,10 @@ int ds_probe(struct usb_interface *intf,
 	return 0;
 }
 
-void ds_disconnect(struct usb_interface *intf)
+static void ds_disconnect(struct usb_interface *intf)
 {
 	struct ds_device *dev;
-	
+
 	dev = usb_get_intfdata(intf);
 	usb_set_intfdata(intf, NULL);
 
@@ -740,7 +747,7 @@ void ds_disconnect(struct usb_interface 
 	ds_dev = NULL;
 }
 
-int ds_init(void)
+static int ds_init(void)
 {
 	int err;
 
@@ -753,7 +760,7 @@ int ds_init(void)
 	return 0;
 }
 
-void ds_fini(void)
+static void ds_fini(void)
 {
 	usb_deregister(&ds_driver);
 }
@@ -776,8 +783,8 @@ EXPORT_SYMBOL(ds_get_device);
 EXPORT_SYMBOL(ds_put_device);
 
 /*
- * This functions can be used for EEPROM programming, 
- * when driver will be included into mainline this will 
+ * This functions can be used for EEPROM programming,
+ * when driver will be included into mainline this will
  * require uncommenting.
  */
 #if 0
diff --git a/drivers/w1/dscore.h b/drivers/w1/dscore.h
--- a/drivers/w1/dscore.h
+++ b/drivers/w1/dscore.h
@@ -1,8 +1,8 @@
 /*
- * 	dscore.h
+ *	dscore.h
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -122,7 +122,7 @@
 
 struct ds_device
 {
-	struct usb_device 	*udev;
+	struct usb_device	*udev;
 	struct usb_interface	*intf;
 
 	int			ep[NUM_EP];
@@ -156,11 +156,7 @@ int ds_read_byte(struct ds_device *, u8 
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

