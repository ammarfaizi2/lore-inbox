Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313453AbSDLIaS>; Fri, 12 Apr 2002 04:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313461AbSDLIaR>; Fri, 12 Apr 2002 04:30:17 -0400
Received: from exchsmtp.via.com.tw ([61.13.36.4]:46597 "EHLO
	exchsmtp.via.com.tw") by vger.kernel.org with ESMTP
	id <S313453AbSDLIaM>; Fri, 12 Apr 2002 04:30:12 -0400
Message-ID: <369B0912E1F5D511ACA5003048222B75A3C040@exchtp02.via.com.tw>
From: Shing Chuang <ShingChuang@via.com.tw>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.19-pre6] via-rhine.c to support new VIA's nic chip VT6
	105, V6105M (correct).
Date: Fri, 12 Apr 2002 16:30:53 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="BIG5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

      (Please ignore the previous post patch,  the correct DEVICE ID for
VT6105 is 0x3106, and VT6105M chip is 0x3053)

      This patch applied to linux kernel 2.4.19-per6 to support VIA's new
NIC chip.
      However, VIA don't have any nic chip with pci device id 0x6100 so far,
so this patch also remove the device ID 0x6100.

       
--- linux/drivers/net/via-rhine.c.orig	Fri Apr 12 15:36:38 2002
+++ linux/drivers/net/via-rhine.c	Fri Apr 12 15:39:04 2002
@@ -317,7 +317,8 @@
 enum via_rhine_chips {
 	VT86C100A = 0,
 	VT6102,
-	VT3043,
+	VT6105,
+	VT6105M,
 };
 
 struct via_rhine_chip_info {
@@ -345,7 +346,9 @@
 	  CanHaveMII | ReqTxAlign },
 	{ "VIA VT6102 Rhine-II", RHINE_IOTYPE, 256,
 	  CanHaveMII | HasWOL },
-	{ "VIA VT3043 Rhine",    RHINE_IOTYPE, 128,
+	{ "VIA VT6105 Rhine-III",    RHINE_IOTYPE, 256,
+	  CanHaveMII | ReqTxAlign },
+	{ "VIA VT6105M Rhine-III",    RHINE_IOTYPE, 256,
 	  CanHaveMII | ReqTxAlign }
 };
 
@@ -353,7 +356,8 @@
 {
 	{0x1106, 0x6100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT86C100A},
 	{0x1106, 0x3065, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6102},
-	{0x1106, 0x3043, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT3043},
+	{0x1106, 0x3106, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6105},
+	{0x1106, 0x3053, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6105M},
 	{0,}			/* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, via_rhine_pci_tbl);
@@ -510,7 +514,7 @@
 	int i;
 
 	/* 3043 may need long delay after reset (dlink) */
-	if (chip_id == VT3043 || chip_id == VT86C100A)
+	if (chip_id == VT86C100A)
 		udelay(100);
 
 	i = 0;
@@ -531,7 +535,7 @@
 static void __devinit enable_mmio(long ioaddr, int chip_id)
 {
 	int n;
-	if (chip_id == VT3043 || chip_id == VT86C100A) {
+	if (chip_id == VT86C100A) {
 		/* More recent docs say that this bit is reserved ... */
 		n = inb(ioaddr + ConfigA) | 0x20;
 		outb(n, ioaddr + ConfigA);

-- 
Chuang Liang-Shing
VIA Technologies, Inc.
+886-2-22185452 Ext. 7523
E-Mail: ShingChuang@via.com.tw


