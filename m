Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTEEV70 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 17:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbTEEV70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 17:59:26 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:21257 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261411AbTEEV7Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 17:59:24 -0400
Date: Tue, 6 May 2003 00:02:46 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [COMPILATION ERROR] 2.5.69 drivers/bluetooth/hci_usb.c USB_ZERO_PACKET
Message-ID: <20030506000246.A28427@electric-eye.fr.zoreil.com>
References: <1052170326.11699.2.camel@nalesnik> <1052170720.11697.6.camel@nalesnik>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1052170720.11697.6.camel@nalesnik>; from gj@pointblue.com.pl on Mon, May 05, 2003 at 10:38:43PM +0100
X-Organisation: Hungry patch-scripts (c) users
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Jaskiewicz <gj@pointblue.com.pl> :
[...]
> If so, please give me some hints i will correct it my self :) 

If I remember M. KH's message of last week, it should be something like the
following patch. Now I can't remember who he told it should be sent to :o)

Typo: s/USB_ZERO_PACKET/URB_ZERO_PACKET/



 drivers/bluetooth/hci_usb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/bluetooth/hci_usb.c~typo-usb_zero_packet drivers/bluetooth/hci_usb.c
--- linux-2.5.69-1.1042.1.187-to-1.1063/drivers/bluetooth/hci_usb.c~typo-usb_zero_packet	Mon May  5 21:37:01 2003
+++ linux-2.5.69-1.1042.1.187-to-1.1063-fr/drivers/bluetooth/hci_usb.c	Mon May  5 21:37:01 2003
@@ -64,8 +64,8 @@
 #endif
 
 #ifndef CONFIG_BT_USB_ZERO_PACKET
-#undef  USB_ZERO_PACKET
-#define USB_ZERO_PACKET 0
+#undef  URB_ZERO_PACKET
+#define URB_ZERO_PACKET 0
 #endif
 
 static struct usb_driver hci_usb_driver; 
@@ -458,7 +458,7 @@ static inline int hci_usb_send_bulk(stru
 	pipe = usb_sndbulkpipe(husb->udev, husb->bulk_out_ep->desc.bEndpointAddress);
 	usb_fill_bulk_urb(urb, husb->udev, pipe, skb->data, skb->len, 
 			hci_usb_tx_complete, husb);
-	urb->transfer_flags = USB_ZERO_PACKET;
+	urb->transfer_flags = URB_ZERO_PACKET;
 
 	BT_DBG("%s skb %p len %d", husb->hdev.name, skb, skb->len);
 

_
