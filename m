Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbUKFUTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbUKFUTS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 15:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUKFUTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 15:19:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18445 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261463AbUKFURI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 15:17:08 -0500
Date: Sat, 6 Nov 2004 21:16:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: marcel@holtmann.org, maxk@qualcomm.com
Cc: bluez-devel@lists.sf.net, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-net@vger.kernel.org
Subject: [2.6 patch] drivers/bluetooth/: make some functions static
Message-ID: <20041106201630.GN1295@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global functions under 
drivers/bluetooth/ static.


diffstat output:
 drivers/bluetooth/bluecard_cs.c |   26 ++++++++++++------------
 drivers/bluetooth/bt3c_cs.c     |   34 ++++++++++++++++----------------
 drivers/bluetooth/btuart_cs.c   |   24 +++++++++++-----------
 drivers/bluetooth/dtl1_cs.c     |   24 +++++++++++-----------
 drivers/bluetooth/hci_usb.c     |    6 ++---
 drivers/bluetooth/hci_usb.h     |    4 ---
 drivers/bluetooth/hci_vhci.c    |    4 +--


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/bluetooth/bluecard_cs.c.old	2004-11-06 20:42:56.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/bluetooth/bluecard_cs.c	2004-11-06 20:45:10.000000000 +0100
@@ -92,14 +92,14 @@
 } bluecard_info_t;
 
 
-void bluecard_config(dev_link_t *link);
-void bluecard_release(dev_link_t *link);
-int bluecard_event(event_t event, int priority, event_callback_args_t *args);
+static void bluecard_config(dev_link_t *link);
+static void bluecard_release(dev_link_t *link);
+static int bluecard_event(event_t event, int priority, event_callback_args_t *args);
 
 static dev_info_t dev_info = "bluecard_cs";
 
-dev_link_t *bluecard_attach(void);
-void bluecard_detach(dev_link_t *);
+static dev_link_t *bluecard_attach(void);
+static void bluecard_detach(dev_link_t *);
 
 static dev_link_t *dev_list = NULL;
 
@@ -172,7 +172,7 @@
 /* ======================== LED handling routines ======================== */
 
 
-void bluecard_activity_led_timeout(u_long arg)
+static void bluecard_activity_led_timeout(u_long arg)
 {
 	bluecard_info_t *info = (bluecard_info_t *)arg;
 	unsigned int iobase = info->link.io.BasePort1;
@@ -721,7 +721,7 @@
 /* ======================== Card services HCI interaction ======================== */
 
 
-int bluecard_open(bluecard_info_t *info)
+static int bluecard_open(bluecard_info_t *info)
 {
 	unsigned int iobase = info->link.io.BasePort1;
 	struct hci_dev *hdev;
@@ -839,7 +839,7 @@
 }
 
 
-int bluecard_close(bluecard_info_t *info)
+static int bluecard_close(bluecard_info_t *info)
 {
 	unsigned int iobase = info->link.io.BasePort1;
 	struct hci_dev *hdev = info->hdev;
@@ -866,7 +866,7 @@
 	return 0;
 }
 
-dev_link_t *bluecard_attach(void)
+static dev_link_t *bluecard_attach(void)
 {
 	bluecard_info_t *info;
 	client_reg_t client_reg;
@@ -924,7 +924,7 @@
 }
 
 
-void bluecard_detach(dev_link_t *link)
+static void bluecard_detach(dev_link_t *link)
 {
 	bluecard_info_t *info = link->priv;
 	dev_link_t **linkp;
@@ -969,7 +969,7 @@
 	return pcmcia_parse_tuple(handle, tuple, parse);
 }
 
-void bluecard_config(dev_link_t *link)
+static void bluecard_config(dev_link_t *link)
 {
 	client_handle_t handle = link->handle;
 	bluecard_info_t *info = link->priv;
@@ -1044,7 +1044,7 @@
 }
 
 
-void bluecard_release(dev_link_t *link)
+static void bluecard_release(dev_link_t *link)
 {
 	bluecard_info_t *info = link->priv;
 
@@ -1063,7 +1063,7 @@
 }
 
 
-int bluecard_event(event_t event, int priority, event_callback_args_t *args)
+static int bluecard_event(event_t event, int priority, event_callback_args_t *args)
 {
 	dev_link_t *link = args->client_data;
 	bluecard_info_t *info = link->priv;
--- linux-2.6.10-rc1-mm3-full/drivers/bluetooth/bt3c_cs.c.old	2004-11-06 20:45:17.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/bluetooth/bt3c_cs.c	2004-11-06 20:48:29.000000000 +0100
@@ -96,14 +96,14 @@
 } bt3c_info_t;
 
 
-void bt3c_config(dev_link_t *link);
-void bt3c_release(dev_link_t *link);
-int bt3c_event(event_t event, int priority, event_callback_args_t *args);
+static void bt3c_config(dev_link_t *link);
+static void bt3c_release(dev_link_t *link);
+static int bt3c_event(event_t event, int priority, event_callback_args_t *args);
 
 static dev_info_t dev_info = "bt3c_cs";
 
-dev_link_t *bt3c_attach(void);
-void bt3c_detach(dev_link_t *);
+static dev_link_t *bt3c_attach(void);
+static void bt3c_detach(dev_link_t *);
 
 static dev_link_t *dev_list = NULL;
 
@@ -132,28 +132,28 @@
 #define CONTROL  4
 
 
-inline void bt3c_address(unsigned int iobase, unsigned short addr)
+static inline void bt3c_address(unsigned int iobase, unsigned short addr)
 {
 	outb(addr & 0xff, iobase + ADDR_L);
 	outb((addr >> 8) & 0xff, iobase + ADDR_H);
 }
 
 
-inline void bt3c_put(unsigned int iobase, unsigned short value)
+static inline void bt3c_put(unsigned int iobase, unsigned short value)
 {
 	outb(value & 0xff, iobase + DATA_L);
 	outb((value >> 8) & 0xff, iobase + DATA_H);
 }
 
 
-inline void bt3c_io_write(unsigned int iobase, unsigned short addr, unsigned short value)
+static inline void bt3c_io_write(unsigned int iobase, unsigned short addr, unsigned short value)
 {
 	bt3c_address(iobase, addr);
 	bt3c_put(iobase, value);
 }
 
 
-inline unsigned short bt3c_get(unsigned int iobase)
+static inline unsigned short bt3c_get(unsigned int iobase)
 {
 	unsigned short value = inb(iobase + DATA_L);
 
@@ -163,7 +163,7 @@
 }
 
 
-inline unsigned short bt3c_read(unsigned int iobase, unsigned short addr)
+static inline unsigned short bt3c_read(unsigned int iobase, unsigned short addr)
 {
 	bt3c_address(iobase, addr);
 
@@ -587,7 +587,7 @@
 }
 
 
-int bt3c_open(bt3c_info_t *info)
+static int bt3c_open(bt3c_info_t *info)
 {
 	const struct firmware *firmware;
 	struct hci_dev *hdev;
@@ -657,7 +657,7 @@
 }
 
 
-int bt3c_close(bt3c_info_t *info)
+static int bt3c_close(bt3c_info_t *info)
 {
 	struct hci_dev *hdev = info->hdev;
 
@@ -674,7 +674,7 @@
 	return 0;
 }
 
-dev_link_t *bt3c_attach(void)
+static dev_link_t *bt3c_attach(void)
 {
 	bt3c_info_t *info;
 	client_reg_t client_reg;
@@ -732,7 +732,7 @@
 }
 
 
-void bt3c_detach(dev_link_t *link)
+static void bt3c_detach(dev_link_t *link)
 {
 	bt3c_info_t *info = link->priv;
 	dev_link_t **linkp;
@@ -786,7 +786,7 @@
 	return get_tuple(handle, tuple, parse);
 }
 
-void bt3c_config(dev_link_t *link)
+static void bt3c_config(dev_link_t *link)
 {
 	static ioaddr_t base[5] = { 0x3f8, 0x2f8, 0x3e8, 0x2e8, 0x0 };
 	client_handle_t handle = link->handle;
@@ -899,7 +899,7 @@
 }
 
 
-void bt3c_release(dev_link_t *link)
+static void bt3c_release(dev_link_t *link)
 {
 	bt3c_info_t *info = link->priv;
 
@@ -916,7 +916,7 @@
 }
 
 
-int bt3c_event(event_t event, int priority, event_callback_args_t *args)
+static int bt3c_event(event_t event, int priority, event_callback_args_t *args)
 {
 	dev_link_t *link = args->client_data;
 	bt3c_info_t *info = link->priv;
--- linux-2.6.10-rc1-mm3-full/drivers/bluetooth/btuart_cs.c.old	2004-11-06 20:48:45.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/bluetooth/btuart_cs.c	2004-11-06 20:50:17.000000000 +0100
@@ -92,14 +92,14 @@
 } btuart_info_t;
 
 
-void btuart_config(dev_link_t *link);
-void btuart_release(dev_link_t *link);
-int btuart_event(event_t event, int priority, event_callback_args_t *args);
+static void btuart_config(dev_link_t *link);
+static void btuart_release(dev_link_t *link);
+static int btuart_event(event_t event, int priority, event_callback_args_t *args);
 
 static dev_info_t dev_info = "btuart_cs";
 
-dev_link_t *btuart_attach(void);
-void btuart_detach(dev_link_t *);
+static dev_link_t *btuart_attach(void);
+static void btuart_detach(dev_link_t *);
 
 static dev_link_t *dev_list = NULL;
 
@@ -492,7 +492,7 @@
 /* ======================== Card services HCI interaction ======================== */
 
 
-int btuart_open(btuart_info_t *info)
+static int btuart_open(btuart_info_t *info)
 {
 	unsigned long flags;
 	unsigned int iobase = info->link.io.BasePort1;
@@ -561,7 +561,7 @@
 }
 
 
-int btuart_close(btuart_info_t *info)
+static int btuart_close(btuart_info_t *info)
 {
 	unsigned long flags;
 	unsigned int iobase = info->link.io.BasePort1;
@@ -590,7 +590,7 @@
 	return 0;
 }
 
-dev_link_t *btuart_attach(void)
+static dev_link_t *btuart_attach(void)
 {
 	btuart_info_t *info;
 	client_reg_t client_reg;
@@ -648,7 +648,7 @@
 }
 
 
-void btuart_detach(dev_link_t *link)
+static void btuart_detach(dev_link_t *link)
 {
 	btuart_info_t *info = link->priv;
 	dev_link_t **linkp;
@@ -702,7 +702,7 @@
 	return get_tuple(handle, tuple, parse);
 }
 
-void btuart_config(dev_link_t *link)
+static void btuart_config(dev_link_t *link)
 {
 	static ioaddr_t base[5] = { 0x3f8, 0x2f8, 0x3e8, 0x2e8, 0x0 };
 	client_handle_t handle = link->handle;
@@ -816,7 +816,7 @@
 }
 
 
-void btuart_release(dev_link_t *link)
+static void btuart_release(dev_link_t *link)
 {
 	btuart_info_t *info = link->priv;
 
@@ -833,7 +833,7 @@
 }
 
 
-int btuart_event(event_t event, int priority, event_callback_args_t *args)
+static int btuart_event(event_t event, int priority, event_callback_args_t *args)
 {
 	dev_link_t *link = args->client_data;
 	btuart_info_t *info = link->priv;
--- linux-2.6.10-rc1-mm3-full/drivers/bluetooth/dtl1_cs.c.old	2004-11-06 20:50:30.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/bluetooth/dtl1_cs.c	2004-11-06 20:51:59.000000000 +0100
@@ -95,14 +95,14 @@
 } dtl1_info_t;
 
 
-void dtl1_config(dev_link_t *link);
-void dtl1_release(dev_link_t *link);
-int dtl1_event(event_t event, int priority, event_callback_args_t *args);
+static void dtl1_config(dev_link_t *link);
+static void dtl1_release(dev_link_t *link);
+static int dtl1_event(event_t event, int priority, event_callback_args_t *args);
 
 static dev_info_t dev_info = "dtl1_cs";
 
-dev_link_t *dtl1_attach(void);
-void dtl1_detach(dev_link_t *);
+static dev_link_t *dtl1_attach(void);
+static void dtl1_detach(dev_link_t *);
 
 static dev_link_t *dev_list = NULL;
 
@@ -469,7 +469,7 @@
 /* ======================== Card services HCI interaction ======================== */
 
 
-int dtl1_open(dtl1_info_t *info)
+static int dtl1_open(dtl1_info_t *info)
 {
 	unsigned long flags;
 	unsigned int iobase = info->link.io.BasePort1;
@@ -540,7 +540,7 @@
 }
 
 
-int dtl1_close(dtl1_info_t *info)
+static int dtl1_close(dtl1_info_t *info)
 {
 	unsigned long flags;
 	unsigned int iobase = info->link.io.BasePort1;
@@ -569,7 +569,7 @@
 	return 0;
 }
 
-dev_link_t *dtl1_attach(void)
+static dev_link_t *dtl1_attach(void)
 {
 	dtl1_info_t *info;
 	client_reg_t client_reg;
@@ -627,7 +627,7 @@
 }
 
 
-void dtl1_detach(dev_link_t *link)
+static void dtl1_detach(dev_link_t *link)
 {
 	dtl1_info_t *info = link->priv;
 	dev_link_t **linkp;
@@ -681,7 +681,7 @@
 	return get_tuple(handle, tuple, parse);
 }
 
-void dtl1_config(dev_link_t *link)
+static void dtl1_config(dev_link_t *link)
 {
 	client_handle_t handle = link->handle;
 	dtl1_info_t *info = link->priv;
@@ -768,7 +768,7 @@
 }
 
 
-void dtl1_release(dev_link_t *link)
+static void dtl1_release(dev_link_t *link)
 {
 	dtl1_info_t *info = link->priv;
 
@@ -785,7 +785,7 @@
 }
 
 
-int dtl1_event(event_t event, int priority, event_callback_args_t *args)
+static int dtl1_event(event_t event, int priority, event_callback_args_t *args)
 {
 	dev_link_t *link = args->client_data;
 	dtl1_info_t *info = link->priv;
--- linux-2.6.10-rc1-mm3-full/drivers/bluetooth/hci_usb.h.old	2004-11-06 20:55:37.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/bluetooth/hci_usb.h	2004-11-06 20:55:59.000000000 +0100
@@ -56,8 +56,6 @@
 	struct urb        urb;
 };
 
-struct _urb *_urb_alloc(int isoc, int gfp);
-
 static inline void _urb_free(struct _urb *_urb)
 {
 	kfree(_urb);
@@ -96,8 +94,6 @@
 	}
 }
 
-struct _urb *_urb_dequeue(struct _urb_queue *q);
-
 struct hci_usb {
 	struct hci_dev		*hdev;
 
--- linux-2.6.10-rc1-mm3-full/drivers/bluetooth/hci_usb.c.old	2004-11-06 20:52:06.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/bluetooth/hci_usb.c	2004-11-06 20:52:46.000000000 +0100
@@ -120,7 +120,7 @@
 	{ }	/* Terminating entry */
 };
 
-struct _urb *_urb_alloc(int isoc, int gfp)
+static struct _urb *_urb_alloc(int isoc, int gfp)
 {
 	struct _urb *_urb = kmalloc(sizeof(struct _urb) +
 				sizeof(struct usb_iso_packet_descriptor) * isoc, gfp);
@@ -131,7 +131,7 @@
 	return _urb;
 }
 
-struct _urb *_urb_dequeue(struct _urb_queue *q)
+static struct _urb *_urb_dequeue(struct _urb_queue *q)
 {
 	struct _urb *_urb = NULL;
 	unsigned long flags;
@@ -805,7 +805,7 @@
 	BT_DBG("%s evt %d", hdev->name, evt);
 }
 
-int hci_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
+static int hci_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct usb_host_endpoint *bulk_out_ep = NULL;
--- linux-2.6.10-rc1-mm3-full/drivers/bluetooth/hci_vhci.c.old	2004-11-06 20:53:01.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/bluetooth/hci_vhci.c	2004-11-06 20:53:20.000000000 +0100
@@ -338,7 +338,7 @@
         &hci_vhci_fops
 };
 
-int __init hci_vhci_init(void)
+static int __init hci_vhci_init(void)
 {
 	BT_INFO("VHCI driver ver %s", VERSION);
 
@@ -350,7 +350,7 @@
 	return 0;
 }
 
-void hci_vhci_cleanup(void)
+static void hci_vhci_cleanup(void)
 {
 	misc_deregister(&hci_vhci_miscdev);
 }

