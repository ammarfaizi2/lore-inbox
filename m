Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268356AbUH2W7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268356AbUH2W7y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 18:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268359AbUH2W7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 18:59:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:21755 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268356AbUH2W7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 18:59:50 -0400
Date: Mon, 30 Aug 2004 00:59:42 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] DEBUG_BUGVERBOSE for i386
Message-ID: <20040829225941.GD12134@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below implements CONFIG_DEBUG_BUGVERBOSE for i386 (more 
exactly, it allows disabling the verbose BUG() reporting).


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.9-rc1-mm1-full/lib/Kconfig.debug.old	2004-08-29 21:22:20.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/lib/Kconfig.debug	2004-08-29 21:28:29.000000000 +0200
@@ -61,7 +61,7 @@
 
 config DEBUG_BUGVERBOSE
 	bool "Verbose BUG() reporting (adds 70K)"
-	depends on DEBUG_KERNEL && (ARM || ARM26 || M68K || SPARC32 || SPARC64)
+	depends on DEBUG_KERNEL && (ARM || ARM26 || M68K || SPARC32 || SPARC64 || (X86 && !X86_64))
 	help
 	  Say Y here to make BUG() panics output the file name and line number
 	  of the BUG call as well as the EIP and oops trace.  This aids
--- linux-2.6.9-rc1-mm1-full/include/asm-i386/bug.h.old	2004-08-29 21:22:46.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/asm-i386/bug.h	2004-08-29 21:28:38.000000000 +0200
@@ -9,7 +9,7 @@
  * undefined" opcode for parsing in the trap handler.
  */
 
-#if 1	/* Set to zero for a slightly smaller kernel */
+#ifdef CONFIG_DEBUG_BUGVERBOSE
 #define BUG()				\
  __asm__ __volatile__(	"ud2\n"		\
 			"\t.word %c0\n"	\

