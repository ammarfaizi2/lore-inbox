Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261506AbSKWH6n>; Sat, 23 Nov 2002 02:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266981AbSKWH6n>; Sat, 23 Nov 2002 02:58:43 -0500
Received: from pD900E163.dip.t-dialin.net ([217.0.225.99]:1673 "EHLO
	gate.saftware.de") by vger.kernel.org with ESMTP id <S261506AbSKWH6m>;
	Sat, 23 Nov 2002 02:58:42 -0500
Subject: [PATCH] recognize ATI M3 & M4 video bios on Dell notebooks
From: Andreas Oberritter <obi@saftware.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1038038729.13725.6.camel@shiva>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 23 Nov 2002 09:05:29 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


This patch makes aty128fb find the video bios on a Latitude C600 (M3)
and Inspiron 8000 (M4).

If you reply, then please CC to me. I am not subscribed to the lkml.

Regards,
Andreas



diff -u -r1.26 aty128fb.c
--- drivers/video/aty128fb.c	2002/11/04 18:51:29	1.26
+++ drivers/video/aty128fb.c	2002/11/23 07:46:58
@@ -2134,9 +2134,12 @@
 	char *rom_base;
 	char *rom;
 	int  stage;
-	int  i;
+	int  i,j;
 	char aty_rom_sig[] = "761295520";   /* ATI ROM Signature      */
-	char R128_sig[] = "R128";           /* Rage128 ROM identifier */
+	char *R128_sig[] = {
+		"R128",           /* Rage128 ROM identifier */
+		"128b"
+	};
 
 	for (segstart=0x000c0000; segstart<0x000f0000; segstart+=0x00001000) {
         	stage = 1;
@@ -2167,10 +2170,14 @@
 
 		/* ATI signature found.  Let's see if it's a Rage128 */
 		for (i = 0; (i < 512) && (stage != 4); i++) {
-			if (R128_sig[0] == *rom)
-				if (strncmp(R128_sig, rom, 
-						strlen(R128_sig)) == 0)
-					stage = 4;
+		    for(j = 0;j < sizeof(R128_sig)/sizeof(char *);j++) {
+			if (R128_sig[j][0] == *rom)
+				if (strncmp(R128_sig[j], rom, 
+					    strlen(R128_sig[j])) == 0) {
+					      stage = 4;
+					      break;
+				            }
+		    }
 			rom++;
 		}
 		if (stage != 4) {



