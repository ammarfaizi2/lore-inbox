Return-Path: <linux-kernel-owner+w=401wt.eu-S932804AbXASAaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932804AbXASAaz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbXASA1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:27:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:61715 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932799AbXASA1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:27:19 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=luOPs4uYN7JhPpc1H4eOLvIKHQjxchbil/aVV86BAGFAnXRx87MxUsIGAvh/5YmuoWjayqvCop1YqLT7T1YxNGBe1tfXp/dQeFx8+/CBLrlzttkLts5iVL0OlOs/OpS9Pa9MZ5nJTJBB7lLfAlrVRB9HUtVgTB6WoCPwuGOtSeM=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 19 Jan 2007 01:31:18 +0100
Message-Id: <20070119003118.14846.56318.sendpatchset@localhost.localdomain>
In-Reply-To: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Subject: [PATCH 3/15] it8213: fix build and ->ultra_mask
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] it8213: fix build and ->ultra_mask

* PCI_DEVICE_ID_ITE_8213 is only defined in -mm kernels,
  so just use PCI Device ID (0x8213) directly
* fix ->ultra_mask to indicate UDMA6 support

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/it8213.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -282,7 +282,7 @@ static void __devinit init_hwif_it8213(i
 		return;
 
 	hwif->atapi_dma = 1;
-	hwif->ultra_mask = 0x3f;
+	hwif->ultra_mask = 0x7f;
 	hwif->mwdma_mask = 0x06;
 	hwif->swdma_mask = 0x04;
 
@@ -338,7 +338,7 @@ static int __devinit it8213_init_one(str
 
 
 static struct pci_device_id it8213_pci_tbl[] = {
-	{ PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8213,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_ITE, 0x8213, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, },
 };
 
