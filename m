Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752311AbWCFJOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbWCFJOr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 04:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbWCFJOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 04:14:47 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:55277 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752310AbWCFJOr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 04:14:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RglMO76rHbV4+DLbRxRd9XBCqfNI9/xbmTGXuOpHXVZhZ8p6NWc3UgHg0OPnUzUL8lI63gtJtN4tHMgG29cjlngLuM2Wh1Phaf/yr3cKofC47ujoprsJ1Xm4CuoyHs1oGrbWM/vf5A8NM/a4e4ndidomYJqYa53dRMOh2t3s/M4=
Message-ID: <38c09b90603060114n79dcc45p499603b614bbbe20@mail.gmail.com>
Date: Mon, 6 Mar 2006 17:14:45 +0800
From: "Lanslott Gish" <lanslott.gish@gmail.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       "Greg KH" <greg@kroah.com>
Subject: [PATCH] add support for PANJIT TouchSet USB Touchscreen Device
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Alan Cox" <alan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this is the first version of the patch from a newbie :)
add support for PANJIT TouchSet USB touchscreen device.

patch for kernel 2.6.16-rc5.
thx for anyone see this, and feel free to apply it :)

Best Regards,

victima


=========================================================================


diff -u -r -N linux-2.6.16-rc5/drivers/usb/input/hid-core.c
linux-2.6.16-rc5.modi/drivers/usb/input/hid-core.c
--- linux-2.6.16-rc5/drivers/usb/input/hid-core.c	2006-02-27
13:09:35.000000000 +0800
+++ linux-2.6.16-rc5.modi/drivers/usb/input/hid-core.c	2006-03-02
10:20:36.000000000 +0800
@@ -1459,6 +1459,12 @@
 #define USB_VENDOR_ID_HP		0x03f0
 #define USB_DEVICE_ID_HP_USBHUB_KB	0x020c

+#define USB_VENDOR_ID_TOUCHSET		0x134c
+#define USB_DEVICE_ID_TOUCHSET_INITIAL	0x0001
+#define USB_DEVICE_ID_TOUCHSET_JUNIOR	0x0002
+#define USB_DEVICE_ID_TOUCHSET_TRIAD	0x0003
+#define USB_DEVICE_ID_TOUCHSET_QUATA	0x0004
+
 /*
  * Alphabetically sorted blacklist by quirk type.
  */
@@ -1603,6 +1609,11 @@
 	{ USB_VENDOR_ID_APPLE, 0x030A, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x030B, HID_QUIRK_POWERBOOK_HAS_FN },

+	{ USB_VENDOR_ID_TOUCHSET, USB_DEVICE_ID_TOUCHSET_INITIAL, HID_QUIRK_BADPAD },
+	{ USB_VENDOR_ID_TOUCHSET, USB_DEVICE_ID_TOUCHSET_JUNIOR, HID_QUIRK_BADPAD },
+	{ USB_VENDOR_ID_TOUCHSET, USB_DEVICE_ID_TOUCHSET_TRIAD, HID_QUIRK_BADPAD },
+	{ USB_VENDOR_ID_TOUCHSET, USB_DEVICE_ID_TOUCHSET_QUATA, HID_QUIRK_BADPAD },
+
 	{ 0, 0 }
 };

diff -u -r -N linux-2.6.16-rc5/drivers/usb/input/Kconfig
linux-2.6.16-rc5.modi/drivers/usb/input/Kconfig
--- linux-2.6.16-rc5/drivers/usb/input/Kconfig	2006-02-27
13:09:35.000000000 +0800
+++ linux-2.6.16-rc5.modi/drivers/usb/input/Kconfig	2006-03-02
09:48:38.000000000 +0800
@@ -224,6 +224,19 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called itmtouch.

+config USB_TOUCHSET
+	tristate "TouchSet USB Device Driver"
+	depends on USB && INPUT
+	---help---
+	  Say Y here if you want to use a TouchSet USB
+	  Touchscreen controller.
+
+	  Have a look at <http://linux.chapter7.ch/touchkit/> for
+	  a usage description and the required user-space stuff.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called touchsetusb.
+
 config USB_EGALAX
 	tristate "eGalax TouchKit USB Touchscreen Driver"
 	depends on USB && INPUT
diff -u -r -N linux-2.6.16-rc5/drivers/usb/input/Makefile
linux-2.6.16-rc5.modi/drivers/usb/input/Makefile
--- linux-2.6.16-rc5/drivers/usb/input/Makefile	2006-02-27
13:09:35.000000000 +0800
+++ linux-2.6.16-rc5.modi/drivers/usb/input/Makefile	2006-03-02
10:20:36.000000000 +0800
@@ -36,6 +36,7 @@
 obj-$(CONFIG_USB_MOUSE)		+= usbmouse.o
 obj-$(CONFIG_USB_MTOUCH)	+= mtouchusb.o
 obj-$(CONFIG_USB_ITMTOUCH)	+= itmtouch.o
+obj-$(CONFIG_USB_TOUCHSET)	+= touchsetusb.o
 obj-$(CONFIG_USB_EGALAX)	+= touchkitusb.o
 obj-$(CONFIG_USB_POWERMATE)	+= powermate.o
 obj-$(CONFIG_USB_WACOM)		+= wacom.o
diff -u -r -N linux-2.6.16-rc5/drivers/usb/input/touchsetusb.c
linux-2.6.16-rc5.modi/drivers/usb/input/touchsetusb.c
--- linux-2.6.16-rc5/drivers/usb/input/touchsetusb.c	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.16-rc5.modi/drivers/usb/input/touchsetusb.c	2006-03-02
10:20:36.000000000 +0800
@@ -0,0 +1,294 @@
+/******************************************************************************
+ * touchsetusb.c  --  Driver for TouchSet USB Device
+ *
+ * Copyright (C) 2006 by Victima Gish
+ * Copyright (C) by Todd E. Johnson (mtouchusb.c)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Based upon mtouchusb.c
+ *
+ *****************************************************************************/
+
+//#define DEBUG
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/usb.h>
+#include <linux/usb_input.h>
+
+#define TOUCHSET_MIN_XC			0x0
+#define TOUCHSET_MAX_XC			0x0fff
+#define TOUCHSET_XC_FUZZ		0x0
+#define TOUCHSET_XC_FLAT		0x0
+#define TOUCHSET_MIN_YC			0x0
+#define TOUCHSET_MAX_YC			0x0fff
+#define TOUCHSET_YC_FUZZ		0x0
+#define TOUCHSET_YC_FLAT		0x0
+#define TOUCHSET_REPORT_DATA_SIZE	8
+
+#define TOUCHSET_DOWN			0x01
+#define TOUCHSET_POINT_TOUCH		0x81
+#define TOUCHSET_POINT_NOTOUCH		0x80
+
+#define TOUCHSET_GET_TOUCHED(dat)	((((dat)[0]) & TOUCHSET_DOWN) ? 1 : 0)
+#define TOUCHSET_GET_X(dat)		((dat)[1] | ((dat)[2] << 8))
+#define TOUCHSET_GET_Y(dat)		((dat)[3] | ((dat)[4] << 8))
+
+#define DRIVER_VERSION			"0.1"
+#define DRIVER_AUTHOR			"Victima Gish <victima.gish@gmail.com>"
+#define DRIVER_DESC			"TouchSet USB Device"
+
+static int swap_xy;
+static int _x;
+static int _y;
+module_param(swap_xy, bool, 0644);
+MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
+
+struct touchset_usb {
+	unsigned char *data;
+	dma_addr_t data_dma;
+	struct urb *irq;
+	struct usb_device *udev;
+	struct input_dev *input;
+	char name[128];
+	char phys[64];
+};
+
+static struct usb_device_id touchset_devices[] = {
+	{USB_DEVICE(0x134c, 0x0001)},
+	{USB_DEVICE(0x134c, 0x0002)},
+	{USB_DEVICE(0x134c, 0x0003)},
+	{USB_DEVICE(0x134c, 0x0004)},
+	{}
+};
+
+static void touchset_irq(struct urb *urb, struct pt_regs *regs)
+{
+	struct touchset_usb *touchset = urb->context;
+	int retval;
+	int x, y;
+
+	switch (urb->status) {
+	case 0:
+		/* success */
+		break;
+	case -ETIMEDOUT:
+		/* this urb is timing out */
+		dbg("%s - urb timed out - was the device unplugged?",
+		    __FUNCTION__);
+		return;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		/* this urb is terminated, clean up */
+		dbg("%s - urb shutting down with status: %d",
+		    __FUNCTION__, urb->status);
+		return;
+	default:
+		dbg("%s - nonzero urb status received: %d",
+		    __FUNCTION__, urb->status);
+		goto exit;
+	}
+
+	if (swap_xy) {
+		y = TOUCHSET_GET_X(touchset->data);
+		x = TOUCHSET_GET_Y(touchset->data);
+	} else {
+		x = TOUCHSET_GET_X(touchset->data);
+		y = TOUCHSET_GET_Y(touchset->data);
+	}
+
+	input_regs(touchset->input, regs);
+	input_report_key(touchset->input, BTN_TOUCH,
+	                 TOUCHSET_GET_TOUCHED(touchset->data));
+	input_report_abs(touchset->input, ABS_X, x);
+	input_report_abs(touchset->input, ABS_Y, y);
+	input_sync(touchset->input);
+
+exit:
+	retval = usb_submit_urb(urb, GFP_ATOMIC);
+	if (retval)
+		err("%s - usb_submit_urb failed with result: %d",
+		    __FUNCTION__, retval);
+}
+
+static int touchset_open(struct input_dev *input)
+{
+	struct touchset_usb *touchset = input->private;
+
+	touchset->irq->dev = touchset->udev;
+
+	if (usb_submit_urb(touchset->irq, GFP_ATOMIC))
+		return -EIO;
+
+	return 0;
+}
+
+static void touchset_close(struct input_dev *input)
+{
+	struct touchset_usb *touchset = input->private;
+
+	usb_kill_urb(touchset->irq);
+}
+
+static int touchset_alloc_buffers(struct usb_device *udev,
+				  struct touchset_usb *touchset)
+{
+	touchset->data = usb_buffer_alloc(udev, TOUCHSET_REPORT_DATA_SIZE,
+	                                  SLAB_ATOMIC, &touchset->data_dma);
+
+	if (!touchset->data)
+		return -1;
+
+	return 0;
+}
+
+static void touchset_free_buffers(struct usb_device *udev,
+				  struct touchset_usb *touchset)
+{
+	if (touchset->data)
+		usb_buffer_free(udev, TOUCHSET_REPORT_DATA_SIZE,
+		                touchset->data, touchset->data_dma);
+}
+
+static int touchset_probe(struct usb_interface *intf,
+			  const struct usb_device_id *id)
+{
+	struct touchset_usb *touchset;
+	struct input_dev *input_dev;
+	struct usb_host_interface *interface;
+	struct usb_endpoint_descriptor *endpoint;
+	struct usb_device *udev = interface_to_usbdev(intf);
+
+	interface = intf->cur_altsetting;
+	endpoint = &interface->endpoint[0].desc;
+
+	touchset = kzalloc(sizeof(struct touchset_usb), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!touchset || !input_dev)
+		goto out_free;
+
+	if (touchset_alloc_buffers(udev, touchset))
+		goto out_free;
+
+	touchset->irq = usb_alloc_urb(0, GFP_KERNEL);
+	if (!touchset->irq) {
+		dbg("%s - usb_alloc_urb failed: touchset->irq", __FUNCTION__);
+		goto out_free_buffers;
+	}
+
+	touchset->udev = udev;
+	touchset->input = input_dev;
+
+	if (udev->manufacturer)
+		strlcpy(touchset->name, udev->manufacturer, sizeof(touchset->name));
+
+	if (udev->product) {
+		if (udev->manufacturer)
+			strlcat(touchset->name, " ", sizeof(touchset->name));
+		strlcat(touchset->name, udev->product, sizeof(touchset->name));
+	}
+
+	if (!strlen(touchset->name))
+		snprintf(touchset->name, sizeof(touchset->name),
+			"USB Device %04x:%04x",
+			 le16_to_cpu(udev->descriptor.idVendor),
+			 le16_to_cpu(udev->descriptor.idProduct));
+
+	usb_make_path(udev, touchset->phys, sizeof(touchset->phys));
+	strlcpy(touchset->phys, "/input0", sizeof(touchset->phys));
+
+	input_dev->name = touchset->name;
+	input_dev->phys = touchset->phys;
+	usb_to_input_id(udev, &input_dev->id);
+	input_dev->cdev.dev = &intf->dev;
+	input_dev->private = touchset;
+	input_dev->open = touchset_open;
+	input_dev->close = touchset_close;
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+	input_set_abs_params(input_dev, ABS_X, TOUCHSET_MIN_XC, TOUCHSET_MAX_XC,
+				TOUCHSET_XC_FUZZ, TOUCHSET_XC_FLAT);
+	input_set_abs_params(input_dev, ABS_Y, TOUCHSET_MIN_YC, TOUCHSET_MAX_YC,
+				TOUCHSET_YC_FUZZ, TOUCHSET_YC_FLAT);
+
+	usb_fill_int_urb(touchset->irq, touchset->udev,
+			 usb_rcvintpipe(touchset->udev, 0x81),
+			 touchset->data, TOUCHSET_REPORT_DATA_SIZE,
+			 touchset_irq, touchset, endpoint->bInterval);
+
+	touchset->irq->transfer_dma = touchset->data_dma;
+	touchset->irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+	input_register_device(touchset->input);
+
+	usb_set_intfdata(intf, touchset);
+	return 0;
+
+out_free_buffers:
+	touchset_free_buffers(udev, touchset);
+out_free:
+	input_free_device(input_dev);
+	kfree(touchset);
+	return -ENOMEM;
+}
+
+static void touchset_disconnect(struct usb_interface *intf)
+{
+	struct touchset_usb *touchset = usb_get_intfdata(intf);
+
+	dbg("%s - called", __FUNCTION__);
+
+	if (!touchset)
+		return;
+
+	dbg("%s - touchset is initialized, cleaning up", __FUNCTION__);
+	usb_set_intfdata(intf, NULL);
+	usb_kill_urb(touchset->irq);
+	input_unregister_device(touchset->input);
+	usb_free_urb(touchset->irq);
+	touchset_free_buffers(interface_to_usbdev(intf), touchset);
+	kfree(touchset);
+}
+
+MODULE_DEVICE_TABLE(usb, touchset_devices);
+
+static struct usb_driver touchset_driver = {
+	.name		= "touchsetusb",
+	.probe		= touchset_probe,
+	.disconnect	= touchset_disconnect,
+	.id_table	= touchset_devices,
+};
+
+static int __init touchset_init(void)
+{
+	return usb_register(&touchset_driver);
+}
+
+static void __exit touchset_cleanup(void)
+{
+	usb_deregister(&touchset_driver);
+}
+
+module_init(touchset_init);
+module_exit(touchset_cleanup);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
diff -u -r -N linux-2.6.16-rc5/drivers/usb/Makefile
linux-2.6.16-rc5.modi/drivers/usb/Makefile
--- linux-2.6.16-rc5/drivers/usb/Makefile	2006-02-27 13:09:35.000000000 +0800
+++ linux-2.6.16-rc5.modi/drivers/usb/Makefile	2006-03-02
10:11:39.000000000 +0800
@@ -31,6 +31,7 @@
 obj-$(CONFIG_USB_KBTAB)		+= input/
 obj-$(CONFIG_USB_MOUSE)		+= input/
 obj-$(CONFIG_USB_MTOUCH)	+= input/
+obj-$(CONFIG_USB_TOUCHSET)	+= input/
 obj-$(CONFIG_USB_POWERMATE)	+= input/
 obj-$(CONFIG_USB_WACOM)		+= input/
 obj-$(CONFIG_USB_ACECAD)	+= input/





=======================================================================





--
~
