Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVCVR7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVCVR7e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 12:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVCVR7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 12:59:05 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:35512 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261498AbVCVR4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 12:56:38 -0500
Subject: [patch 10/12] uml: add kconfig debug deps
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Tue, 22 Mar 2005 17:21:41 +0100
Message-Id: <20050322162142.16F94C4B86@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add some needed dependencies for some debug options and hide the MAGIC_SYSRQ
option for UML, since it displays this option in another menu.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Kconfig.debug |    6 +++---
 linux-2.6.11-paolo/lib/Kconfig.debug     |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -puN arch/um/Kconfig.debug~uml-kbuild-debug-deps arch/um/Kconfig.debug
--- linux-2.6.11/arch/um/Kconfig.debug~uml-kbuild-debug-deps	2005-03-22 10:28:03.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/Kconfig.debug	2005-03-22 10:30:46.000000000 +0100
@@ -8,7 +8,7 @@ config FRAME_POINTER
 
 config PT_PROXY
 	bool "Enable ptrace proxy"
-	depends on XTERM_CHAN && DEBUG_INFO
+	depends on XTERM_CHAN && DEBUG_INFO && MODE_TT
 	help
 	This option enables a debugging interface which allows gdb to debug
 	the kernel without needing to actually attach to kernel threads.
@@ -16,7 +16,7 @@ config PT_PROXY
 
 config GPROF
 	bool "Enable gprof support"
-	depends on DEBUG_INFO
+	depends on DEBUG_INFO && MODE_SKAS
 	help
         This allows profiling of a User-Mode Linux kernel with the gprof
         utility.
@@ -29,7 +29,7 @@ config GPROF
 
 config GCOV
 	bool "Enable gcov support"
-	depends on DEBUG_INFO
+	depends on DEBUG_INFO && MODE_SKAS
 	help
         This option allows developers to retrieve coverage data from a UML
         session.
diff -puN lib/Kconfig.debug~uml-kbuild-debug-deps lib/Kconfig.debug
--- linux-2.6.11/lib/Kconfig.debug~uml-kbuild-debug-deps	2005-03-22 10:28:03.000000000 +0100
+++ linux-2.6.11-paolo/lib/Kconfig.debug	2005-03-22 10:30:50.000000000 +0100
@@ -17,7 +17,7 @@ config DEBUG_KERNEL
 
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && !UML
 	help
 	  If you say Y here, you will have some control over the system even
 	  if the system crashes for example during kernel debugging (e.g., you
_
