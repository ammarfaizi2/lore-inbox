Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263213AbUDAV50 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbUDAVX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:23:59 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:60981 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263204AbUDAVOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:14:19 -0500
Date: Thu, 1 Apr 2004 13:13:04 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: [Patch 21/23] mask v2 - Dyadic physids_complement()
Message-Id: <20040401131304.08126d92.pj@sgi.com>
In-Reply-To: <20040401122802.23521599.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_21_of_23 - Convert physids_complement() to really use both args
	Provide for specifying distinct source and dest args to the
	physids_complement().  No one actually uses this macro yet.
	The physid_mask type would be a good candidate to convert to
	using this new mask ADT as a base.

Diffstat Patch_21_of_23:
 asm-i386/mpspec.h              |    2 +-
 asm-x86_64/mpspec.h            |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -Nru a/include/asm-i386/mpspec.h b/include/asm-i386/mpspec.h
--- a/include/asm-i386/mpspec.h	Mon Mar 29 01:04:04 2004
+++ b/include/asm-i386/mpspec.h	Mon Mar 29 01:04:04 2004
@@ -60,7 +60,7 @@
 #define physids_and(dst, src1, src2)		bitmap_and((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_or(dst, src1, src2)		bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_clear(map)			bitmap_clear((map).mask, MAX_APICS)
-#define physids_complement(map)			bitmap_complement((map).mask, (map).mask, MAX_APICS)
+#define physids_complement(dst, src)		bitmap_complement((dst).mask, (src).mask, MAX_APICS)
 #define physids_empty(map)			bitmap_empty((map).mask, MAX_APICS)
 #define physids_equal(map1, map2)		bitmap_equal((map1).mask, (map2).mask, MAX_APICS)
 #define physids_weight(map)			bitmap_weight((map).mask, MAX_APICS)
diff -Nru a/include/asm-x86_64/mpspec.h b/include/asm-x86_64/mpspec.h
--- a/include/asm-x86_64/mpspec.h	Mon Mar 29 01:04:04 2004
+++ b/include/asm-x86_64/mpspec.h	Mon Mar 29 01:04:04 2004
@@ -214,7 +214,7 @@
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
