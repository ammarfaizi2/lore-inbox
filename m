Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbTDFWM6 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 18:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbTDFWM6 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 18:12:58 -0400
Received: from modemcable169.130-200-24.mtl.mc.videotron.ca ([24.200.130.169]:44037
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263163AbTDFWM4 (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 18:12:56 -0400
Date: Sun, 6 Apr 2003 18:19:52 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH][2.5] SET_MODULE_OWNER for tulip_core
Message-ID: <Pine.LNX.4.50.0304061814110.2268-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tested with a pcmcia tulip

Index: linux-2.5.66/drivers/net/tulip/tulip_core.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.66/drivers/net/tulip/tulip_core.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 tulip_core.c
--- linux-2.5.66/drivers/net/tulip/tulip_core.c	24 Mar 2003 23:39:20 -0000	1.1.1.1
+++ linux-2.5.66/drivers/net/tulip/tulip_core.c	6 Apr 2003 21:00:36 -0000
@@ -485,12 +485,9 @@ tulip_open(struct net_device *dev)
         struct tulip_private *tp = (struct tulip_private *)dev->priv;
 #endif
 	int retval;
-	MOD_INC_USE_COUNT;
 
-	if ((retval = request_irq(dev->irq, &tulip_interrupt, SA_SHIRQ, dev->name, dev))) {
-		MOD_DEC_USE_COUNT;
+	if ((retval = request_irq(dev->irq, &tulip_interrupt, SA_SHIRQ, dev->name, dev)))
 		return retval;
-	}
 
 	tulip_init_ring (dev);
 
@@ -823,8 +820,6 @@ static int tulip_close (struct net_devic
 		tp->tx_buffers[i].mapping = 0;
 	}
 
-	MOD_DEC_USE_COUNT;
-
 	return 0;
 }
 
@@ -1361,6 +1356,7 @@ static int __devinit tulip_init_one (str
 		return -ENOMEM;
 	}
 
+	SET_MODULE_OWNER(dev);
 	if (pci_resource_len (pdev, 0) < tulip_tbl[chip_idx].io_size) {
 		printk (KERN_ERR PFX "%s: I/O region (0x%lx@0x%lx) too small, "
 			"aborting\n", pdev->slot_name,

-- 
function.linuxpower.ca
