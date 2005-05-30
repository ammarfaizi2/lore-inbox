Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVE3A2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVE3A2t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 20:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVE3A2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 20:28:49 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16400 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261474AbVE3A2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 20:28:21 -0400
Date: Mon, 30 May 2005 02:28:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] lib/zlib*: possible cleanups
Message-ID: <20050530002819.GJ10441@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- #if 0 the following unused functions:
  - zlib_deflate/deflate.c: zlib_deflateSetDictionary
  - zlib_deflate/deflate.c: zlib_deflateParams
  - zlib_deflate/deflate.c: zlib_deflateCopy
  - zlib_inflate/infblock.c: zlib_inflate_set_dictionary
  - zlib_inflate/infblock.c: zlib_inflate_blocks_sync_point
  - zlib_inflate/inflate_sync.c: zlib_inflateSync
  - zlib_inflate/inflate_sync.c: zlib_inflateSyncPoint
- remove the following unneeded EXPORT_SYMBOL's:
  - zlib_deflate/deflate_syms.c: zlib_deflateCopy
  - zlib_deflate/deflate_syms.c: zlib_deflateParams
  - zlib_inflate/inflate_syms.c: zlib_inflateSync
  - zlib_inflate/inflate_syms.c: zlib_inflateSyncPoint

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 17 May 2005
- 6 May 2005

 include/linux/zlib.h            |   11 +++++++++++
 lib/zlib_deflate/deflate.c      |    6 ++++++
 lib/zlib_deflate/deflate_syms.c |    2 --
 lib/zlib_inflate/infblock.c     |    4 ++++
 lib/zlib_inflate/infblock.h     |    4 ++++
 lib/zlib_inflate/inflate_syms.c |    2 --
 lib/zlib_inflate/inflate_sync.c |    4 ++++
 7 files changed, 29 insertions(+), 4 deletions(-)

--- linux-2.6.12-rc3-mm2-full/include/linux/zlib.h.old	2005-05-03 09:10:20.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/include/linux/zlib.h	2005-05-03 09:13:57.000000000 +0200
@@ -442,9 +442,11 @@
    not perform any compression: this will be done by deflate().
 */
                             
+#if 0
 extern int zlib_deflateSetDictionary (z_streamp strm,
 						     const Byte *dictionary,
 						     uInt  dictLength);
+#endif
 /*
      Initializes the compression dictionary from the given byte sequence
    without producing any compressed output. This function must be called
@@ -478,7 +480,10 @@
    perform any compression: this will be done by deflate().
 */
 
+#if 0
 extern int zlib_deflateCopy (z_streamp dest, z_streamp source);
+#endif
+
 /*
      Sets the destination stream as a complete copy of the source stream.
 
@@ -506,7 +511,9 @@
    stream state was inconsistent (such as zalloc or state being NULL).
 */
 
+#if 0
 extern int zlib_deflateParams (z_streamp strm, int level, int strategy);
+#endif
 /*
      Dynamically update the compression level and compression strategy.  The
    interpretation of level and strategy is as in deflateInit2.  This can be
@@ -566,7 +573,9 @@
    inflate().
 */
 
+#if 0
 extern int zlib_inflateSync (z_streamp strm);
+#endif
 /* 
     Skips invalid compressed data until a full flush point (see above the
   description of deflate with Z_FULL_FLUSH) can be found, or until all
@@ -631,7 +640,9 @@
 #endif
 
 extern const char  * zlib_zError           (int err);
+#if 0
 extern int           zlib_inflateSyncPoint (z_streamp z);
+#endif
 extern const uLong * zlib_get_crc_table    (void);
 
 #endif /* _ZLIB_H */
--- linux-2.6.12-rc3-mm2-full/lib/zlib_deflate/deflate.c.old	2005-05-03 09:10:46.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/lib/zlib_deflate/deflate.c	2005-05-03 09:12:39.000000000 +0200
@@ -255,6 +255,7 @@
 }
 
 /* ========================================================================= */
+#if 0
 int zlib_deflateSetDictionary(
 	z_streamp strm,
 	const Byte *dictionary,
@@ -297,6 +298,7 @@
     if (hash_head) hash_head = 0;  /* to make compiler happy */
     return Z_OK;
 }
+#endif  /*  0  */
 
 /* ========================================================================= */
 int zlib_deflateReset(
@@ -330,6 +332,7 @@
 }
 
 /* ========================================================================= */
+#if 0
 int zlib_deflateParams(
 	z_streamp strm,
 	int level,
@@ -365,6 +368,7 @@
     s->strategy = strategy;
     return err;
 }
+#endif  /*  0  */
 
 /* =========================================================================
  * Put a short in the pending buffer. The 16-bit value is put in MSB order.
@@ -572,6 +576,7 @@
 /* =========================================================================
  * Copy the source state to the destination state.
  */
+#if 0
 int zlib_deflateCopy (
 	z_streamp dest,
 	z_streamp source
@@ -624,6 +629,7 @@
     return Z_OK;
 #endif
 }
+#endif  /*  0  */
 
 /* ===========================================================================
  * Read a new buffer from the current input stream, update the adler32
--- linux-2.6.12-rc3-mm2-full/lib/zlib_deflate/deflate_syms.c.old	2005-05-03 09:11:13.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/lib/zlib_deflate/deflate_syms.c	2005-05-03 09:12:02.000000000 +0200
@@ -16,6 +16,4 @@
 EXPORT_SYMBOL(zlib_deflateInit2_);
 EXPORT_SYMBOL(zlib_deflateEnd);
 EXPORT_SYMBOL(zlib_deflateReset);
-EXPORT_SYMBOL(zlib_deflateCopy);
-EXPORT_SYMBOL(zlib_deflateParams);
 MODULE_LICENSE("GPL");
--- linux-2.6.12-rc3-mm2-full/lib/zlib_inflate/infblock.h.old	2005-05-03 09:12:49.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/lib/zlib_inflate/infblock.h	2005-05-03 09:34:30.000000000 +0200
@@ -33,12 +33,16 @@
     inflate_blocks_statef *,
     z_streamp);
 
+#if 0
 extern void zlib_inflate_set_dictionary (
     inflate_blocks_statef *s,
     const Byte *d,  /* dictionary */
     uInt  n);       /* dictionary length */
+#endif  /*  0  */
 
+#if 0
 extern int zlib_inflate_blocks_sync_point (
     inflate_blocks_statef *s);
+#endif  /*  0  */
 
 #endif /* _INFBLOCK_H */
--- linux-2.6.12-rc3-mm2-full/lib/zlib_inflate/infblock.c.old	2005-05-03 09:13:13.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/lib/zlib_inflate/infblock.c	2005-05-03 09:34:46.000000000 +0200
@@ -338,6 +338,7 @@
 }
 
 
+#if 0
 void zlib_inflate_set_dictionary(
 	inflate_blocks_statef *s,
 	const Byte *d,
@@ -347,15 +348,18 @@
   memcpy(s->window, d, n);
   s->read = s->write = s->window + n;
 }
+#endif  /*  0  */
 
 
 /* Returns true if inflate is currently at the end of a block generated
  * by Z_SYNC_FLUSH or Z_FULL_FLUSH. 
  * IN assertion: s != NULL
  */
+#if 0
 int zlib_inflate_blocks_sync_point(
 	inflate_blocks_statef *s
 )
 {
   return s->mode == LENS;
 }
+#endif  /*  0  */
--- linux-2.6.12-rc3-mm2-full/lib/zlib_inflate/inflate_sync.c.old	2005-05-03 09:14:12.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/lib/zlib_inflate/inflate_sync.c	2005-05-03 09:14:52.000000000 +0200
@@ -7,6 +7,7 @@
 #include "infblock.h"
 #include "infutil.h"
 
+#if 0
 int zlib_inflateSync(
 	z_streamp z
 )
@@ -57,6 +58,7 @@
   z->state->mode = BLOCKS;
   return Z_OK;
 }
+#endif  /*  0  */
 
 
 /* Returns true if inflate is currently at the end of a block generated
@@ -66,6 +68,7 @@
  * decompressing, PPP checks that at the end of input packet, inflate is
  * waiting for these length bytes.
  */
+#if 0
 int zlib_inflateSyncPoint(
 	z_streamp z
 )
@@ -74,6 +77,7 @@
     return Z_STREAM_ERROR;
   return zlib_inflate_blocks_sync_point(z->state->blocks);
 }
+#endif  /*  0  */
 
 /*
  * This subroutine adds the data at next_in/avail_in to the output history
--- linux-2.6.12-rc3-mm2-full/lib/zlib_inflate/inflate_syms.c.old	2005-05-03 09:15:06.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/lib/zlib_inflate/inflate_syms.c	2005-05-03 09:15:13.000000000 +0200
@@ -15,8 +15,6 @@
 EXPORT_SYMBOL(zlib_inflateInit_);
 EXPORT_SYMBOL(zlib_inflateInit2_);
 EXPORT_SYMBOL(zlib_inflateEnd);
-EXPORT_SYMBOL(zlib_inflateSync);
 EXPORT_SYMBOL(zlib_inflateReset);
-EXPORT_SYMBOL(zlib_inflateSyncPoint);
 EXPORT_SYMBOL(zlib_inflateIncomp); 
 MODULE_LICENSE("GPL");


