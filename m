Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTJJSpw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 14:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263110AbTJJSpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 14:45:52 -0400
Received: from c-36a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.54]:28549
	"EHLO ford.pronto.tv") by vger.kernel.org with ESMTP
	id S262725AbTJJSpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 14:45:50 -0400
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: USB and DMA on Alpha with 2.6.0-test7
References: <3F86E9D7.9020104@pacbell.net>
	<20031010221919.A650@den.park.msu.ru>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 10 Oct 2003 20:45:18 +0200
In-Reply-To: <20031010221919.A650@den.park.msu.ru> (Ivan Kokshaysky's
 message of "Fri, 10 Oct 2003 22:19:19 +0400")
Message-ID: <yw1x4qyhorsx.fsf@users.sourceforge.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky <ink@jurassic.park.msu.ru> writes:

> I'd suggest following (untested) patch.

There was a little typo in there.  This seems to work.

--- t7/drivers/usb/net/usbnet.c	Wed Oct  8 23:24:07 2003
+++ linux/drivers/usb/net/usbnet.c	Fri Oct 10 22:10:24 2003
@@ -2970,7 +2970,7 @@ usbnet_probe (struct usb_interface *udev
 	memcpy (net->dev_addr, node_id, sizeof node_id);
 
 	// possible with some EHCI controllers
-	if (dma_supported (&udev->dev, 0xffffffffffffffffULL))
+	if (*udev->dev.dma_mask == 0xffffffffffffffffULL))
 		net->features |= NETIF_F_HIGHDMA;
 
 	net->change_mtu = usbnet_change_mtu;
--- t7/drivers/usb/net/kaweth.c	Wed Oct  8 23:24:26 2003
+++ linux/drivers/usb/net/kaweth.c	Fri Oct 10 22:11:21 2003
@@ -1120,7 +1120,7 @@ static int kaweth_probe(
 
 	usb_set_intfdata(intf, kaweth);
 
-	if (dma_supported (&intf->dev, 0xffffffffffffffffULL))
+	if (*intf->dev.dma_mask == 0xffffffffffffffffULL))
 		kaweth->net->features |= NETIF_F_HIGHDMA;
 
 	SET_NETDEV_DEV(netdev, &intf->dev);

-- 
Måns Rullgård
mru@users.sf.net
