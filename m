Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbUDAAjt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 19:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUDAAjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 19:39:48 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:44200 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261214AbUDAAjq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 19:39:46 -0500
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <20040329041253.5cd281a5.pj@sgi.com>
References: <20040329041253.5cd281a5.pj@sgi.com>
Content-Type: multipart/mixed; boundary="=-FvS01rJKOHKn6UYL47VY"
Organization: IBM LTC
Message-Id: <1080779931.9787.3.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 31 Mar 2004 16:38:51 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FvS01rJKOHKn6UYL47VY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-03-29 at 04:12, Paul Jackson wrote:
> Patch_2_of_22 - New mask ADT
> 	Adds new include/linux/mask.h header file
> 
> 	==> See this mask.h header for more extensive mask documentation <==

Paul,
	2 small changes to include/linux/mask.h:

1) Change #ifndef _ASM_GENERIC_MASK_H to #ifnded __LINUX_MASK_H since
mask.h resides in include/linux/ not include/asm-generic/.

2) In #define mask_complement(), the "nbits" argument to
bitmap_complement wasn't wrapped in parens.

Cheers!

-Matt

--=-FvS01rJKOHKn6UYL47VY
Content-Disposition: attachment; filename=mask_h-mcd.patch
Content-Type: text/x-patch; name=mask_h-mcd.patch; charset=
Content-Transfer-Encoding: 7bit

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-pj_nodemask/include/linux/mask.h linux-2.6.4-mask_h-mcd/include/linux/mask.h
--- linux-2.6.4-pj_nodemask/include/linux/mask.h	Tue Mar 30 17:04:27 2004
+++ linux-2.6.4-mask_h-mcd/include/linux/mask.h	Wed Mar 31 15:59:36 2004
@@ -1,5 +1,5 @@
-#ifndef _ASM_GENERIC_MASK_H
-#define _ASM_GENERIC_MASK_H
+#ifndef __LINUX_MASK_H
+#define __LINUX_MASK_H
 
 /*
  * include/linux/mask.h
@@ -273,7 +273,7 @@ do {									\
 } while(0)
 
 #define mask_complement(dst, src, nbits)				\
-	bitmap_complement((dst)._m, (src)._m, nbits)
+	bitmap_complement((dst)._m, (src)._m, (nbits))
 
 #define mask_equal(mask1, mask2)					\
 ({									\
@@ -369,4 +369,4 @@ do {									\
 #define mask_parse(ubuf, ulen, mask, nbits)				\
 	bitmap_parse((ubuf), (ulen), ((mask)._m), (nbits))
 
-#endif /* _ASM_GENERIC_MASK_H */
+#endif /* __LINUX_MASK_H */

--=-FvS01rJKOHKn6UYL47VY--

