Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRBGT2d>; Wed, 7 Feb 2001 14:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129224AbRBGT2X>; Wed, 7 Feb 2001 14:28:23 -0500
Received: from carbon.btinternet.com ([194.73.73.92]:9371 "EHLO
	carbon.btinternet.com") by vger.kernel.org with ESMTP
	id <S129084AbRBGT2K>; Wed, 7 Feb 2001 14:28:10 -0500
Date: Wed, 7 Feb 2001 19:28:01 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Alan Cox <alan@redhat.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] natsemi pci_enable_device fixup.
Message-ID: <Pine.LNX.4.31.0102071927010.17659-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And they keep on coming.

d.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/natsemi.c linux-dj/drivers/net/natsemi.c
--- linux/drivers/net/natsemi.c	Wed Feb  7 12:42:40 2001
+++ linux-dj/drivers/net/natsemi.c	Wed Feb  7 19:24:02 2001
@@ -380,11 +380,13 @@

 	find_cnt++;
 	option = find_cnt < MAX_UNITS ? options[find_cnt] : 0;
+
+	if (pci_enable_device(pdev))
+		return -EIO;
+
 	ioaddr = pci_resource_start(pdev, pcibar);
 	iosize = pci_resource_len(pdev, pcibar);

-	if (pci_enable_device(pdev))
-		return -EIO;
 	if (natsemi_pci_info[chip_idx].flags & PCI_USES_MASTER)
 		pci_set_master(pdev);


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
