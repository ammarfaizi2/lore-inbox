Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265361AbUGDEAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265361AbUGDEAf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 00:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265387AbUGDEAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 00:00:35 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:56442 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265361AbUGDEAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 00:00:30 -0400
Date: Sat, 3 Jul 2004 20:59:09 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Paul Jackson <pj@sgi.com>,
       Simon <Simon.Derr@bull.net>
Message-Id: <20040704035909.10365.17449.82915@sam.engr.sgi.com>
Subject: [patch] remaining cpumask const qualifiers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The remainder of the const qualifiers on cpumask ops.

My cpumask overhaul missed specifying the const qualifiers
in cpumask.h.  Subsequently, Linus has added some.  The following
should provide the remainder of them.  It also fixes one src vs dst
variable misnaming.

Using crosstool on 2.6.7-mm5, I have built the following
arch's with the following change included:

  alpha ia64 powerpc-405 powerpc-750 sparc sparc64 x86_64

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.7-mm5/include/linux/cpumask.h
===================================================================
--- 2.6.7-mm5.orig/include/linux/cpumask.h	2004-07-01 19:05:31.000000000 -0700
+++ 2.6.7-mm5/include/linux/cpumask.h	2004-07-01 19:30:10.000000000 -0700
@@ -114,58 +114,58 @@ static inline int __cpu_test_and_set(int
 }
 
 #define cpus_and(dst, src1, src2) __cpus_and(&(dst), &(src1), &(src2), NR_CPUS)
-static inline void __cpus_and(cpumask_t *dstp, cpumask_t *src1p,
-					cpumask_t *src2p, int nbits)
+static inline void __cpus_and(cpumask_t *dstp, const cpumask_t *src1p,
+					const cpumask_t *src2p, int nbits)
 {
 	bitmap_and(dstp->bits, src1p->bits, src2p->bits, nbits);
 }
 
 #define cpus_or(dst, src1, src2) __cpus_or(&(dst), &(src1), &(src2), NR_CPUS)
-static inline void __cpus_or(cpumask_t *dstp, cpumask_t *src1p,
-					cpumask_t *src2p, int nbits)
+static inline void __cpus_or(cpumask_t *dstp, const cpumask_t *src1p,
+					const cpumask_t *src2p, int nbits)
 {
 	bitmap_or(dstp->bits, src1p->bits, src2p->bits, nbits);
 }
 
 #define cpus_xor(dst, src1, src2) __cpus_xor(&(dst), &(src1), &(src2), NR_CPUS)
-static inline void __cpus_xor(cpumask_t *dstp, cpumask_t *src1p,
-					cpumask_t *src2p, int nbits)
+static inline void __cpus_xor(cpumask_t *dstp, const cpumask_t *src1p,
+					const cpumask_t *src2p, int nbits)
 {
 	bitmap_xor(dstp->bits, src1p->bits, src2p->bits, nbits);
 }
 
 #define cpus_andnot(dst, src1, src2) \
 				__cpus_andnot(&(dst), &(src1), &(src2), NR_CPUS)
-static inline void __cpus_andnot(cpumask_t *dstp, cpumask_t *src1p,
-					cpumask_t *src2p, int nbits)
+static inline void __cpus_andnot(cpumask_t *dstp, const cpumask_t *src1p,
+					const cpumask_t *src2p, int nbits)
 {
 	bitmap_andnot(dstp->bits, src1p->bits, src2p->bits, nbits);
 }
 
 #define cpus_complement(dst, src) __cpus_complement(&(dst), &(src), NR_CPUS)
 static inline void __cpus_complement(cpumask_t *dstp,
-					cpumask_t *srcp, int nbits)
+					const cpumask_t *srcp, int nbits)
 {
 	bitmap_complement(dstp->bits, srcp->bits, nbits);
 }
 
 #define cpus_equal(src1, src2) __cpus_equal(&(src1), &(src2), NR_CPUS)
-static inline int __cpus_equal(cpumask_t *src1p,
-					cpumask_t *src2p, int nbits)
+static inline int __cpus_equal(const cpumask_t *src1p,
+					const cpumask_t *src2p, int nbits)
 {
 	return bitmap_equal(src1p->bits, src2p->bits, nbits);
 }
 
 #define cpus_intersects(src1, src2) __cpus_intersects(&(src1), &(src2), NR_CPUS)
-static inline int __cpus_intersects(cpumask_t *src1p,
-					cpumask_t *src2p, int nbits)
+static inline int __cpus_intersects(const cpumask_t *src1p,
+					const cpumask_t *src2p, int nbits)
 {
 	return bitmap_intersects(src1p->bits, src2p->bits, nbits);
 }
 
 #define cpus_subset(src1, src2) __cpus_subset(&(src1), &(src2), NR_CPUS)
-static inline int __cpus_subset(cpumask_t *src1p,
-					cpumask_t *src2p, int nbits)
+static inline int __cpus_subset(const cpumask_t *src1p,
+					const cpumask_t *src2p, int nbits)
 {
 	return bitmap_subset(src1p->bits, src2p->bits, nbits);
 }
@@ -257,7 +257,7 @@ static inline int __next_cpu(int n, cons
 #define cpumask_scnprintf(buf, len, src) \
 			__cpumask_scnprintf((buf), (len), &(src), NR_CPUS)
 static inline int __cpumask_scnprintf(char *buf, int len,
-					cpumask_t *srcp, int nbits)
+					const cpumask_t *srcp, int nbits)
 {
 	return bitmap_scnprintf(buf, len, srcp->bits, nbits);
 }
@@ -265,9 +265,9 @@ static inline int __cpumask_scnprintf(ch
 #define cpumask_parse(ubuf, ulen, src) \
 			__cpumask_parse((ubuf), (ulen), &(src), NR_CPUS)
 static inline int __cpumask_parse(const char __user *buf, int len,
-					cpumask_t *srcp, int nbits)
+					cpumask_t *dstp, int nbits)
 {
-	return bitmap_parse(buf, len, srcp->bits, nbits);
+	return bitmap_parse(buf, len, dstp->bits, nbits);
 }
 
 #if NR_CPUS > 1

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
