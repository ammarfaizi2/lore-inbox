Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUDVHOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUDVHOD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbUDVHND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:13:03 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:49592 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263733AbUDVHJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:09:55 -0400
Date: Thu, 22 Apr 2004 00:07:53 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: [Patch 15 of 17] cpumask v4 - Convert physids_complement() to use
 both args
Message-Id: <20040422000753.1fd2ef0d.pj@sgi.com>
In-Reply-To: <20040421232247.22ffe1f2.pj@sgi.com>
References: <20040421232247.22ffe1f2.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mask15-cpumask-physids-complement - Convert physids_complement() to really use both args
        Provide for specifying distinct source and dest args to the
        physids_complement().  No one actually uses this macro yet.
        The physid_mask type would be a good candidate to convert to
        using this new mask ADT as a base.

Index: 2.6.5.bitmap/include/asm-i386/mpspec.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-i386/mpspec.h	2004-04-08 03:50:33.000000000 -0700
+++ 2.6.5.bitmap/include/asm-i386/mpspec.h	2004-04-08 04:21:18.000000000 -0700
@@ -53,7 +53,7 @@
 #define physids_and(dst, src1, src2)		bitmap_and((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_or(dst, src1, src2)		bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_clear(map)			bitmap_clear((map).mask, MAX_APICS)
-#define physids_complement(map)			bitmap_complement((map).mask, (map).mask, MAX_APICS)
+#define physids_complement(dst, src)		bitmap_complement((dst).mask, (src).mask, MAX_APICS)
 #define physids_empty(map)			bitmap_empty((map).mask, MAX_APICS)
 #define physids_equal(map1, map2)		bitmap_equal((map1).mask, (map2).mask, MAX_APICS)
 #define physids_weight(map)			bitmap_weight((map).mask, MAX_APICS)
Index: 2.6.5.bitmap/include/asm-x86_64/mpspec.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-x86_64/mpspec.h	2004-04-08 03:50:33.000000000 -0700
+++ 2.6.5.bitmap/include/asm-x86_64/mpspec.h	2004-04-08 04:21:18.000000000 -0700
@@ -212,7 +212,7 @@
 #define physids_and(dst, src1, src2)		bitmap_and((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_or(dst, src1, src2)		bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_clear(map)			bitmap_clear((map).mask, MAX_APICS)
-#define physids_complement(map)			bitmap_complement((map).mask, (map).mask, MAX_APICS)
+#define physids_complement(dst, src)		bitmap_complement((dst).mask, (src).mask, MAX_APICS)
 #define physids_empty(map)			bitmap_empty((map).mask, MAX_APICS)
 #define physids_equal(map1, map2)		bitmap_equal((map1).mask, (map2).mask, MAX_APICS)
 #define physids_weight(map)			bitmap_weight((map).mask, MAX_APICS)


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
