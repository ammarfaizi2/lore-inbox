Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbUKQEqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUKQEqN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 23:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbUKQEjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 23:39:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59147 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262216AbUKQEe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 23:34:59 -0500
Date: Wed, 17 Nov 2004 05:32:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] DEBUG_BUGVERBOSE for i386 (fwd)
Message-ID: <20041117043228.GH4943@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've received zero somments on this patch that still applies and 
compiles against 2.6.10-rc2-mm1.

Could you either apply or comment on it?


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Mon, 30 Aug 2004 00:59:42 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] DEBUG_BUGVERBOSE for i386

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

