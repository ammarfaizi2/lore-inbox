Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbVLNWkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbVLNWkb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbVLNWkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:40:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36053 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965039AbVLNWka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:40:30 -0500
Date: Wed, 14 Dec 2005 14:36:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL
In-Reply-To: <20051214221304.GE23349@stusta.de>
Message-ID: <Pine.LNX.4.64.0512141429030.3292@g5.osdl.org>
References: <20051214191006.GC23349@stusta.de> <20051214140531.7614152d.akpm@osdl.org>
 <20051214221304.GE23349@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Dec 2005, Adrian Bunk wrote:
> 
> What about marking it as EXPERIMENTAL?

It's not experimental on other architectures, where it is always used.

The best option _may_ be to do something like this, where we use that 
"depends on" to set the expectations, and people shouldn't see it unless 
they ask for EXPERIMENTAL.

It also refuses to turn on for SPARC64, since that seems to be known 
broken. Or should it be just "SPARC"? Davem?

		Linus

---
diff --git a/init/Kconfig b/init/Kconfig
index be74adb..6c5dbed 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -256,6 +256,20 @@ config CPUSETS
 
 source "usr/Kconfig"
 
+config CC_OPTIMIZE_FOR_SIZE
+	bool "Optimize for size (Look out for broken compilers!)"
+	default y
+	depends on ARM || H8300 || EXPERIMENTAL
+	depends on !SPARC64
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
@@ -338,18 +352,6 @@ config EPOLL
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
