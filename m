Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946032AbWBORIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946032AbWBORIM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946028AbWBORIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:08:12 -0500
Received: from [194.90.237.34] ([194.90.237.34]:52584 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1946030AbWBORII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:08:08 -0500
Date: Wed, 15 Feb 2006 19:09:35 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-arch@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Roland Dreier <rdreier@cisco.com>, Hugh Dickins <hugh@veritas.com>,
       Linus Torvalds <torvalds@osdl.org>, Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] add asm-generic/mman.h
Message-ID: <20060215170935.GE12974@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060215151649.GA12090@mellanox.co.il> <1140019088.21448.3.camel@dyn9047017100.beaverton.ibm.com> <20060215165016.GD12974@mellanox.co.il> <1140022377.21448.6.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140022377.21448.6.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 15 Feb 2006 17:10:01.0312 (UTC) FILETIME=[A7F3D600:01C63252]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Badari Pulavarty <pbadari@us.ibm.com>:
> MS_SYNC should be 4
> MS_INVALIDATE should be 2

Good catch, thanks!
Other numbers look right, dont they?

---

Make new MADV_REMOVE, MADV_DONTFORK, MADV_DOFORK consistent across all arches.
The idea is to make it possible to use them portably even before distros
include them in libc headers.

Move common flags to asm-generic/mman.h

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

Index: linux-2.6.16-rc3/include/asm-powerpc/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-powerpc/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-powerpc/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _ASM_POWERPC_MMAN_H
 #define _ASM_POWERPC_MMAN_H
 
+#include <asm-generic/mman.h>
+
 /*
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -8,19 +10,6 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#define PROT_READ	0x1		/* page can be read */
-#define PROT_WRITE	0x2		/* page can be written */
-#define PROT_EXEC	0x4		/* page can be executed */
-#define PROT_SEM	0x8		/* page may be used for atomic ops */
-#define PROT_NONE	0x0		/* page can not be accessed */
-#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
-#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
-
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_TYPE	0x0f		/* Mask for type of mapping */
-#define MAP_FIXED	0x10		/* Interpret addr exactly */
-#define MAP_ANONYMOUS	0x20		/* don't use a file */
 #define MAP_RENAME      MAP_ANONYMOUS   /* In SunOS terminology */
 #define MAP_NORESERVE   0x40            /* don't reserve swap pages */
 #define MAP_LOCKED	0x80
@@ -29,27 +18,10 @@
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 
-#define MS_ASYNC	1		/* sync memory asynchronously */
-#define MS_INVALIDATE	2		/* invalidate the caches */
-#define MS_SYNC		4		/* synchronous memory sync */
-
 #define MCL_CURRENT     0x2000          /* lock all currently mapped pages */
 #define MCL_FUTURE      0x4000          /* lock all additions to address space */
 
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
 
-#define MADV_NORMAL	0x0		/* default page-in behavior */
-#define MADV_RANDOM	0x1		/* page-in minimum required */
-#define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
-#define MADV_WILLNEED	0x3		/* pre-fault pages */
-#define MADV_DONTNEED	0x4		/* discard these pages */
-#define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
-
-/* compatibility flags */
-#define MAP_ANON	MAP_ANONYMOUS
-#define MAP_FILE	0
-
 #endif	/* _ASM_POWERPC_MMAN_H */
Index: linux-2.6.16-rc3/include/asm-cris/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-cris/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-cris/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -3,19 +3,7 @@
 
 /* verbatim copy of asm-i386/ version */
 
-#define PROT_READ	0x1		/* page can be read */
-#define PROT_WRITE	0x2		/* page can be written */
-#define PROT_EXEC	0x4		/* page can be executed */
-#define PROT_SEM	0x8		/* page may be used for atomic ops */
-#define PROT_NONE	0x0		/* page can not be accessed */
-#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
-#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
-
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_TYPE	0x0f		/* Mask for type of mapping */
-#define MAP_FIXED	0x10		/* Interpret addr exactly */
-#define MAP_ANONYMOUS	0x20		/* don't use a file */
+#include <asm-generic/mman.h>
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
@@ -25,24 +13,7 @@
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
 
-#define MS_ASYNC	1		/* sync memory asynchronously */
-#define MS_INVALIDATE	2		/* invalidate the caches */
-#define MS_SYNC		4		/* synchronous memory sync */
-
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
 
-#define MADV_NORMAL	0x0		/* default page-in behavior */
-#define MADV_RANDOM	0x1		/* page-in minimum required */
-#define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
-#define MADV_WILLNEED	0x3		/* pre-fault pages */
-#define MADV_DONTNEED	0x4		/* discard these pages */
-#define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
-
-/* compatibility flags */
-#define MAP_ANON	MAP_ANONYMOUS
-#define MAP_FILE	0
-
 #endif /* __CRIS_MMAN_H__ */
Index: linux-2.6.16-rc3/include/asm-arm26/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-arm26/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-arm26/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -1,19 +1,7 @@
 #ifndef __ARM_MMAN_H__
 #define __ARM_MMAN_H__
 
-#define PROT_READ	0x1		/* page can be read */
-#define PROT_WRITE	0x2		/* page can be written */
-#define PROT_EXEC	0x4		/* page can be executed */
-#define PROT_SEM	0x8		/* page may be used for atomic ops */
-#define PROT_NONE	0x0		/* page can not be accessed */
-#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
-#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
-
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_TYPE	0x0f		/* Mask for type of mapping */
-#define MAP_FIXED	0x10		/* Interpret addr exactly */
-#define MAP_ANONYMOUS	0x20		/* don't use a file */
+#include <asm-generic/mman.h>
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
@@ -23,24 +11,7 @@
 #define MAP_POPULATE    0x8000          /* populate (prefault) page tables */
 #define MAP_NONBLOCK    0x10000         /* do not block on IO */
 
-#define MS_ASYNC	1		/* sync memory asynchronously */
-#define MS_INVALIDATE	2		/* invalidate the caches */
-#define MS_SYNC		4		/* synchronous memory sync */
-
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
 
-#define MADV_NORMAL	0x0		/* default page-in behavior */
-#define MADV_RANDOM	0x1		/* page-in minimum required */
-#define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
-#define MADV_WILLNEED	0x3		/* pre-fault pages */
-#define MADV_DONTNEED	0x4		/* discard these pages */
-#define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
-
-/* compatibility flags */
-#define MAP_ANON	MAP_ANONYMOUS
-#define MAP_FILE	0
-
 #endif /* __ARM_MMAN_H__ */
Index: linux-2.6.16-rc3/include/asm-alpha/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-alpha/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-alpha/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -42,9 +42,11 @@
 #define MADV_WILLNEED	3		/* will need these pages */
 #define	MADV_SPACEAVAIL	5		/* ensure resources are available */
 #define MADV_DONTNEED	6		/* don't need these pages */
-#define MADV_REMOVE	7		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+
+/* common/generic parameters */
+#define MADV_REMOVE	9		/* remove these pages & resources */
+#define MADV_DONTFORK	10		/* don't inherit across fork */
+#define MADV_DOFORK	11		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
Index: linux-2.6.16-rc3/include/asm-m68k/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-m68k/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-m68k/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -1,19 +1,7 @@
 #ifndef __M68K_MMAN_H__
 #define __M68K_MMAN_H__
 
-#define PROT_READ	0x1		/* page can be read */
-#define PROT_WRITE	0x2		/* page can be written */
-#define PROT_EXEC	0x4		/* page can be executed */
-#define PROT_SEM	0x8		/* page may be used for atomic ops */
-#define PROT_NONE	0x0		/* page can not be accessed */
-#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
-#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
-
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_TYPE	0x0f		/* Mask for type of mapping */
-#define MAP_FIXED	0x10		/* Interpret addr exactly */
-#define MAP_ANONYMOUS	0x20		/* don't use a file */
+#include <asm-generic/mman.h>
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
@@ -23,24 +11,7 @@
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
 
-#define MS_ASYNC	1		/* sync memory asynchronously */
-#define MS_INVALIDATE	2		/* invalidate the caches */
-#define MS_SYNC		4		/* synchronous memory sync */
-
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
 
-#define MADV_NORMAL	0x0		/* default page-in behavior */
-#define MADV_RANDOM	0x1		/* page-in minimum required */
-#define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
-#define MADV_WILLNEED	0x3		/* pre-fault pages */
-#define MADV_DONTNEED	0x4		/* discard these pages */
-#define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
-
-/* compatibility flags */
-#define MAP_ANON	MAP_ANONYMOUS
-#define MAP_FILE	0
-
 #endif /* __M68K_MMAN_H__ */
Index: linux-2.6.16-rc3/include/asm-xtensa/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-xtensa/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-xtensa/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -67,17 +67,19 @@
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
 
-#define MADV_NORMAL	0x0		/* default page-in behavior */
-#define MADV_RANDOM	0x1		/* page-in minimum required */
-#define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
-#define MADV_WILLNEED	0x3		/* pre-fault pages */
-#define MADV_DONTNEED	0x4		/* discard these pages */
-#define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_NORMAL	0		/* no further special treatment */
+#define MADV_RANDOM	1		/* expect random page references */
+#define MADV_SEQUENTIAL	2		/* expect sequential page references */
+#define MADV_WILLNEED	3		/* will need these pages */
+#define MADV_DONTNEED	4		/* don't need these pages */
+
+/* common parameters: try to keep these consistent across architectures */
+#define MADV_REMOVE	9		/* remove these pages & resources */
+#define MADV_DONTFORK	10		/* don't inherit across fork */
+#define MADV_DOFORK	11		/* do inherit across fork */
 
 /* compatibility flags */
-#define MAP_ANON       MAP_ANONYMOUS
-#define MAP_FILE       0
+#define MAP_ANON	MAP_ANONYMOUS
+#define MAP_FILE	0
 
 #endif /* _XTENSA_MMAN_H */
Index: linux-2.6.16-rc3/include/asm-mips/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-mips/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-mips/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -60,17 +60,19 @@
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
 
-#define MADV_NORMAL	0x0		/* default page-in behavior */
-#define MADV_RANDOM	0x1		/* page-in minimum required */
-#define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
-#define MADV_WILLNEED	0x3		/* pre-fault pages */
-#define MADV_DONTNEED	0x4		/* discard these pages */
-#define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_NORMAL	0		/* no further special treatment */
+#define MADV_RANDOM	1		/* expect random page references */
+#define MADV_SEQUENTIAL	2		/* expect sequential page references */
+#define MADV_WILLNEED	3		/* will need these pages */
+#define MADV_DONTNEED	4		/* don't need these pages */
+
+/* common parameters: try to keep these consistent across architectures */
+#define MADV_REMOVE	9		/* remove these pages & resources */
+#define MADV_DONTFORK	10		/* don't inherit across fork */
+#define MADV_DOFORK	11		/* do inherit across fork */
 
 /* compatibility flags */
-#define MAP_ANON       MAP_ANONYMOUS
-#define MAP_FILE       0
+#define MAP_ANON	MAP_ANONYMOUS
+#define MAP_FILE	0
 
 #endif /* _ASM_MMAN_H */
Index: linux-2.6.16-rc3/include/asm-sparc64/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-sparc64/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-sparc64/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -2,21 +2,10 @@
 #ifndef __SPARC64_MMAN_H__
 #define __SPARC64_MMAN_H__
 
+#include <asm-generic/mman.h>
+
 /* SunOS'ified... */
 
-#define PROT_READ	0x1		/* page can be read */
-#define PROT_WRITE	0x2		/* page can be written */
-#define PROT_EXEC	0x4		/* page can be executed */
-#define PROT_SEM	0x8		/* page may be used for atomic ops */
-#define PROT_NONE	0x0		/* page can not be accessed */
-#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
-#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
-
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_TYPE	0x0f		/* Mask for type of mapping */
-#define MAP_FIXED	0x10		/* Interpret addr exactly */
-#define MAP_ANONYMOUS	0x20		/* don't use a file */
 #define MAP_RENAME      MAP_ANONYMOUS   /* In SunOS terminology */
 #define MAP_NORESERVE   0x40            /* don't reserve swap pages */
 #define MAP_INHERIT     0x80            /* SunOS doesn't do this, but... */
@@ -27,10 +16,6 @@
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 
-#define MS_ASYNC	1		/* sync memory asynchronously */
-#define MS_INVALIDATE	2		/* invalidate the caches */
-#define MS_SYNC		4		/* synchronous memory sync */
-
 #define MCL_CURRENT     0x2000          /* lock all currently mapped pages */
 #define MCL_FUTURE      0x4000          /* lock all additions to address space */
 
@@ -48,18 +33,6 @@
 #define MC_LOCKAS       5  /* Lock an entire address space of the calling process */
 #define MC_UNLOCKAS     6  /* Unlock entire address space of calling process */
 
-#define MADV_NORMAL	0x0		/* default page-in behavior */
-#define MADV_RANDOM	0x1		/* page-in minimum required */
-#define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
-#define MADV_WILLNEED	0x3		/* pre-fault pages */
-#define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_FREE	0x5		/* (Solaris) contents can be freed */
-#define MADV_REMOVE	0x6		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
-
-/* compatibility flags */
-#define MAP_ANON	MAP_ANONYMOUS
-#define MAP_FILE	0
 
 #endif /* __SPARC64_MMAN_H__ */
Index: linux-2.6.16-rc3/include/asm-v850/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-v850/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-v850/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -1,18 +1,7 @@
 #ifndef __V850_MMAN_H__
 #define __V850_MMAN_H__
 
-#define PROT_READ	0x1		/* page can be read */
-#define PROT_WRITE	0x2		/* page can be written */
-#define PROT_EXEC	0x4		/* page can be executed */
-#define PROT_NONE	0x0		/* page can not be accessed */
-#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
-#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
-
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_TYPE	0x0f		/* Mask for type of mapping */
-#define MAP_FIXED	0x10		/* Interpret addr exactly */
-#define MAP_ANONYMOUS	0x20		/* don't use a file */
+#include <asm-generic/mman.h>
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
@@ -20,24 +9,7 @@
 #define MAP_LOCKED	0x2000		/* pages are locked */
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 
-#define MS_ASYNC	1		/* sync memory asynchronously */
-#define MS_INVALIDATE	2		/* invalidate the caches */
-#define MS_SYNC		4		/* synchronous memory sync */
-
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
 
-#define MADV_NORMAL	0x0		/* default page-in behavior */
-#define MADV_RANDOM	0x1		/* page-in minimum required */
-#define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
-#define MADV_WILLNEED	0x3		/* pre-fault pages */
-#define MADV_DONTNEED	0x4		/* discard these pages */
-#define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
-
-/* compatibility flags */
-#define MAP_ANON	MAP_ANONYMOUS
-#define MAP_FILE	0
-
 #endif /* __V850_MMAN_H__ */
Index: linux-2.6.16-rc3/include/asm-s390/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-s390/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-s390/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -9,19 +9,7 @@
 #ifndef __S390_MMAN_H__
 #define __S390_MMAN_H__
 
-#define PROT_READ	0x1		/* page can be read */
-#define PROT_WRITE	0x2		/* page can be written */
-#define PROT_EXEC	0x4		/* page can be executed */
-#define PROT_SEM	0x8		/* page may be used for atomic ops */
-#define PROT_NONE	0x0		/* page can not be accessed */
-#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
-#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
-
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_TYPE	0x0f		/* Mask for type of mapping */
-#define MAP_FIXED	0x10		/* Interpret addr exactly */
-#define MAP_ANONYMOUS	0x20		/* don't use a file */
+#include <asm-generic/mman.h>
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
@@ -31,24 +19,7 @@
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
 
-#define MS_ASYNC	1		/* sync memory asynchronously */
-#define MS_INVALIDATE	2		/* invalidate the caches */
-#define MS_SYNC		4		/* synchronous memory sync */
-
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
 
-#define MADV_NORMAL    0x0              /* default page-in behavior */
-#define MADV_RANDOM    0x1              /* page-in minimum required */
-#define MADV_SEQUENTIAL        0x2             /* read-ahead aggressively */
-#define MADV_WILLNEED  0x3              /* pre-fault pages */
-#define MADV_DONTNEED  0x4              /* discard these pages */
-#define MADV_REMOVE    0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
-
-/* compatibility flags */
-#define MAP_ANON	MAP_ANONYMOUS
-#define MAP_FILE	0
-
 #endif /* __S390_MMAN_H__ */
Index: linux-2.6.16-rc3/include/asm-parisc/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-parisc/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-parisc/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -38,7 +38,11 @@
 #define MADV_SPACEAVAIL 5               /* insure that resources are reserved */
 #define MADV_VPS_PURGE  6               /* Purge pages from VM page cache */
 #define MADV_VPS_INHERIT 7              /* Inherit parents page size */
-#define MADV_REMOVE     8		/* remove these pages & resources */
+
+/* common/generic parameters */
+#define MADV_REMOVE	9		/* remove these pages & resources */
+#define MADV_DONTFORK	10		/* don't inherit across fork */
+#define MADV_DOFORK	11		/* do inherit across fork */
 
 /* The range 12-64 is reserved for page size specification. */
 #define MADV_4K_PAGES   12              /* Use 4K pages  */
@@ -49,8 +53,6 @@
 #define MADV_4M_PAGES   22              /* Use 4 Megabyte pages */
 #define MADV_16M_PAGES  24              /* Use 16 Megabyte pages */
 #define MADV_64M_PAGES  26              /* Use 64 Megabyte pages */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
Index: linux-2.6.16-rc3/include/asm-i386/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-i386/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-i386/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -1,19 +1,7 @@
 #ifndef __I386_MMAN_H__
 #define __I386_MMAN_H__
 
-#define PROT_READ	0x1		/* page can be read */
-#define PROT_WRITE	0x2		/* page can be written */
-#define PROT_EXEC	0x4		/* page can be executed */
-#define PROT_SEM	0x8		/* page may be used for atomic ops */
-#define PROT_NONE	0x0		/* page can not be accessed */
-#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
-#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
-
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_TYPE	0x0f		/* Mask for type of mapping */
-#define MAP_FIXED	0x10		/* Interpret addr exactly */
-#define MAP_ANONYMOUS	0x20		/* don't use a file */
+#include <asm-generic/mman.h>
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
@@ -23,24 +11,7 @@
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
 
-#define MS_ASYNC	1		/* sync memory asynchronously */
-#define MS_INVALIDATE	2		/* invalidate the caches */
-#define MS_SYNC		4		/* synchronous memory sync */
-
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
 
-#define MADV_NORMAL	0x0		/* default page-in behavior */
-#define MADV_RANDOM	0x1		/* page-in minimum required */
-#define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
-#define MADV_WILLNEED	0x3		/* pre-fault pages */
-#define MADV_DONTNEED	0x4		/* discard these pages */
-#define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
-
-/* compatibility flags */
-#define MAP_ANON	MAP_ANONYMOUS
-#define MAP_FILE	0
-
 #endif /* __I386_MMAN_H__ */
Index: linux-2.6.16-rc3/include/asm-sh/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-sh/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-sh/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -1,19 +1,7 @@
 #ifndef __ASM_SH_MMAN_H
 #define __ASM_SH_MMAN_H
 
-#define PROT_READ	0x1		/* page can be read */
-#define PROT_WRITE	0x2		/* page can be written */
-#define PROT_EXEC	0x4		/* page can be executed */
-#define PROT_SEM	0x8		/* page may be used for atomic ops */
-#define PROT_NONE	0x0		/* page can not be accessed */
-#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
-#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
-
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_TYPE	0x0f		/* Mask for type of mapping */
-#define MAP_FIXED	0x10		/* Interpret addr exactly */
-#define MAP_ANONYMOUS	0x20		/* don't use a file */
+#include <asm-generic/mman.h>
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
@@ -23,24 +11,7 @@
 #define MAP_POPULATE	0x8000		/* populate (prefault) page tables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
 
-#define MS_ASYNC	1		/* sync memory asynchronously */
-#define MS_INVALIDATE	2		/* invalidate the caches */
-#define MS_SYNC		4		/* synchronous memory sync */
-
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
 
-#define MADV_NORMAL	0x0		/* default page-in behavior */
-#define MADV_RANDOM	0x1		/* page-in minimum required */
-#define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
-#define MADV_WILLNEED	0x3		/* pre-fault pages */
-#define MADV_DONTNEED	0x4		/* discard these pages */
-#define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
-
-/* compatibility flags */
-#define MAP_ANON	MAP_ANONYMOUS
-#define MAP_FILE	0
-
 #endif /* __ASM_SH_MMAN_H */
Index: linux-2.6.16-rc3/include/asm-ia64/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-ia64/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-ia64/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -8,19 +8,7 @@
  *	David Mosberger-Tang <davidm@hpl.hp.com>, Hewlett-Packard Co
  */
 
-#define PROT_READ	0x1		/* page can be read */
-#define PROT_WRITE	0x2		/* page can be written */
-#define PROT_EXEC	0x4		/* page can be executed */
-#define PROT_SEM	0x8		/* page may be used for atomic ops */
-#define PROT_NONE	0x0		/* page can not be accessed */
-#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
-#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
-
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_TYPE	0x0f		/* Mask for type of mapping */
-#define MAP_FIXED	0x10		/* Interpret addr exactly */
-#define MAP_ANONYMOUS	0x20		/* don't use a file */
+#include <asm-generic/mman.h>
 
 #define MAP_GROWSDOWN	0x00100		/* stack-like segment */
 #define MAP_GROWSUP	0x00200		/* register stack-like segment */
@@ -31,24 +19,7 @@
 #define MAP_POPULATE	0x08000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
 
-#define MS_ASYNC	1		/* sync memory asynchronously */
-#define MS_INVALIDATE	2		/* invalidate the caches */
-#define MS_SYNC		4		/* synchronous memory sync */
-
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
 
-#define MADV_NORMAL	0x0		/* default page-in behavior */
-#define MADV_RANDOM	0x1		/* page-in minimum required */
-#define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
-#define MADV_WILLNEED	0x3		/* pre-fault pages */
-#define MADV_DONTNEED	0x4		/* discard these pages */
-#define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
-
-/* compatibility flags */
-#define MAP_ANON	MAP_ANONYMOUS
-#define MAP_FILE	0
-
 #endif /* _ASM_IA64_MMAN_H */
Index: linux-2.6.16-rc3/include/asm-generic/mman.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-rc3/include/asm-generic/mman.h	2006-02-15 21:52:25.000000000 +0200
@@ -0,0 +1,42 @@
+#ifndef _ASM_GENERIC_MMAN_H
+#define _ASM_GENERIC_MMAN_H
+
+/*
+ Author: Michael S. Tsirkin <mst@mellanox.co.il>, Mellanox Technologies Ltd.
+ Based on: asm-xxx/mman.h
+*/
+
+#define PROT_READ	0x1		/* page can be read */
+#define PROT_WRITE	0x2		/* page can be written */
+#define PROT_EXEC	0x4		/* page can be executed */
+#define PROT_SEM	0x8		/* page may be used for atomic ops */
+#define PROT_NONE	0x0		/* page can not be accessed */
+#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
+#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+
+#define MAP_SHARED	0x01		/* Share changes */
+#define MAP_PRIVATE	0x02		/* Changes are private */
+#define MAP_TYPE	0x0f		/* Mask for type of mapping */
+#define MAP_FIXED	0x10		/* Interpret addr exactly */
+#define MAP_ANONYMOUS	0x20		/* don't use a file */
+
+#define MS_ASYNC	1		/* sync memory asynchronously */
+#define MS_INVALIDATE	2		/* invalidate the caches */
+#define MS_SYNC		4		/* synchronous memory sync */
+
+#define MADV_NORMAL	0		/* no further special treatment */
+#define MADV_RANDOM	1		/* expect random page references */
+#define MADV_SEQUENTIAL	2		/* expect sequential page references */
+#define MADV_WILLNEED	3		/* will need these pages */
+#define MADV_DONTNEED	4		/* don't need these pages */
+
+/* common parameters: try to keep these consistent across architectures */
+#define MADV_REMOVE	9		/* remove these pages & resources */
+#define MADV_DONTFORK	10		/* don't inherit across fork */
+#define MADV_DOFORK	11		/* do inherit across fork */
+
+/* compatibility flags */
+#define MAP_ANON	MAP_ANONYMOUS
+#define MAP_FILE	0
+
+#endif
Index: linux-2.6.16-rc3/include/asm-sparc/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-sparc/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-sparc/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -2,21 +2,10 @@
 #ifndef __SPARC_MMAN_H__
 #define __SPARC_MMAN_H__
 
+#include <asm-generic/mman.h>
+
 /* SunOS'ified... */
 
-#define PROT_READ	0x1		/* page can be read */
-#define PROT_WRITE	0x2		/* page can be written */
-#define PROT_EXEC	0x4		/* page can be executed */
-#define PROT_SEM	0x8		/* page may be used for atomic ops */
-#define PROT_NONE	0x0		/* page can not be accessed */
-#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
-#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
-
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_TYPE	0x0f		/* Mask for type of mapping */
-#define MAP_FIXED	0x10		/* Interpret addr exactly */
-#define MAP_ANONYMOUS	0x20		/* don't use a file */
 #define MAP_RENAME      MAP_ANONYMOUS   /* In SunOS terminology */
 #define MAP_NORESERVE   0x40            /* don't reserve swap pages */
 #define MAP_INHERIT     0x80            /* SunOS doesn't do this, but... */
@@ -27,10 +16,6 @@
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 
-#define MS_ASYNC	1		/* sync memory asynchronously */
-#define MS_INVALIDATE	2		/* invalidate the caches */
-#define MS_SYNC		4		/* synchronous memory sync */
-
 #define MCL_CURRENT     0x2000          /* lock all currently mapped pages */
 #define MCL_FUTURE      0x4000          /* lock all additions to address space */
 
@@ -48,18 +33,6 @@
 #define MC_LOCKAS       5  /* Lock an entire address space of the calling process */
 #define MC_UNLOCKAS     6  /* Unlock entire address space of calling process */
 
-#define MADV_NORMAL	0x0		/* default page-in behavior */
-#define MADV_RANDOM	0x1		/* page-in minimum required */
-#define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
-#define MADV_WILLNEED	0x3		/* pre-fault pages */
-#define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_FREE	0x5		/* (Solaris) contents can be freed */
-#define MADV_REMOVE	0x6		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
-
-/* compatibility flags */
-#define MAP_ANON	MAP_ANONYMOUS
-#define MAP_FILE	0
 
 #endif /* __SPARC_MMAN_H__ */
Index: linux-2.6.16-rc3/include/asm-m32r/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-m32r/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-m32r/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -1,21 +1,9 @@
 #ifndef __M32R_MMAN_H__
 #define __M32R_MMAN_H__
 
-/* orig : i386 2.6.0-test6 */
-
-#define PROT_READ	0x1		/* page can be read */
-#define PROT_WRITE	0x2		/* page can be written */
-#define PROT_EXEC	0x4		/* page can be executed */
-#define PROT_SEM	0x8		/* page may be used for atomic ops */
-#define PROT_NONE	0x0		/* page can not be accessed */
-#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
-#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#include <asm-generic/mman.h>
 
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_TYPE	0x0f		/* Mask for type of mapping */
-#define MAP_FIXED	0x10		/* Interpret addr exactly */
-#define MAP_ANONYMOUS	0x20		/* don't use a file */
+/* orig : i386 2.6.0-test6 */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
@@ -25,24 +13,7 @@
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
 
-#define MS_ASYNC	1		/* sync memory asynchronously */
-#define MS_INVALIDATE	2		/* invalidate the caches */
-#define MS_SYNC		4		/* synchronous memory sync */
-
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
 
-#define MADV_NORMAL	0x0		/* default page-in behavior */
-#define MADV_RANDOM	0x1		/* page-in minimum required */
-#define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
-#define MADV_WILLNEED	0x3		/* pre-fault pages */
-#define MADV_DONTNEED	0x4		/* discard these pages */
-#define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
-
-/* compatibility flags */
-#define MAP_ANON	MAP_ANONYMOUS
-#define MAP_FILE	0
-
 #endif /* __M32R_MMAN_H__ */
Index: linux-2.6.16-rc3/include/asm-frv/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-frv/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-frv/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -1,19 +1,7 @@
 #ifndef __ASM_MMAN_H__
 #define __ASM_MMAN_H__
 
-#define PROT_READ	0x1		/* page can be read */
-#define PROT_WRITE	0x2		/* page can be written */
-#define PROT_EXEC	0x4		/* page can be executed */
-#define PROT_SEM	0x8		/* page may be used for atomic ops */
-#define PROT_NONE	0x0		/* page can not be accessed */
-#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
-#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
-
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_TYPE	0x0f		/* Mask for type of mapping */
-#define MAP_FIXED	0x10		/* Interpret addr exactly */
-#define MAP_ANONYMOUS	0x20		/* don't use a file */
+#include <asm-generic/mman.h>
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
@@ -23,25 +11,8 @@
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
 
-#define MS_ASYNC	1		/* sync memory asynchronously */
-#define MS_INVALIDATE	2		/* invalidate the caches */
-#define MS_SYNC		4		/* synchronous memory sync */
-
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
 
-#define MADV_NORMAL	0x0		/* default page-in behavior */
-#define MADV_RANDOM	0x1		/* page-in minimum required */
-#define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
-#define MADV_WILLNEED	0x3		/* pre-fault pages */
-#define MADV_DONTNEED	0x4		/* discard these pages */
-#define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
-
-/* compatibility flags */
-#define MAP_ANON	MAP_ANONYMOUS
-#define MAP_FILE	0
-
 #endif /* __ASM_MMAN_H__ */
 
Index: linux-2.6.16-rc3/include/asm-h8300/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-h8300/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-h8300/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -1,19 +1,7 @@
 #ifndef __H8300_MMAN_H__
 #define __H8300_MMAN_H__
 
-#define PROT_READ	0x1		/* page can be read */
-#define PROT_WRITE	0x2		/* page can be written */
-#define PROT_EXEC	0x4		/* page can be executed */
-#define PROT_SEM	0x8		/* page may be used for atomic ops */
-#define PROT_NONE	0x0		/* page can not be accessed */
-#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
-#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
-
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_TYPE	0x0f		/* Mask for type of mapping */
-#define MAP_FIXED	0x10		/* Interpret addr exactly */
-#define MAP_ANONYMOUS	0x20		/* don't use a file */
+#include <asm-generic/mman.h>
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
@@ -23,24 +11,7 @@
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
 
-#define MS_ASYNC	1		/* sync memory asynchronously */
-#define MS_INVALIDATE	2		/* invalidate the caches */
-#define MS_SYNC		4		/* synchronous memory sync */
-
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
 
-#define MADV_NORMAL	0x0		/* default page-in behavior */
-#define MADV_RANDOM	0x1		/* page-in minimum required */
-#define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
-#define MADV_WILLNEED	0x3		/* pre-fault pages */
-#define MADV_DONTNEED	0x4		/* discard these pages */
-#define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
-
-/* compatibility flags */
-#define MAP_ANON	MAP_ANONYMOUS
-#define MAP_FILE	0
-
 #endif /* __H8300_MMAN_H__ */
Index: linux-2.6.16-rc3/include/asm-arm/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-arm/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-arm/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -1,19 +1,7 @@
 #ifndef __ARM_MMAN_H__
 #define __ARM_MMAN_H__
 
-#define PROT_READ	0x1		/* page can be read */
-#define PROT_WRITE	0x2		/* page can be written */
-#define PROT_EXEC	0x4		/* page can be executed */
-#define PROT_SEM	0x8		/* page may be used for atomic ops */
-#define PROT_NONE	0x0		/* page can not be accessed */
-#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
-#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
-
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_TYPE	0x0f		/* Mask for type of mapping */
-#define MAP_FIXED	0x10		/* Interpret addr exactly */
-#define MAP_ANONYMOUS	0x20		/* don't use a file */
+#include <asm-generic/mman.h>
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
@@ -23,24 +11,7 @@
 #define MAP_POPULATE	0x8000		/* populate (prefault) page tables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
 
-#define MS_ASYNC	1		/* sync memory asynchronously */
-#define MS_INVALIDATE	2		/* invalidate the caches */
-#define MS_SYNC		4		/* synchronous memory sync */
-
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
 
-#define MADV_NORMAL	0x0		/* default page-in behavior */
-#define MADV_RANDOM	0x1		/* page-in minimum required */
-#define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
-#define MADV_WILLNEED	0x3		/* pre-fault pages */
-#define MADV_DONTNEED	0x4		/* discard these pages */
-#define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
-
-/* compatibility flags */
-#define MAP_ANON	MAP_ANONYMOUS
-#define MAP_FILE	0
-
 #endif /* __ARM_MMAN_H__ */
Index: linux-2.6.16-rc3/include/asm-x86_64/mman.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-x86_64/mman.h	2006-02-15 18:59:13.000000000 +0200
+++ linux-2.6.16-rc3/include/asm-x86_64/mman.h	2006-02-15 19:01:32.000000000 +0200
@@ -1,19 +1,8 @@
 #ifndef __X8664_MMAN_H__
 #define __X8664_MMAN_H__
 
-#define PROT_READ	0x1		/* page can be read */
-#define PROT_WRITE	0x2		/* page can be written */
-#define PROT_EXEC	0x4		/* page can be executed */
-#define PROT_NONE	0x0		/* page can not be accessed */
-#define PROT_SEM	0x8
-#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
-#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#include <asm-generic/mman.h>
 
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_TYPE	0x0f		/* Mask for type of mapping */
-#define MAP_FIXED	0x10		/* Interpret addr exactly */
-#define MAP_ANONYMOUS	0x20		/* don't use a file */
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
@@ -24,24 +13,7 @@
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
 
-#define MS_ASYNC	1		/* sync memory asynchronously */
-#define MS_INVALIDATE	2		/* invalidate the caches */
-#define MS_SYNC		4		/* synchronous memory sync */
-
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
 
-#define MADV_NORMAL	0x0		/* default page-in behavior */
-#define MADV_RANDOM	0x1		/* page-in minimum required */
-#define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
-#define MADV_WILLNEED	0x3		/* pre-fault pages */
-#define MADV_DONTNEED	0x4		/* discard these pages */
-#define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
-
-/* compatibility flags */
-#define MAP_ANON	MAP_ANONYMOUS
-#define MAP_FILE	0
-
 #endif



-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
