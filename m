Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424304AbWLBR4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424304AbWLBR4D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 12:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424301AbWLBRzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 12:55:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57093 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424305AbWLBRzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 12:55:35 -0500
Date: Sat, 2 Dec 2006 18:55:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] cleanup asm/setup.h userspace visibility
Message-ID: <20061202175539.GV11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the contents of the userspace asm/setup.h header 
consistent on all architectures:
- export setup.h to userspace on all architectures
- export only COMMAND_LINE_SIZE to userspace
- frv: move COMMAND_LINE_SIZE from param.h
- i386: remove duplicate COMMAND_LINE_SIZE from param.h

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/asm-arm/setup.h        |    4 ++++
 include/asm-arm26/setup.h      |    4 ++++
 include/asm-avr32/setup.h      |    4 ++++
 include/asm-frv/param.h        |    1 -
 include/asm-frv/setup.h        |    6 ++++++
 include/asm-generic/Kbuild.asm |    1 +
 include/asm-i386/Kbuild        |    1 -
 include/asm-i386/param.h       |    1 -
 include/asm-i386/setup.h       |    6 ++++--
 include/asm-ia64/Kbuild        |    1 -
 include/asm-m32r/setup.h       |    9 +++++++--
 include/asm-m68k/setup.h       |   12 ++++--------
 include/asm-m68knommu/setup.h  |    5 +++++
 include/asm-mips/setup.h       |    2 --
 include/asm-powerpc/setup.h    |    3 ---
 include/asm-s390/setup.h       |    3 ++-
 include/asm-sh/setup.h         |    6 ++++--
 include/asm-sh64/setup.h       |    6 ++++++
 include/asm-x86_64/Kbuild      |    1 -
 19 files changed, 51 insertions(+), 25 deletions(-)

--- linux-2.6.19-rc6-mm2/include/asm-generic/Kbuild.asm.old	2006-12-02 13:22:46.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-generic/Kbuild.asm	2006-12-02 13:31:35.000000000 +0100
@@ -14,6 +14,7 @@
 unifdef-y += ptrace.h
 unifdef-y += resource.h
 unifdef-y += sembuf.h
+unifdef-y += setup.h
 unifdef-y += shmbuf.h
 unifdef-y += sigcontext.h
 unifdef-y += siginfo.h
--- linux-2.6.19-rc6-mm2/include/asm-i386/Kbuild.old	2006-12-02 13:23:11.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-i386/Kbuild	2006-12-02 13:31:35.000000000 +0100
@@ -7,5 +7,4 @@
 header-y += ucontext.h
 
 unifdef-y += mtrr.h
-unifdef-y += setup.h
 unifdef-y += vm86.h
--- linux-2.6.19-rc6-mm2/include/asm-ia64/Kbuild.old	2006-12-02 13:23:23.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-ia64/Kbuild	2006-12-02 13:31:35.000000000 +0100
@@ -10,7 +10,6 @@
 header-y += perfmon_default_smpl.h
 header-y += ptrace_offsets.h
 header-y += rse.h
-header-y += setup.h
 header-y += ucontext.h
 
 unifdef-y += perfmon.h
--- linux-2.6.19-rc6-mm2/include/asm-x86_64/Kbuild.old	2006-12-02 13:23:35.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-x86_64/Kbuild	2006-12-02 13:31:35.000000000 +0100
@@ -11,7 +11,6 @@
 header-y += msr.h
 header-y += prctl.h
 header-y += ptrace-abi.h
-header-y += setup.h
 header-y += sigcontext32.h
 header-y += ucontext.h
 header-y += vsyscall32.h
--- linux-2.6.19-rc6-mm2/include/asm-arm/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-arm/setup.h	2006-12-02 13:31:35.000000000 +0100
@@ -16,6 +16,8 @@
 
 #define COMMAND_LINE_SIZE 1024
 
+#ifdef __KERNEL__
+
 /* The list ends with an ATAG_NONE node. */
 #define ATAG_NONE	0x00000000
 
@@ -217,4 +219,6 @@
 static struct early_params __early_##fn __attribute_used__	\
 __attribute__((__section__(".early_param.init"))) = { name, fn }
 
+#endif  /*  __KERNEL__  */
+
 #endif
--- linux-2.6.19-rc6-mm2/include/asm-arm26/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-arm26/setup.h	2006-12-02 13:31:35.000000000 +0100
@@ -16,6 +16,8 @@
 
 #define COMMAND_LINE_SIZE 1024
 
+#ifdef __KERNEL__
+
 /* The list ends with an ATAG_NONE node. */
 #define ATAG_NONE	0x00000000
 
@@ -202,4 +204,6 @@
 
 extern struct meminfo meminfo;
 
+#endif  /*  __KERNEL__  */
+
 #endif
--- linux-2.6.19-rc6-mm2/include/asm-frv/param.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-frv/param.h	2006-12-02 13:31:35.000000000 +0100
@@ -18,6 +18,5 @@
 #endif
 
 #define MAXHOSTNAMELEN		64	/* max length of hostname */
-#define COMMAND_LINE_SIZE	512
 
 #endif /* _ASM_PARAM_H */
--- linux-2.6.19-rc6-mm2/include/asm-frv/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-frv/setup.h	2006-12-02 13:31:35.000000000 +0100
@@ -12,6 +12,10 @@
 #ifndef _ASM_SETUP_H
 #define _ASM_SETUP_H
 
+#define COMMAND_LINE_SIZE       512
+
+#ifdef __KERNEL__
+
 #include <linux/init.h>
 
 #ifndef __ASSEMBLY__
@@ -22,4 +26,6 @@
 
 #endif /* !__ASSEMBLY__ */
 
+#endif  /*  __KERNEL__  */
+
 #endif /* _ASM_SETUP_H */
--- linux-2.6.19-rc6-mm2/include/asm-i386/param.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-i386/param.h	2006-12-02 13:31:35.000000000 +0100
@@ -18,6 +18,5 @@
 #endif
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
-#define COMMAND_LINE_SIZE 256
 
 #endif
--- linux-2.6.19-rc6-mm2/include/asm-i386/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-i386/setup.h	2006-12-02 13:43:43.000000000 +0100
@@ -6,6 +6,8 @@
 #ifndef _i386_SETUP_H
 #define _i386_SETUP_H
 
+#define COMMAND_LINE_SIZE 256
+
 #ifdef __KERNEL__
 #include <linux/pfn.h>
 
@@ -14,10 +16,8 @@
  */
 #define MAXMEM_PFN	PFN_DOWN(MAXMEM)
 #define MAX_NONPAE_PFN	(1 << 20)
-#endif
 
 #define PARAM_SIZE 4096
-#define COMMAND_LINE_SIZE 256
 
 #define OLD_CL_MAGIC_ADDR	0x90020
 #define OLD_CL_MAGIC		0xA33F
@@ -79,4 +79,6 @@
 
 #endif /* __ASSEMBLY__ */
 
+#endif  /*  __KERNEL__  */
+
 #endif /* _i386_SETUP_H */
--- linux-2.6.19-rc6-mm2/include/asm-m32r/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-m32r/setup.h	2006-12-02 13:38:45.000000000 +0100
@@ -1,6 +1,11 @@
 /*
  * This is set up by the setup-routine at boot-time
  */
+
+#define COMMAND_LINE_SIZE       512
+
+#ifdef __KERNEL__
+
 #define PARAM			((unsigned char *)empty_zero_page)
 
 #define MOUNT_ROOT_RDONLY	(*(unsigned long *) (PARAM+0x000))
@@ -18,8 +23,6 @@
 
 #define SCREEN_INFO		(*(struct screen_info *) (PARAM+0x200))
 
-#define COMMAND_LINE_SIZE	(512)
-
 #define RAMDISK_IMAGE_START_MASK	(0x07FF)
 #define RAMDISK_PROMPT_FLAG		(0x8000)
 #define RAMDISK_LOAD_FLAG		(0x4000)
@@ -27,3 +30,5 @@
 extern unsigned long memory_start;
 extern unsigned long memory_end;
 
+#endif  /*  __KERNEL__  */
+
--- linux-2.6.19-rc6-mm2/include/asm-m68k/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-m68k/setup.h	2006-12-02 13:31:35.000000000 +0100
@@ -23,7 +23,11 @@
 #ifndef _M68K_SETUP_H
 #define _M68K_SETUP_H
 
+#define COMMAND_LINE_SIZE 256
 
+#ifdef __KERNEL__
+
+#define CL_SIZE COMMAND_LINE_SIZE
 
     /*
      *  Linux/m68k Architectures
@@ -41,8 +45,6 @@
 #define MACH_Q40     10
 #define MACH_SUN3X   11
 
-#ifdef __KERNEL__
-
 #ifndef __ASSEMBLY__
 extern unsigned long m68k_machtype;
 #endif /* !__ASSEMBLY__ */
@@ -189,8 +191,6 @@
 #  define MACH_TYPE (m68k_machtype)
 #endif
 
-#endif /* __KERNEL__ */
-
 
     /*
      *  CPU, FPU and MMU types
@@ -239,8 +239,6 @@
 #define MMU_SUN3       (1<<MMUB_SUN3)
 #define MMU_APOLLO     (1<<MMUB_APOLLO)
 
-#ifdef __KERNEL__
-
 #ifndef __ASSEMBLY__
 extern unsigned long m68k_cputype;
 extern unsigned long m68k_fputype;
@@ -355,8 +353,6 @@
      */
 
 #define NUM_MEMINFO	4
-#define CL_SIZE		256
-#define COMMAND_LINE_SIZE	CL_SIZE
 
 #ifndef __ASSEMBLY__
 struct mem_info {
--- linux-2.6.19-rc6-mm2/include/asm-m68knommu/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-m68knommu/setup.h	2006-12-02 13:31:35.000000000 +0100
@@ -1,5 +1,10 @@
+#ifdef __KERNEL__
+
 #include <asm-m68k/setup.h>
 
 /* We have a bigger command line buffer. */
 #undef COMMAND_LINE_SIZE
+
+#endif  /*  __KERNEL__  */
+
 #define COMMAND_LINE_SIZE	512
--- linux-2.6.19-rc6-mm2/include/asm-mips/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-mips/setup.h	2006-12-02 13:31:35.000000000 +0100
@@ -1,8 +1,6 @@
-#ifdef __KERNEL__
 #ifndef _MIPS_SETUP_H
 #define _MIPS_SETUP_H
 
 #define COMMAND_LINE_SIZE	256
 
 #endif /* __SETUP_H */
-#endif /* __KERNEL__ */
--- linux-2.6.19-rc6-mm2/include/asm-powerpc/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-powerpc/setup.h	2006-12-02 13:31:35.000000000 +0100
@@ -1,9 +1,6 @@
 #ifndef _ASM_POWERPC_SETUP_H
 #define _ASM_POWERPC_SETUP_H
 
-#ifdef __KERNEL__
-
 #define COMMAND_LINE_SIZE	512
 
-#endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_SETUP_H */
--- linux-2.6.19-rc6-mm2/include/asm-s390/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-s390/setup.h	2006-12-02 13:35:07.000000000 +0100
@@ -8,12 +8,13 @@
 #ifndef _ASM_S390_SETUP_H
 #define _ASM_S390_SETUP_H
 
+#define COMMAND_LINE_SIZE 	896
+
 #ifdef __KERNEL__
 
 #include <asm/types.h>
 
 #define PARMAREA		0x10400
-#define COMMAND_LINE_SIZE 	896
 #define MEMORY_CHUNKS		16	/* max 0x7fff */
 #define IPL_PARMBLOCK_ORIGIN	0x2000
 
--- linux-2.6.19-rc6-mm2/include/asm-sh/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-sh/setup.h	2006-12-02 13:35:50.000000000 +0100
@@ -1,10 +1,12 @@
-#ifdef __KERNEL__
 #ifndef _SH_SETUP_H
 #define _SH_SETUP_H
 
 #define COMMAND_LINE_SIZE 256
 
+#ifdef __KERNEL__
+
 int setup_early_printk(char *);
 
-#endif /* _SH_SETUP_H */
 #endif /* __KERNEL__ */
+
+#endif /* _SH_SETUP_H */
--- linux-2.6.19-rc6-mm2/include/asm-sh64/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-sh64/setup.h	2006-12-02 13:31:35.000000000 +0100
@@ -1,6 +1,10 @@
 #ifndef __ASM_SH64_SETUP_H
 #define __ASM_SH64_SETUP_H
 
+#define COMMAND_LINE_SIZE 256
+
+#ifdef __KERNEL__
+
 #define PARAM ((unsigned char *)empty_zero_page)
 #define MOUNT_ROOT_RDONLY (*(unsigned long *) (PARAM+0x000))
 #define RAMDISK_FLAGS (*(unsigned long *) (PARAM+0x004))
@@ -12,5 +16,7 @@
 #define COMMAND_LINE ((char *) (PARAM+256))
 #define COMMAND_LINE_SIZE 256
 
+#endif  /*  __KERNEL__  */
+
 #endif /* __ASM_SH64_SETUP_H */
 
--- linux-2.6.19-rc6-mm2/include/asm-avr32/setup.h.old	2006-12-02 13:33:07.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-avr32/setup.h	2006-12-02 13:33:33.000000000 +0100
@@ -13,6 +13,8 @@
 
 #define COMMAND_LINE_SIZE 256
 
+#ifdef __KERNEL__
+
 /* Magic number indicating that a tag table is present */
 #define ATAG_MAGIC	0xa2a25441
 
@@ -138,4 +140,6 @@
 
 #endif /* !__ASSEMBLY__ */
 
+#endif  /*  __KERNEL__  */
+
 #endif /* __ASM_AVR32_SETUP_H__ */

