Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSEGGQJ>; Tue, 7 May 2002 02:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315364AbSEGGQI>; Tue, 7 May 2002 02:16:08 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:23487 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S315358AbSEGGQI>;
	Tue, 7 May 2002 02:16:08 -0400
Date: Tue, 7 May 2002 16:15:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] USE_STANDARD_AS_RULE in i386 arch Makefiles
Message-Id: <20020507161515.15937c50.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

In Rules.make, a comment says:

# Old makefiles define their own rules for compiling .S files,
# but these standard rules are available for any Makefile that
# wants to use them.  Our plan is to incrementally convert all
# the Makefiles to these standard rules.  -- rmk, mec

This patch does that for the i386 arch Makefiles.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.14/arch/i386/kernel/Makefile 2.5.14-kb1/arch/i386/kernel/Makefile
--- 2.5.14/arch/i386/kernel/Makefile	Mon Apr 15 10:44:54 2002
+++ 2.5.14-kb1/arch/i386/kernel/Makefile	Tue May  7 15:34:20 2002
@@ -7,8 +7,8 @@
 #
 # Note 2! The CFLAGS definitions are now in the main makefile...
 
-.S.o:
-	$(CC) $(AFLAGS) -traditional -c $< -o $*.o
+EXTRA_AFLAGS	:= -traditional
+USE_STANDARD_AS_RULE	:= true
 
 all: kernel.o head.o init_task.o
 
diff -ruN 2.5.14/arch/i386/lib/Makefile 2.5.14-kb1/arch/i386/lib/Makefile
--- 2.5.14/arch/i386/lib/Makefile	Mon Sep 24 05:12:37 2001
+++ 2.5.14-kb1/arch/i386/lib/Makefile	Tue May  7 15:43:21 2002
@@ -2,8 +2,7 @@
 # Makefile for i386-specific library files..
 #
 
-.S.o:
-	$(CC) $(AFLAGS) -c $< -o $*.o
+USE_STANDARD_AS_RULE	:= true
 
 L_TARGET = lib.a
 
diff -ruN 2.5.14/arch/i386/math-emu/Makefile 2.5.14-kb1/arch/i386/math-emu/Makefile
--- 2.5.14/arch/i386/math-emu/Makefile	Sat Dec 30 09:07:20 2000
+++ 2.5.14-kb1/arch/i386/math-emu/Makefile	Tue May  7 15:45:58 2002
@@ -9,8 +9,8 @@
 PARANOID = -DPARANOID
 CFLAGS	:= $(CFLAGS) $(PARANOID) $(DEBUG) -fno-builtin $(MATH_EMULATION)
 
-.S.o:
-	$(CC) $(AFLAGS) $(PARANOID) -c $<
+USE_STANDARD_AS_RULE	:= true
+EXTRA_AFLAGS	:= $(PARANOID)
 
 # From 'C' language sources:
 C_OBJS =fpu_entry.o errors.o \
