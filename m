Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317157AbSFKQQG>; Tue, 11 Jun 2002 12:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317159AbSFKQQF>; Tue, 11 Jun 2002 12:16:05 -0400
Received: from [212.234.221.113] ([212.234.221.113]:9800 "EHLO mail.cev-sa.com")
	by vger.kernel.org with ESMTP id <S317168AbSFKQQA>;
	Tue, 11 Jun 2002 12:16:00 -0400
Message-ID: <015401c21162$f2ebc4c0$6601a8c0@stlo.cevsa.com>
From: =?ISO-8859-1?Q? "Fran=E7ois?= Leblanc" 
	<francois.leblanc@cev-sa.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] friendly kernel 2.4.18 endianness logical mistakes patch correction on fbcon-cfb2.c and fbcon-cfb4.c
Date: Tue, 11 Jun 2002 18:13:39 +0200
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

SECOND VERSION 2 small patchs to apply to::

drivers\video\fbcon-cfb2.c
drivers\video\fbcon-cf4.c o

This patchs correct the endianness logical of nibbletab, the first table is
u_char mades so no endian needed and the second swap correctly bytes in
LITTLE_ENDIAN. (old version swap half bytes instead of bytes).

Second version, is much more FRIENDLY and don't break current tree but let
the ability to create new option in driver/video/Config.in, option
CONFIG_FBCON_NOSWAP witch reverse and correct tables orders for fbcon-cfb4.c
and fbcon-cfb2.c.
Patchs don't add currently the CONFIG_FBCON_NOSWAP option definition in
Config.in since I use it in other tree so this can be quickly integrated to
linux kernel and defined in other linux kernel tree without too much
unuseful changes. Option will be added in main linux kernel
driver/video/Config.in only if necessary (It supposed not).

--- fbcon-cfb2.c.orig Tue Jun 11 15:27:57 2002
+++ fbcon-cfb2.c Tue Jun 11 17:37:52 2002
@@ -32,7 +32,7 @@
      */

 static u_char nibbletab_cfb2[]={
-#if defined(__BIG_ENDIAN)
+#if defined(__BIG_ENDIAN) || (defined(__LITTLE_ENDIAN) && defined
(CONFIG_FBCON_NOSWAP))
  0x00,0x03,0x0c,0x0f,
  0x30,0x33,0x3c,0x3f,
  0xc0,0xc3,0xcc,0xcf,

--- fbcon-cfb4.c.orig Tue Jun 11 15:27:35 2002
+++ fbcon-cfb4.c Tue Jun 11 17:14:09 2002
@@ -37,7 +37,12 @@
     0x0f00,0x0f0f,0x0ff0,0x0fff,
     0xf000,0xf00f,0xf0f0,0xf0ff,
     0xff00,0xff0f,0xfff0,0xffff
-#elif defined(__LITTLE_ENDIAN)
+#elif defined(__LITTLE_ENDIAN) && defined (CONFIG_FBCON_NOSWAP)
+    0x0000,0x0f00,0xf000,0xff00,
+    0x000f,0x0f0f,0xf00f,0xff0f,
+    0x00f0,0x0ff0,0xf0f0,0xfff0,
+    0x00ff,0x0fff,0xf0ff,0xffff
+#elif defined(__LITTLE_ENDIAN)
     0x0000,0xf000,0x0f00,0xff00,
     0x00f0,0xf0f0,0x0ff0,0xfff0,
     0x000f,0xf00f,0x0f0f,0xff0f,


