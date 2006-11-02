Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752806AbWKBKVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbWKBKVU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbWKBKVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:21:20 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:30136 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1752806AbWKBKVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:21:19 -0500
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Andi Kleen <ak@muc.de>,
       magnus.damm@gmail.com, fastboot@lists.osdl.org,
       Horms <horms@verge.net.au>, Magnus Damm <magnus@valinux.co.jp>,
       Dave Anderson <anderson@redhat.com>, ebiederm@xmission.com
Date: Thu, 02 Nov 2006 19:19:42 +0900
Message-Id: <20061102101942.452.73192.sendpatchset@localhost>
Subject: [PATCH 01/02] Elf: Always define elf_addr_t in linux/elf.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

elf: Always define elf_addr_t in linux/elf.h

This patch defines elf_addr_t in linux/elf.h. The size of the type is 
determined using ELF_CLASS. This allows us to remove the defines that
today are spread all over .c and .h files.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 Applies to 2.6.19-rc4.

 arch/ia64/ia32/ia32priv.h          |    2 --
 arch/mips/kernel/binfmt_elfn32.c   |    1 -
 arch/mips/kernel/binfmt_elfo32.c   |    1 -
 arch/mips/kernel/irixelf.c         |    4 ----
 arch/parisc/kernel/binfmt_elf32.c  |    1 -
 arch/s390/kernel/binfmt_elf32.c    |    1 -
 arch/sparc64/kernel/binfmt_elf32.c |    1 -
 arch/x86_64/ia32/ia32_binfmt.c     |    2 --
 fs/binfmt_elf.c                    |    4 ----
 fs/binfmt_elf_fdpic.c              |    3 ---
 include/asm-powerpc/elf.h          |    2 --
 include/linux/elf.h                |    5 +++++
 12 files changed, 5 insertions(+), 22 deletions(-)

--- 0001/arch/ia64/ia32/ia32priv.h
+++ work/arch/ia64/ia32/ia32priv.h	2006-11-02 15:34:25.000000000 +0900
@@ -330,8 +330,6 @@ struct old_linux32_dirent {
 void ia64_elf32_init(struct pt_regs *regs);
 #define ELF_PLAT_INIT(_r, load_addr)	ia64_elf32_init(_r)
 
-#define elf_addr_t	u32
-
 /* This macro yields a bitmask that programs can use to figure out
    what instruction set this CPU supports.  */
 #define ELF_HWCAP	0
--- 0001/arch/mips/kernel/binfmt_elfn32.c
+++ work/arch/mips/kernel/binfmt_elfn32.c	2006-11-02 15:37:56.000000000 +0900
@@ -90,7 +90,6 @@ struct elf_prpsinfo32
 	char	pr_psargs[ELF_PRARGSZ];	/* initial part of arg list */
 };
 
-#define elf_addr_t	u32
 #define elf_caddr_t	u32
 #define init_elf_binfmt init_elfn32_binfmt
 
--- 0001/arch/mips/kernel/binfmt_elfo32.c
+++ work/arch/mips/kernel/binfmt_elfo32.c	2006-11-02 15:39:15.000000000 +0900
@@ -92,7 +92,6 @@ struct elf_prpsinfo32
 	char	pr_psargs[ELF_PRARGSZ];	/* initial part of arg list */
 };
 
-#define elf_addr_t	u32
 #define elf_caddr_t	u32
 #define init_elf_binfmt init_elf32_binfmt
 
--- 0001/arch/mips/kernel/irixelf.c
+++ work/arch/mips/kernel/irixelf.c	2006-11-02 15:38:26.000000000 +0900
@@ -52,10 +52,6 @@ static struct linux_binfmt irix_format =
 	irix_core_dump, PAGE_SIZE
 };
 
-#ifndef elf_addr_t
-#define elf_addr_t unsigned long
-#endif
-
 #ifdef DEBUG
 /* Debugging routines. */
 static char *get_elf_p_type(Elf32_Word p_type)
--- 0002/arch/parisc/kernel/binfmt_elf32.c
+++ work/arch/parisc/kernel/binfmt_elf32.c	2006-11-02 15:40:21.000000000 +0900
@@ -75,7 +75,6 @@ struct elf_prpsinfo32
 	char	pr_psargs[ELF_PRARGSZ];	/* initial part of arg list */
 };
 
-#define elf_addr_t	unsigned int
 #define init_elf_binfmt init_elf32_binfmt
 
 #define ELF_PLATFORM  ("PARISC32\0")
--- 0001/arch/s390/kernel/binfmt_elf32.c
+++ work/arch/s390/kernel/binfmt_elf32.c	2006-11-02 15:39:52.000000000 +0900
@@ -176,7 +176,6 @@ struct elf_prpsinfo32
 
 #include <linux/highuid.h>
 
-#define elf_addr_t	u32
 /*
 #define init_elf_binfmt init_elf32_binfmt
 */
--- 0001/arch/sparc64/kernel/binfmt_elf32.c
+++ work/arch/sparc64/kernel/binfmt_elf32.c	2006-11-02 15:41:10.000000000 +0900
@@ -141,7 +141,6 @@ cputime_to_compat_timeval(const cputime_
 	value->tv_sec = jiffies / HZ;
 }
 
-#define elf_addr_t	u32
 #undef start_thread
 #define start_thread start_thread32
 #define init_elf_binfmt init_elf32_binfmt
--- 0002/arch/x86_64/ia32/ia32_binfmt.c
+++ work/arch/x86_64/ia32/ia32_binfmt.c	2006-11-02 15:37:08.000000000 +0900
@@ -305,8 +305,6 @@ MODULE_AUTHOR("Eric Youngdale, Andi Klee
 #undef MODULE_DESCRIPTION
 #undef MODULE_AUTHOR
 
-#define elf_addr_t __u32
-
 static void elf32_init(struct pt_regs *);
 
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
--- 0002/fs/binfmt_elf.c
+++ work/fs/binfmt_elf.c	2006-11-02 15:42:14.000000000 +0900
@@ -47,10 +47,6 @@ static int load_elf_binary(struct linux_
 static int load_elf_library(struct file *);
 static unsigned long elf_map (struct file *, unsigned long, struct elf_phdr *, int, int);
 
-#ifndef elf_addr_t
-#define elf_addr_t unsigned long
-#endif
-
 /*
  * If we don't support core dumping, then supply a NULL so we
  * don't even try.
--- 0002/fs/binfmt_elf_fdpic.c
+++ work/fs/binfmt_elf_fdpic.c	2006-11-02 15:42:04.000000000 +0900
@@ -40,9 +40,6 @@
 #include <asm/pgalloc.h>
 
 typedef char *elf_caddr_t;
-#ifndef elf_addr_t
-#define elf_addr_t unsigned long
-#endif
 
 #if 0
 #define kdebug(fmt, ...) printk("FDPIC "fmt"\n" ,##__VA_ARGS__ )
--- 0001/include/asm-powerpc/elf.h
+++ work/include/asm-powerpc/elf.h	2006-11-02 15:33:33.000000000 +0900
@@ -124,12 +124,10 @@ typedef elf_greg_t32 elf_gregset_t32[ELF
 # define ELF_DATA	ELFDATA2MSB
   typedef elf_greg_t64 elf_greg_t;
   typedef elf_gregset_t64 elf_gregset_t;
-# define elf_addr_t unsigned long
 #else
   /* Assumption: ELF_ARCH == EM_PPC and ELF_CLASS == ELFCLASS32 */
   typedef elf_greg_t32 elf_greg_t;
   typedef elf_gregset_t32 elf_gregset_t;
-# define elf_addr_t __u32
 #endif /* ELF_ARCH */
 
 /* Floating point registers */
--- 0001/include/linux/elf.h
+++ work/include/linux/elf.h	2006-11-02 15:44:10.000000000 +0900
@@ -352,12 +352,16 @@ typedef struct elf64_note {
   Elf64_Word n_type;	/* Content type */
 } Elf64_Nhdr;
 
+typedef Elf64_Off elf64_addr;
+typedef Elf32_Off elf32_addr;
+
 #if ELF_CLASS == ELFCLASS32
 
 extern Elf32_Dyn _DYNAMIC [];
 #define elfhdr		elf32_hdr
 #define elf_phdr	elf32_phdr
 #define elf_note	elf32_note
+#define elf_addr_t	elf32_addr
 
 #else
 
@@ -365,6 +369,7 @@ extern Elf64_Dyn _DYNAMIC [];
 #define elfhdr		elf64_hdr
 #define elf_phdr	elf64_phdr
 #define elf_note	elf64_note
+#define elf_addr_t	elf64_addr
 
 #endif
 
