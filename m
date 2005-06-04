Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVFDCwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVFDCwa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 22:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVFDCwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 22:52:30 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:28563 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261192AbVFDCwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 22:52:18 -0400
Message-ID: <42A11766.7080902@krufky.com>
Date: Fri, 03 Jun 2005 22:52:22 -0400
From: Michael Krufky <mike@krufky.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
Subject: [PATCH] DViCO FusionHDTV3 Gold-T documentation fix
Content-Type: multipart/mixed;
 boundary="------------040101000303020601020704"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - krufky.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040101000303020601020704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Even though it says DViCO FusionHDTV3 Gold-Q on the box, Gold-T is 
printed on the card.  This fix corrects the error in all places, and 
corrects the tuner name Thomson DDT 7611 (ATSC/NTSC)  in the documentation.

This applies against 2.6.12-rc5-mm2 after applying Manueal Capinha's 
patch "Add support for PixelView Ultra Pro in v4l" (because of the 
change from card=27 to card=28)

--------------040101000303020601020704
Content-Type: text/plain;
 name="dvico-fusionhdtv-3-gold-t-documentation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dvico-fusionhdtv-3-gold-t-documentation.patch"

diff -upr a/Documentation/video4linux/CARDLIST.cx88 b/Documentation/video4linux/CARDLIST.cx88
--- a/Documentation/video4linux/CARDLIST.cx88	2005-06-03 21:29:24.000000000 +0000
+++ b/Documentation/video4linux/CARDLIST.cx88	2005-06-03 22:13:49.000000000 +0000
@@ -26,4 +26,4 @@ card=24 - Hauppauge WinTV 28xxx (Roslyn)
 card=25 - Digital-Logic MICROSPACE Entertainment Center (MEC)
 card=26 - IODATA GV/BCTV7E
 card=27 - PixelView PlayTV Ultra Pro (Stereo)
-card=28 - DViCO - FusionHDTV 3 Gold-Q
+card=28 - DViCO - FusionHDTV 3 Gold-T
diff -upr a/Documentation/video4linux/CARDLIST.tuner b/Documentation/video4linux/CARDLIST.tuner
--- a/Documentation/video4linux/CARDLIST.tuner	2005-06-03 21:29:24.000000000 +0000
+++ b/Documentation/video4linux/CARDLIST.tuner	2005-06-03 22:13:31.000000000 +0000
@@ -58,4 +58,4 @@ tuner=56 - Philips PAL/SECAM multi (FQ12
 tuner=57 - Philips FQ1236A MK4
 tuner=58 - Ymec TVision TVF-8531MF
 tuner=59 - Ymec TVision TVF-5533MF
-tuner=60 - Thomson DDT 7611
+tuner=60 - Thomson DDT 7611 (ATSC/NTSC)
diff -upr a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
--- a/drivers/media/video/cx88/cx88-cards.c	2005-06-03 21:54:36.000000000 +0000
+++ b/drivers/media/video/cx88/cx88-cards.c	2005-06-03 22:10:56.000000000 +0000
@@ -428,16 +428,11 @@ struct cx88_board cx88_boards[] = {
 			.vmux   = 2,
 			.gpio0	= 0x0f00,
 		}},
-#if 0
-		.ts             = {
-			 .type   = CX88_TS,
-			 .gpio0  = 0x00000f01,   /* Hooked to tuner reset bit */
-		 }
-#endif
-	},
-        [CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q] = {
-                .name           = "DViCO - FusionHDTV 3 Gold-Q",
-                .tuner_type     = 52, /* Thomson DDT 7610 ATSC/NTSC - Its actually a 7611 chip, but this works */
+	},
+        [CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_T] = {
+                .name           = "DViCO - FusionHDTV 3 Gold-T",
+                .tuner_type     = 52, /* Thomson DDT 7611 ATSC/NTSC */
+               /*  See DViCO FusionHDTV 3 Gold for GPIO documentation.  */
                 .input          = {{
                         .type   = CX88_VMUX_TELEVISION,
                         .vmux   = 0,
@@ -455,12 +450,6 @@ struct cx88_board cx88_boards[] = {
                         .vmux   = 2,
                         .gpio0  = 0x0f00,
                 }},
-#if 0
-                .ts             = {
-                         .type   = CX88_TS,
-                         .gpio0  = 0x00000f01,   /* Hooked to tuner reset bit */
-                 }
-#endif
         },
         [CX88_BOARD_HAUPPAUGE_DVB_T1] = {
                 .name           = "Hauppauge Nova-T DVB-T",
@@ -723,7 +712,7 @@ struct cx88_subid cx88_subids[] = {
 	},{
 		.subvendor = 0x18ac,
 		.subdevice = 0xd820,
-		.card      = CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q,
+		.card      = CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_T,
 	},{
 		.subvendor = 0x18AC,
 		.subdevice = 0xDB00,
diff -upr a/drivers/media/video/cx88/cx88.h b/drivers/media/video/cx88/cx88.h
--- a/drivers/media/video/cx88/cx88.h	2005-06-03 21:54:36.000000000 +0000
+++ b/drivers/media/video/cx88/cx88.h	2005-06-03 21:55:44.000000000 +0000
@@ -163,7 +163,7 @@ extern struct sram_channel cx88_sram_cha
 #define CX88_BOARD_DIGITALLOGIC_MEC	       25
 #define CX88_BOARD_IODATA_GVBCTV7E         26
 #define CX88_BOARD_PIXELVIEW_PLAYTV_ULTRA_PRO 27
-#define CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q   28
+#define CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_T   28
 
 enum cx88_itype {
 	CX88_VMUX_COMPOSITE1 = 1,

--------------040101000303020601020704--
