Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbUBZTbw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbUBZTad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:30:33 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:6410 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262943AbUBZT2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:28:12 -0500
Date: Thu, 26 Feb 2004 20:28:14 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] Identify Radeon Ya and Yd in radeonfb
Message-Id: <20040226202814.5655f16e.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Here is a patch that adds support for the Radeon 9200 (Ya) and 9200 SE
(Yd) to the radeonfb driver. Since it already supports the Radeon 9200
Pro which is basically (if not exactly) the same chipset, this is just a
matter of making the driver recognize two new IDs as something it
supports. No new code here.

I take no credit for this patch, since it is almost identical to this
one by Sven Luther:
http://marc.theaimsgroup.com/?l=linux-ppc&m=107427038129062

And is similar to these two other ones that are now in Linux 2.6, by
Bernardo Innocenti and Andreas Steinmetz, respectively:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107345065025365
http://lkml.org/lkml/2004/2/6/64

The patch is against 2.4.26-pre1.
Please apply,
thanks.


--- linux-2.4.26-pre1/include/linux/pci_ids.h	2004-02-26 13:50:00.000000000 +0100
+++ linux-2.4.26-pre1-k1/include/linux/pci_ids.h	2004-02-26 13:54:04.000000000 +0100
@@ -287,6 +287,8 @@
 #define PCI_DEVICE_ID_ATI_RADEON_Ig	0x4967
 /* Radeon RV280 (9200) */
 #define PCI_DEVICE_ID_ATI_RADEON_Y_	0x5960
+#define PCI_DEVICE_ID_ATI_RADEON_Ya	0x5961
+#define PCI_DEVICE_ID_ATI_RADEON_Yd	0x5964
 /* Radeon R300 (9700) */
 #define PCI_DEVICE_ID_ATI_RADEON_ND	0x4e44
 #define PCI_DEVICE_ID_ATI_RADEON_NE	0x4e45
--- linux-2.4.26-pre1/drivers/video/radeonfb.c	2003-08-25 13:44:42.000000000 +0200
+++ linux-2.4.26-pre1-k1/drivers/video/radeonfb.c	2004-02-26 14:04:20.000000000 +0100
@@ -202,6 +202,8 @@
 	RADEON_If,
 	RADEON_Ig,
 	RADEON_Y_,
+	RADEON_Ya,
+	RADEON_Yd,
 	RADEON_Ld,
 	RADEON_Le,
 	RADEON_Lf,
@@ -261,6 +263,8 @@
 	{ "9000 If", RADEON_RV250 },
 	{ "9000 Ig", RADEON_RV250 },
 	{ "9200 Y", RADEON_RV280 },
+	{ "9200 Ya", RADEON_RV280 },
+	{ "9200 Yd", RADEON_RV280 },
 	{ "M9 Ld", RADEON_M9 },
 	{ "M9 Le", RADEON_M9 },
 	{ "M9 Lf", RADEON_M9 },
@@ -326,6 +330,8 @@
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_NH, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_NH},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_NI, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_NI},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Y_, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Y_},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ya, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Ya},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Yd, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Yd},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AD, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_AD},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AP, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_AP},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AR, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_AR},


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
