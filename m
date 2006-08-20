Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWHTSo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWHTSo2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 14:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWHTSo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 14:44:28 -0400
Received: from mail.gmx.de ([213.165.64.20]:9936 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751138AbWHTSo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 14:44:27 -0400
X-Authenticated: #704063
Subject: [PATCH] Signdness issue in drivers/usb/gadget/ether.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 20 Aug 2006 20:44:23 +0200
Message-Id: <1156099463.3687.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

another gcc 4.1 signdness warning:

drivers/usb/gadget/ether.c:2028: warning: comparison of unsigned expression < 0 is always false

length is assigned the value of usb_ep_queue() which returns an int. Directly
after this it is checked for < 0, which can never be true. Making length an
int makes the error check work again.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-rc4/drivers/usb/gadget/ether.c.orig	2006-08-20 20:40:20.000000000 +0200
+++ linux-2.6.18-rc4/drivers/usb/gadget/ether.c	2006-08-20 20:40:37.000000000 +0200
@@ -1998,7 +1998,7 @@ rndis_control_ack_complete (struct usb_e
 static int rndis_control_ack (struct net_device *net)
 {
 	struct eth_dev          *dev = netdev_priv(net);
-	u32                     length;
+	int                     length;
 	struct usb_request      *resp = dev->stat_req;
 
 	/* in case RNDIS calls this after disconnect */


