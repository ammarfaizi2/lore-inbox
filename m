Return-Path: <linux-kernel-owner+w=401wt.eu-S932805AbXASA1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932805AbXASA1c (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbXASA1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:27:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:61715 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932793AbXASA1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:27:12 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=kKKIjWel4B1By3PZZB9PxQXpR5Sl7l+/fM8Evlw5eFHlIyuAVFFNPzr0iHEIV//FTbfjLFtW/G8meHIZTQOZ5Abxg+jxNK/AeE15fW6COHfrUJTAMS0H17H1xYXE1a4XLkmYJVaFy7z63Uw9t3Pb9Q3Cn/QfktyHpWg8Wsv+FMM=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 19 Jan 2007 01:31:11 +0100
Message-Id: <20070119003111.14846.88932.sendpatchset@localhost.localdomain>
In-Reply-To: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Subject: [PATCH 2/15] via82cxxx/pata_via: correct PCI_DEVICE_ID_VIA_SATA_EIDE ID and add support for CX700 and 8237S
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] via82cxxx/pata_via: correct PCI_DEVICE_ID_VIA_SATA_EIDE ID and add support for CX700 and 8237S

This patch:
* Corrects the wrong device ID of PCI_DEVICE_ID_VIA_SATA_EIDE
  from 0x0581 to 0x5324.
* Adds VIA CX700 and VT8237S support in drivers/ide/pci/via82cxxx.c
* Adds VIA VT8237S support in drivers/ata/pata_via.c

Signed-off-by: Josepch Chan <josephchan@via.com.tw>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ata/pata_via.c      |    1 +
 drivers/ide/pci/via82cxxx.c |    3 +++
 include/linux/pci_ids.h     |    3 ++-
 3 files changed, 6 insertions(+), 1 deletion(-)

Index: b/drivers/ata/pata_via.c
===================================================================
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -95,6 +95,7 @@ static const struct via_isa_bridge {
 	u8 rev_max;
 	u16 flags;
 } via_isa_bridges[] = {
+	{ "vt8237s",	PCI_DEVICE_ID_VIA_8237S,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "cx700",	PCI_DEVICE_ID_VIA_CX700,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST | VIA_NO_ENABLES},
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -78,6 +78,8 @@ static struct via_isa_bridge {
 	u8 rev_max;
 	u16 flags;
 } via_isa_bridges[] = {
+	{ "cx7000",	PCI_DEVICE_ID_VIA_CX700,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
+	{ "vt8237s",	PCI_DEVICE_ID_VIA_8237S,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
@@ -504,6 +506,7 @@ static struct pci_device_id via_pci_tbl[
 	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C576_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_6410,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
+	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_SATA_EIDE,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, via_pci_tbl);
Index: b/include/linux/pci_ids.h
===================================================================
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1283,7 +1283,6 @@
 #define PCI_DEVICE_ID_VIA_82C561	0x0561
 #define PCI_DEVICE_ID_VIA_82C586_1	0x0571
 #define PCI_DEVICE_ID_VIA_82C576	0x0576
-#define PCI_DEVICE_ID_VIA_SATA_EIDE	0x0581
 #define PCI_DEVICE_ID_VIA_82C586_0	0x0586
 #define PCI_DEVICE_ID_VIA_82C596	0x0596
 #define PCI_DEVICE_ID_VIA_82C597_0	0x0597
@@ -1326,6 +1325,8 @@
 #define PCI_DEVICE_ID_VIA_8237		0x3227
 #define PCI_DEVICE_ID_VIA_8251		0x3287
 #define PCI_DEVICE_ID_VIA_8237A		0x3337
+#define PCI_DEVICE_ID_VIA_8237S		0x3372
+#define PCI_DEVICE_ID_VIA_SATA_EIDE	0x5324
 #define PCI_DEVICE_ID_VIA_8231		0x8231
 #define PCI_DEVICE_ID_VIA_8231_4	0x8235
 #define PCI_DEVICE_ID_VIA_8365_1	0x8305
