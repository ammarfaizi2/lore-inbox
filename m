Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWJ0SpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWJ0SpW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 14:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWJ0SpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 14:45:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59545 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750748AbWJ0SpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 14:45:20 -0400
Date: Fri, 27 Oct 2006 11:41:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: vmlinux.lds: consolidate initcall sections
Message-Id: <20061027114144.f8a5addc.akpm@osdl.org>
In-Reply-To: <20061027113908.4a82c28a.akpm@osdl.org>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
	<20061026224541.GQ27968@stusta.de>
	<20061027010252.GV27968@stusta.de>
	<20061027012058.GH5591@parisc-linux.org>
	<20061026182838.ac2c7e20.akpm@osdl.org>
	<20061026191131.003f141d@localhost.localdomain>
	<20061027170748.GA9020@kroah.com>
	<20061027172219.GC30416@elf.ucw.cz>
	<20061027113908.4a82c28a.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Add a vmlinux.lds.h helper macro for defining the eight-level initcall table,
teach all the architectures to use it.

This is a prerequisite for a patch which performs initcall synchronisation for
multithreaded-probing.

Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/alpha/kernel/vmlinux.lds.S     |    8 +-------
 arch/arm/kernel/vmlinux.lds.S       |    8 +-------
 arch/frv/kernel/vmlinux.lds.S       |    8 +-------
 arch/h8300/kernel/vmlinux.lds.S     |    8 +-------
 arch/i386/kernel/vmlinux.lds.S      |    8 +-------
 arch/ia64/kernel/vmlinux.lds.S      |    8 +-------
 arch/m32r/kernel/vmlinux.lds.S      |    8 +-------
 arch/m68knommu/kernel/vmlinux.lds.S |    8 +-------
 arch/mips/kernel/vmlinux.lds.S      |    8 +-------
 arch/parisc/kernel/vmlinux.lds.S    |    8 +-------
 arch/powerpc/kernel/vmlinux.lds.S   |    8 +-------
 arch/ppc/kernel/vmlinux.lds.S       |    8 +-------
 arch/s390/kernel/vmlinux.lds.S      |    8 +-------
 arch/sh/kernel/vmlinux.lds.S        |    8 +-------
 arch/sh64/kernel/vmlinux.lds.S      |    8 +-------
 arch/sparc/kernel/vmlinux.lds.S     |    8 +-------
 arch/sparc64/kernel/vmlinux.lds.S   |    8 +-------
 arch/v850/kernel/vmlinux.lds.S      |    8 +-------
 arch/x86_64/kernel/vmlinux.lds.S    |    8 +-------
 arch/xtensa/kernel/vmlinux.lds.S    |    8 +-------
 include/asm-generic/vmlinux.lds.h   |   10 ++++++++++
 21 files changed, 30 insertions(+), 140 deletions(-)

diff -puN arch/alpha/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/alpha/kernel/vmlinux.lds.S
--- a/arch/alpha/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/alpha/kernel/vmlinux.lds.S
@@ -48,13 +48,7 @@ SECTIONS
   . = ALIGN(8);
   __initcall_start = .;
   .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
+	INITCALLS
   }
   __initcall_end = .;
 
diff -puN arch/arm/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/arm/kernel/vmlinux.lds.S
--- a/arch/arm/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/arm/kernel/vmlinux.lds.S
@@ -45,13 +45,7 @@ SECTIONS
 			*(.early_param.init)
 		__early_end = .;
 		__initcall_start = .;
-			*(.initcall1.init)
-			*(.initcall2.init)
-			*(.initcall3.init)
-			*(.initcall4.init)
-			*(.initcall5.init)
-			*(.initcall6.init)
-			*(.initcall7.init)
+			INITCALLS
 		__initcall_end = .;
 		__con_initcall_start = .;
 			*(.con_initcall.init)
diff -puN arch/arm26/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/arm26/kernel/vmlinux.lds.S
diff -puN arch/frv/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/frv/kernel/vmlinux.lds.S
--- a/arch/frv/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/frv/kernel/vmlinux.lds.S
@@ -44,13 +44,7 @@ SECTIONS
 
   __initcall_start = .;
   .initcall.init : {
-	*(.initcall1.init)
-	*(.initcall2.init)
-	*(.initcall3.init)
-	*(.initcall4.init)
-	*(.initcall5.init)
-	*(.initcall6.init)
-	*(.initcall7.init)
+	INITCALLS
   }
   __initcall_end = .;
   __con_initcall_start = .;
diff -puN arch/h8300/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/h8300/kernel/vmlinux.lds.S
--- a/arch/h8300/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/h8300/kernel/vmlinux.lds.S
@@ -118,13 +118,7 @@ SECTIONS
 	. = ALIGN(0x4) ;
 	___setup_end = .;
 	___initcall_start = .;
-		*(.initcall1.init)
-		*(.initcall2.init)
-		*(.initcall3.init)
-		*(.initcall4.init)
-		*(.initcall5.init)
-		*(.initcall6.init)
-		*(.initcall7.init)
+		INITCALLS
 	___initcall_end = .;
 	___con_initcall_start = .;
 		*(.con_initcall.init)
diff -puN arch/i386/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/i386/kernel/vmlinux.lds.S
--- a/arch/i386/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/i386/kernel/vmlinux.lds.S
@@ -126,13 +126,7 @@ SECTIONS
   __setup_end = .;
   __initcall_start = .;
   .initcall.init : AT(ADDR(.initcall.init) - LOAD_OFFSET) {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
+	INITCALLS
   }
   __initcall_end = .;
   __con_initcall_start = .;
diff -puN arch/ia64/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/ia64/kernel/vmlinux.lds.S
--- a/arch/ia64/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/ia64/kernel/vmlinux.lds.S
@@ -128,13 +128,7 @@ SECTIONS
   .initcall.init : AT(ADDR(.initcall.init) - LOAD_OFFSET)
 	{
 	  __initcall_start = .;
-	  *(.initcall1.init)
-	  *(.initcall2.init)
-	  *(.initcall3.init)
-	  *(.initcall4.init)
-	  *(.initcall5.init)
-	  *(.initcall6.init)
-	  *(.initcall7.init)
+	INITCALLS
 	  __initcall_end = .;
 	}
 
diff -puN arch/m32r/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/m32r/kernel/vmlinux.lds.S
--- a/arch/m32r/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/m32r/kernel/vmlinux.lds.S
@@ -83,13 +83,7 @@ SECTIONS
   __setup_end = .;
   __initcall_start = .;
   .initcall.init : {
-	*(.initcall1.init)
-	*(.initcall2.init)
-	*(.initcall3.init)
-	*(.initcall4.init)
-	*(.initcall5.init)
-	*(.initcall6.init)
-	*(.initcall7.init)
+	INITCALLS
   }
   __initcall_end = .;
   __con_initcall_start = .;
diff -puN arch/m68k/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/m68k/kernel/vmlinux.lds.S
diff -puN arch/m68knommu/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/m68knommu/kernel/vmlinux.lds.S
--- a/arch/m68knommu/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/m68knommu/kernel/vmlinux.lds.S
@@ -140,13 +140,7 @@ SECTIONS {
 		*(.init.setup)
 		__setup_end = .;
 		__initcall_start = .;
-		*(.initcall1.init)
-		*(.initcall2.init)
-		*(.initcall3.init)
-		*(.initcall4.init)
-		*(.initcall5.init)
-		*(.initcall6.init)
-		*(.initcall7.init)
+		INITCALLS
 		__initcall_end = .;
 		__con_initcall_start = .;
 		*(.con_initcall.init)
diff -puN arch/mips/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/mips/kernel/vmlinux.lds.S
--- a/arch/mips/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/mips/kernel/vmlinux.lds.S
@@ -91,13 +91,7 @@ SECTIONS
 
   __initcall_start = .;
   .initcall.init : {
-	*(.initcall1.init)
-	*(.initcall2.init)
-	*(.initcall3.init)
-	*(.initcall4.init)
-	*(.initcall5.init)
-	*(.initcall6.init)
-	*(.initcall7.init)
+	INITCALLS
   }
   __initcall_end = .;
 
diff -puN arch/parisc/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/parisc/kernel/vmlinux.lds.S
--- a/arch/parisc/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/parisc/kernel/vmlinux.lds.S
@@ -153,13 +153,7 @@ SECTIONS
   __setup_end = .;
   __initcall_start = .;
   .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
+	INITCALLS
   }
   __initcall_end = .;
   __con_initcall_start = .;
diff -puN arch/powerpc/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/powerpc/kernel/vmlinux.lds.S
--- a/arch/powerpc/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/powerpc/kernel/vmlinux.lds.S
@@ -108,13 +108,7 @@ SECTIONS
 
 	.initcall.init : {
 		__initcall_start = .;
-		*(.initcall1.init)
-		*(.initcall2.init)
-		*(.initcall3.init)
-		*(.initcall4.init)
-		*(.initcall5.init)
-		*(.initcall6.init)
-		*(.initcall7.init)
+		INITCALLS
 		__initcall_end = .;
 		}
 
diff -puN arch/ppc/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/ppc/kernel/vmlinux.lds.S
--- a/arch/ppc/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/ppc/kernel/vmlinux.lds.S
@@ -115,13 +115,7 @@ SECTIONS
   __setup_end = .;
   __initcall_start = .;
   .initcall.init : {
-	*(.initcall1.init)
-	*(.initcall2.init)
-	*(.initcall3.init)
-	*(.initcall4.init)
-	*(.initcall5.init)
-	*(.initcall6.init)
-	*(.initcall7.init)
+	INITCALLS
   }
   __initcall_end = .;
 
diff -puN arch/s390/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/s390/kernel/vmlinux.lds.S
--- a/arch/s390/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/s390/kernel/vmlinux.lds.S
@@ -83,13 +83,7 @@ SECTIONS
   __setup_end = .;
   __initcall_start = .;
   .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
+	INITCALLS
   }
   __initcall_end = .;
   __con_initcall_start = .;
diff -puN arch/sh/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/sh/kernel/vmlinux.lds.S
--- a/arch/sh/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/sh/kernel/vmlinux.lds.S
@@ -76,13 +76,7 @@ SECTIONS
   __setup_end = .;
   __initcall_start = .;
   .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
+	INITCALLS
   }
   __initcall_end = .;
   __con_initcall_start = .;
diff -puN arch/sh64/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/sh64/kernel/vmlinux.lds.S
--- a/arch/sh64/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/sh64/kernel/vmlinux.lds.S
@@ -108,13 +108,7 @@ SECTIONS
   __setup_end = .;
   __initcall_start = .;
   .initcall.init : C_PHYS(.initcall.init) {
-  	*(.initcall1.init)
-  	*(.initcall2.init)
-  	*(.initcall3.init)
-  	*(.initcall4.init)
-  	*(.initcall5.init)
-  	*(.initcall6.init)
-  	*(.initcall7.init)
+	INITCALLS
   }
   __initcall_end = .;
   __con_initcall_start = .;
diff -puN arch/sparc/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/sparc/kernel/vmlinux.lds.S
--- a/arch/sparc/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/sparc/kernel/vmlinux.lds.S
@@ -49,13 +49,7 @@ SECTIONS
   __setup_end = .;
   __initcall_start = .;
   .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
+	INITCALLS
   }
   __initcall_end = .;
   __con_initcall_start = .;
diff -puN arch/sparc64/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/sparc64/kernel/vmlinux.lds.S
--- a/arch/sparc64/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/sparc64/kernel/vmlinux.lds.S
@@ -57,13 +57,7 @@ SECTIONS
   __setup_end = .;
   __initcall_start = .;
   .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
+	INITCALLS
   }
   __initcall_end = .;
   __con_initcall_start = .;
diff -puN arch/um/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/um/kernel/vmlinux.lds.S
diff -puN arch/v850/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/v850/kernel/vmlinux.lds.S
--- a/arch/v850/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/v850/kernel/vmlinux.lds.S
@@ -140,13 +140,7 @@
 		___setup_end = . ;					      \
 		___initcall_start = . ;					      \
 			*(.initcall.init)				      \
-			*(.initcall1.init)				      \
-			*(.initcall2.init)				      \
-			*(.initcall3.init)				      \
-			*(.initcall4.init)				      \
-			*(.initcall5.init)				      \
-			*(.initcall6.init)				      \
-			*(.initcall7.init)				      \
+			INITCALLS					      \
 		. = ALIGN (4) ;						      \
 		___initcall_end = . ;					      \
 		___con_initcall_start = .;				      \
diff -puN arch/x86_64/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/x86_64/kernel/vmlinux.lds.S
--- a/arch/x86_64/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/x86_64/kernel/vmlinux.lds.S
@@ -175,13 +175,7 @@ SECTIONS
   __setup_end = .;
   __initcall_start = .;
   .initcall.init : AT(ADDR(.initcall.init) - LOAD_OFFSET) {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
+	INITCALLS
   }
   __initcall_end = .;
   __con_initcall_start = .;
diff -puN arch/xtensa/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections arch/xtensa/kernel/vmlinux.lds.S
--- a/arch/xtensa/kernel/vmlinux.lds.S~vmlinuxlds-consolidate-initcall-sections
+++ a/arch/xtensa/kernel/vmlinux.lds.S
@@ -184,13 +184,7 @@ SECTIONS
 
   __initcall_start = .;
   .initcall.init : {
-  	*(.initcall1.init)
-  	*(.initcall2.init)
-  	*(.initcall3.init)
-  	*(.initcall4.init)
-  	*(.initcall5.init)
-  	*(.initcall6.init)
-  	*(.initcall7.init)
+	INITCALLS
   }
   __initcall_end = .;
 
diff -puN include/asm-generic/vmlinux.lds.h~vmlinuxlds-consolidate-initcall-sections include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h~vmlinuxlds-consolidate-initcall-sections
+++ a/include/asm-generic/vmlinux.lds.h
@@ -213,3 +213,13 @@
 
 #define NOTES								\
 		.notes : { *(.note.*) } :note
+
+#define INITCALLS							\
+  	*(.initcall1.init)						\
+  	*(.initcall2.init)						\
+  	*(.initcall3.init)						\
+  	*(.initcall4.init)						\
+  	*(.initcall5.init)						\
+  	*(.initcall6.init)						\
+  	*(.initcall7.init)
+
_

