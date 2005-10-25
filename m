Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVJYOcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVJYOcL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 10:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVJYOcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 10:32:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:39334 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932164AbVJYOcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 10:32:09 -0400
Date: Tue, 25 Oct 2005 07:31:57 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Paul Jackson <pj@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051025143157.23950.31576.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] cpuset remap const fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Put const qualifier on the const argument of various bitmap,
nodemask and cpumask *_remap definitions, instead of on the
other argument.  ... duh.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

This fixes a botch in *-mm patch "cpuset bitmap and mask remap operators"

 include/linux/bitmap.h   |    2 +-
 include/linux/cpumask.h  |    2 +-
 include/linux/nodemask.h |    2 +-
 lib/bitmap.c             |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- 2.6.14-rc4-mm1-cpuset-patches.orig/include/linux/bitmap.h	2005-10-25 00:45:50.397954959 -0700
+++ 2.6.14-rc4-mm1-cpuset-patches/include/linux/bitmap.h	2005-10-25 00:46:28.747004170 -0700
@@ -106,7 +106,7 @@ extern int bitmap_scnlistprintf(char *bu
 			const unsigned long *src, int nbits);
 extern int bitmap_parselist(const char *buf, unsigned long *maskp,
 			int nmaskbits);
-extern void bitmap_remap(const unsigned long *dst, unsigned long *src,
+extern void bitmap_remap(unsigned long *dst, const unsigned long *src,
 		const unsigned long *old, const unsigned long *new, int bits);
 extern int bitmap_bitremap(int oldbit,
 		const unsigned long *old, const unsigned long *new, int bits);
--- 2.6.14-rc4-mm1-cpuset-patches.orig/include/linux/cpumask.h	2005-10-25 00:45:50.408697263 -0700
+++ 2.6.14-rc4-mm1-cpuset-patches/include/linux/cpumask.h	2005-10-25 00:46:28.747980743 -0700
@@ -308,7 +308,7 @@ static inline int __cpu_remap(int oldbit
 
 #define cpus_remap(dst, src, old, new) \
 		__cpus_remap(&(dst), &(src), &(old), &(new), NR_CPUS)
-static inline void __cpus_remap(const cpumask_t *dstp, cpumask_t *srcp,
+static inline void __cpus_remap(cpumask_t *dstp, const cpumask_t *srcp,
 		const cpumask_t *oldp, const cpumask_t *newp, int nbits)
 {
 	bitmap_remap(dstp->bits, srcp->bits, oldp->bits, newp->bits, nbits);
--- 2.6.14-rc4-mm1-cpuset-patches.orig/include/linux/nodemask.h	2005-10-25 00:45:50.414556702 -0700
+++ 2.6.14-rc4-mm1-cpuset-patches/include/linux/nodemask.h	2005-10-25 00:46:28.748957316 -0700
@@ -321,7 +321,7 @@ static inline int __node_remap(int oldbi
 
 #define nodes_remap(dst, src, old, new) \
 		__nodes_remap(&(dst), &(src), &(old), &(new), MAX_NUMNODES)
-static inline void __nodes_remap(const nodemask_t *dstp, nodemask_t *srcp,
+static inline void __nodes_remap(nodemask_t *dstp, const nodemask_t *srcp,
 		const nodemask_t *oldp, const nodemask_t *newp, int nbits)
 {
 	bitmap_remap(dstp->bits, srcp->bits, oldp->bits, newp->bits, nbits);
--- 2.6.14-rc4-mm1-cpuset-patches.orig/lib/bitmap.c	2005-10-25 00:45:50.415533275 -0700
+++ 2.6.14-rc4-mm1-cpuset-patches/lib/bitmap.c	2005-10-25 07:18:24.250477667 -0700
@@ -619,7 +619,7 @@ static int bitmap_ord_to_pos(const unsig
  * comes into this routine with bits 1, 5 and 7 set, then @dst should
  * leave with bits 12, 13 and 15 set.
  */
-void bitmap_remap(const unsigned long *dst, unsigned long *src,
+void bitmap_remap(unsigned long *dst, const unsigned long *src,
 		const unsigned long *old, const unsigned long *new,
 		int bits)
 {

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
