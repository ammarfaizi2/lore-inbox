Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261243AbVCEXop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVCEXop (ORCPT <rfc822;akpm@zip.com.au>);
	Sat, 5 Mar 2005 18:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVCEXj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 18:39:58 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:25989 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S261249AbVCEXiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:38:08 -0500
Date: Sat, 05 Mar 2005 17:38:08 -0600 (CST)
Date-warning: Date header was inserted by vms040.mailsrvcs.net
From: James Nelson <james4765@cwazy.co.uk>
Subject: [PATCH 10/13] uss720: Clean up printk()'s in drivers/usb/misc/uss720.c
In-reply-to: <20050305233712.7648.24364.93822@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-id: <20050305233807.7648.42888.42634@localhost.localdomain>
References: <20050305233712.7648.24364.93822@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a KERN_ constant and fix two driver prefixes in the printk()s in
drivers/usb/misc/uss720.c

Signed-off-by: James Nelson <james4765@gmail.com>

diff -Nurp -x dontdiff-osdl --exclude='*~' linux-2.6.11-mm1-original/drivers/usb/misc/uss720.c linux-2.6.11-mm1/drivers/usb/misc/uss720.c
--- linux-2.6.11-mm1-original/drivers/usb/misc/uss720.c	2005-03-05 13:29:48.000000000 -0500
+++ linux-2.6.11-mm1/drivers/usb/misc/uss720.c	2005-03-05 15:58:13.000000000 -0500
@@ -564,7 +564,7 @@ static int uss720_probe(struct usb_inter
 	if (!(priv = kmalloc(sizeof(struct parport_uss720_private), GFP_KERNEL)))
 		return -ENOMEM;
 	if (!(pp = parport_register_port(0, PARPORT_IRQ_NONE, PARPORT_DMA_NONE, &parport_uss720_ops))) {
-		printk(KERN_WARNING "usb-uss720: could not register parport\n");
+		printk(KERN_WARNING "uss720: could not register parport\n");
 		goto probe_abort;
 	}
 
@@ -578,7 +578,7 @@ static int uss720_probe(struct usb_inter
 	set_1284_register(pp, 2, 0x0c);
 	/* debugging */
 	get_1284_register(pp, 0, NULL);
-	printk("uss720: reg: %02x %02x %02x %02x %02x %02x %02x\n",
+	printk(KERN_DEBUG "uss720: reg: %02x %02x %02x %02x %02x %02x %02x\n",
 	       priv->reg[0], priv->reg[1], priv->reg[2], priv->reg[3], priv->reg[4], priv->reg[5], priv->reg[6]);
 
 	endpoint = &interface->endpoint[2];
@@ -589,7 +589,7 @@ static int uss720_probe(struct usb_inter
 				  uss720_irq, endpoint->bInterval,
 				  pp, &priv->irqhandle);
 	if (i) {
-		printk (KERN_WARNING "usb-uss720: usb_request_irq failed (0x%x)\n", i);
+		printk (KERN_WARNING "uss720: usb_request_irq failed (0x%x)\n", i);
 		goto probe_abort_port;
 	}
 #endif
