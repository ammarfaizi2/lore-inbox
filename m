Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277143AbRJNTab>; Sun, 14 Oct 2001 15:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277275AbRJNTaW>; Sun, 14 Oct 2001 15:30:22 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:6064 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S277143AbRJNTaI>; Sun, 14 Oct 2001 15:30:08 -0400
Date: Sun, 14 Oct 2001 20:30:39 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Patch: minor cleanup to floppy.c (2/3)
Message-ID: <20011014203039.G32145@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

This patch adds support for architectures (like ARM) that need to add
extra floppy parameters.  The ARM floppy.h already has support for
this; this patch adds the necessary bits to the other architectures,
and the bit floppy.c change to hook it into the table.

This patch should be applied after the first, but the order isn't
critical.

--- orig/include/asm-alpha/floppy.h	Sun Jun 18 17:11:05 2000
+++ linux/include/asm-alpha/floppy.h	Sat Oct 13 13:08:56 2001
@@ -116,4 +116,6 @@
 # endif
 #endif
 
+#define EXTRA_FLOPPY_PARAMS
+
 #endif /* __ASM_ALPHA_FLOPPY_H */
--- orig/include/asm-i386/floppy.h	Fri Jan  5 01:03:52 2001
+++ linux/include/asm-i386/floppy.h	Sat Oct 13 13:08:56 2001
@@ -315,5 +315,6 @@
 
 #define AUTO_DMA
 
+#define EXTRA_FLOPPY_PARAMS
 
 #endif /* __ASM_I386_FLOPPY_H */
--- orig/include/asm-m68k/floppy.h	Wed Jul  4 19:54:07 2001
+++ linux/include/asm-m68k/floppy.h	Sat Oct 13 13:08:56 2001
@@ -254,5 +254,4 @@
 #endif
 }
 
-
-
+#define EXTRA_FLOPPY_PARAMS
--- orig/include/asm-mips/floppy.h	Mon Jul 10 21:56:30 2000
+++ linux/include/asm-mips/floppy.h	Sat Oct 13 13:08:56 2001
@@ -107,4 +107,6 @@
  */
 #define CROSS_64KB(a,s) ((unsigned long)(a)/K_64 != ((unsigned long)(a) + (s) - 1) / K_64)
 
+#define EXTRA_FLOPPY_PARAMS
+
 #endif /* _ASM_FLOPPY_H */
--- orig/include/asm-mips64/floppy.h	Mon Jul 10 21:56:31 2000
+++ linux/include/asm-mips64/floppy.h	Sat Oct 13 13:08:56 2001
@@ -105,4 +105,6 @@
  */
 #define CROSS_64KB(a,s) ((unsigned long)(a)/K_64 != ((unsigned long)(a) + (s) - 1) / K_64)
 
+#define EXTRA_FLOPPY_PARAMS
+
 #endif /* _ASM_FLOPPY_H */
--- orig/include/asm-ppc/floppy.h	Fri May 25 20:06:28 2001
+++ linux/include/asm-ppc/floppy.h	Sat Oct 13 13:08:56 2001
@@ -58,4 +58,7 @@
 #define CROSS_64KB(a,s)	(0)
 
 #endif /* __ASM_PPC_FLOPPY_H */
+
+#define EXTRA_FLOPPY_PARAMS
+
 #endif /* __KERNEL__ */
--- orig/include/asm-ppc64/floppy.h	Thu Oct 11 10:17:21 2001
+++ linux/include/asm-ppc64/floppy.h	Sat Oct 13 13:08:56 2001
@@ -100,4 +100,6 @@
  */
 #define CROSS_64KB(a,s)	(0)
 
+#define EXTRA_FLOPPY_PARAMS
+
 #endif /* __ASM_PPC64_FLOPPY_H */
--- orig/include/asm-sparc/floppy.h	Fri Sep  8 21:58:02 2000
+++ linux/include/asm-sparc/floppy.h	Sat Oct 13 13:08:56 2001
@@ -366,4 +366,6 @@
 
 #define fd_eject(drive) sparc_eject()
 
+#define EXTRA_FLOPPY_PARAMS
+
 #endif /* !(__ASM_SPARC_FLOPPY_H) */
--- orig/include/asm-sparc64/floppy.h	Mon Oct  1 23:11:32 2001
+++ linux/include/asm-sparc64/floppy.h	Sat Oct 13 13:08:56 2001
@@ -884,4 +884,6 @@
 	return sun_floppy_types[0];
 }
 
+#define EXTRA_FLOPPY_PARAMS
+
 #endif /* !(__ASM_SPARC64_FLOPPY_H) */
--- orig/include/asm-um/floppy.h	Thu Oct 11 10:17:25 2001
+++ linux/include/asm-um/floppy.h	Sat Oct 13 13:08:56 2001
@@ -3,4 +3,8 @@
 
 #include "asm/arch/floppy.h"
 
+#ifndef EXTRA_FLOPPY_PARAMS
+#define EXTRA_FLOPPY_PARAMS
+#endif
+
 #endif
--- orig/include/asm-x86_64/floppy.h	Thu Oct 11 10:17:26 2001
+++ linux/include/asm-x86_64/floppy.h	Sat Oct 13 13:08:56 2001
@@ -281,5 +281,6 @@
 
 #define AUTO_DMA
 
+#define EXTRA_FLOPPY_PARAMS
 
 #endif /* __ASM_X86_64_FLOPPY_H */
--- orig/drivers/block/floppy.c	Sun Oct 14 20:17:18 2001
+++ linux/drivers/block/floppy.c	Sat Oct 13 13:25:04 2001
@@ -4104,6 +4104,8 @@
 	{ "unexpected_interrupts", 0, &print_unex, 1, 0 },
 	{ "no_unexpected_interrupts", 0, &print_unex, 0, 0 },
 	{ "L40SX", 0, &print_unex, 0, 0 }
+
+	EXTRA_FLOPPY_PARAMS
 };
 
 static int __init floppy_setup(char *str)


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

