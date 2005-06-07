Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVFGM5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVFGM5d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 08:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVFGM5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 08:57:32 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:47245 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261850AbVFGM5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 08:57:25 -0400
Message-ID: <42A599B2.6000406@m1k.net>
Date: Tue, 07 Jun 2005 08:57:22 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Tuner Thomson DDT 7611 (ATSC/NTSC)
Content-Type: multipart/mixed;
 boundary="------------010500080505040109030504"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010500080505040109030504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add support for tuner#60: Thomson DDT 7611 (ATSC/NTSC)
Change tuner in card#28 (DViCO FusionHDTV3 Gold-T) from tuner=52 (Tuner 
Thomson DDT 7610) to tuner=60 (Tuner Thomson DDT 7611)

Signed-off-by: Michael Krufky <mkrufky@m1k.net>

-- 
Michael Krufky


--------------010500080505040109030504
Content-Type: text/plain;
 name="tuner-thomson-dtt7611.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tuner-thomson-dtt7611.patch"

diff -upr linux-2.6.12-rc6-mm1/drivers/media/video/cx88/cx88-cards.c linux-2.6.12-rc6-mm1-patched/drivers/media/video/cx88/cx88-cards.c
--- linux-2.6.12-rc6-mm1/drivers/media/video/cx88/cx88-cards.c	2005-06-07 07:58:15.000000000 +0000
+++ linux-2.6.12-rc6-mm1-patched/drivers/media/video/cx88/cx88-cards.c	2005-06-07 08:10:55.000000000 +0000
@@ -431,7 +431,7 @@ struct cx88_board cx88_boards[] = {
 	},
         [CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_T] = {
                 .name           = "DViCO - FusionHDTV 3 Gold-T",
-                .tuner_type     = 52, /* Thomson DDT 7611 ATSC/NTSC */
+                .tuner_type     = 60, /* Thomson DDT 7611 ATSC/NTSC */
                /*  See DViCO FusionHDTV 3 Gold for GPIO documentation.  */
                 .input          = {{
                         .type   = CX88_VMUX_TELEVISION,
diff -upr linux-2.6.12-rc6-mm1/drivers/media/video/tuner-simple.c linux-2.6.12-rc6-mm1-patched/drivers/media/video/tuner-simple.c
--- linux-2.6.12-rc6-mm1/drivers/media/video/tuner-simple.c	2005-06-07 07:58:15.000000000 +0000
+++ linux-2.6.12-rc6-mm1-patched/drivers/media/video/tuner-simple.c	2005-06-07 08:06:15.000000000 +0000
@@ -217,6 +217,9 @@ static struct tunertype tuners[] = {
 	  16*160.00,16*454.00,0xa0,0x90,0x30,0x8e,732},
 	{ "Ymec TVision TVF-5533MF", Philips, NTSC,
 	  16*160.00,16*454.00,0x01,0x02,0x04,0x8e,732},
+
+	{ "Thomson DDT 7611 (ATSC/NTSC)", THOMSON, ATSC,
+	  16*157.25,16*454.00,0x39,0x3a,0x3c,0x8e,732},
 };
 unsigned const int tuner_count = ARRAY_SIZE(tuners);
 
diff -upr linux-2.6.12-rc6-mm1/include/media/tuner.h linux-2.6.12-rc6-mm1-patched/include/media/tuner.h
--- linux-2.6.12-rc6-mm1/include/media/tuner.h	2005-06-07 07:58:16.000000000 +0000
+++ linux-2.6.12-rc6-mm1-patched/include/media/tuner.h	2005-06-07 08:09:32.000000000 +0000
@@ -101,6 +101,8 @@
 #define TUNER_YMEC_TVF_8531MF 58
 #define TUNER_YMEC_TVF_5533MF 59	/* Pixelview Pro Ultra NTSC */
 
+#define TUNER_THOMSON_DTT7611    60
+
 #define NOTUNER 0
 #define PAL     1	/* PAL_BG */
 #define PAL_I   2

--------------010500080505040109030504--
