Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBGTSX>; Wed, 7 Feb 2001 14:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130044AbRBGTSN>; Wed, 7 Feb 2001 14:18:13 -0500
Received: from [194.73.73.138] ([194.73.73.138]:45560 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S129047AbRBGTRz>;
	Wed, 7 Feb 2001 14:17:55 -0500
Date: Wed, 7 Feb 2001 19:17:43 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Alan Cox <alan@redhat.com>
cc: <becker@scyld.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Hamachi not doing pci_enable before reading resources
Message-ID: <Pine.LNX.4.31.0102071914210.17543-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan,

 Another driver not doing pci_enable_device() early enough.

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/hamachi.c linux-dj/drivers/net/hamachi.c
--- linux/drivers/net/hamachi.c	Wed Feb  7 12:42:39 2001
+++ linux-dj/drivers/net/hamachi.c	Wed Feb  7 19:09:31 2001
@@ -562,13 +562,14 @@
 	if (hamachi_debug > 0  &&  did_version++ == 0)
 		printk(version);

+	if (pci_enable_device(pdev))
+		return -EIO;
+
 	ioaddr = pci_resource_start(pdev, 0);
 #ifdef __alpha__				/* Really "64 bit addrs" */
 	ioaddr |= (pci_resource_start(pdev, 1) << 32);
 #endif

-	if (pci_enable_device(pdev))
-		return -EIO;
 	pci_set_master(pdev);

 	ioaddr = (long) ioremap(ioaddr, 0x400);


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
