Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbUCOOwf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 09:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbUCOOwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 09:52:35 -0500
Received: from shark.pro-futura.com ([161.58.178.219]:56248 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S262587AbUCOOwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 09:52:32 -0500
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
Organization: Croadria Internet usluge
To: linux-kernel@vger.kernel.org
Subject: Re: SATA on 2.4.x
Date: Mon, 15 Mar 2004 15:56:51 +0100
User-Agent: KMail/1.6.1
References: <Pine.LNX.4.58.0403150934590.21510@wormwood.cs.yorku.ca>
In-Reply-To: <Pine.LNX.4.58.0403150934590.21510@wormwood.cs.yorku.ca>
Cc: Andrew Hogue <hogue@cs.yorku.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zQcVAmPxhg7lGsh"
Message-Id: <200403151556.51162.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_zQcVAmPxhg7lGsh
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 15 March 2004 15:36, Andrew Hogue wrote:

Hello Andrew,
> Is there a patch to allow the via 8237 sata controller to work for kernel
> 2.4.x ?

Try this one, it works for me flawlessly.

--Boundary-00=_zQcVAmPxhg7lGsh
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="via-onboard-sata.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="via-onboard-sata.patch"

diff -aur linux-2.4.23-orig/drivers/ide/pci/generic.c linux-2.4.23-grsec/drivers/ide/pci/generic.c
--- linux-2.4.23-orig/drivers/ide/pci/generic.c	2003-10-07 11:21:32.000000000 +0200
+++ linux-2.4.23-grsec/drivers/ide/pci/generic.c	2003-12-17 09:07:01.000000000 +0100
@@ -140,7 +140,8 @@
 	{ PCI_VENDOR_ID_HINT,   PCI_DEVICE_ID_HINT_VXPROII_IDE,    PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
 	{ PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_82C561,          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7},
 	{ PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8},
-	{ PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_TOSHIBA_PICCOLO,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9},
+	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9},
+	{ PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237_SATA,       PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10},
 	{ 0, },
 };
 
diff -aur linux-2.4.23-orig/drivers/ide/pci/generic.h linux-2.4.23-grsec/drivers/ide/pci/generic.h
--- linux-2.4.23-orig/drivers/ide/pci/generic.h	2003-10-07 11:21:32.000000000 +0200
+++ linux-2.4.23-grsec/drivers/ide/pci/generic.h	2003-12-23 09:53:46.000000000 +0100
@@ -140,6 +140,19 @@
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
 		.extra		= 0,
+	},{	/* 10 */
+		.vendor = PCI_VENDOR_ID_VIA,
+		.device = PCI_DEVICE_ID_VIA_8237_SATA,
+		.name = "VIA8237SATA",
+		.init_chipset = init_chipset_generic,
+		.init_iops = NULL,
+		.init_hwif = init_hwif_generic,
+		.init_dma = init_dma_generic,
+		.channels = 2,
+		.autodma = AUTODMA,
+		.enablebits = {{0x00,0x00,0x00},{0x00,0x00,0x00}},
+		.bootable = OFF_BOARD,
+		.extra = 0,
 	},{
 		.vendor		= 0,
 		.device		= 0,

--Boundary-00=_zQcVAmPxhg7lGsh--
