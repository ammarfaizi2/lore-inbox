Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318152AbSIEVuz>; Thu, 5 Sep 2002 17:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318162AbSIEVuy>; Thu, 5 Sep 2002 17:50:54 -0400
Received: from hermes.domdv.de ([193.102.202.1]:36361 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S318152AbSIEVuv>;
	Thu, 5 Sep 2002 17:50:51 -0400
Message-ID: <3D77BCEC.4070400@domdv.de>
Date: Thu, 05 Sep 2002 22:22:04 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.20pre5 trivial assembler warning fix for pci-pc.c
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000909040407090509040409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000909040407090509040409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

trivial fix for "Warning: indirect lcall without `*'" assembler warnings
attached.
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--------------000909040407090509040409
Content-Type: text/plain;
 name="pci-pc.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci-pc.c.diff"

--- arch/i386/kernel/pci-pc.c.orig	2002-09-05 22:16:40.000000000 +0200
+++ arch/i386/kernel/pci-pc.c	2002-09-05 22:18:00.000000000 +0200
@@ -589,7 +589,7 @@
 	unsigned long flags;
 
 	__save_flags(flags); __cli();
-	__asm__("lcall (%%edi); cld"
+	__asm__("lcall *(%%edi); cld"
 		: "=a" (return_code),
 		  "=b" (address),
 		  "=c" (length),
@@ -630,7 +630,7 @@
 
 		__save_flags(flags); __cli();
 		__asm__(
-			"lcall (%%edi); cld\n\t"
+			"lcall *(%%edi); cld\n\t"
 			"jc 1f\n\t"
 			"xor %%ah, %%ah\n"
 			"1:"
@@ -675,7 +675,7 @@
 	unsigned short bx;
 	unsigned short ret;
 
-	__asm__("lcall (%%edi); cld\n\t"
+	__asm__("lcall *(%%edi); cld\n\t"
 		"jc 1f\n\t"
 		"xor %%ah, %%ah\n"
 		"1:"
@@ -704,7 +704,7 @@
 
 	switch (len) {
 	case 1:
-		__asm__("lcall (%%esi); cld\n\t"
+		__asm__("lcall *(%%esi); cld\n\t"
 			"jc 1f\n\t"
 			"xor %%ah, %%ah\n"
 			"1:"
@@ -716,7 +716,7 @@
 			  "S" (&pci_indirect));
 		break;
 	case 2:
-		__asm__("lcall (%%esi); cld\n\t"
+		__asm__("lcall *(%%esi); cld\n\t"
 			"jc 1f\n\t"
 			"xor %%ah, %%ah\n"
 			"1:"
@@ -728,7 +728,7 @@
 			  "S" (&pci_indirect));
 		break;
 	case 4:
-		__asm__("lcall (%%esi); cld\n\t"
+		__asm__("lcall *(%%esi); cld\n\t"
 			"jc 1f\n\t"
 			"xor %%ah, %%ah\n"
 			"1:"
@@ -759,7 +759,7 @@
 
 	switch (len) {
 	case 1:
-		__asm__("lcall (%%esi); cld\n\t"
+		__asm__("lcall *(%%esi); cld\n\t"
 			"jc 1f\n\t"
 			"xor %%ah, %%ah\n"
 			"1:"
@@ -771,7 +771,7 @@
 			  "S" (&pci_indirect));
 		break;
 	case 2:
-		__asm__("lcall (%%esi); cld\n\t"
+		__asm__("lcall *(%%esi); cld\n\t"
 			"jc 1f\n\t"
 			"xor %%ah, %%ah\n"
 			"1:"
@@ -783,7 +783,7 @@
 			  "S" (&pci_indirect));
 		break;
 	case 4:
-		__asm__("lcall (%%esi); cld\n\t"
+		__asm__("lcall *(%%esi); cld\n\t"
 			"jc 1f\n\t"
 			"xor %%ah, %%ah\n"
 			"1:"
@@ -1006,7 +1006,7 @@
 	__asm__("push %%es\n\t"
 		"push %%ds\n\t"
 		"pop  %%es\n\t"
-		"lcall (%%esi); cld\n\t"
+		"lcall *(%%esi); cld\n\t"
 		"pop %%es\n\t"
 		"jc 1f\n\t"
 		"xor %%ah, %%ah\n"
@@ -1039,7 +1039,7 @@
 {
 	int ret;
 
-	__asm__("lcall (%%esi); cld\n\t"
+	__asm__("lcall *(%%esi); cld\n\t"
 		"jc 1f\n\t"
 		"xor %%ah, %%ah\n"
 		"1:"

--------------000909040407090509040409--


