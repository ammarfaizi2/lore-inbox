Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272245AbRIERkk>; Wed, 5 Sep 2001 13:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272246AbRIERk3>; Wed, 5 Sep 2001 13:40:29 -0400
Received: from home1.gvdnet.dk ([212.88.76.170]:23301 "EHLO home1.gvdnet.dk")
	by vger.kernel.org with ESMTP id <S272245AbRIERkM>;
	Wed, 5 Sep 2001 13:40:12 -0400
Date: Wed, 5 Sep 2001 19:44:59 +0200
Message-Id: <200109051744.f85Hixf12576@home1.gvdnet.dk>
To: <torvalds@transmeta.com>
Subject: [PATCH] Proper detection of G400 DH MAX cards in matroxfb
From: <simon@home1.gvdnet.dk>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: <simon@home1.gvdnet.dk>
Subject: [PATCH] Proper detection of G400 DH MAX cards in matroxfb
X-Originating-Ip: [192.168.1.10]
X-Mailer: GVDnet Webmail<BR><i>home1.gvdnet.dk</i> v
Content-Type: text/plain;
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

A simple little patch on matroxfb_base.{c/h} in the 2.4.8 kernel. 
The current matroxfb driver doesn't detect G400 MAX Dual-Head cards 
properly, instead calling them "Unknown G400" and setting their DAC
speed to 300 MHz instead of the correct 360 MHz. This patch fixes 
that.

--simon

diff -urN -X dontdiff linux-vanilla/drivers/video/matrox/matroxfb_base.c kernel-source-2.4.8/drivers/vide
o/matrox/matroxfb_base.c
--- linux-vanilla/drivers/video/matrox/matroxfb_base.c  Wed Sep  5 19:04:32 2001
+++ kernel-source-2.4.8/drivers/video/matrox/matroxfb_base.c    Wed Sep  5 19:16:52 2001
@@ -75,6 +75,9 @@
  *               "Uns Lider" <unslider@miranda.org>
  *                     G100 PLNWT fixes
  *
+ *               "Simon Kongshoj" <simon@home1.gvdnet.dk>
+ *                     G400 MAX Dual-Head detection
+ *
  * (following author is not in any relation with this code, but his code
  *  is included in this driver)
  *
@@ -1566,6 +1569,12 @@
                360000,
                &vbG400,
                "Millennium G400 MAX (AGP)"},
+       {PCI_VENDOR_ID_MATROX,  PCI_DEVICE_ID_MATROX_G400_AGP,  0x80,
+               PCI_SS_VENDOR_ID_MATROX,        PCI_SS_ID_MATROX_MILLENNIUM_G400_MAX_DUAL_AGP,
+               DEVF_G400,
+               360000,
+               &vbG400,
+               "Millennium G400 MAX Dual-Head (AGP)"},
        {PCI_VENDOR_ID_MATROX,  PCI_DEVICE_ID_MATROX_G400_AGP,  0x80,
                0,                      0,
                DEVF_G400,
diff -urN -X dontdiff linux-vanilla/drivers/video/matrox/matroxfb_base.h kernel-source-2.4.8/drivers/vide
o/matrox/matroxfb_base.h
--- linux-vanilla/drivers/video/matrox/matroxfb_base.h  Wed Sep  5 19:04:32 2001
+++ kernel-source-2.4.8/drivers/video/matrox/matroxfb_base.h    Wed Sep  5 19:09:56 2001
@@ -171,6 +171,7 @@
 #define PCI_SS_ID_MATROX_MGA_G100_PCI          0xFF05
 #define PCI_SS_ID_MATROX_MGA_G100_AGP          0x1001
 #define PCI_SS_ID_MATROX_MILLENNIUM_G400_MAX_AGP       0x2179
+#define PCI_SS_ID_MATROX_MILLENNIUM_G400_MAX_DUAL_AGP  0x217D
 #define PCI_SS_ID_SIEMENS_MGA_G100_AGP         0x001E /* 30 */
 #define PCI_SS_ID_SIEMENS_MGA_G200_AGP         0x0032 /* 50 */
 #endif


 




