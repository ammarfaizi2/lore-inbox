Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263365AbUJ2Qja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbUJ2Qja (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 12:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263342AbUJ2QfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 12:35:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21411 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263358AbUJ2Qbs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 12:31:48 -0400
Date: Fri, 29 Oct 2004 17:31:43 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] update lib/Kconfig.debug
Message-ID: <20041029163143.GC8958@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PA-RISC has spinlock debugging and doesn't have the option to compile with
frame pointers.  Both patches from Randolph Chung.  Also, -bk8 included
a second check for USERMODE which I've taken the liberty of removing.

diff -urpNX dontdiff linux-2.6.10-rc1-bk8/lib/Kconfig.debug parisc-2.6-bk/lib/Kconfig.debug
--- linux-2.6.10-rc1-bk8/lib/Kconfig.debug	Fri Oct 29 06:37:03 2004
+++ parisc-2.6-bk/lib/Kconfig.debug	Fri Oct 29 08:18:33 2004
@@ -50,7 +50,7 @@ config DEBUG_SLAB
 
 config DEBUG_SPINLOCK
 	bool "Spinlock debugging"
-	depends on DEBUG_KERNEL && (ALPHA || ARM || X86 || IA64 || MIPS || PPC32 || (SUPERH && !SUPERH64) || SPARC32 || SPARC64 || USERMODE || X86_64 || USERMODE)
+	depends on DEBUG_KERNEL && (ALPHA || ARM || X86 || IA64 || MIPS || PARISC || PPC32 || (SUPERH && !SUPERH64) || SPARC32 || SPARC64 || USERMODE || X86_64)
 	help
 	  Say Y here and build SMP to catch missing spinlock initialization
 	  and certain other kinds of spinlock errors commonly made.  This is
@@ -110,7 +110,7 @@ config DEBUG_INFO
 if !X86_64
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
-	depends on X86 || CRIS || M68KNOMMU || PARISC
+	depends on X86 || CRIS || M68KNOMMU
 	help
 	  If you say Y here the resulting kernel image will be slightly larger
 	  and slower, but it will give very useful debugging information.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
