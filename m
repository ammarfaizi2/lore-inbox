Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268268AbUIKRiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268268AbUIKRiP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268259AbUIKRfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:35:06 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:6317 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S268232AbUIKRdT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:33:19 -0400
Message-ID: <414336DD.9030003@free.fr>
Date: Sat, 11 Sep 2004 19:33:17 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: eric.valette@free.fr
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, petkan@nucleusys.com
Subject: Re: rtl8150.c ethernet driver : usb_unlink_urb ->usb_kill_urb
References: <413DB68C.7030508@free.fr> <4140256C.5090803@free.fr> <20040909152454.14f7ebc9.akpm@osdl.org> <20040909223605.GA17655@kroah.com> <414335FB.8050203@free.fr>
In-Reply-To: <414335FB.8050203@free.fr>
Content-Type: multipart/mixed;
 boundary="------------000902000700010505040607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000902000700010505040607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Eric Valette wrote:
> 
>> I'll defer to Petkan as to what to do about this, as he sent me that
>> patch for a good reason I imagine :)
> 
> 
> While we are looking at this driver, here is a way to avoid one full 
> page of annoying messages at shutdown/module unload.
> 
> Signed-off-by: Eric Valette <Eric.Valette@free.fr>

Wrong patch, sorry...

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr




--------------000902000700010505040607
Content-Type: text/x-patch;
 name="patch_rtl8150.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_rtl8150.c.patch"

--- linux/drivers/usb/net/rtl8150.c-2.6.9-rc1-mm4.orig	2004-09-09 11:15:11.000000000 +0200
+++ linux/drivers/usb/net/rtl8150.c	2004-09-11 14:06:44.000000000 +0200
@@ -341,7 +341,7 @@
 
 static int rtl8150_reset(rtl8150_t * dev)
 {
-	u8 data = 0x11;
+	u8 data = 0x10;
 	int i = HZ;
 
 	set_registers(dev, CR, 1, &data);
@@ -389,10 +389,10 @@
 
 static void unlink_all_urbs(rtl8150_t * dev)
 {
-	usb_unlink_urb(dev->rx_urb);
-	usb_unlink_urb(dev->tx_urb);
-	usb_unlink_urb(dev->intr_urb);
-	usb_unlink_urb(dev->ctrl_urb);
+	usb_kill_urb(dev->rx_urb);
+	usb_kill_urb(dev->tx_urb);
+	usb_kill_urb(dev->intr_urb);
+	usb_kill_urb(dev->ctrl_urb);
 }
 
 static inline struct sk_buff *pull_skb(rtl8150_t *dev)
@@ -656,7 +656,7 @@
 	rtl8150_t *dev = netdev_priv(netdev);
 	warn("%s: Tx timeout.", netdev->name);
 	dev->tx_urb->transfer_flags |= URB_ASYNC_UNLINK;
-	usb_unlink_urb(dev->tx_urb);
+	usb_kill_urb(dev->tx_urb);
 	dev->stats.tx_errors++;
 }
 

--------------000902000700010505040607--
