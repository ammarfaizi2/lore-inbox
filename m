Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWFNBqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWFNBqb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWFNBqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:46:31 -0400
Received: from xenotime.net ([66.160.160.81]:29889 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932365AbWFNBqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:46:30 -0400
Date: Tue, 13 Jun 2006 18:49:15 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH 1/3] kernel-doc for lib/bitmap.c
Message-Id: <20060613184915.a7ea79f8.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Make corrections/fixes to kernel-doc in lib/bitmap.c
and include it in DocBook template.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/DocBook/kernel-api.tmpl |    4 ++++
 lib/bitmap.c                          |   31 ++++++++++++++++---------------
 2 files changed, 20 insertions(+), 15 deletions(-)

--- linux-2617-rc6.orig/lib/bitmap.c
+++ linux-2617-rc6/lib/bitmap.c
@@ -317,16 +317,16 @@ EXPORT_SYMBOL(bitmap_scnprintf);
 
 /**
  * bitmap_parse - convert an ASCII hex string into a bitmap.
- * @buf: pointer to buffer in user space containing string.
- * @buflen: buffer size in bytes.  If string is smaller than this
+ * @ubuf: pointer to buffer in user space containing string.
+ * @ubuflen: buffer size in bytes.  If string is smaller than this
  *    then it must be terminated with a \0.
  * @maskp: pointer to bitmap array that will contain result.
  * @nmaskbits: size of bitmap, in bits.
  *
  * Commas group hex digits into chunks.  Each chunk defines exactly 32
  * bits of the resultant bitmask.  No chunk may specify a value larger
- * than 32 bits (-EOVERFLOW), and if a chunk specifies a smaller value
- * then leading 0-bits are prepended.  -EINVAL is returned for illegal
+ * than 32 bits (%-EOVERFLOW), and if a chunk specifies a smaller value
+ * then leading 0-bits are prepended.  %-EINVAL is returned for illegal
  * characters and for grouping errors such as "1,,5", ",44", "," and "".
  * Leading and trailing whitespace accepted, but not embedded whitespace.
  */
@@ -452,8 +452,8 @@ EXPORT_SYMBOL(bitmap_scnlistprintf);
 
 /**
  * bitmap_parselist - convert list format ASCII string to bitmap
- * @buf: read nul-terminated user string from this buffer
- * @mask: write resulting mask here
+ * @bp: read nul-terminated user string from this buffer
+ * @maskp: write resulting mask here
  * @nmaskbits: number of bits in mask to be written
  *
  * Input format is a comma-separated list of decimal numbers and
@@ -461,10 +461,11 @@ EXPORT_SYMBOL(bitmap_scnlistprintf);
  * decimal numbers, the smallest and largest bit numbers set in
  * the range.
  *
- * Returns 0 on success, -errno on invalid input strings:
- *    -EINVAL:   second number in range smaller than first
- *    -EINVAL:   invalid character in string
- *    -ERANGE:   bit number specified too large for mask
+ * Returns 0 on success, -errno on invalid input strings.
+ * Error values:
+ *    %-EINVAL: second number in range smaller than first
+ *    %-EINVAL: invalid character in string
+ *    %-ERANGE: bit number specified too large for mask
  */
 int bitmap_parselist(const char *bp, unsigned long *maskp, int nmaskbits)
 {
@@ -625,10 +626,10 @@ EXPORT_SYMBOL(bitmap_remap);
 
 /**
  * bitmap_bitremap - Apply map defined by a pair of bitmaps to a single bit
- *	@oldbit - bit position to be mapped
- *      @old: defines domain of map
- *      @new: defines range of map
- *      @bits: number of bits in each of these bitmaps
+ *	@oldbit: bit position to be mapped
+ *	@old: defines domain of map
+ *	@new: defines range of map
+ *	@bits: number of bits in each of these bitmaps
  *
  * Let @old and @new define a mapping of bit positions, such that
  * whatever position is held by the n-th set bit in @old is mapped
@@ -790,7 +791,7 @@ EXPORT_SYMBOL(bitmap_release_region);
  *
  * Allocate (set bits in) a specified region of a bitmap.
  *
- * Return 0 on success, or -EBUSY if specified region wasn't
+ * Return 0 on success, or %-EBUSY if specified region wasn't
  * free (not all bits were zero).
  */
 int bitmap_allocate_region(unsigned long *bitmap, int pos, int order)
--- linux-2617-rc6.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2617-rc6/Documentation/DocBook/kernel-api.tmpl
@@ -112,6 +112,10 @@ X!Ilib/string.c
      <sect1><title>Bit Operations</title>
 !Iinclude/asm-i386/bitops.h
      </sect1>
+     <sect1><title>Bitmap Operations</title>
+!Elib/bitmap.c
+!Ilib/bitmap.c
+     </sect1>
   </chapter>
 
   <chapter id="mm">


---
