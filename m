Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbVLNTKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbVLNTKI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbVLNTKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:10:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18445 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964893AbVLNTKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:10:06 -0500
Date: Wed, 14 Dec 2005 20:10:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix the EMBEDDED menu
Message-ID: <20051214191006.GC23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

your patch to allow CC_OPTIMIZE_FOR_SIZE even for EMBEDDED=n has broken 
the EMBEDDED menu.

This patch fixes this by moving CC_OPTIMIZE_FOR_SIZE above the EMBEDDED 
menu.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 init/Kconfig |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- linux-git/init/Kconfig.old	2005-12-14 19:58:05.000000000 +0100
+++ linux-git/init/Kconfig	2005-12-14 19:58:38.000000000 +0100
@@ -256,6 +256,18 @@
 
 source "usr/Kconfig"
 
+config CC_OPTIMIZE_FOR_SIZE
+	bool "Optimize for size"
+	default y if ARM || H8300
+	help
+	  Enabling this option will pass "-Os" instead of "-O2" to gcc
+	  resulting in a smaller kernel.
+
+	  WARNING: some versions of gcc may generate incorrect code with this
+	  option.  If problems are observed, a gcc upgrade may be needed.
+
+	  If unsure, say N.
+
 menuconfig EMBEDDED
 	bool "Configure standard kernel features (for small systems)"
 	help
@@ -338,18 +350,6 @@
 	  Disabling this option will cause the kernel to be built without
 	  support for epoll family of system calls.
 
-config CC_OPTIMIZE_FOR_SIZE
-	bool "Optimize for size"
-	default y if ARM || H8300
-	help
-	  Enabling this option will pass "-Os" instead of "-O2" to gcc
-	  resulting in a smaller kernel.
-
-	  WARNING: some versions of gcc may generate incorrect code with this
-	  option.  If problems are observed, a gcc upgrade may be needed.
-
-	  If unsure, say N.
-
 config SHMEM
 	bool "Use full shmem filesystem" if EMBEDDED
 	default y

