Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262797AbULQNCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbULQNCB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 08:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbULQNCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 08:02:01 -0500
Received: from srv94-252.ip-tech.ch ([195.129.94.252]:4281 "EHLO
	srv94-252.ip-tech.ch") by vger.kernel.org with ESMTP
	id S262797AbULQNB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 08:01:56 -0500
Message-ID: <41C2E6B6.20701@fippu.ch>
Date: Fri, 17 Dec 2004 15:01:26 +0100
From: "Philipp E, Imhof" <fippu@fippu.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] it8212.c, kernel 2.6.9-ac16
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I am using an ITE 8211 controller that did not work with
2.6.9-ac16, because of the PCI device ID.

I created a trivial (but useful) patch that adds the device
ID to the driver and a small comment for people grepping the
sources for the controller type.

I do not know whether the 8212 and the 8211 are fully
compatible, but in my computer, 8211 works fine with 8212's
driver.


diff -ur linux/drivers/ide/pci/it8212.c
linux-2.6.9-ite/drivers/ide/pci/it8212.c
--- linux/drivers/ide/pci/it8212.c	2004-12-17 14:43:39.000000000
+0100
+++ linux-2.6.9-ite/drivers/ide/pci/it8212.c	2004-12-17
14:48:43.000000000 +0100
@@ -16,6 +16,8 @@
   *  as an IDE controller. Smart mode only understands DMA
read/write and
   *  identify, none of the fancier commands apply.
   *
+ *  This driver also supports ITE8211.
+ *
   *  Errata:
   *  o	Rev 0x10 also requires master/slave hold the same DMA
timings and
   *	cannot do ATAPI MWDMA.
@@ -831,6 +833,7 @@
  }

  static struct pci_device_id it8212_pci_tbl[] = {
+	{ PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8211,  PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
  	{ PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8212,  PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
  	{ 0, },
  };
diff -ur linux/include/linux/pci_ids.h
linux-2.6.9-ite/include/linux/pci_ids.h
--- linux/include/linux/pci_ids.h	2004-12-17 14:43:39.000000000 +0100
+++ linux-2.6.9-ite/include/linux/pci_ids.h	2004-12-17
14:30:01.000000000 +0100
@@ -1659,6 +1659,7 @@
  #define PCI_VENDOR_ID_ITE		0x1283
  #define PCI_DEVICE_ID_ITE_IT8172G	0x8172
  #define PCI_DEVICE_ID_ITE_IT8172G_AUDIO 0x0801
+#define PCI_DEVICE_ID_ITE_8211		0x8211
  #define PCI_DEVICE_ID_ITE_8212		0x8212
  #define PCI_DEVICE_ID_ITE_8872		0x8872
  #define PCI_DEVICE_ID_ITE_IT8330G_0	0xe886


--- END ---

Thank you very much for all your work.

Kind regards

Philipp Imhof, fippu@fippu.ch

PS: Please cc: me for comments, feedback or flames, as I
am not subscribed to the list (shame!) due to my lack
of knowledge...


