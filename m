Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265679AbTFNNjN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 09:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265673AbTFNNiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 09:38:25 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:24747 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S265663AbTFNNgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 09:36:37 -0400
Date: Sat, 14 Jun 2003 15:50:26 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Marcelo Tosatti <marcelo@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.21 zlib merge #4 windowBits
Message-ID: <20030614135026.GG15099@wohnheim.fh-wedel.de>
References: <20030614134708.GD15099@wohnheim.fh-wedel.de> <20030614134811.GE15099@wohnheim.fh-wedel.de> <20030614134912.GF15099@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030614134912.GF15099@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Disallow windowBits <9 (windowBits=9 would hit a bug) for deflate and
do the same for ppp.

Jörn

-- 
Anything that can go wrong, will.
-- Finagle's Law

--- linux-2.4.20/lib/zlib_deflate/deflate.c~zlib_merge_magic	2003-06-10 12:37:17.000000000 +0200
+++ linux-2.4.20/lib/zlib_deflate/deflate.c	2003-06-10 17:01:02.000000000 +0200
@@ -215,7 +215,7 @@
         windowBits = -windowBits;
     }
     if (memLevel < 1 || memLevel > MAX_MEM_LEVEL || method != Z_DEFLATED ||
-        windowBits < 8 || windowBits > 15 || level < 0 || level > 9 ||
+        windowBits < 9 || windowBits > 15 || level < 0 || level > 9 ||
 	strategy < 0 || strategy > Z_HUFFMAN_ONLY) {
         return Z_STREAM_ERROR;
     }
--- linux-2.4.20/include/linux/ppp-comp.h~zlib_merge_magic	1999-08-06 19:44:11.000000000 +0200
+++ linux-2.4.20/include/linux/ppp-comp.h	2003-06-10 17:01:02.000000000 +0200
@@ -177,7 +177,7 @@
 #define CI_DEFLATE_DRAFT	24	/* value used in original draft RFC */
 #define CILEN_DEFLATE		4	/* length of its config option */
 
-#define DEFLATE_MIN_SIZE	8
+#define DEFLATE_MIN_SIZE	9
 #define DEFLATE_MAX_SIZE	15
 #define DEFLATE_METHOD_VAL	8
 #define DEFLATE_SIZE(x)		(((x) >> 4) + DEFLATE_MIN_SIZE)
