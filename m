Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSE3ATO>; Wed, 29 May 2002 20:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315922AbSE3ATN>; Wed, 29 May 2002 20:19:13 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:32400 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S315919AbSE3ATF>;
	Wed, 29 May 2002 20:19:05 -0400
Date: Thu, 30 May 2002 10:18:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: Trivial Kernel Patches <trivial@rustcorp.com.au>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] missing bit from signal patches
Message-Id: <20020530101848.2ac84805.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following should allow the affected architectures to build in
2.5.19 as currently there will be two definitions of
copy_siginfo_to_user.

Please apply.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.19/include/asm-alpha/siginfo.h 2.5.19-si.1/include/asm-alpha/siginfo.h
--- 2.5.19/include/asm-alpha/siginfo.h	Thu May 30 09:44:38 2002
+++ 2.5.19-si.1/include/asm-alpha/siginfo.h	Mon May 27 00:55:05 2002
@@ -6,6 +6,7 @@
 #define SIGEV_PAD_SIZE	((SIGEV_MAX_SIZE/sizeof(int)) - 4)
 
 #define HAVE_ARCH_COPY_SIGINFO
+#define HAVE_ARCH_COPY_SIGINFO_TO_USER
 
 #include <asm-generic/siginfo.h>
 
diff -ruN 2.5.19/include/asm-cris/siginfo.h 2.5.19-si.1/include/asm-cris/siginfo.h
--- 2.5.19/include/asm-cris/siginfo.h	Thu May 30 09:44:38 2002
+++ 2.5.19-si.1/include/asm-cris/siginfo.h	Mon May 27 00:55:05 2002
@@ -1,6 +1,8 @@
 #ifndef _CRIS_SIGINFO_H
 #define _CRIS_SIGINFO_H
 
+#define HAVE_ARCH_COPY_SIGINFO_TO_USER
+
 #include <asm-generic/siginfo.h>
 
 #endif
diff -ruN 2.5.19/include/asm-ia64/siginfo.h 2.5.19-si.1/include/asm-ia64/siginfo.h
--- 2.5.19/include/asm-ia64/siginfo.h	Thu May 30 09:44:38 2002
+++ 2.5.19-si.1/include/asm-ia64/siginfo.h	Mon May 27 00:55:05 2002
@@ -13,6 +13,7 @@
 #define HAVE_ARCH_SIGINFO_T
 
 #define HAVE_ARCH_COPY_SIGINFO
+#define HAVE_ARCH_COPY_SIGINFO_TO_USER
 
 #include <asm-generic/siginfo.h>
 
diff -ruN 2.5.19/include/asm-mips64/siginfo.h 2.5.19-si.1/include/asm-mips64/siginfo.h
--- 2.5.19/include/asm-mips64/siginfo.h	Thu May 30 09:44:38 2002
+++ 2.5.19-si.1/include/asm-mips64/siginfo.h	Mon May 27 00:55:05 2002
@@ -13,6 +13,7 @@
 
 #define HAVE_ARCH_SIGINFO_T
 #define HAVE_ARCH_SIGEVENT_T
+#define HAVE_ARCH_COPY_SIGINFO_TO_USER
 
 #include <asm-generic/siginfo.h>
 
diff -ruN 2.5.19/include/asm-parisc/siginfo.h 2.5.19-si.1/include/asm-parisc/siginfo.h
--- 2.5.19/include/asm-parisc/siginfo.h	Thu May 30 09:44:38 2002
+++ 2.5.19-si.1/include/asm-parisc/siginfo.h	Mon May 27 00:55:05 2002
@@ -1,6 +1,8 @@
 #ifndef _PARISC_SIGINFO_H
 #define _PARISC_SIGINFO_H
 
+#define HAVE_ARCH_COPY_SIGINFO_TO_USER
+
 #include <asm-generic/siginfo.h>
 
 /*
diff -ruN 2.5.19/include/asm-sparc/siginfo.h 2.5.19-si.1/include/asm-sparc/siginfo.h
--- 2.5.19/include/asm-sparc/siginfo.h	Thu May 30 09:44:39 2002
+++ 2.5.19-si.1/include/asm-sparc/siginfo.h	Mon May 27 00:55:05 2002
@@ -7,6 +7,7 @@
 
 #define HAVE_ARCH_SIGINFO_T
 #define HAVE_ARCH_COPY_SIGINFO
+#define HAVE_ARCH_COPY_SIGINFO_TO_USER
 
 #include <asm-generic/siginfo.h>
 
diff -ruN 2.5.19/include/asm-sparc64/siginfo.h 2.5.19-si.1/include/asm-sparc64/siginfo.h
--- 2.5.19/include/asm-sparc64/siginfo.h	Thu May 30 09:44:39 2002
+++ 2.5.19-si.1/include/asm-sparc64/siginfo.h	Mon May 27 00:55:05 2002
@@ -10,6 +10,7 @@
 #define HAVE_ARCH_SIGINFO_T
 
 #define HAVE_ARCH_COPY_SIGINFO
+#define HAVE_ARCH_COPY_SIGINFO_TO_USER
 
 #include <asm-generic/siginfo.h>
 
