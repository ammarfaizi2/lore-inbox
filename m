Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946462AbWJSU1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946462AbWJSU1U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946456AbWJSU0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:26:52 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:31644 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1946459AbWJSU0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:26:48 -0400
Message-id: <10365316513231318476@wsc.cz>
Subject: [PATCH 6/7] Char: isicom, use pci_request_region
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Thu, 19 Oct 2006 22:26:59 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, use pci_request_region

Use pci_request_region in pci probing function instead of request_region.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit b298d99f4a779fb54b0035f0f870d5247b13b269
tree 4a7e9a76cc286a126cea5079ef3d405f7fda6436
parent 780d1e45bab78cb6cc6c79037bfe0986bc999332
author Jiri Slaby <jirislaby@gmail.com> Thu, 19 Oct 2006 19:45:18 +0200
committer Jiri Slaby <jirislaby@gmail.com> Thu, 19 Oct 2006 19:45:18 +0200

 drivers/char/isicom.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index f07226a..2f5be09 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -1788,7 +1788,8 @@ static int __devinit isicom_probe(struct
 
 	pci_set_drvdata(pdev, board);
 
-	if (!request_region(board->base, 16, ISICOM_NAME)) {
+	retval = pci_request_region(pdev, 3, ISICOM_NAME);
+	if (retval) {
 		dev_err(&pdev->dev, "I/O Region 0x%lx-0x%lx is busy. Card%d "
 			"will be disabled.\n", board->base, board->base + 15,
 			index + 1);
@@ -1821,7 +1822,7 @@ static int __devinit isicom_probe(struct
 errunri:
 	free_irq(board->irq, board);
 errunrr:
-	release_region(board->base, 16);
+	pci_release_region(pdev, 3);
 err:
 	board->base = 0;
 	return retval;
@@ -1836,7 +1837,7 @@ static void __devexit isicom_remove(stru
 		tty_unregister_device(isicom_normal, board->index * 16 + i);
 
 	free_irq(board->irq, board);
-	release_region(board->base, 16);
+	pci_release_region(pdev, 3);
 }
 
 static int __init isicom_init(void)
