Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbVHVWiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbVHVWiz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbVHVWiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:38:54 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:38539 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751397AbVHVWiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:38:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=mihxNXKk4jeOg9kxE5Npthkfjg8j37rYWyinXip8p16e6Xvg+AhLCqelUIgkTj6WotxrVziws7GskMDHNjcXxRWRnxR69nwVHot+mUiO0dwn9gm+lRfOf13mn7Z74OY2wUeHAyG2g+T6D5mxuboN9E71IsJt992uBVvayWKZIMg=
Date: Mon, 22 Aug 2005 14:02:39 +0800
From: lepton <ytht.net@gmail.com>
To: dbrownell@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12.5]fix gl_skb/skb type error in genelink driver in usbnet in 2.6
Message-ID: <20050822060239.GA4155@gsy2.lepton.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
   I think there is a type error when port genelink driver to 2.6..
   With this error, a linux host will panic when it link with a windows
   host.
   
   See the following patch.

diff -pruNX linux-2.6-curr/Documentation/dontdiff linux-2.6-curr/drivers/usb/net/usbnet.c linux-2.6-curr-lepton/drivers/usb/net/usbnet.c
--- linux-2.6-curr/drivers/usb/net/usbnet.c	2005-06-30 07:00:53.000000000 +0800
+++ linux-2.6-curr-lepton/drivers/usb/net/usbnet.c	2005-08-22 13:55:18.000000000 +0800
@@ -1922,7 +1922,7 @@ static int genelink_rx_fixup (struct usb
 
 			// copy the packet data to the new skb
 			memcpy(skb_put(gl_skb, size), packet->packet_data, size);
-			skb_return (dev, skb);
+			skb_return (dev, gl_skb);
 		}
 
 		// advance to the next packet
