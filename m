Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129443AbRBGS5X>; Wed, 7 Feb 2001 13:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129053AbRBGS5N>; Wed, 7 Feb 2001 13:57:13 -0500
Received: from [194.73.73.138] ([194.73.73.138]:41166 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S129443AbRBGS5G>;
	Wed, 7 Feb 2001 13:57:06 -0500
Date: Wed, 7 Feb 2001 18:24:57 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Alan Cox <alan@redhat.com>
Subject: [PATCH] ne2k calling pci_enable twice.
Message-ID: <Pine.LNX.4.31.0102071822360.16790-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan,
 This looks odd to me, we're enabling the device twice.
Patch against ac4.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/ne2k-pci.c linux-dj/drivers/net/ne2k-pci.c
--- linux/drivers/net/ne2k-pci.c	Wed Feb  7 12:42:40 2001
+++ linux-dj/drivers/net/ne2k-pci.c	Wed Feb  7 18:18:38 2001
@@ -213,9 +213,6 @@
 		return -ENODEV;
 	}

-	i = pci_enable_device (pdev);
-	if (i)
-		return i;
 	irq = pdev->irq;

 	if (request_region (ioaddr, NE_IO_EXTENT, "ne2k-pci") == NULL) {


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
