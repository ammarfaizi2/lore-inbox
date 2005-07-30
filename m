Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262982AbVG3PP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbVG3PP5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 11:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbVG3PP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 11:15:57 -0400
Received: from 69.36.162.216.west-datacenter.net ([69.36.162.216]:33492 "EHLO
	schau.com") by vger.kernel.org with ESMTP id S262982AbVG3PPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 11:15:54 -0400
Message-ID: <42EB99D6.1020907@schau.com>
Date: Sat, 30 Jul 2005 17:16:38 +0200
From: Brian Schau <brian@schau.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wireless Security Lock driver.
References: <42EB940E.5000008@schau.com> <42EB9650.8010305@m1k.net>
In-Reply-To: <42EB9650.8010305@m1k.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael (and others),


Thanks for the info.   Well, the reason why I didn't inline the patch
was due to the size of it - in terms of lines.   However, here it is:



diff -urN linux-2.6.13-rc4.orig/drivers/usb/Makefile 
linux-2.6.13-rc4/drivers/usb/Makefile
--- linux-2.6.13-rc4.orig/drivers/usb/Makefile	2005-07-29 
00:44:44.000000000 +0200
+++ linux-2.6.13-rc4/drivers/usb/Makefile	2005-07-29 23:21:26.000000000 
+0200
@@ -34,6 +34,7 @@
  obj-$(CONFIG_USB_WACOM)		+= input/
  obj-$(CONFIG_USB_ACECAD)	+= input/
  obj-$(CONFIG_USB_XPAD)		+= input/
+obj-$(CONFIG_USB_WSL)		+= input/

  obj-$(CONFIG_USB_DABUSB)	+= media/
  obj-$(CONFIG_USB_DSBR)		+= media/
diff -urN linux-2.6.13-rc4.orig/drivers/usb/input/Kconfig 
linux-2.6.13-rc4/drivers/usb/input/Kconfig
--- linux-2.6.13-rc4.orig/drivers/usb/input/Kconfig	2005-07-29 
00:44:44.000000000 +0200
+++ linux-2.6.13-rc4/drivers/usb/input/Kconfig	2005-07-29 
23:23:59.000000000 +0200
@@ -272,3 +272,13 @@

  	  To compile this driver as a module, choose M here: the module will
  	  be called keyspan_remote.
+
+config USB_WSL
+	tristate "Wireless Security lock"
+	depends on USB && INPUT
+	---help---
+	  Say Y here if you want support for Wireless Security Locks (WSLs)
+	  based on the Cypress Ultra Mouse controller.
+
+	  See <http://www.schau.com/l/wsl/> for more information and
+ 	  "how to use it".
diff -urN linux-2.6.13-rc4.orig/drivers/usb/input/Makefile 
linux-2.6.13-rc4/drivers/usb/input/Makefile
--- linux-2.6.13-rc4.orig/drivers/usb/input/Makefile	2005-07-29 
00:44:44.000000000 +0200
+++ linux-2.6.13-rc4/drivers/usb/input/Makefile	2005-07-29 
23:21:26.000000000 +0200
@@ -40,3 +40,4 @@
  obj-$(CONFIG_USB_WACOM)		+= wacom.o
  obj-$(CONFIG_USB_ACECAD)	+= acecad.o
  obj-$(CONFIG_USB_XPAD)		+= xpad.o
+obj-$(CONFIG_USB_WSL)		+= wsl.o
diff -urN linux-2.6.13-rc4.orig/drivers/usb/input/hid-core.c 
linux-2.6.13-rc4/drivers/usb/input/hid-core.c
--- linux-2.6.13-rc4.orig/drivers/usb/input/hid-core.c	2005-07-29 
00:44:44.000000000 +0200
+++ linux-2.6.13-rc4/drivers/usb/input/hid-core.c	2005-07-29 
23:21:19.000000000 +0200
@@ -1375,6 +1375,7 @@
  #define USB_VENDOR_ID_CYPRESS		0x04b4
  #define USB_DEVICE_ID_CYPRESS_MOUSE	0x0001
  #define USB_DEVICE_ID_CYPRESS_HIDCOM	0x5500
+#define USB_DEVICE_ID_CYPRES_ULTRAMOUSE	0x7417

  #define USB_VENDOR_ID_BERKSHIRE		0x0c98
  #define USB_DEVICE_ID_BERKSHIRE_PCWD	0x1140
@@ -1465,6 +1466,7 @@
  	{ USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW48, 
HID_QUIRK_IGNORE },
  	{ USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW28, 
HID_QUIRK_IGNORE },
  	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_HIDCOM, 
HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRES_ULTRAMOUSE, 
HID_QUIRK_IGNORE },
  	{ USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EARTHMATE, 
HID_QUIRK_IGNORE },
  	{ USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20, 
HID_QUIRK_IGNORE },
  	{ USB_VENDOR_ID_ESSENTIAL_REALITY, 
USB_DEVICE_ID_ESSENTIAL_REALITY_P5, HID_QUIRK_IGNORE },
diff -urN linux-2.6.13-rc4.orig/drivers/usb/input/wsl.c 
linux-2.6.13-rc4/drivers/usb/input/wsl.c
--- linux-2.6.13-rc4.orig/drivers/usb/input/wsl.c	1970-01-01 
01:00:00.000000000 +0100
+++ linux-2.6.13-rc4/drivers/usb/input/wsl.c	2005-07-29 
23:21:26.000000000 +0200
@@ -0,0 +1,224 @@
+/*
+ * wsl - Wireless Security Lock driver.
+ *
+ * Copyright (c) 2005 Brian Schau <brian@schau.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * This driver is based on:
+ *  - information from:
+ *        http://www.technocage.com/~caskey/usb-lock/
+ *        http://blogs.patchadvisor.com/bryan/archive/2004/12/29/741.aspx
+ *        http://www.qbik.ch/usb/devices/showdev.php?id=3095
+ *  - the xpad driver
+ *
+ * History:
+ *
+ * 2005-07-23 - 0.1 : first version
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/input.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/smp_lock.h>
+#include <linux/usb.h>
+
+#define DRIVER_VERSION "v0.1"
+#define DRIVER_SHORT "wsl"
+#define DRIVER_AUTHOR "Brian Schau <brian@schau.com>"
+#define DRIVER_DESC "wsl - Wireless Security Lock driver"
+
+#define WSL_PKT_LEN 4
+
+static struct usb_device_id wsl_table [] = {
+	{ USB_DEVICE(0x04b4, 0x7417) },		/* Cypress Ultra Mouse ID */
+	{ }
+};
+
+MODULE_DEVICE_TABLE (usb, wsl_table);
+
+struct usb_wsl {
+	struct input_dev dev;		/* input device interface */
+	struct usb_device *udev;	/* usb device */
+	struct urb *irq_in;		/* urb for interrupt in report */
+	unsigned char *data;		/* input data */
+	dma_addr_t data_dma;
+	char phys[65];			/* physical device path */
+	int open_count;			/* reference count */
+};
+
+static void wsl_irq_in(struct urb *urb, struct pt_regs *regs)
+{
+	struct usb_wsl *wsl=urb->context;
+	int id=0, retval;
+	
+	switch (urb->status) {
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		/* this urb is terminated, clean up */
+		dbg("%s - urb shutting down with status: %d", __FUNCTION__, urb->status);
+		return;
+	case 0:
+		input_regs(&wsl->dev, regs);
+
+		id=wsl->data[1]<<8;
+		id|=wsl->data[2];
+
+		input_event(&wsl->dev, EV_MSC, MSC_SERIAL, id);
+		break;
+	default:
+		dbg("%s - nonzero urb status received: %d", __FUNCTION__, urb->status);
+		break;
+	}
+
+	if ((retval=usb_submit_urb(urb, GFP_ATOMIC)))
+		err("%s - usb_submit_urb failed with result %d", __FUNCTION__, retval);
+}
+
+static int wsl_open(struct input_dev *dev)
+{
+	struct usb_wsl *wsl=dev->private;
+	
+	if (wsl->open_count++)
+		return 0;
+	
+	wsl->irq_in->dev=wsl->udev;
+	if (usb_submit_urb(wsl->irq_in, GFP_KERNEL)) {
+		wsl->open_count--;
+		return -EIO;
+	}
+	
+	return 0;
+}
+
+static void wsl_close(struct input_dev *dev)
+{
+	struct usb_wsl *wsl=dev->private;
+	
+	if (!--wsl->open_count)
+		usb_kill_urb(wsl->irq_in);
+}
+
+static int wsl_probe(struct usb_interface *intf, const struct 
usb_device_id *id)
+{
+	struct usb_device *udev=interface_to_usbdev (intf);
+	struct usb_wsl *wsl=NULL;
+	struct usb_endpoint_descriptor *ep_irq_in;
+	char path[64];
+	int i;
+	
+	for (i=0; wsl_table[i].idVendor; i++) {
+		if ((le16_to_cpu(udev->descriptor.idVendor) == wsl_table[i].idVendor) &&
+		    (le16_to_cpu(udev->descriptor.idProduct) == wsl_table[i].idProduct))
+			break;
+	}
+
+	if (!wsl_table[i].idVendor)
+		return -ENODEV;
+	
+	if ((wsl=kmalloc(sizeof(struct usb_wsl), GFP_KERNEL))==NULL) {
+		err("cannot allocate memory for lock");
+		return -ENOMEM;
+	}
+	memset(wsl, 0, sizeof(struct usb_wsl));
+	
+	if ((wsl->data=usb_buffer_alloc(udev, WSL_PKT_LEN, SLAB_ATOMIC, 
&wsl->data_dma))==NULL) {
+		kfree(wsl);
+		return -ENOMEM;
+	}
+
+	if ((wsl->irq_in=usb_alloc_urb(0, GFP_KERNEL))==NULL) {
+		err("cannot allocate memory for new lock irq urb");
+		usb_buffer_free(udev, WSL_PKT_LEN, wsl->data, wsl->data_dma);
+                kfree(wsl);
+		return -ENOMEM;
+        }
+	
+	ep_irq_in=&intf->cur_altsetting->endpoint[0].desc;
+	
+	usb_fill_int_urb(wsl->irq_in, udev, usb_rcvintpipe(udev, 
ep_irq_in->bEndpointAddress), wsl->data, WSL_PKT_LEN, wsl_irq_in, wsl, 
ep_irq_in->bInterval);
+	wsl->irq_in->transfer_dma=wsl->data_dma;
+	wsl->irq_in->transfer_flags|=URB_NO_TRANSFER_DMA_MAP;
+	
+	wsl->udev=udev;
+	
+	wsl->dev.id.bustype=BUS_USB;
+	wsl->dev.id.vendor=le16_to_cpu(udev->descriptor.idVendor);
+	wsl->dev.id.product=le16_to_cpu(udev->descriptor.idProduct);
+	wsl->dev.id.version=le16_to_cpu(udev->descriptor.bcdDevice);
+	wsl->dev.dev=&intf->dev;
+	wsl->dev.private=wsl;
+	wsl->dev.name="Wireless Security Lock";
+	wsl->dev.phys=wsl->phys;
+	wsl->dev.open=wsl_open;
+	wsl->dev.close=wsl_close;
+	
+	usb_make_path(udev, path, 64);
+	snprintf(wsl->phys, 64,  "%s/wsl", path);
+
+	wsl->dev.evbit[0]=BIT(EV_MSC)|BIT(EV_REP);
+	set_bit(MSC_SERIAL, wsl->dev.mscbit);
+	input_register_device(&wsl->dev);
+	
+	usb_set_intfdata(intf, wsl);
+	return 0;
+}
+
+static void wsl_disconnect(struct usb_interface *intf)
+{
+	struct usb_wsl *wsl=usb_get_intfdata (intf);
+	
+	usb_set_intfdata(intf, NULL);
+	if (wsl) {
+		usb_kill_urb(wsl->irq_in);
+		input_unregister_device(&wsl->dev);
+		usb_free_urb(wsl->irq_in);
+		usb_buffer_free(interface_to_usbdev(intf), WSL_PKT_LEN, wsl->data, 
wsl->data_dma);
+		kfree(wsl);
+	}
+}
+
+static struct usb_driver wsl_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "wsl",
+	.probe		= wsl_probe,
+	.disconnect	= wsl_disconnect,
+	.id_table	= wsl_table,
+};
+
+static int __init usb_wsl_init(void)
+{
+	int result=usb_register(&wsl_driver);
+
+	if (result==0)
+		info(DRIVER_DESC ":" DRIVER_VERSION);
+
+	return result;
+}
+
+static void __exit usb_wsl_exit(void)
+{
+	usb_deregister(&wsl_driver);
+}
+
+module_init(usb_wsl_init);
+module_exit(usb_wsl_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");


