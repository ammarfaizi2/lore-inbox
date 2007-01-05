Return-Path: <linux-kernel-owner+w=401wt.eu-S1161162AbXAERLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161162AbXAERLH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 12:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161163AbXAERLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 12:11:07 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:51013 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161160AbXAERKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 12:10:55 -0500
Message-id: <16552191032074511145@wsc.cz>
In-reply-to: <16079316021425814645@wsc.cz>
Subject: [PATCH 3/7] Char: moxa, remove moxa_pci_devinfo
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Fri,  5 Jan 2007 18:11:03 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moxa, remove moxa_pci_devinfo

Nothing is used from this struct but *pdev. Remove it and store only pdev.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 6e83fe1d42725f7f704cc50ab130805fba5b548b
tree bcd6ac4107e808a9e78f7d8bffe08d7e5749c8e1
parent 040f78a69ad874e2976ab93a55cde2dc02df7d66
author Jiri Slaby <jirislaby@gmail.com> Wed, 03 Jan 2007 12:34:01 +0059
committer Jiri Slaby <jirislaby@gmail.com> Fri, 05 Jan 2007 17:38:50 +0059

 drivers/char/moxa.c |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/char/moxa.c b/drivers/char/moxa.c
index 9eb8fa6..2899bea 100644
--- a/drivers/char/moxa.c
+++ b/drivers/char/moxa.c
@@ -102,18 +102,12 @@ static struct moxa_isa_board_conf moxa_isa_boards[] =
 /*       {MOXA_BOARD_C218_ISA,8,0xDC000}, */
 };
 
-struct moxa_pci_devinfo {
-	ushort busNum;
-	ushort devNum;
-	struct pci_dev *pdev;
-};
-
 struct moxa_board_conf {
 	int boardType;
 	int numPorts;
 	unsigned long baseAddr;
 	int busType;
-	struct moxa_pci_devinfo pciInfo;
+	struct pci_dev *pdev;
 };
 
 static struct moxa_board_conf moxa_boards[MAX_BOARDS];
@@ -284,11 +278,8 @@ static int moxa_get_PCI_conf(struct pci_dev *p, int board_type,
 		break;
 	}
 	board->busType = MOXA_BUS_TYPE_PCI;
-	board->pciInfo.busNum = p->bus->number;
-	board->pciInfo.devNum = p->devfn >> 3;
-	board->pciInfo.pdev = p;
 	/* don't lose the reference in the next pci_get_device iteration */
-	pci_dev_get(p);
+	board->pdev = pci_dev_get(p);
 
 	return (0);
 }
@@ -437,7 +428,7 @@ static void __exit moxa_exit(void)
 		if (moxaBaseAddr[i])
 			iounmap(moxaBaseAddr[i]);
 		if (moxa_boards[i].busType == MOXA_BUS_TYPE_PCI)
-			pci_dev_put(moxa_boards[i].pciInfo.pdev);
+			pci_dev_put(moxa_boards[i].pdev);
 	}
 
 	if (verbose)
