Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbUK2KcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbUK2KcT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 05:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbUK2KcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 05:32:19 -0500
Received: from www.linux4media.com ([213.133.97.116]:18361 "EHLO archimedis.tv")
	by vger.kernel.org with ESMTP id S261650AbUK2KcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 05:32:13 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: LINUX4MEDIA GmbH
To: linux-kernel@vger.kernel.org, linux@syskonnect.de
Subject: [PATCH] Use MODULE_DEVICE_TABLE in sk98lin driver
Date: Mon, 29 Nov 2004 11:31:03 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_opvqBV7AHWD6lbT"
Message-Id: <200411291131.04843.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_opvqBV7AHWD6lbT
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I just noticed sk98lin devices don't appear in modules.pcimap -- fix attached.
The patch is relative to 2.6.10-rc2-mm3, but it should apply to mostly all 
other kernels with little to no modifications.

LLaP
bero

--Boundary-00=_opvqBV7AHWD6lbT
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.6.9-sk98lin-MDT.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.9-sk98lin-MDT.patch"

--- linux-2.6.9/drivers/net/sk98lin/skge.c.ark	2004-11-29 11:26:17.000000000 +0100
+++ linux-2.6.9/drivers/net/sk98lin/skge.c	2004-11-29 11:27:17.000000000 +0100
@@ -72,8 +72,8 @@
  *		<linux/slab.h>
  *		<linux/interrupt.h>
  *		<linux/pci.h>
+ *		<linux/bitops.h>
  *		<asm/byteorder.h>
- *		<asm/bitops.h>
  *		<asm/io.h>
  *		<linux/netdevice.h>
  *		<linux/etherdevice.h>
@@ -303,7 +303,7 @@
 	/*
 	 * Remap the regs into kernel space.
 	 */
-	pAC->IoBase = (char*)ioremap_nocache(dev->mem_start, 0x4000);
+	pAC->IoBase = ioremap_nocache(dev->mem_start, 0x4000);
 
 	if (!pAC->IoBase){
 		retval = 3;
@@ -5169,6 +5169,8 @@
 	{ 0, }
 };
 
+MODULE_DEVICE_TABLE(ci, skge_pci_tbl);
+
 static struct pci_driver skge_driver = {
 	.name		= "skge",
 	.id_table	= skge_pci_tbl,

--Boundary-00=_opvqBV7AHWD6lbT--
