Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317303AbSFCHxN>; Mon, 3 Jun 2002 03:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317304AbSFCHxM>; Mon, 3 Jun 2002 03:53:12 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:33747 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317303AbSFCHxL>;
	Mon, 3 Jun 2002 03:53:11 -0400
Date: Mon, 3 Jun 2002 17:51:09 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Fix for recent swap changes on 64 bit archs
Message-ID: <20020603075108.GA11597@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes two shift warnings on 64 bit archs.

Anton

diff -urN linux-2.5_ppc64/include/linux/swapops.h linux-2.5_work/include/linux/swapops.h
--- linux-2.5_ppc64/include/linux/swapops.h	Mon Jun  3 17:36:21 2002
+++ linux-2.5_work/include/linux/swapops.h	Mon Jun  3 16:50:02 2002
@@ -10,7 +10,7 @@
  * swp_entry_t's are *never* stored anywhere in their arch-dependent format.
  */
 #define SWP_TYPE_SHIFT(e)	(sizeof(e.val) * 8 - MAX_SWAPFILES_SHIFT)
-#define SWP_OFFSET_MASK(e)	((1 << SWP_TYPE_SHIFT(e)) - 1)
+#define SWP_OFFSET_MASK(e)	((1UL << SWP_TYPE_SHIFT(e)) - 1)
 
 /*
  * Store a type+offset into a swp_entry_t in an arch-independent format
@@ -19,7 +19,7 @@
 {
 	swp_entry_t ret;
 
-	ret.val = (type << SWP_TYPE_SHIFT(ret)) |
+	ret.val = ((unsigned long)type << SWP_TYPE_SHIFT(ret)) |
 			(offset & SWP_OFFSET_MASK(ret));
 	return ret;
 }
