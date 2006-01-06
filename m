Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752554AbWAFUhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbWAFUhg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbWAFUhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:37:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39950 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752556AbWAFUhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:37:34 -0500
Date: Fri, 6 Jan 2006 21:37:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] document that gcc 4 is not supported
Message-ID: <20060106203727.GE12131@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 4 is not supported for compiling kernel 2.4, and I don't see any 
compelling reason why kernel 2.4 should ever be adapted to gcc 4.

This patch documents this fact.

Without this patch, your screen is flooded with warnings and errors when
accidentially trying to compile kernel 2.4 with gcc 4.

With this patch, the same happens, but the last lines contain the
explanation
  #error Sorry, your GCC is too recent for kernel 2.4

If someone makes a patch to fix all issues with gcc 4, adding the
removal of this #error should be the most trivial part of the patch.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/Changes |    2 ++
 README                |    1 +
 init/main.c           |    7 +++++++
 3 files changed, 10 insertions(+)

--- linux-2.4.31-rc1-full/init/main.c.old	2005-05-30 21:20:00.000000000 +0200
+++ linux-2.4.31-rc1-full/init/main.c	2005-05-30 21:21:19.000000000 +0200
@@ -84,6 +84,13 @@
 #error Sorry, your GCC is too old. It builds incorrect kernels.
 #endif
 
+/*
+ * gcc >= 4 is not supported by kernel 2.4
+ */
+#if __GNUC__ > 3
+#error Sorry, your GCC is too recent for kernel 2.4
+#endif
+
 extern char _stext, _etext;
 extern char *linux_banner;
 
--- linux-2.4.31-rc1-full/README.old	2005-05-30 21:21:29.000000000 +0200
+++ linux-2.4.31-rc1-full/README	2005-05-30 21:21:59.000000000 +0200
@@ -152,6 +152,7 @@
 
  - Make sure you have gcc 2.95.3 available.  gcc 2.91.66 (egcs-1.1.2) may
    also work but is not as safe, and *gcc 2.7.2.3 is no longer supported*.
+   gcc 4 is *not* supported.
    Also remember to upgrade your binutils package (for as/ld/nm and company)
    if necessary. For more information, refer to ./Documentation/Changes.
 
--- linux-2.4.31-rc1-full/Documentation/Changes.old	2005-05-30 21:22:10.000000000 +0200
+++ linux-2.4.31-rc1-full/Documentation/Changes	2005-05-30 21:22:41.000000000 +0200
@@ -91,6 +91,8 @@
 You should ensure you use gcc-2.96-74 or later. gcc-2.96-54 will not build
 the kernel correctly.
 
+gcc 4 is not supported.
+
 In addition, please pay attention to compiler optimization.  Anything
 greater than -O2 may not be wise.  Similarly, if you choose to use gcc-2.95.x
 or derivatives, be sure not to use -fstrict-aliasing (which, depending on


