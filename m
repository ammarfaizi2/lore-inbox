Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUDHTuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 15:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUDHTt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:49:59 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:28386 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262389AbUDHTtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:49:19 -0400
Date: Thu, 8 Apr 2004 12:47:52 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Patch 1/23 - Bitmaps, Cpumasks and Nodemasks
Message-Id: <20040408124752.16b22bb8.pj@sgi.com>
In-Reply-To: <20040408115050.2c67311a.pj@sgi.com>
References: <20040408115050.2c67311a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P1.bitmap_comment - Document bitmap.c bit model.
        Document the bitmap bit model, including handling of unused bits,
        and operation preconditions and postconditions.

Index: 2.6.5.bitmap/lib/bitmap.c
===================================================================
--- 2.6.5.bitmap.orig/lib/bitmap.c	2004-04-05 02:00:15.000000000 -0700
+++ 2.6.5.bitmap/lib/bitmap.c	2004-04-05 02:50:25.000000000 -0700
@@ -12,6 +12,26 @@
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 
+/*
+ * bitmaps provide an array of bits, implemented using an an
+ * array of unsigned longs.  The number of valid bits in a
+ * given bitmap need not be an exact multiple of BITS_PER_LONG.
+ *
+ * The possible unused bits in the last, partially used word
+ * of a bitmap are 'don't care'.  The implementation makes
+ * no particular effort to keep them zero.  It ensures that
+ * their value will not affect the results of any operation.
+ * The bitmap operations that return Boolean (bitmap_empty,
+ * for example) or scalar (bitmap_weight, for example) results
+ * carefully filter out these unused bits from impacting their
+ * results.
+ *
+ * Except for bitmap_complement, these operations hold to a
+ * slightly stronger rule: if you don't input any bitmaps to
+ * these ops that have some unused bits set, then they won't
+ * output any set unused bits in output bitmaps.
+ */
+
 #define MAX_BITMAP_BITS	512U	/* for ia64 NR_CPUS maximum */
 
 int bitmap_empty(const unsigned long *bitmap, int bits)


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
