Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270594AbTGNMdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270614AbTGNMcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:32:00 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39812
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270572AbTGNMH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:07:57 -0400
Date: Mon, 14 Jul 2003 13:21:56 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141221.h6ECLuOM030872@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: fix sbni driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/net/wan/sbni.c linux.22-pre5-ac1/drivers/net/wan/sbni.c
--- linux.22-pre5/drivers/net/wan/sbni.c	2003-07-14 12:26:39.000000000 +0100
+++ linux.22-pre5-ac1/drivers/net/wan/sbni.c	2003-07-07 15:54:55.000000000 +0100
@@ -1552,13 +1552,13 @@
 static u32
 calc_crc32( u32  crc,  u8  *p,  u32  len )
 {
-	register u32  _crc __asm ( "ax" );
+	register u32  _crc;
 	_crc = crc;
 	
 	__asm __volatile (
 		"xorl	%%ebx, %%ebx\n"
-		"movl	%1, %%esi\n" 
-		"movl	%2, %%ecx\n" 
+		"movl	%2, %%esi\n" 
+		"movl	%3, %%ecx\n" 
 		"movl	$crc32tab, %%edi\n"
 		"shrl	$2, %%ecx\n"
 		"jz	1f\n"
@@ -1594,7 +1594,7 @@
 		"jnz	0b\n"
 
 	"1:\n"
-		"movl	%2, %%ecx\n"
+		"movl	%3, %%ecx\n"
 		"andl	$3, %%ecx\n"
 		"jz	2f\n"
 
@@ -1619,9 +1619,9 @@
 		"xorb	2(%%esi), %%bl\n"
 		"xorl	(%%edi,%%ebx,4), %%eax\n"
 	"2:\n"
-		:
-		: "a" (_crc), "g" (p), "g" (len)
-		: "ax", "bx", "cx", "dx", "si", "di"
+		: "=a" (_crc)
+		: "0" (_crc), "g" (p), "g" (len)
+		: "bx", "cx", "dx", "si", "di"
 	);
 
 	return  _crc;
