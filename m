Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSFXCin>; Sun, 23 Jun 2002 22:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSFXCim>; Sun, 23 Jun 2002 22:38:42 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:19729 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S317257AbSFXCil>;
	Sun, 23 Jun 2002 22:38:41 -0400
Date: Sun, 23 Jun 2002 22:29:55 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.24 : drivers/net/defxx.c 
Message-ID: <Pine.LNX.4.44.0206232225410.922-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch adds the check for 32-bit DMA mapping functionality 
for the defxx driver. This is the first step to make this driver compliant 
with Documentation/DMA-mapping.txt . Please review.
Regards,
Frank

--- drivers/net/defxx.c.old	Sun May 26 14:37:25 2002
+++ drivers/net/defxx.c	Sun Jun 23 22:18:39 2002
@@ -427,7 +427,10 @@
 		printk(version);	/* we only display this string ONCE */
 	}
 #endif
-
+	if(pci_set_dma_mask(pdev, 0xffffffff))
+	{
+		printk(KERN_WARNING "defxx : No suitable DMA available\n");
+	}
 	/*
 	 * init_fddidev() allocates a device structure with private data, clears the device structure and private data,
 	 * and  calls fddi_setup() and register_netdev(). Not much left to do for us here.


