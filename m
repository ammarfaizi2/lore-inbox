Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWJVPsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWJVPsp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 11:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWJVPsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 11:48:45 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:18401 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1751106AbWJVPso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 11:48:44 -0400
Message-id: <20637171152004418878@wsc.cz>
Subject: [PATCH 2/4] Char: stallion, prints cleanup
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sun, 22 Oct 2006 17:48:51 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stallion, prints cleanup

Too many information is printed out (they may be easily obtained through
sysfs), wipe them out in probe function. Convert rest of them to dev_
variants.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit d69255dafff0fbf775d8ec4de1479cf3cc31b977
tree 47f12a708cd50a0fc8767f90d5c90646a8e57366
parent c4a0f4d15661fe74b8c67b0258d5dfbcff57071b
author Jiri Slaby <ku@bellona.localdomain> Sun, 22 Oct 2006 16:43:39 +0159
committer Jiri Slaby <ku@bellona.localdomain> Sun, 22 Oct 2006 16:43:39 +0159

 drivers/char/stallion.c |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index 592bd6e..884a578 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -2423,9 +2423,6 @@ static int __devinit stl_pciprobe(struct
 	struct stlbrd *brdp;
 	unsigned int brdtype = ent->driver_data;
 
-	pr_debug("stl_initpcibrd(brdtype=%d,busnr=%x,devnr=%x)\n", brdtype,
-		pdev->bus->number, pdev->devfn);
-
 	if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE)
 		return -ENODEV;
 
@@ -2437,21 +2434,13 @@ static int __devinit stl_pciprobe(struct
 	if ((brdp = stl_allocbrd()) == NULL)
 		return(-ENOMEM);
 	if ((brdp->brdnr = stl_getbrdnr()) < 0) {
-		printk("STALLION: too many boards found, "
+		dev_err(&pdev->dev, "too many boards found, "
 			"maximum supported %d\n", STL_MAXBRDS);
 		return(0);
 	}
 	brdp->brdtype = brdtype;
 
 /*
- *	Different Stallion boards use the BAR registers in different ways,
- *	so set up io addresses based on board type.
- */
-	pr_debug("%s(%d): BAR[]=%Lx,%Lx,%Lx,%Lx IRQ=%x\n", __FILE__, __LINE__,
-		pci_resource_start(pdev, 0), pci_resource_start(pdev, 1),
-		pci_resource_start(pdev, 2), pci_resource_start(pdev, 3), pdev->irq);
-
-/*
  *	We have all resources from the board, so let's setup the actual
  *	board structure now.
  */
@@ -2469,7 +2458,7 @@ static int __devinit stl_pciprobe(struct
 		brdp->ioaddr2 = pci_resource_start(pdev, 1);
 		break;
 	default:
-		printk("STALLION: unknown PCI board type=%d\n", brdtype);
+		dev_err(&pdev->dev, "unknown PCI board type=%u\n", brdtype);
 		break;
 	}
 
