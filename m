Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbTFFT7g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 15:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbTFFT7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 15:59:36 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:19135 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262256AbTFFT7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 15:59:34 -0400
Date: Fri, 6 Jun 2003 22:13:07 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>
Subject: [Patch] 2.5.70-bk11 zlib merge #4 pure magic
Message-ID: <20030606201306.GJ10487@wohnheim.fh-wedel.de>
References: <20030606183126.GA10487@wohnheim.fh-wedel.de> <20030606183247.GB10487@wohnheim.fh-wedel.de> <20030606183920.GC10487@wohnheim.fh-wedel.de> <20030606185210.GE10487@wohnheim.fh-wedel.de> <20030606192325.GG10487@wohnheim.fh-wedel.de> <20030606192814.GH10487@wohnheim.fh-wedel.de> <20030606200051.GI10487@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030606200051.GI10487@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

This one is pure magic, really.  No comment and inspection of the code
doesn't show much either.  But judging from the other changes, this
should also fix a real problem, at least a theoretical one.

The only code that could be bitten by this change is ppp, so I changed
that as well.  Paulus, could you have a quick look at it?

Jörn

-- 
This above all: to thine own self be true.
-- Shakespeare

--- linux-2.5.70-bk11/lib/zlib_deflate/deflate.c~zlib_merge_magic	2003-06-06 20:44:51.000000000 +0200
+++ linux-2.5.70-bk11/lib/zlib_deflate/deflate.c	2003-06-06 22:05:30.000000000 +0200
@@ -216,7 +216,7 @@
         windowBits = -windowBits;
     }
     if (memLevel < 1 || memLevel > MAX_MEM_LEVEL || method != Z_DEFLATED ||
-        windowBits < 8 || windowBits > 15 || level < 0 || level > 9 ||
+        windowBits < 9 || windowBits > 15 || level < 0 || level > 9 ||
 	strategy < 0 || strategy > Z_HUFFMAN_ONLY) {
         return Z_STREAM_ERROR;
     }
--- linux-2.5.70-bk11/include/linux/ppp-comp.h~zlib_merge_magic	2003-06-05 17:46:35.000000000 +0200
+++ linux-2.5.70-bk11/include/linux/ppp-comp.h	2003-06-06 22:07:08.000000000 +0200
@@ -182,7 +182,7 @@
 #define CI_DEFLATE_DRAFT	24	/* value used in original draft RFC */
 #define CILEN_DEFLATE		4	/* length of its config option */
 
-#define DEFLATE_MIN_SIZE	8
+#define DEFLATE_MIN_SIZE	9
 #define DEFLATE_MAX_SIZE	15
 #define DEFLATE_METHOD_VAL	8
 #define DEFLATE_SIZE(x)		(((x) >> 4) + DEFLATE_MIN_SIZE)
