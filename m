Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422944AbWHZRmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422944AbWHZRmq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 13:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422949AbWHZRmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 13:42:40 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:41874 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964808AbWHZRmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 13:42:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=n4U6kdbINCdZvvQMVNkyRVHPTFLmtqj32NuMUyfsyP8vEBGdWyr6nJvIyPhllupJ+YcfpGmlWe4PpVV/tqfqj1eH2+DcruTA5FM7L8OaiXn0qL+rrzanU9tuKwshjRMI+cgbEkIHVB63r5guICFuhAXCnQQi/vp0LFyOrxJH8UY=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH RFP-V4 03/13] RFP prot support: add needed macros
Date: Sat, 26 Aug 2006 19:42:16 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-Id: <20060826174216.14790.82731.stgit@memento.home.lan>
In-Reply-To: <200608261933.36574.blaisorblade@yahoo.it>
References: <200608261933.36574.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add pte_to_pgprot() and pgoff_prot_to_pte() macros, in generic versions; so we
can safely use it and keep the kernel compiling. For some architectures real
definitions of the macros are actually provided.

Also, add the MAP_CHGPROT flag to all arch headers (was MAP_NOINHERIT, changed on
Hugh Dickins' suggestion).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-alpha/mman.h      |    3 +++
 include/asm-arm/mman.h        |    3 +++
 include/asm-arm26/mman.h      |    3 +++
 include/asm-cris/mman.h       |    3 +++
 include/asm-frv/mman.h        |    3 +++
 include/asm-generic/pgtable.h |   13 +++++++++++++
 include/asm-h8300/mman.h      |    3 +++
 include/asm-i386/mman.h       |    3 +++
 include/asm-ia64/mman.h       |    3 +++
 include/asm-m32r/mman.h       |    3 +++
 include/asm-m68k/mman.h       |    3 +++
 include/asm-mips/mman.h       |    3 +++
 include/asm-parisc/mman.h     |    3 +++
 include/asm-powerpc/mman.h    |    3 +++
 include/asm-s390/mman.h       |    3 +++
 include/asm-sh/mman.h         |    3 +++
 include/asm-sparc/mman.h      |    3 +++
 include/asm-sparc64/mman.h    |    3 +++
 include/asm-x86_64/mman.h     |    3 +++
 include/asm-xtensa/mman.h     |    3 +++
 20 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/include/asm-alpha/mman.h b/include/asm-alpha/mman.h
index 5f24c75..30f4694 100644
--- a/include/asm-alpha/mman.h
+++ b/include/asm-alpha/mman.h
@@ -28,6 +28,9 @@ #define MAP_LOCKED	0x08000		/* lock the 
 #define MAP_NORESERVE	0x10000		/* don't check for reservations */
 #define MAP_POPULATE	0x20000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x40000		/* do not block on IO */
+#define MAP_CHGPROT	0x80000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_SYNC		2		/* synchronous memory sync */
diff --git a/include/asm-arm/mman.h b/include/asm-arm/mman.h
index 54570d2..a5b3c37 100644
--- a/include/asm-arm/mman.h
+++ b/include/asm-arm/mman.h
@@ -10,6 +10,9 @@ #define MAP_LOCKED	0x2000		/* pages are 
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) page tables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
diff --git a/include/asm-arm26/mman.h b/include/asm-arm26/mman.h
index 4000a6c..de73e1b 100644
--- a/include/asm-arm26/mman.h
+++ b/include/asm-arm26/mman.h
@@ -10,6 +10,9 @@ #define MAP_LOCKED	0x2000		/* pages are 
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE    0x8000          /* populate (prefault) page tables */
 #define MAP_NONBLOCK    0x10000         /* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
diff --git a/include/asm-cris/mman.h b/include/asm-cris/mman.h
index 1c35e1b..a75ee61 100644
--- a/include/asm-cris/mman.h
+++ b/include/asm-cris/mman.h
@@ -12,6 +12,9 @@ #define MAP_LOCKED	0x2000		/* pages are 
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
diff --git a/include/asm-frv/mman.h b/include/asm-frv/mman.h
index b4371e9..320816d 100644
--- a/include/asm-frv/mman.h
+++ b/include/asm-frv/mman.h
@@ -10,6 +10,9 @@ #define MAP_LOCKED	0x2000		/* pages are 
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index c2059a3..2796f63 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -232,4 +232,17 @@ static inline int pmd_none_or_clear_bad(
 }
 #endif /* !__ASSEMBLY__ */
 
+#ifndef __HAVE_ARCH_PTE_TO_PGPROT
+/* Wrappers for architectures which don't support yet page protections for
+ * remap_file_pages. */
+
+/* Dummy define - if the architecture has no special support, access is denied
+ * in VM_MANYPROTS vma's. */
+#define pte_to_pgprot(pte) __P000
+#define pte_file_to_pgprot(pte) __P000
+
+#define pgoff_prot_to_pte(off, prot) pgoff_to_pte(off)
+
+#endif
+
 #endif /* _ASM_GENERIC_PGTABLE_H */
diff --git a/include/asm-h8300/mman.h b/include/asm-h8300/mman.h
index b9f104f..3ae27ca 100644
--- a/include/asm-h8300/mman.h
+++ b/include/asm-h8300/mman.h
@@ -10,6 +10,9 @@ #define MAP_LOCKED	0x2000		/* pages are 
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
diff --git a/include/asm-i386/mman.h b/include/asm-i386/mman.h
index 8fd9d7a..182452b 100644
--- a/include/asm-i386/mman.h
+++ b/include/asm-i386/mman.h
@@ -10,6 +10,9 @@ #define MAP_LOCKED	0x2000		/* pages are 
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
diff --git a/include/asm-ia64/mman.h b/include/asm-ia64/mman.h
index 6ba179f..e7ca36f 100644
--- a/include/asm-ia64/mman.h
+++ b/include/asm-ia64/mman.h
@@ -18,6 +18,9 @@ #define MAP_LOCKED	0x02000		/* pages are
 #define MAP_NORESERVE	0x04000		/* don't check for reservations */
 #define MAP_POPULATE	0x08000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
diff --git a/include/asm-m32r/mman.h b/include/asm-m32r/mman.h
index 695a860..a65374b 100644
--- a/include/asm-m32r/mman.h
+++ b/include/asm-m32r/mman.h
@@ -12,6 +12,9 @@ #define MAP_LOCKED	0x2000		/* pages are 
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
diff --git a/include/asm-m68k/mman.h b/include/asm-m68k/mman.h
index 1626d37..2ff6ae2 100644
--- a/include/asm-m68k/mman.h
+++ b/include/asm-m68k/mman.h
@@ -10,6 +10,9 @@ #define MAP_LOCKED	0x2000		/* pages are 
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
diff --git a/include/asm-mips/mman.h b/include/asm-mips/mman.h
index 046cf68..f4d670f 100644
--- a/include/asm-mips/mman.h
+++ b/include/asm-mips/mman.h
@@ -46,6 +46,9 @@ #define MAP_EXECUTABLE	0x4000		/* mark i
 #define MAP_LOCKED	0x8000		/* pages are locked */
 #define MAP_POPULATE	0x10000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x20000		/* do not block on IO */
+#define MAP_CHGPROT	0x40000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 /*
  * Flags for msync
diff --git a/include/asm-parisc/mman.h b/include/asm-parisc/mman.h
index 0ef15ee..0e25591 100644
--- a/include/asm-parisc/mman.h
+++ b/include/asm-parisc/mman.h
@@ -22,6 +22,9 @@ #define MAP_NORESERVE	0x4000		/* don't c
 #define MAP_GROWSDOWN	0x8000		/* stack-like segment */
 #define MAP_POPULATE	0x10000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x20000		/* do not block on IO */
+#define MAP_CHGPROT	0x40000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MS_SYNC		1		/* synchronous memory sync */
 #define MS_ASYNC	2		/* sync memory asynchronously */
diff --git a/include/asm-powerpc/mman.h b/include/asm-powerpc/mman.h
index 24cf664..56a76bb 100644
--- a/include/asm-powerpc/mman.h
+++ b/include/asm-powerpc/mman.h
@@ -23,5 +23,8 @@ #define MCL_FUTURE      0x4000          
 
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #endif	/* _ASM_POWERPC_MMAN_H */
diff --git a/include/asm-s390/mman.h b/include/asm-s390/mman.h
index 7839767..a8ff4f4 100644
--- a/include/asm-s390/mman.h
+++ b/include/asm-s390/mman.h
@@ -18,6 +18,9 @@ #define MAP_LOCKED	0x2000		/* pages are 
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
diff --git a/include/asm-sh/mman.h b/include/asm-sh/mman.h
index 156eb02..29eb229 100644
--- a/include/asm-sh/mman.h
+++ b/include/asm-sh/mman.h
@@ -10,6 +10,9 @@ #define MAP_LOCKED	0x2000		/* pages are 
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) page tables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
diff --git a/include/asm-sparc/mman.h b/include/asm-sparc/mman.h
index 88d1886..4aeabaa 100644
--- a/include/asm-sparc/mman.h
+++ b/include/asm-sparc/mman.h
@@ -21,6 +21,9 @@ #define MCL_FUTURE      0x4000          
 
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 /* XXX Need to add flags to SunOS's mctl, mlockall, and madvise system
  * XXX calls.
diff --git a/include/asm-sparc64/mman.h b/include/asm-sparc64/mman.h
index 6fd878e..572adec 100644
--- a/include/asm-sparc64/mman.h
+++ b/include/asm-sparc64/mman.h
@@ -21,6 +21,9 @@ #define MCL_FUTURE      0x4000          
 
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 /* XXX Need to add flags to SunOS's mctl, mlockall, and madvise system
  * XXX calls.
diff --git a/include/asm-x86_64/mman.h b/include/asm-x86_64/mman.h
index dd5cb05..ceffa4f 100644
--- a/include/asm-x86_64/mman.h
+++ b/include/asm-x86_64/mman.h
@@ -12,6 +12,9 @@ #define MAP_LOCKED	0x2000		/* pages are 
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
diff --git a/include/asm-xtensa/mman.h b/include/asm-xtensa/mman.h
index ba394cb..5342c78 100644
--- a/include/asm-xtensa/mman.h
+++ b/include/asm-xtensa/mman.h
@@ -53,6 +53,9 @@ #define MAP_EXECUTABLE	0x4000		/* mark i
 #define MAP_LOCKED	0x8000		/* pages are locked */
 #define MAP_POPULATE	0x10000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x20000		/* do not block on IO */
+#define MAP_CHGPROT	0x40000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 /*
  * Flags for msync
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
