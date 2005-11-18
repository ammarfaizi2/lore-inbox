Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVKRDeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVKRDeR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 22:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbVKRDeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 22:34:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59910 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932304AbVKRDeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 22:34:01 -0500
Date: Fri, 18 Nov 2005 04:34:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/ext3/: small cleanups
Message-ID: <20051118033359.GX11494@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- there's no need for ext3_count_free() #ifndef EXT3FS_DEBUG
- having prototypes for ext3_count_free() in two different headers is
  nonsense


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/ext3/balloc.c |    2 --
 fs/ext3/bitmap.c |    8 +++++++-
 fs/ext3/bitmap.h |    8 --------
 fs/ext3/ialloc.c |    1 -
 4 files changed, 7 insertions(+), 12 deletions(-)

--- linux-2.6.15-rc1-mm1-full/fs/ext3/bitmap.c.old	2005-11-18 02:52:02.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/fs/ext3/bitmap.c	2005-11-18 02:54:14.000000000 +0100
@@ -7,8 +7,11 @@
  * Universite Pierre et Marie Curie (Paris VI)
  */
 
+#ifdef EXT3FS_DEBUG
+
 #include <linux/buffer_head.h>
-#include "bitmap.h"
+
+#include "ext3_fs.h"
 
 static int nibblemap[] = {4, 3, 3, 2, 3, 2, 2, 1, 3, 2, 2, 1, 2, 1, 1, 0};
 
@@ -24,3 +27,6 @@
 			nibblemap[(map->b_data[i] >> 4) & 0xf];
 	return (sum);
 }
+
+#endif  /*  EXT3FS_DEBUG  */
+
--- linux-2.6.15-rc1-mm1-full/fs/ext3/balloc.c.old	2005-11-18 02:52:55.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/fs/ext3/balloc.c	2005-11-18 02:53:02.000000000 +0100
@@ -20,8 +20,6 @@
 #include <linux/quotaops.h>
 #include <linux/buffer_head.h>
 
-#include "bitmap.h"
-
 /*
  * balloc.c contains the blocks allocation and deallocation routines
  */
--- linux-2.6.15-rc1-mm1-full/fs/ext3/ialloc.c.old	2005-11-18 02:53:26.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/fs/ext3/ialloc.c	2005-11-18 02:53:31.000000000 +0100
@@ -26,7 +26,6 @@
 
 #include <asm/byteorder.h>
 
-#include "bitmap.h"
 #include "xattr.h"
 #include "acl.h"
 
--- linux-2.6.15-rc1-mm1-full/fs/ext3/bitmap.h	2005-11-17 21:30:48.000000000 +0100
+++ /dev/null	2005-11-08 19:07:57.000000000 +0100
@@ -1,8 +0,0 @@
-/*  linux/fs/ext3/bitmap.c
- *
- * Copyright (C) 2005 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
-*/
-
-extern unsigned long ext3_count_free (struct buffer_head *, unsigned int );

