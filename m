Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312584AbSDOD3s>; Sun, 14 Apr 2002 23:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312586AbSDOD3r>; Sun, 14 Apr 2002 23:29:47 -0400
Received: from exchsmtp.via.com.tw ([61.13.36.4]:48398 "EHLO
	exchsmtp.via.com.tw") by vger.kernel.org with ESMTP
	id <S312584AbSDOD3o>; Sun, 14 Apr 2002 23:29:44 -0400
Message-ID: <369B0912E1F5D511ACA5003048222B75A3C045@exchtp02.via.com.tw>
From: Shing Chuang <ShingChuang@via.com.tw>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.19-pre6] via-rhine.c to support new VIA's nic chip VT
	6105, V6105M(corrected)
Date: Mon, 15 Apr 2002 11:30:22 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

     I'm very sorry for posting two previous worng patch,  this one should
be correct. 
     I'll be very carefull on posting patch next time.
     
   

--- drivers/net/via-rhine.c.orig	Fri Apr 12 15:13:07 2002
+++ drivers//net/via-rhine.c	Mon Apr 15 10:57:42 2002
@@ -316,7 +316,8 @@
 enum via_rhine_chips {
 	VT86C100A = 0,
 	VT6102,
-	VT3043,
+	VT6105,
+	VT6105M
 };
 
 struct via_rhine_chip_info {
@@ -344,15 +345,18 @@
 	  CanHaveMII | ReqTxAlign },
 	{ "VIA VT6102 Rhine-II", RHINE_IOTYPE, 256,
 	  CanHaveMII | HasWOL },
-	{ "VIA VT3043 Rhine",    RHINE_IOTYPE, 128,
-	  CanHaveMII | ReqTxAlign }
+	{ "VIA VT6105 Rhine-III", RHINE_IOTYPE, 256,
+	  CanHaveMII | HasWOL },	  
+	{ "VIA VT6105M Rhine-III", RHINE_IOTYPE, 256,
+	  CanHaveMII | HasWOL },	  	  	 
 };
 
 static struct pci_device_id via_rhine_pci_tbl[] __devinitdata =
 {
-	{0x1106, 0x6100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT86C100A},
+	{0x1106, 0x3043, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT86C100A},
 	{0x1106, 0x3065, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6102},
-	{0x1106, 0x3043, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT3043},
+	{0x1106, 0x3106, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6105},
+	{0x1106, 0x3053, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6105M},	
 	{0,}			/* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, via_rhine_pci_tbl);
@@ -509,7 +513,7 @@
 	int i;
 
 	/* 3043 may need long delay after reset (dlink) */
-	if (chip_id == VT3043 || chip_id == VT86C100A)
+	if (chip_id == VT86C100A)
 		udelay(100);
 
 	i = 0;
@@ -530,7 +534,7 @@
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
