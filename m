Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTFFSik (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 14:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTFFSik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 14:38:40 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:4795 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262175AbTFFSii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 14:38:38 -0400
Date: Fri, 6 Jun 2003 20:52:10 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: [Patch] 2.5.70-bk11 zlib cleanup #4 casts
Message-ID: <20030606185210.GE10487@wohnheim.fh-wedel.de>
References: <20030606183126.GA10487@wohnheim.fh-wedel.de> <20030606183247.GB10487@wohnheim.fh-wedel.de> <20030606183920.GC10487@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030606183920.GC10487@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

As promised, the NULL casts.

Jörn

-- 
Beware of bugs in the above code; I have only proved it correct, but
not tried it.
-- Donald Knuth

--- linux-2.5.70-bk11/lib/zlib_deflate/deflate.c~zlib_cleanup_casts	2003-06-06 20:14:27.000000000 +0200
+++ linux-2.5.70-bk11/lib/zlib_deflate/deflate.c	2003-06-06 20:44:51.000000000 +0200
@@ -962,7 +962,7 @@
 #define FLUSH_BLOCK_ONLY(s, eof) { \
    zlib_tr_flush_block(s, (s->block_start >= 0L ? \
                    (char *)&s->window[(unsigned)s->block_start] : \
-                   (char *)NULL), \
+                   NULL), \
 		(ulg)((long)s->strstart - s->block_start), \
 		(eof)); \
    s->block_start = s->strstart; \
--- linux-2.5.70-bk11/lib/zlib_inflate/infblock.c~zlib_cleanup_casts	2003-06-06 20:14:27.000000000 +0200
+++ linux-2.5.70-bk11/lib/zlib_inflate/infblock.c	2003-06-06 20:45:51.000000000 +0200
@@ -80,7 +80,7 @@
   s->bitb = 0;
   s->read = s->write = s->window;
   if (s->checkfn != NULL)
-    z->adler = s->check = (*s->checkfn)(0L, (const Byte *)NULL, 0);
+    z->adler = s->check = (*s->checkfn)(0L, NULL, 0);
 }
 
 inflate_blocks_statef *zlib_inflate_blocks_new(
--- linux-2.5.70-bk11/lib/zlib_inflate/inftrees.c~zlib_cleanup_casts	2003-06-06 20:14:27.000000000 +0200
+++ linux-2.5.70-bk11/lib/zlib_inflate/inftrees.c	2003-06-06 20:47:11.000000000 +0200
@@ -139,7 +139,7 @@
   } while (--i);
   if (c[0] == n)                /* null input--all zero length codes */
   {
-    *t = (inflate_huft *)NULL;
+    *t = NULL;
     *m = 0;
     return Z_OK;
   }
@@ -193,8 +193,8 @@
   p = v;                        /* grab values in bit order */
   h = -1;                       /* no tables yet--level -1 */
   w = -l;                       /* bits decoded == (l * h) */
-  u[0] = (inflate_huft *)NULL;        /* just to keep compilers happy */
-  q = (inflate_huft *)NULL;     /* ditto */
+  u[0] = NULL;                  /* just to keep compilers happy */
+  q = NULL;                     /* ditto */
   z = 0;                        /* ditto */
 
   /* go through the bit lengths (k already is bits in shortest code) */
@@ -302,8 +302,7 @@
   uInt *v;              /* work area for huft_build */
   
   v = WS(z)->tree_work_area_1;
-  r = huft_build(c, 19, 19, (uInt*)NULL, (uInt*)NULL,
-                 tb, bb, hp, &hn, v);
+  r = huft_build(c, 19, 19, NULL, NULL, tb, bb, hp, &hn, v);
   if (r == Z_DATA_ERROR)
     z->msg = (char*)"oversubscribed dynamic bit lengths tree";
   else if (r == Z_BUF_ERROR || *bb == 0)
