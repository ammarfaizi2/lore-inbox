Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263811AbUDVHTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263811AbUDVHTL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbUDVHRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:17:50 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:34994 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263708AbUDVHJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:09:16 -0400
Date: Thu, 22 Apr 2004 00:07:03 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: [Patch 4 of 17] cpumask v4 - two missing 'const' qualifiers in
 bitops/bitmap
Message-Id: <20040422000703.2060692e.pj@sgi.com>
In-Reply-To: <20040421232247.22ffe1f2.pj@sgi.com>
References: <20040421232247.22ffe1f2.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mask4-bitmap-const - two missing 'const' qualifiers in bitops/bitmap
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
