Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVEIXXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVEIXXb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 19:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVEIXVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 19:21:54 -0400
Received: from [151.97.230.9] ([151.97.230.9]:34834 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261390AbVEIXVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 19:21:38 -0400
Subject: [patch 5/6] uml: split CONFIG_FRAME_POINTER from DEBUG_INFO
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Tue, 10 May 2005 00:45:20 +0200
Message-Id: <20050509224520.C9E9613C21A@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Until now, FRAME_POINTER was set = DEBUG_INFO for UML. Change it to be the
default way, so that it can be enabled alone (for instance to get better
backtraces on crashes).
The call-trace dumper which uses the frame pointer is not yet in, I'm going to
introduce it in a separate patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---


diff -puN arch/um/Kconfig.debug~uml-split-frame-pointer-option arch/um/Kconfig.debug
--- linux-2.6.git/arch/um/Kconfig.debug~uml-split-frame-pointer-option	2005-05-07 18:00:23.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/Kconfig.debug	2005-05-07 18:00:23.000000000 +0200
@@ -2,10 +2,6 @@ menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
-config FRAME_POINTER
-	bool
-	default y if DEBUG_INFO
-
 config PT_PROXY
 	bool "Enable ptrace proxy"
 	depends on XTERM_CHAN && DEBUG_INFO && MODE_TT
diff -puN lib/Kconfig.debug~uml-split-frame-pointer-option lib/Kconfig.debug
--- linux-2.6.git/lib/Kconfig.debug~uml-split-frame-pointer-option	2005-05-07 18:00:23.000000000 +0200
+++ linux-2.6.git-paolo/lib/Kconfig.debug	2005-05-07 18:00:23.000000000 +0200
@@ -151,7 +151,8 @@ config DEBUG_FS
 
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
-	depends on DEBUG_KERNEL && ((X86 && !X86_64) || CRIS || M68K || M68KNOMMU || FRV)
+	depends on DEBUG_KERNEL && ((X86 && !X86_64) || CRIS || M68K || M68KNOMMU || FRV || UML)
+	default y if DEBUG_INFO && UML
 	help
 	  If you say Y here the resulting kernel image will be slightly larger
 	  and slower, but it will give very useful debugging information.
_
