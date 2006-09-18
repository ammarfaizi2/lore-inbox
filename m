Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965193AbWIRAy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbWIRAy7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 20:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbWIRAyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 20:54:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:2839 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965193AbWIRAy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 20:54:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ow7KlRScWDchua/yJkNXFfs2THvtmjgmqfONdqTMlz4onvHtNIABbqqJn23XbvqalpwTLaGh/lczCbhT72/kSqB6o65+S/fiR9EJF/RWb9dETx5i/pf233EaBlIfn8IxSiQKyGyx1PxEQcPcjccZgIabttXNJhowlmOIozb0udc=
Message-ID: <6b4e42d10609171754q7c7335f9pfab703d6b746236b@mail.gmail.com>
Date: Sun, 17 Sep 2006 17:54:25 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       bluez-devel@lists.sourceforge.net
Subject: bluetooth drivers : kmalloc to kzalloc conversion
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tested by compiling with $make allmodconfig; make

Signed off by Om Narasimhan <om.turyx@gmail.com>

 drivers/bluetooth/bfusb.c   |    2 +-
 drivers/bluetooth/hci_usb.c |   11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 23f9621..9772d8c 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -588,7 +588,7 @@ static int bfusb_load_firmware(struct bf

 	bfusb->udev->toggle[0] = bfusb->udev->toggle[1] = 0;

-	buf = kmalloc(BFUSB_MAX_BLOCK_SIZE + 3, GFP_ATOMIC);
+	buf = kzalloc(BFUSB_MAX_BLOCK_SIZE + 3, GFP_ATOMIC);
 	if (!buf) {
 		BT_ERR("Can't allocate memory chunk for firmware");
 		return -ENOMEM;
diff --git a/drivers/bluetooth/hci_usb.c b/drivers/bluetooth/hci_usb.c
index e2d4bea..2274248 100644
--- a/drivers/bluetooth/hci_usb.c
+++ b/drivers/bluetooth/hci_usb.c
@@ -147,10 +147,9 @@ static struct usb_device_id blacklist_id

 static struct _urb *_urb_alloc(int isoc, gfp_t gfp)
 {
-	struct _urb *_urb = kmalloc(sizeof(struct _urb) +
+	struct _urb *_urb = kzalloc(sizeof(struct _urb) +
 				sizeof(struct usb_iso_packet_descriptor) * isoc, gfp);
 	if (_urb) {
-		memset(_urb, 0, sizeof(*_urb));
 		usb_init_urb(&_urb->urb);
 	}
 	return _urb;
@@ -220,7 +219,7 @@ static int hci_usb_intr_rx_submit(struct

 	size = le16_to_cpu(husb->intr_in_ep->desc.wMaxPacketSize);

-	buf = kmalloc(size, GFP_ATOMIC);
+	buf = kzalloc(size, GFP_ATOMIC);
 	if (!buf)
 		return -ENOMEM;

@@ -255,7 +254,7 @@ static int hci_usb_bulk_rx_submit(struct
 	int err, pipe, size = HCI_MAX_FRAME_SIZE;
 	void *buf;

-	buf = kmalloc(size, GFP_ATOMIC);
+	buf = kzalloc(size, GFP_ATOMIC);
 	if (!buf)
 		return -ENOMEM;

@@ -296,7 +295,7 @@ static int hci_usb_isoc_rx_submit(struct
 	mtu  = le16_to_cpu(husb->isoc_in_ep->desc.wMaxPacketSize);
 	size = mtu * HCI_MAX_ISOC_FRAMES;

-	buf = kmalloc(size, GFP_ATOMIC);
+	buf = kzalloc(size, GFP_ATOMIC);
 	if (!buf)
 		return -ENOMEM;

@@ -471,7 +470,7 @@ static inline int hci_usb_send_ctrl(stru
 			return -ENOMEM;
 		_urb->type = bt_cb(skb)->pkt_type;

-		dr = kmalloc(sizeof(*dr), GFP_ATOMIC);
+		dr = kzalloc(sizeof(*dr), GFP_ATOMIC);
 		if (!dr) {
 			_urb_free(_urb);
 			return -ENOMEM;
