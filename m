Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbUDAVli (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbUDAV2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:28:35 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:27698 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263173AbUDAVMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:12:23 -0500
Date: Thu, 1 Apr 2004 13:11:23 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: [Patch 4/23] mask v2 - two missing 'const' qualifiers
Message-Id: <20040401131123.560e673d.pj@sgi.com>
In-Reply-To: <20040401122802.23521599.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_4_of_23 - two missing 'const' qualifiers in bitops/bitmap
	Add a couple of missing 'const' qualifiers on
	bitops test_bit and bitmap_equal args.

Diffstat Patch_4_of_23:
 include/asm-generic/bitops.h   |    2 +-
 lib/bitmap.c                   |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

===================================================================
--- 2.6.4.orig/include/asm-generic/bitops.h	2004-03-31 22:04:06.000000000 -0800
+++ 2.6.4/include/asm-generic/bitops.h	2004-03-31 22:07:17.000000000 -0800
@@ -42,7 +42,7 @@
 	return retval;
 }
 
-extern __inline__ int test_bit(int nr, long * addr)
+extern __inline__ int test_bit(int nr, const unsigned long * addr)
 {
 	int	mask;
 
===================================================================
--- 2.6.4.orig/lib/bitmap.c	2004-03-31 22:07:07.000000000 -0800
+++ 2.6.4/lib/bitmap.c	2004-03-31 22:13:51.000000000 -0800
@@ -17,7 +17,7 @@
  *
  * The operations in this lib/bitmap.c, and the associated
  * files include/linux/bitmap.h, include/linux/bitops.h,
- * and include/asm-*/bitops.h, and in the *_BITMAP macros in
+ * and include/asm-<arch>/bitops.h, and in the *_BITMAP macros in
  * include/linux/types.h, support a model of a set of bits, in
  * positions 0 .. nbits-1, for some nbits size between 1 and some
  * modest size.  There is no specific limit on the size, but the
@@ -92,7 +92,7 @@
 EXPORT_SYMBOL(bitmap_full);
 
 int bitmap_equal(const unsigned long *bitmap1,
-		unsigned long *bitmap2, int bits)
+		const unsigned long *bitmap2, int bits)
 {
 	int k, lim = bits/BITS_PER_LONG;;
 	for (k = 0; k < lim; ++k)


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
