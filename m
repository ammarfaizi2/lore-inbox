Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbVHXENW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbVHXENW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 00:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbVHXENW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 00:13:22 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:29649 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751442AbVHXENW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 00:13:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Ogkj6NOIxTYoCnL3/zjCz2sfweXmzuDVad1Vg9ibPiRtKb9YrjsZ0qW+JBQatm5VKHvNAszf6aGqP8IGHViF+bD/dlIb1rndatb5q0+VZMBxwqnmitDf0giBvCSvh8jC+OKGbjDy0CQF9RYFTHICWWOGnIIiXNkJpBliWzX+wuI=
Date: Wed, 24 Aug 2005 12:13:00 +0800
From: lepton <ytht.net@gmail.com>
To: dbrownell@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12.5]error condition fix in usbnet
Message-ID: <20050824041300.GA5139@gsy2.lepton.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I thinks this condition is strange, it could be a type error.
See the following patch.

Signed-off-by: Wu Tao <ytht.net@gmail.com>

diff -pru linux-2.6-curr/drivers/usb/net/usbnet.c linux-2.6-curr-lepton/drivers/usb/net/usbnet.c
--- linux-2.6-curr/drivers/usb/net/usbnet.c	2005-06-30 07:00:53.000000000 +0800
+++ linux-2.6-curr-lepton/drivers/usb/net/usbnet.c	2005-08-24 11:26:49.000000000 +0800
@@ -3807,7 +3807,7 @@ usbnet_probe (struct usb_interface *udev
 		if ((dev->driver_info->flags & FLAG_ETHER) != 0
 				&& (net->dev_addr [0] & 0x02) == 0)
 			strcpy (net->name, "eth%d");
-	} else if (!info->in || info->out)
+	} else if (!info->in || !info->out)
 		status = get_endpoints (dev, udev);
 	else {
 		dev->in = usb_rcvbulkpipe (xdev, info->in);
