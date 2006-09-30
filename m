Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751561AbWI3WeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWI3WeW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWI3WeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:34:22 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:63617 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1751561AbWI3WeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:34:20 -0400
Message-id: <83721356982173@wsc.cz>
Subject: [PATCH 3/4] Char: mxser_new, pci_request_region for pci regions
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Date: Sun,  1 Oct 2006 00:34:19 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, pci_request_region for pci regions

Use pci_request_region instead of standard request_region for pci device
regions. More checking, simplier use.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 1a717bdb06cef859dfbd426f46ea24a9c740e5c5
tree 85460f01008e9fa2edea675a73b394c48139df4a
parent d4f99406c592fb7ce2a65645d7c1f98ebe599238
author Jiri Slaby <jirislaby@gmail.com> Sat, 30 Sep 2006 01:20:12 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Sat, 30 Sep 2006 01:20:12 +0200

 drivers/char/mxser_new.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index dfef9ce..c566cd0 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -526,8 +526,8 @@ static void __exit mxser_module_exit(voi
 			pdev = mxser_boards[i].pdev;
 			free_irq(mxser_boards[i].irq, &mxser_boards[i]);
 			if (pdev != NULL) {	/* PCI */
-				release_region(pci_resource_start(pdev, 2), pci_resource_len(pdev, 2));
-				release_region(pci_resource_start(pdev, 3), pci_resource_len(pdev, 3));
+				pci_release_region(pdev, 2);
+				pci_release_region(pdev, 3);
 				pci_dev_put(pdev);
 			} else {
 				release_region(mxser_boards[i].ports[0].ioaddr, 8 * mxser_boards[i].nports);
@@ -627,16 +627,14 @@ static int __init mxser_get_PCI_conf(int
 	brd->board_type = board_type;
 	brd->nports = mxser_numports[board_type - 1];
 	ioaddress = pci_resource_start(pdev, 2);
-	request_region(pci_resource_start(pdev, 2), pci_resource_len(pdev, 2),
-			"mxser(IO)");
+	pci_request_region(pdev, 2, "mxser(IO)");
 
 	for (i = 0; i < brd->nports; i++)
 		brd->ports[i].ioaddr = ioaddress + 8 * i;
 
 	/* vector */
 	ioaddress = pci_resource_start(pdev, 3);
-	request_region(pci_resource_start(pdev, 3), pci_resource_len(pdev, 3),
-			"mxser(vector)");
+	pci_request_region(pdev, 3, "mxser(vector)");
 	brd->vector = ioaddress;
 
 	/* irq */
