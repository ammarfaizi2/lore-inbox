Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbUCWELi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 23:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbUCWELi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 23:11:38 -0500
Received: from mail.ccur.com ([208.248.32.212]:11538 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S261960AbUCWELc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 23:11:32 -0500
Date: Mon, 22 Mar 2004 23:10:13 -0500
From: Joe Korty <joe.korty@ccur.com>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       Paul Jackson <pj@sgi.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] broken bitmap_parse for ncpus > 32
Message-ID: <20040323041012.GA30322@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040322202118.GA27281@tsunami.ccur.com> <20040322231246.GQ2045@holomorphy.com> <20040323001433.GA29320@tsunami.ccur.com> <20040323020907.GU2045@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323020907.GU2045@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 06:09:07PM -0800, William Lee Irwin III wrote:
> At some point in the past, I wrote:
>>> Bugfixes are always good. Maybe the kerneldoc stuff would be a good idea
>>> for these functions, and the rest of the non-static functions ppl might
>>> be expected to call.
> 
> On Mon, Mar 22, 2004 at 07:14:33PM -0500, Joe Korty wrote:
>> IMO, one+ liners describing how a function is used is best put near
>> the function, where it is most likely to be seen.  Stuff going into
>> Documentation/*.txt should be bulky stuff not suitable for inlining,
>> such as largish tutorials, annotated examples, theory papers, etc. 
> 
> Sorry about not being clear; I meant the : and @ stuff I've seen around
> various comments that somehow gets yanked directly out of C comments in
> the source and generated into a pdf.


Ah, I see.  Here is the New-n-Improved patch:

--- base/lib/bitmap.c	2004-03-10 21:55:43.000000000 -0500
+++ new/lib/bitmap.c	2004-03-22 23:04:51.000000000 -0500
@@ -71,6 +71,17 @@
 }
 EXPORT_SYMBOL(bitmap_complement);
 
+/*
+ * bitmap_shift_write - logical right shift of the bits in a bitmap
+ *   @dst - destination bitmap
+ *   @src - source bitmap
+ *   @nbits - shift by this many bits
+ *   @bits - bitmap size, in bits
+ *
+ * Shifting right (dividing) means moving bits in the MS -> LS bit
+ * direction.  Zeros are fed into the vacated MS positions and the
+ * LS bits shifted off the bottom are lost.
+ */
 void bitmap_shift_right(unsigned long *dst,
 			const unsigned long *src, int shift, int bits)
 {
@@ -86,6 +97,17 @@
 }
 EXPORT_SYMBOL(bitmap_shift_right);
 
+/*
+ * bitmap_shift_left - logical left shift of the bits in a bitmap
+ *   @dst - destination bitmap
+ *   @src - source bitmap
+ *   @nbits - shift by this many bits
+ *   @bits - bitmap size, in bits
+ *
+ * Shifting left (multiplying) means moving bits in the LS -> MS
+ * direction.  Zeros are fed into the vacated LS bit positions
+ * and those MS bits shifted off the top are lost.
+ */
 void bitmap_shift_left(unsigned long *dst,
 			const unsigned long *src, int shift, int bits)
 {
@@ -269,7 +291,7 @@
 		if (nchunks == 0 && chunk == 0)
 			continue;
 
-		bitmap_shift_right(maskp, maskp, CHUNKSZ, nmaskbits);
+		bitmap_shift_left(maskp, maskp, CHUNKSZ, nmaskbits);
 		*maskp |= chunk;
 		nchunks++;
 		nbits += (nchunks == 1) ? nbits_to_hold_value(chunk) : CHUNKSZ;
