Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265880AbSKZAgu>; Mon, 25 Nov 2002 19:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbSKZAgu>; Mon, 25 Nov 2002 19:36:50 -0500
Received: from english-breakfast.cloud9.net ([168.100.1.9]:7941 "EHLO
	english-breakfast.cloud9.net") by vger.kernel.org with ESMTP
	id <S265880AbSKZAgt>; Mon, 25 Nov 2002 19:36:49 -0500
Date: Mon, 25 Nov 2002 19:44:01 -0500 (EST)
From: Leif Delgass <ldelgass@retinalburn.net>
X-X-Sender: ldelgass@istanbul.retinalburn.dnsalias.net
To: linux-kernel@vger.kernel.org
Cc: Marcello Tosatti <marcelo@connectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <Nicolas.Mailhot@laposte.net>
Subject: [PATCH] [2.4] AGP Support for VIA KT400
Message-ID: <Pine.LNX.4.44.0211251901240.7688-100000@istanbul.retinalburn.dnsalias.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.7; VAE: 6.16.0.0; VDF: 6.16.0.21; host: english-breakfast.cloud9.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a small patch to support agp for the VIA KT400 northbridge.  It's
against 2.4.20-rc3 and is based on Nicolas Mailhot's patch for 2.5 which
was included in 2.5.49.  It adds the PCI id and registers the VIA generic
setup routine for the chipset.  I've tested it successfully on a Gigabyte
GA-7VAXP (KT400) with a Radeon 7500 using DRI and various GL apps/games.  
If this has already been submitted, just ignore it -- but I hadn't seen a
patch for 2.4 appear on lkml or the BitKeeper site yet.

Nicolas' patch for 2.5 on lkml:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103786946803970&w=2

Bugzilla entry for 2.5 is here:
http://bugme.osdl.org/show_bug.cgi?id=14

Please apply.  Thanks.
P.S. Please cc: me on any replies, I'm not subscribed to the list.

diff -uNr linux-2.4.20-rc3.orig/drivers/char/agp/agpgart_be.c linux-2.4.20-rc3/drivers/char/agp/agpgart_be.c
--- linux-2.4.20-rc3.orig/drivers/char/agp/agpgart_be.c	2002-11-25 17:53:36.000000000 -0500
+++ linux-2.4.20-rc3/drivers/char/agp/agpgart_be.c	2002-11-25 17:46:42.000000000 -0500
@@ -4714,6 +4714,12 @@
 		"Via",
 		"Apollo Pro KT266",
 		via_generic_setup },
+	{ PCI_DEVICE_ID_VIA_8377_0,
+		PCI_VENDOR_ID_VIA,
+		VIA_APOLLO_KT400,
+		"Via",
+		"Apollo Pro KT400",
+		via_generic_setup },
 	{ 0,
 		PCI_VENDOR_ID_VIA,
 		VIA_GENERIC,
diff -uNr linux-2.4.20-rc3.orig/include/linux/agp_backend.h linux-2.4.20-rc3/include/linux/agp_backend.h
--- linux-2.4.20-rc3.orig/include/linux/agp_backend.h	2002-11-25 17:53:42.000000000 -0500
+++ linux-2.4.20-rc3/include/linux/agp_backend.h	2002-11-25 17:44:14.000000000 -0500
@@ -60,6 +60,7 @@
 	VIA_APOLLO_PRO,
 	VIA_APOLLO_KX133,
 	VIA_APOLLO_KT133,
+	VIA_APOLLO_KT400,
 	SIS_GENERIC,
 	AMD_GENERIC,
 	AMD_IRONGATE,
diff -uNr linux-2.4.20-rc3.orig/include/linux/pci_ids.h linux-2.4.20-rc3/include/linux/pci_ids.h
--- linux-2.4.20-rc3.orig/include/linux/pci_ids.h	2002-11-25 17:53:42.000000000 -0500
+++ linux-2.4.20-rc3/include/linux/pci_ids.h	2002-11-25 17:43:27.000000000 -0500
@@ -986,6 +986,7 @@
 #define PCI_DEVICE_ID_VIA_8233C_0	0x3109
 #define PCI_DEVICE_ID_VIA_8361		0x3112
 #define PCI_DEVICE_ID_VIA_8233A		0x3147
+#define PCI_DEVICE_ID_VIA_8377_0	0x3189
 #define PCI_DEVICE_ID_VIA_86C100A	0x6100
 #define PCI_DEVICE_ID_VIA_8231		0x8231
 #define PCI_DEVICE_ID_VIA_8231_4	0x8235

-- 
Leif Delgass 
http://www.retinalburn.net


