Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWCHC5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWCHC5b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWCHC5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:57:30 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:57646 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932389AbWCHC52 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:57:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RkwmQHqHaYzPFMfMhxOsn7rV6RkxRahqJRR1X+KpW6tNgqu52SeYYJ2pFx9OGTTOidr1PC5xHvjB6EV61krEW099gjdP8c3LLEDg8KhY04GIHD5//VnD4NHLndg9CGCf60h2/4tANwFJYwL4ne68K78eVe2ivnoDgwaWBEEJqxE=
Message-ID: <38c09b90603071857g11e333a2l5a00ff3ba9e93b12@mail.gmail.com>
Date: Wed, 8 Mar 2006 10:57:28 +0800
From: "Lanslott Gish" <lanslott.gish@gmail.com>
To: "Oliver Neukum" <oliver@neukum.org>
Subject: Re: [linux-usb-devel] [PATCH] add support for PANJIT TouchSet USB Touchscreen Device
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       "Greg KH" <greg@kroah.com>, "Alan Cox" <alan@redhat.com>
In-Reply-To: <200603061205.32660.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <38c09b90603060114n79dcc45p499603b614bbbe20@mail.gmail.com>
	 <200603061205.32660.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

thx a lot ( Oliver :) )
i fixed some:

*some macros to func when transfer raw data
* the way *_ATOMIC" to *_KERNEL

as usual, for kernel 2.6.16-rc5.

best rgds,


========================================================

diff -u -N linux-2.6.16-rc5/drivers/usb/input/hid-core.c
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

diff -u -N linux-2.6.16-rc5/drivers/usb/input/Kconfig
linux-2.6.16-rc5.modi/drivers/usb/input/Kconfig
--- linux-2.6.16-rc5/drivers/usb/input/Kconfig	2006-02-27
13:09:35.000000000 +0800
+++ linux-2.6.16-rc5.modi/drivers/usb/input/Kconfig	2006-03-08
10:28:33.686019096 +0800
@@ -330,3 +330,16 @@

 	  To compile this driver as a module, choose M here: the
 	  module will be called appletouch.
+
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
diff -u -N linux-2.6.16-rc5/drivers/usb/input/Makefile
linux-2.6.16-rc5.modi/drivers/usb/input/Makefile
--- linux-2.6.16-rc5/drivers/usb/input/Makefile	2006-02-27
13:09:35.000000000 +0800
+++ linux-2.6.16-rc5.modi/drivers/usb/input/Makefile	2006-03-08
10:27:29.188824160 +0800
@@ -43,6 +43,7 @@
 obj-$(CONFIG_USB_YEALINK)	+= yealink.o
 obj-$(CONFIG_USB_XPAD)		+= xpad.o
 obj-$(CONFIG_USB_APPLETOUCH)	+= appletouch.o
+obj-$(CONFIG_USB_TOUCHSET)	+= touchsetusb.o

 ifeq ($(CONFIG_USB_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -u -N linux-2.6.16-rc5/drivers/usb/input/touchsetusb.c
linux-2.6.16-rc5.modi/drivers/usb/input/touchsetusb.c
--- linux-2.6.16-rc5/drivers/usb/input/touchsetusb.c	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.16-rc5.modi/drivers/usb/input/touchsetusb.c	2006-03-07
11:43:18.000000000 +0800
@@ -0,0 +1,303 @@
+/******************************************************************************
+ * touchsetusb.c  --  Driver for TouchSet USB Device
+ *
+ * Copyright (C) 2006 by Lanslott Gish
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
+#define DRIVER_VERSION			"0.2"
+#define DRIVER_AUTHOR			"Lanslott Gish <lanslott.gish@gmail.com>"
+#define DRIVER_DESC			"TouchSet USB Device"
+
+static int swap_xy;
+module_param(swap_xy, bool, 0644);
+MODULE_PARM_DESC(swap_xy, "Swap X and Y axes.");
+
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
+static struct usb_device_id touchsetusb_devices[] = {
+	{USB_DEVICE(0x134c, 0x0001)},
+	{USB_DEVICE(0x134c, 0x0002)},
+	{USB_DEVICE(0x134c, 0x0003)},
+	{USB_DEVICE(0x134c, 0x0004)},
+	{}
+};
+
+static inline int touchsetusb_get_touched(char *data)
+{
+	return ((((data)[0]) & TOUCHSET_DOWN) ? 1 : 0);
+}
+
+static inline int touchsetusb_get_x(char *data)
+{
+	return ((data)[1] | ((data)[2] << 8));
+}
+
+static inline int touchsetusb_get_y(char *data)
+{
+	return ((data)[3] | ((data)[4] << 8));
+}
+
+static void touchsetusb_irq(struct urb *urb, struct pt_regs *regs)
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
+		y = touchsetusb_get_x(touchset->data);
+		x = touchsetusb_get_y(touchset->data);
+	} else {
+		x = touchsetusb_get_x(touchset->data);
+		y = touchsetusb_get_y(touchset->data);
+	}
+
+	input_regs(touchset->input, regs);
+	input_report_key(touchset->input, BTN_TOUCH,
+	                 touchsetusb_get_touched(touchset->data));
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
+static int touchsetusb_open(struct input_dev *input)
+{
+	struct touchset_usb *touchset = input->private;
+
+	touchset->irq->dev = touchset->udev;
+
+	if (usb_submit_urb(touchset->irq, GFP_KERNEL))
+		return -EIO;
+
+	return 0;
+}
+
+static void touchsetusb_close(struct input_dev *input)
+{
+	struct touchset_usb *touchset = input->private;
+
+	usb_kill_urb(touchset->irq);
+}
+
+static int touchsetusb_alloc_buffers(struct usb_device *udev,
+				  struct touchset_usb *touchset)
+{
+	touchset->data = usb_buffer_alloc(udev, TOUCHSET_REPORT_DATA_SIZE,
+	                                  SLAB_KERNEL, &touchset->data_dma);
+
+	if (!touchset->data)
+		return -1;
+
+	return 0;
+}
+
+static void touchsetusb_free_buffers(struct usb_device *udev,
+				  struct touchset_usb *touchset)
+{
+	if (touchset->data)
+		usb_buffer_free(udev, TOUCHSET_REPORT_DATA_SIZE,
+		                touchset->data, touchset->data_dma);
+}
+
+static int touchsetusb_probe(struct usb_interface *intf,
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
+	if (touchsetusb_alloc_buffers(udev, touchset))
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
+	input_dev->open = touchsetusb_open;
+	input_dev->close = touchsetusb_close;
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
+			 touchsetusb_irq, touchset, endpoint->bInterval);
+
+	input_register_device(touchset->input);
+
+	usb_set_intfdata(intf, touchset);
+	return 0;
+
+out_free_buffers:
+	touchsetusb_free_buffers(udev, touchset);
+out_free:
+	input_free_device(input_dev);
+	kfree(touchset);
+	return -ENOMEM;
+}
+
+static void touchsetusb_disconnect(struct usb_interface *intf)
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
+	touchsetusb_free_buffers(interface_to_usbdev(intf), touchset);
+	kfree(touchset);
+}
+
+MODULE_DEVICE_TABLE(usb, touchsetusb_devices);
+
+static struct usb_driver touchsetusb_driver = {
+	.name		= "touchsetusb",
+	.probe		= touchsetusb_probe,
+	.disconnect	= touchsetusb_disconnect,
+	.id_table	= touchsetusb_devices,
+};
+
+static int __init touchsetusb_init(void)
+{
+	return usb_register(&touchsetusb_driver);
+}
+
+static void __exit touchsetusb_cleanup(void)
+{
+	usb_deregister(&touchsetusb_driver);
+}
+
+module_init(touchsetusb_init);
+module_exit(touchsetusb_cleanup);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");

========================================================

On 3/6/06, Oliver Neukum <oliver@neukum.org> wrote:
> Am Montag, 6. März 2006 10:14 schrieb Lanslott Gish:
> > hi,
> >
> > this is the first version of the patch from a newbie :)
> > add support for PANJIT TouchSet USB touchscreen device.
> >
>
> > +#define TOUCHSET_GET_TOUCHED(dat)    ((((dat)[0]) & TOUCHSET_DOWN) ? 1 : 0)
>
> Drop the "?"
>

> > +     if (usb_submit_urb(touchset->irq, GFP_ATOMIC))
>
> GFP_KERNEL
>
> > +             return -EIO;
> > +
> > +     return 0;
> > +}
> > +
> > +static void touchset_close(struct input_dev *input)
> > +{
> > +     struct touchset_usb *touchset = input->private;
> > +
> > +     usb_kill_urb(touchset->irq);
> > +}
> > +
> > +static int touchset_alloc_buffers(struct usb_device *udev,
> > +                               struct touchset_usb *touchset)
> > +{
> > +     touchset->data = usb_buffer_alloc(udev, TOUCHSET_REPORT_DATA_SIZE,
> > +                                       SLAB_ATOMIC, &touchset->data_dma);
>
> SLAB_KERNEL
>
>         Regards
>                 Oliver
>


--
L.G, Life is Good~
