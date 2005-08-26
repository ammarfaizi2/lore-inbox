Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbVHZTYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbVHZTYA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbVHZTX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:23:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8151 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030220AbVHZTX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:23:57 -0400
Message-Id: <20050826191927.323489000@localhost.localdomain>
References: <20050826191755.052951000@localhost.localdomain>
Date: Fri, 26 Aug 2005 12:18:00 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       dbrownell@users.sourceforge.net
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Brownell <david-b@pacbell.net>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 5/7] [PATCH] fix gl_skb/skb type error in genelink driver in usbnet
Content-Disposition: inline; filename=genelink-usbnet-skb-typo.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------

I think there is a type error when port genelink driver to 2.6..
With this error, a linux host will panic when it link with a windows
host.

Cc: David Brownell <david-b@pacbell.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 drivers/usb/net/usbnet.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12.y/drivers/usb/net/usbnet.c
===================================================================
--- linux-2.6.12.y.orig/drivers/usb/net/usbnet.c
+++ linux-2.6.12.y/drivers/usb/net/usbnet.c
@@ -1922,7 +1922,7 @@ static int genelink_rx_fixup (struct usb
 
 			// copy the packet data to the new skb
 			memcpy(skb_put(gl_skb, size), packet->packet_data, size);
-			skb_return (dev, skb);
+			skb_return (dev, gl_skb);
 		}
 
 		// advance to the next packet

--
