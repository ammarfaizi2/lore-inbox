Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbTD3WXk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 18:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTD3WXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 18:23:40 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:41909 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S262481AbTD3WXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 18:23:38 -0400
Subject: Re: 2.5.68-bk10 drivers/bluetooth/hci_usb.c:461: `USB_ZERO_PACKET'
	undeclared
From: Marcel Holtmann <marcel@holtmann.org>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1051741247.4565.1.camel@flat41>
References: <1051741247.4565.1.camel@flat41>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 01 May 2003 00:35:24 +0200
Message-Id: <1051742130.1594.50.camel@pegasus.local>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grzegorz,

> drivers/bluetooth/hci_usb.c: In function `hci_usb_send_bulk':
> drivers/bluetooth/hci_usb.c:461: `USB_ZERO_PACKET' undeclared (first use
> in this function)
> drivers/bluetooth/hci_usb.c:461: (Each undeclared identifier is reported
> only once
> drivers/bluetooth/hci_usb.c:461: for each function it appears in.)
> make[2]: *** [drivers/bluetooth/hci_usb.o] Error 1
> make[1]: *** [drivers/bluetooth] Error 2
> make: *** [drivers] Error 2
> 
> probably #define USB_ZERO_PACKET should help, but i am not convinent.

I have fixed this problem in my repository. You can use the patch below.

Regards

Marcel


diff -Nru a/drivers/bluetooth/hci_usb.c b/drivers/bluetooth/hci_usb.c
--- a/drivers/bluetooth/hci_usb.c       Thu May  1 00:32:06 2003
+++ b/drivers/bluetooth/hci_usb.c       Thu May  1 00:32:06 2003
@@ -64,8 +64,8 @@
 #endif
 
 #ifndef CONFIG_BT_USB_ZERO_PACKET
-#undef  USB_ZERO_PACKET
-#define USB_ZERO_PACKET 0
+#undef  URB_ZERO_PACKET
+#define URB_ZERO_PACKET 0
 #endif
 
 static struct usb_driver hci_usb_driver; 
@@ -458,7 +458,7 @@
        pipe = usb_sndbulkpipe(husb->udev, husb->bulk_out_ep->desc.bEndpointAddress);
        usb_fill_bulk_urb(urb, husb->udev, pipe, skb->data, skb->len, 
                        hci_usb_tx_complete, husb);
-       urb->transfer_flags = USB_ZERO_PACKET;
+       urb->transfer_flags = URB_ZERO_PACKET;
 
        BT_DBG("%s skb %p len %d", husb->hdev.name, skb, skb->len);
 


