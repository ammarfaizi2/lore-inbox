Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUDHURz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 16:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbUDHT4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:56:39 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:44519 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262476AbUDHTvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:51:21 -0400
Date: Thu, 8 Apr 2004 12:49:55 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Patch 13/23 - Bitmaps, Cpumasks and Nodemasks
Message-Id: <20040408124955.61288c45.pj@sgi.com>
In-Reply-To: <20040408115050.2c67311a.pj@sgi.com>
References: <20040408115050.2c67311a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P13.cpumask_physids_complement - Convert physids_complement() to really use both args
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
