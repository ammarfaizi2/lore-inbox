Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbUDHTwu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 15:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUDHTu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:50:59 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:25059 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262422AbUDHTth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:49:37 -0400
Date: Thu, 8 Apr 2004 12:48:51 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Patch 4/23 - Bitmaps, Cpumasks and Nodemasks
Message-Id: <20040408124851.7f461594.pj@sgi.com>
In-Reply-To: <20040408115050.2c67311a.pj@sgi.com>
References: <20040408115050.2c67311a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P4.bitmap_const - two missing 'const' qualifiers in bitops/bitmap
        Add a couple of missing 'const' qualifiers on
        bitops test_bit and bitmap_equal args.

Index: 2.6.5.bitmap/include/asm-generic/bitops.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-generic/bitops.h	2004-04-05 02:41:32.000000000 -0700
+++ 2.6.5.bitmap/include/asm-generic/bitops.h	2004-04-05 03:15:17.000000000 -0700
@@ -42,7 +42,7 @@
 	return retval;
 }
 
-extern __inline__ int test_bit(int nr, long * addr)
+extern __inline__ int test_bit(int nr, const unsigned long * addr)
 {
 	int	mask;
 
Index: 2.6.5.bitmap/lib/bitmap.c
===================================================================
--- 2.6.5.bitmap.orig/lib/bitmap.c	2004-04-05 03:12:27.000000000 -0700
+++ 2.6.5.bitmap/lib/bitmap.c	2004-04-05 03:15:17.000000000 -0700
@@ -65,7 +65,7 @@
 EXPORT_SYMBOL(bitmap_full);
 
 int bitmap_equal(const unsigned long *bitmap1,
-		unsigned long *bitmap2, int bits)
+		const unsigned long *bitmap2, int bits)
 {
 	int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
