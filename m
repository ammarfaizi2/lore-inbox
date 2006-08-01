Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751788AbWHASxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbWHASxY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWHASxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:53:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5058 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751788AbWHASxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:53:23 -0400
Date: Tue, 1 Aug 2006 14:53:21 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: must_check attributes for bitmap functions.
Message-ID: <20060801185321.GR22240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just unearthed this old patch I did.  I'm fairly certain I did
this in response to a bug where one of these functions went unchecked,
but I can't seem to find any reference of that bug any more.

Signed-off-by: Dave Jones <davej@redhat.com>


--- linux-2.6.15.noarch/include/linux/bitmap.h~	2006-02-17 14:05:18.000000000 -0500
+++ linux-2.6.15.noarch/include/linux/bitmap.h	2006-02-17 14:06:14.000000000 -0500
@@ -196,7 +196,7 @@ static inline void bitmap_complement(uns
 		__bitmap_complement(dst, src, nbits);
 }
 
-static inline int bitmap_equal(const unsigned long *src1,
+static inline int __must_check bitmap_equal(const unsigned long *src1,
 			const unsigned long *src2, int nbits)
 {
 	if (nbits <= BITS_PER_LONG)
@@ -205,7 +205,7 @@ static inline int bitmap_equal(const uns
 		return __bitmap_equal(src1, src2, nbits);
 }
 
-static inline int bitmap_intersects(const unsigned long *src1,
+static inline int __must_check bitmap_intersects(const unsigned long *src1,
 			const unsigned long *src2, int nbits)
 {
 	if (nbits <= BITS_PER_LONG)
@@ -214,7 +214,7 @@ static inline int bitmap_intersects(cons
 		return __bitmap_intersects(src1, src2, nbits);
 }
 
-static inline int bitmap_subset(const unsigned long *src1,
+static inline int __must_check bitmap_subset(const unsigned long *src1,
 			const unsigned long *src2, int nbits)
 {
 	if (nbits <= BITS_PER_LONG)
@@ -223,7 +223,7 @@ static inline int bitmap_subset(const un
 		return __bitmap_subset(src1, src2, nbits);
 }
 
-static inline int bitmap_empty(const unsigned long *src, int nbits)
+static inline int __must_check bitmap_empty(const unsigned long *src, int nbits)
 {
 	if (nbits <= BITS_PER_LONG)
 		return ! (*src & BITMAP_LAST_WORD_MASK(nbits));
@@ -231,7 +231,7 @@ static inline int bitmap_empty(const uns
 		return __bitmap_empty(src, nbits);
 }
 
-static inline int bitmap_full(const unsigned long *src, int nbits)
+static inline int __must_check bitmap_full(const unsigned long *src, int nbits)
 {
 	if (nbits <= BITS_PER_LONG)
 		return ! (~(*src) & BITMAP_LAST_WORD_MASK(nbits));
@@ -239,7 +239,7 @@ static inline int bitmap_full(const unsi
 		return __bitmap_full(src, nbits);
 }
 
-static inline int bitmap_weight(const unsigned long *src, int nbits)
+static inline int __must_check bitmap_weight(const unsigned long *src, int nbits)
 {
 	return __bitmap_weight(src, nbits);
 }

-- 
http://www.codemonkey.org.uk
