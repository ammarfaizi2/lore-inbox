Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269104AbUHaWSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269104AbUHaWSp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269101AbUHaWRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:17:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54770 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268442AbUHaWN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:13:56 -0400
Date: Wed, 1 Sep 2004 00:13:48 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch]  kill __always_inline
Message-ID: <20040831221348.GW3466@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An issue that we already discussed at 2.6.8-rc2-mm2 times:

2.6.9-rc1 includes __always_inline which was formerly in  -mm.
__always_inline doesn't make any sense:

__always_inline is _exactly_ the same as __inline__, __inline and inline .


The patch below removes __always_inline again:


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.9-rc1-mm2-full/include/linux/compiler.h.old	2004-08-31 23:30:51.000000000 +0200
+++ linux-2.6.9-rc1-mm2-full/include/linux/compiler.h	2004-08-31 23:31:09.000000000 +0200
@@ -124,8 +124,4 @@
 #define noinline
 #endif
 
-#ifndef __always_inline
-#define __always_inline inline
-#endif
-
 #endif /* __LINUX_COMPILER_H */
--- linux-2.6.9-rc1-mm2-full/include/asm-i386/fixmap.h.old	2004-08-31 23:31:35.000000000 +0200
+++ linux-2.6.9-rc1-mm2-full/include/asm-i386/fixmap.h	2004-08-31 23:31:47.000000000 +0200
@@ -129,7 +129,7 @@
  * directly without tranlation, we catch the bug with a NULL-deference
  * kernel oops. Illegal ranges of incoming indices are caught too.
  */
-static __always_inline unsigned long fix_to_virt(const unsigned int idx)
+static inline unsigned long fix_to_virt(const unsigned int idx)
 {
 	/*
 	 * this branch gets completely eliminated after inlining,

