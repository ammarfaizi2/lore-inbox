Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277284AbRJNTbx>; Sun, 14 Oct 2001 15:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277281AbRJNTbX>; Sun, 14 Oct 2001 15:31:23 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:7344 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S277275AbRJNTal>; Sun, 14 Oct 2001 15:30:41 -0400
Date: Sun, 14 Oct 2001 20:31:07 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Patch: minor cleanup to floppy.c (3/3)
Message-ID: <20011014203107.H32145@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Here's the final part of the cleanup - we remove the useless FDC2
declarations from the various architecture header files, as well
as some speeling mistaks. 8)

It depends on the first patch being applied.

--- orig/include/asm-m68k/floppy.h	Sun Oct 14 20:23:49 2001
+++ linux/include/asm-m68k/floppy.h	Sun Oct 14 20:23:30 2001
@@ -36,8 +36,6 @@
 
 /* basically PC init + set use_virtual_dma */
 #define  FDC1 m68k_floppy_init()
-static int FDC2 = -1;
-
 
 #define N_FDC 1
 #define N_DRIVE 8
--- orig/include/asm-mips/floppy.h	Sun Oct 14 20:23:49 2001
+++ linux/include/asm-mips/floppy.h	Sun Oct 14 20:23:30 2001
@@ -79,14 +79,6 @@
 
 #define FDC1			fd_ops->fd_getfdaddr1();
 
-/*
- * Hack: The floppy drivrer defines this, before including fdreg.h.  We use
- * to define FDC2 only one and keep it a static variable in floppy.c.
- */
-#ifdef FDPATCHES
-static int FDC2 = -1;
-#endif
-
 #define N_FDC 1			/* do you *really* want a second controller? */
 #define N_DRIVE 8
 
--- orig/include/asm-mips64/floppy.h	Sun Oct 14 20:23:49 2001
+++ linux/include/asm-mips64/floppy.h	Sun Oct 14 20:23:30 2001
@@ -77,14 +77,6 @@
 
 #define FDC1			fd_ops->fd_getfdaddr1();
 
-/*
- * Hack: The floppy drivrer defines this, before including fdreg.h.  We use
- * to define FDC2 only one and keep it a static variable in floppy.c.
- */
-#ifdef FDPATCHES
-static int FDC2=-1;
-#endif
-
 #define N_FDC 1			/* do you *really* want a second controller? */
 #define N_DRIVE 8
 
--- orig/include/asm-sparc/floppy.h	Sun Oct 14 20:23:49 2001
+++ linux/include/asm-sparc/floppy.h	Sun Oct 14 20:23:30 2001
@@ -96,8 +96,6 @@
  */
 #define FDC1                      sun_floppy_init()
 
-static int FDC2=-1;
-
 #define N_FDC    1
 #define N_DRIVE  8
 
--- orig/include/asm-sparc64/floppy.h	Sun Oct 14 20:23:50 2001
+++ linux/include/asm-sparc64/floppy.h	Sun Oct 14 20:23:30 2001
@@ -104,7 +104,6 @@
 #define FLOPPY1_TYPE		sun_floppy_types[1]
 
 #define FDC1			((unsigned long)sun_fdc)
-static int FDC2 =		-1;
 
 #define N_FDC    1
 #define N_DRIVE  8


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

