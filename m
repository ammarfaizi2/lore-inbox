Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbVJKXEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbVJKXEM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 19:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVJKXEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 19:04:12 -0400
Received: from sccrmhc11.comcast.net ([63.240.76.21]:18851 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751271AbVJKXEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 19:04:10 -0400
Date: Tue, 11 Oct 2005 16:04:40 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [BLUETOOTH] kmalloc + memset -> kzalloc conversion
Message-ID: <20051011230440.GA26330@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20051001065121.GC25424@plexity.net> <20051011151805.0d32c840.akpm@osdl.org> <1129071122.6487.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129071122.6487.6.camel@localhost.localdomain>
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 12 2005, at 00:52, Marcel Holtmann was caught saying:
> Hi Andrew,
> 
> > Confused.  This patch changes lots of block code, not bluetooth.
> 
> I know. This is what I already mailed Deepak, but he never replied.

Sorry, got lost in the mailbox. I think I was not paying attention to
my tab completion and included the wrong patch. Proper patch follows.

~Deepak

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/drivers/bluetooth/bcm203x.c b/drivers/bluetooth/bcm203x.c
--- a/drivers/bluetooth/bcm203x.c
+++ b/drivers/bluetooth/bcm203x.c
@@ -179,14 +179,12 @@ static int bcm203x_probe(struct usb_inte
 	if (ignore || (intf->cur_altsetting->desc.bInterfaceNumber != 0))
 		return -ENODEV;
 
-	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data) {
 		BT_ERR("Can't allocate memory for data structure");
 		return -ENOMEM;
 	}
 
-	memset(data, 0, sizeof(*data));
-
 	data->udev  = udev;
 	data->state = BCM203X_LOAD_MINIDRV;
 
diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -673,13 +673,11 @@ static int bfusb_probe(struct usb_interf
 	}
 
 	/* Initialize control structure and load firmware */
-	if (!(bfusb = kmalloc(sizeof(struct bfusb), GFP_KERNEL))) {
+	if (!(bfusb = kzalloc(sizeof(struct bfusb), GFP_KERNEL))) {
 		BT_ERR("Can't allocate memory for control structure");
 		goto done;
 	}
 
-	memset(bfusb, 0, sizeof(struct bfusb));
-
 	bfusb->udev = udev;
 	bfusb->bulk_in_ep    = bulk_in_ep->desc.bEndpointAddress;
 	bfusb->bulk_out_ep   = bulk_out_ep->desc.bEndpointAddress;
diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -870,10 +870,9 @@ static dev_link_t *bluecard_attach(void)
 	int ret;
 
 	/* Create new info device */
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return NULL;
-	memset(info, 0, sizeof(*info));
 
 	link = &info->link;
 	link->priv = info;
diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -550,14 +550,12 @@ static int bpa10x_probe(struct usb_inter
 	if (ignore)
 		return -ENODEV;
 
-	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data) {
 		BT_ERR("Can't allocate data structure");
 		return -ENOMEM;
 	}
 
-	memset(data, 0, sizeof(*data));
-
 	data->udev = udev;
 
 	rwlock_init(&data->lock);
diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -671,10 +671,9 @@ static dev_link_t *bt3c_attach(void)
 	int ret;
 
 	/* Create new info device */
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return NULL;
-	memset(info, 0, sizeof(*info));
 
 	link = &info->link;
 	link->priv = info;
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -590,10 +590,9 @@ static dev_link_t *btuart_attach(void)
 	int ret;
 
 	/* Create new info device */
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return NULL;
-	memset(info, 0, sizeof(*info));
 
 	link = &info->link;
 	link->priv = info;
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -569,10 +569,9 @@ static dev_link_t *dtl1_attach(void)
 	int ret;
 
 	/* Create new info device */
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return NULL;
-	memset(info, 0, sizeof(*info));
 
 	link = &info->link;
 	link->priv = info;
diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -682,10 +682,9 @@ static int bcsp_open(struct hci_uart *hu
 
 	BT_DBG("hu %p", hu);
 
-	bcsp = kmalloc(sizeof(*bcsp), GFP_ATOMIC);
+	bcsp = kzalloc(sizeof(*bcsp), GFP_ATOMIC);
 	if (!bcsp)
 		return -ENOMEM;
-	memset(bcsp, 0, sizeof(*bcsp));
 
 	hu->priv = bcsp;
 	skb_queue_head_init(&bcsp->unack);
diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -66,10 +66,9 @@ static int h4_open(struct hci_uart *hu)
 	
 	BT_DBG("hu %p", hu);
 	
-	h4 = kmalloc(sizeof(*h4), GFP_ATOMIC);
+	h4 = kzalloc(sizeof(*h4), GFP_ATOMIC);
 	if (!h4)
 		return -ENOMEM;
-	memset(h4, 0, sizeof(*h4));
 
 	skb_queue_head_init(&h4->txq);
 
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -268,11 +268,10 @@ static int hci_uart_tty_open(struct tty_
 	if (hu)
 		return -EEXIST;
 
-	if (!(hu = kmalloc(sizeof(struct hci_uart), GFP_KERNEL))) {
+	if (!(hu = kzalloc(sizeof(struct hci_uart), GFP_KERNEL))) {
 		BT_ERR("Can't allocate controll structure");
 		return -ENFILE;
 	}
-	memset(hu, 0, sizeof(struct hci_uart));
 
 	tty->disc_data = hu;
 	hu->tty = tty;
diff --git a/drivers/bluetooth/hci_usb.c b/drivers/bluetooth/hci_usb.c
--- a/drivers/bluetooth/hci_usb.c
+++ b/drivers/bluetooth/hci_usb.c
@@ -134,10 +134,9 @@ static struct usb_device_id blacklist_id
 
 static struct _urb *_urb_alloc(int isoc, unsigned int __nocast gfp)
 {
-	struct _urb *_urb = kmalloc(sizeof(struct _urb) +
+	struct _urb *_urb = kzalloc(sizeof(struct _urb) +
 				sizeof(struct usb_iso_packet_descriptor) * isoc, gfp);
 	if (_urb) {
-		memset(_urb, 0, sizeof(*_urb));
 		usb_init_urb(&_urb->urb);
 	}
 	return _urb;
@@ -875,13 +874,11 @@ static int hci_usb_probe(struct usb_inte
 		goto done;
 	}
 
-	if (!(husb = kmalloc(sizeof(struct hci_usb), GFP_KERNEL))) {
+	if (!(husb = kzalloc(sizeof(struct hci_usb), GFP_KERNEL))) {
 		BT_ERR("Can't allocate: control structure");
 		goto done;
 	}
 
-	memset(husb, 0, sizeof(struct hci_usb));
-
 	husb->udev = udev;
 	husb->bulk_out_ep = bulk_out_ep;
 	husb->bulk_in_ep  = bulk_in_ep;
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -261,12 +261,10 @@ static int vhci_open(struct inode *inode
 	struct vhci_data *vhci;
 	struct hci_dev *hdev;
 
-	vhci = kmalloc(sizeof(struct vhci_data), GFP_KERNEL);
+	vhci = kzalloc(sizeof(struct vhci_data), GFP_KERNEL);
 	if (!vhci)
 		return -ENOMEM;
 
-	memset(vhci, 0, sizeof(struct vhci_data));
-
 	skb_queue_head_init(&vhci->readq);
 	init_waitqueue_head(&vhci->read_wait);
 


-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
