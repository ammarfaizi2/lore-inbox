Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317080AbSEXJ4m>; Fri, 24 May 2002 05:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317117AbSEXJ4l>; Fri, 24 May 2002 05:56:41 -0400
Received: from [212.234.221.113] ([212.234.221.113]:51661 "EHLO
	mail.cev-sa.com") by vger.kernel.org with ESMTP id <S317080AbSEXJ4l>;
	Fri, 24 May 2002 05:56:41 -0400
Message-ID: <004001c20309$2832c4c0$6601a8c0@stlo.cevsa.com>
From: =?ISO-8859-1?Q? "Fran=E7ois?= Leblanc" 
	<francois.leblanc@cev-sa.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] kernel 2.4.18 endianness logical mistakes correction on fbcon-cfb2.c and fbcon-cfb4.c
Date: Fri, 24 May 2002 11:55:38 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DESCRIPTIONS:

2 small patchs to apply to:

drivers\video\fbcon-cfb2.c
drivers\video\fbcon-cf4.c o

This patchs correct the endianness logical of nibbletab, the first table is
u_char mades so no endian needed and the second swap correctly bytes in
LITTLE_ENDIAN. (old version swap half bytes instead of bytes).

 --- fbcon-cfb2.c.orig Fri May 24 10:24:17 2002
+++ fbcon-cfb2.c Fri May 24 10:29:30 2002
@@ -32,19 +32,10 @@
      */

 static u_char nibbletab_cfb2[]={
-#if defined(__BIG_ENDIAN)
  0x00,0x03,0x0c,0x0f,
  0x30,0x33,0x3c,0x3f,
  0xc0,0xc3,0xcc,0xcf,
  0xf0,0xf3,0xfc,0xff
-#elif defined(__LITTLE_ENDIAN)
- 0x00,0xc0,0x30,0xf0,
- 0x0c,0xcc,0x3c,0xfc,
- 0x03,0xc3,0x33,0xf3,
- 0x0f,0xcf,0x3f,0xff
-#else
-#error FIXME: No endianness??
-#endif
 };


--- fbcon-cfb4.c.orig Fri May 24 10:24:27 2002
+++ fbcon-cfb4.c Fri May 24 10:25:43 2002
@@ -38,10 +38,10 @@
     0xf000,0xf00f,0xf0f0,0xf0ff,
     0xff00,0xff0f,0xfff0,0xffff
 #elif defined(__LITTLE_ENDIAN)
-    0x0000,0xf000,0x0f00,0xff00,
-    0x00f0,0xf0f0,0x0ff0,0xfff0,
-    0x000f,0xf00f,0x0f0f,0xff0f,
-    0x00ff,0xf0ff,0x0fff,0xffff
+    0x0000,0x0f00,0xf000,0xff00,
+    0x000f,0x0f0f,0xf00f,0xff0f,
+    0x00f0,0x0ff0,0xf0f0,0xfff0,
+    0x00ff,0x0fff,0xf0ff,0xffff
 #else
 #error FIXME: No endianness??
 #endif


