Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbVLOVYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbVLOVYw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVLOVYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:24:52 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40714 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751105AbVLOVYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:24:51 -0500
Date: Thu, 15 Dec 2005 22:24:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] more updates for the gcc >= 3.2 requirement
Message-ID: <20051215212452.GS23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains some documentation updates and removes some code 
paths for gcc < 3.2.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/Changes                 |   31 ++++----------------------
 README                                |    7 +----
 arch/arm/kernel/asm-offsets.c         |    2 -
 arch/i386/Kconfig                     |    4 ---
 arch/i386/Makefile                    |    5 ----
 arch/i386/Makefile.cpu                |   10 ++++----
 arch/ia64/Makefile                    |    4 ---
 drivers/media/video/v4l2-common.c     |    2 -
 fs/ocfs2/cluster/masklog.h            |    7 ++---
 include/asm-alpha/compiler.h          |    2 -
 include/asm-alpha/processor.h         |   21 -----------------
 include/asm-ia64/bug.h                |    6 -----
 include/asm-ia64/spinlock.h           |    2 -
 include/asm-sparc64/system.h          |    4 ---
 include/linux/byteorder/generic.h     |    2 -
 include/linux/byteorder/swab.h        |    2 -
 include/linux/byteorder/swabb.h       |    2 -
 include/linux/compiler-gcc.h          |    9 +++++++
 include/linux/compiler-gcc3.h         |   17 --------------
 include/linux/compiler-gcc4.h         |    7 -----
 include/linux/kernel.h                |    2 -
 sound/isa/wavefront/wavefront_synth.c |    7 -----
 22 files changed, 31 insertions(+), 124 deletions(-)

--- linux-2.6.15-rc5-mm3-full/README.old	2005-12-15 13:45:38.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/README	2005-12-15 13:45:56.000000000 +0100
@@ -181,15 +181,12 @@
 	  should probably answer 'n' to the questions for
           "development", "experimental", or "debugging" features.
 
 COMPILING the kernel:
 
- - Make sure you have gcc 2.95.3 available.
-   gcc 2.91.66 (egcs-1.1.2), and gcc 2.7.2.3 are known to miscompile
-   some parts of the kernel, and are *no longer supported*.
-   Also remember to upgrade your binutils package (for as/ld/nm and company)
-   if necessary. For more information, refer to Documentation/Changes.
+ - Make sure you have at least gcc 3.2 available.
+   For more information, refer to Documentation/Changes.
 
    Please note that you can still run a.out user programs with this kernel.
 
  - Do a "make" to create a compressed kernel image. It is also
    possible to do "make install" if you have lilo installed to suit the
--- linux-2.6.15-rc5-mm3-full/Documentation/Changes.old	2005-12-15 13:46:07.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/Documentation/Changes	2005-12-15 14:02:18.000000000 +0100
@@ -29,12 +29,10 @@
 al español de este documento en varios formatos.
 
 Eine deutsche Version dieser Datei finden Sie unter
 <http://www.stefan-winter.de/Changes-2.4.0.txt>.
 
-Last updated: October 29th, 2002
-
 Chris Ricker (kaboom@gatech.edu or chris.ricker@genetics.utah.edu).
 
 Current Minimal Requirements
 ============================
 
@@ -46,11 +44,11 @@
 functionally running a Linux 2.4 kernel.  Also, not all tools are
 necessary on all systems; obviously, if you don't have any ISDN
 hardware, for example, you probably needn't concern yourself with
 isdn4k-utils.
 
-o  Gnu C                  2.95.3                  # gcc --version
+o  Gnu C                  3.2                     # gcc --version
 o  Gnu make               3.79.1                  # make --version
 o  binutils               2.12                    # ld -v
 o  util-linux             2.10o                   # fdformat --version
 o  module-init-tools      0.9.10                  # depmod -V
 o  e2fsprogs              1.29                    # tune2fs
@@ -73,30 +71,11 @@
 
 GCC
 ---
 
 The gcc version requirements may vary depending on the type of CPU in your
-computer. The next paragraph applies to users of x86 CPUs, but not
-necessarily to users of other CPUs. Users of other CPUs should obtain
-information about their gcc version requirements from another source.
-
-The recommended compiler for the kernel is gcc 2.95.x (x >= 3), and it
-should be used when you need absolute stability. You may use gcc 3.0.x
-instead if you wish, although it may cause problems. Later versions of gcc 
-have not received much testing for Linux kernel compilation, and there are 
-almost certainly bugs (mainly, but not exclusively, in the kernel) that
-will need to be fixed in order to use these compilers. In any case, using
-pgcc instead of plain gcc is just asking for trouble.
-
-The Red Hat gcc 2.96 compiler subtree can also be used to build this tree.
-You should ensure you use gcc-2.96-74 or later. gcc-2.96-54 will not build
-the kernel correctly.
-
-In addition, please pay attention to compiler optimization.  Anything
-greater than -O2 may not be wise.  Similarly, if you choose to use gcc-2.95.x
-or derivatives, be sure not to use -fstrict-aliasing (which, depending on
-your version of gcc 2.95.x, may necessitate using -fno-strict-aliasing).
+computer.
 
 Make
 ----
 
 You will need Gnu make 3.79.1 or later to build the kernel.
@@ -328,13 +307,13 @@
 ========================
 
 Kernel compilation
 ******************
 
-gcc 2.95.3
-----------
-o  <ftp://ftp.gnu.org/gnu/gcc/gcc-2.95.3.tar.gz>
+gcc
+---
+o  <ftp://ftp.gnu.org/gnu/gcc/>
 
 Make
 ----
 o  <ftp://ftp.gnu.org/gnu/make/>
 
--- linux-2.6.15-rc5-mm3-full/include/linux/compiler-gcc.h.old	2005-12-15 13:31:21.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/include/linux/compiler-gcc.h	2005-12-15 14:08:36.000000000 +0100
@@ -13,5 +13,14 @@
    shouldn't recognize the original var, and make assumptions about it */
 #define RELOC_HIDE(ptr, off)					\
   ({ unsigned long __ptr;					\
     __asm__ ("" : "=g"(__ptr) : "0"(ptr));		\
     (typeof(ptr)) (__ptr + (off)); })
+
+
+#define inline		inline		__attribute__((always_inline))
+#define __inline__	__inline__	__attribute__((always_inline))
+#define __inline	__inline	__attribute__((always_inline))
+#define __deprecated			__attribute__((deprecated))
+#define  noinline			__attribute__((noinline))
+#define __attribute_pure__		__attribute__((pure))
+#define __attribute_const__		__attribute__((__const__))
--- linux-2.6.15-rc5-mm3-full/include/linux/compiler-gcc3.h.old	2005-12-15 13:30:50.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/include/linux/compiler-gcc3.h	2005-12-15 13:33:45.000000000 +0100
@@ -1,32 +1,15 @@
 /* Never include this file directly.  Include <linux/compiler.h> instead.  */
 
 /* These definitions are for GCC v3.x.  */
 #include <linux/compiler-gcc.h>
 
-#if __GNUC_MINOR__ >= 1
-# define inline		inline		__attribute__((always_inline))
-# define __inline__	__inline__	__attribute__((always_inline))
-# define __inline	__inline	__attribute__((always_inline))
-#endif
-
-#if __GNUC_MINOR__ > 0
-# define __deprecated		__attribute__((deprecated))
-#endif
-
 #if __GNUC_MINOR__ >= 3
 # define __attribute_used__	__attribute__((__used__))
 #else
 # define __attribute_used__	__attribute__((__unused__))
 #endif
 
-#define __attribute_pure__	__attribute__((pure))
-#define __attribute_const__	__attribute__((__const__))
-
-#if __GNUC_MINOR__ >= 1
-#define  noinline		__attribute__((noinline))
-#endif
-
 #if __GNUC_MINOR__ >= 4
 #define __must_check		__attribute__((warn_unused_result))
 #endif
 
--- linux-2.6.15-rc5-mm3-full/include/linux/compiler-gcc4.h.old	2005-12-15 13:33:57.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/include/linux/compiler-gcc4.h	2005-12-15 13:34:28.000000000 +0100
@@ -1,16 +1,9 @@
 /* Never include this file directly.  Include <linux/compiler.h> instead.  */
 
 /* These definitions are for GCC v4.x.  */
 #include <linux/compiler-gcc.h>
 
-#define inline			inline		__attribute__((always_inline))
-#define __inline__		__inline__	__attribute__((always_inline))
-#define __inline		__inline	__attribute__((always_inline))
-#define __deprecated		__attribute__((deprecated))
 #define __attribute_used__	__attribute__((__used__))
-#define __attribute_pure__	__attribute__((pure))
-#define __attribute_const__	__attribute__((__const__))
-#define  noinline		__attribute__((noinline))
 #define __must_check 		__attribute__((warn_unused_result))
 #define __compiler_offsetof(a,b) __builtin_offsetof(a,b)
 
--- linux-2.6.15-rc5-mm3-full/arch/arm/kernel/asm-offsets.c.old	2005-12-15 13:34:55.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/arch/arm/kernel/asm-offsets.c	2005-12-15 13:35:11.000000000 +0100
@@ -27,11 +27,11 @@
  * GCC 3.2.0: incorrect function argument offset calculation.
  * GCC 3.2.x: miscompiles NEW_AUX_ENT in fs/binfmt_elf.c
  *            (http://gcc.gnu.org/PR8896) and incorrect structure
  *	      initialisation in fs/jffs2/erase.c
  */
-#if __GNUC__ < 3 || (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
+#if (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
 #error Your compiler is too buggy; it is known to miscompile kernels.
 #error    Known good compilers: 3.3
 #endif
 
 /* Use marker if you need to separate the values later */
--- linux-2.6.15-rc5-mm3-full/fs/ocfs2/cluster/masklog.h.old	2005-12-15 13:35:25.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/ocfs2/cluster/masklog.h	2005-12-15 14:03:13.000000000 +0100
@@ -210,15 +210,14 @@
 
 #define mlog_entry_void() do {						\
 	mlog(ML_ENTRY, "ENTRY:\n");					\
 } while (0)
 
-/* We disable this for old compilers since they don't have support for
- * __builtin_types_compatible_p.
+/* 
+ * We disable this for sparse.
  */
-#if (__GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)) && \
-    !defined(__CHECKER__)
+#if !defined(__CHECKER__)
 #define mlog_exit(st) do {						     \
 	if (__builtin_types_compatible_p(typeof(st), unsigned long))	     \
 		mlog(ML_EXIT, "EXIT: %lu\n", (unsigned long) (st));	     \
 	else if (__builtin_types_compatible_p(typeof(st), signed long))      \
 		mlog(ML_EXIT, "EXIT: %ld\n", (signed long) (st));	     \
--- linux-2.6.15-rc5-mm3-full/include/asm-alpha/compiler.h.old	2005-12-15 13:36:45.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/include/asm-alpha/compiler.h	2005-12-15 13:36:57.000000000 +0100
@@ -96,11 +96,9 @@
 
 #include <linux/compiler.h>
 #undef inline
 #undef __inline__
 #undef __inline
-#if __GNUC__ == 3 && __GNUC_MINOR__ >= 1 || __GNUC__ > 3
 #undef __always_inline
 #define __always_inline		inline __attribute__((always_inline))
-#endif
 
 #endif /* __ALPHA_COMPILER_H */
--- linux-2.6.15-rc5-mm3-full/include/asm-alpha/processor.h.old	2005-12-15 13:37:07.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/include/asm-alpha/processor.h	2005-12-15 13:37:22.000000000 +0100
@@ -75,11 +75,10 @@
 #ifndef CONFIG_SMP
 /* Nothing to prefetch. */
 #define spin_lock_prefetch(lock)  	do { } while (0)
 #endif
 
-#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
 extern inline void prefetch(const void *ptr)  
 { 
 	__builtin_prefetch(ptr, 0, 3);
 }
 
@@ -93,26 +92,6 @@
 {
 	__builtin_prefetch(ptr, 1, 3);
 }
 #endif
 
-#else
-extern inline void prefetch(const void *ptr)  
-{ 
-	__asm__ ("ldl $31,%0" : : "m"(*(char *)ptr)); 
-}
-
-extern inline void prefetchw(const void *ptr)  
-{
-	__asm__ ("ldq $31,%0" : : "m"(*(char *)ptr)); 
-}
-
-#ifdef CONFIG_SMP
-extern inline void spin_lock_prefetch(const void *ptr)  
-{
-	__asm__ ("ldq $31,%0" : : "m"(*(char *)ptr)); 
-}
-#endif
-
-#endif /* GCC 3.1 */
-
 #endif /* __ASM_ALPHA_PROCESSOR_H */
--- linux-2.6.15-rc5-mm3-full/include/asm-ia64/bug.h.old	2005-12-15 13:37:34.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/include/asm-ia64/bug.h	2005-12-15 13:37:48.000000000 +0100
@@ -1,14 +1,10 @@
 #ifndef _ASM_IA64_BUG_H
 #define _ASM_IA64_BUG_H
 
 #ifdef CONFIG_BUG
-#if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
-# define ia64_abort()	__builtin_trap()
-#else
-# define ia64_abort()	(*(volatile int *) 0 = 0)
-#endif
+#define ia64_abort()	__builtin_trap()
 #define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); ia64_abort(); } while (0)
 
 /* should this BUG be made generic? */
 #define HAVE_ARCH_BUG
 #endif
--- linux-2.6.15-rc5-mm3-full/include/asm-ia64/spinlock.h.old	2005-12-15 13:38:00.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/include/asm-ia64/spinlock.h	2005-12-15 13:38:07.000000000 +0100
@@ -32,11 +32,11 @@
 static inline void
 __raw_spin_lock_flags (raw_spinlock_t *lock, unsigned long flags)
 {
 	register volatile unsigned int *ptr asm ("r31") = &lock->lock;
 
-#if __GNUC__ < 3 || (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
+#if (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
 # ifdef CONFIG_ITANIUM
 	/* don't use brl on Itanium... */
 	asm volatile ("{\n\t"
 		      "  mov ar.ccv = r0\n\t"
 		      "  mov r28 = ip\n\t"
--- linux-2.6.15-rc5-mm3-full/include/linux/kernel.h.old	2005-12-15 13:38:28.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/include/linux/kernel.h	2005-12-15 13:38:36.000000000 +0100
@@ -315,10 +315,8 @@
 #else
 #define randomize_va_space 1
 #endif
 
 /* Trap pasters of __FUNCTION__ at compile-time */
-#if __GNUC__ > 2 || __GNUC_MINOR__ >= 95
 #define __FUNCTION__ (__func__)
-#endif
 
 #endif
--- linux-2.6.15-rc5-mm3-full/sound/isa/wavefront/wavefront_synth.c.old	2005-12-15 13:39:11.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/sound/isa/wavefront/wavefront_synth.c	2005-12-15 13:39:45.000000000 +0100
@@ -113,22 +113,15 @@
 
 #define WF_DEBUG 1
 
 #ifdef WF_DEBUG
 
-#if defined(NEW_MACRO_VARARGS) || __GNUC__ >= 3
 #define DPRINT(cond, ...) \
        if ((dev->debug & (cond)) == (cond)) { \
 	     snd_printk (__VA_ARGS__); \
        }
 #else
-#define DPRINT(cond, args...) \
-       if ((dev->debug & (cond)) == (cond)) { \
-	     snd_printk (args); \
-       }
-#endif
-#else
 #define DPRINT(cond, args...)
 #endif /* WF_DEBUG */
 
 #define LOGNAME "WaveFront: "
 
--- linux-2.6.15-rc5-mm3-full/drivers/media/video/v4l2-common.c.old	2005-12-15 13:40:21.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/drivers/media/video/v4l2-common.c	2005-12-15 13:40:30.000000000 +0100
@@ -189,13 +189,11 @@
 	[V4L2_BUF_TYPE_VBI_CAPTURE]   = "vbi-cap",
 	[V4L2_BUF_TYPE_VBI_OUTPUT]    = "vbi-out",
 };
 
 char *v4l2_ioctl_names[256] = {
-#if __GNUC__ >= 3
 	[0 ... 255]                      = "UNKNOWN",
-#endif
 	[_IOC_NR(VIDIOC_QUERYCAP)]       = "VIDIOC_QUERYCAP",
 	[_IOC_NR(VIDIOC_RESERVED)]       = "VIDIOC_RESERVED",
 	[_IOC_NR(VIDIOC_ENUM_FMT)]       = "VIDIOC_ENUM_FMT",
 	[_IOC_NR(VIDIOC_G_FMT)]          = "VIDIOC_G_FMT",
 	[_IOC_NR(VIDIOC_S_FMT)]          = "VIDIOC_S_FMT",
--- linux-2.6.15-rc5-mm3-full/include/asm-sparc64/system.h.old	2005-12-15 13:40:55.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/include/asm-sparc64/system.h	2005-12-15 13:41:03.000000000 +0100
@@ -191,15 +191,11 @@
 	 * the output value of 'last'.  'next' is not referenced again
 	 * past the invocation of switch_to in the scheduler, so we need
 	 * not preserve it's value.  Hairy, but it lets us remove 2 loads
 	 * and 2 stores in this critical code path.  -DaveM
 	 */
-#if __GNUC__ >= 3
 #define EXTRA_CLOBBER ,"%l1"
-#else
-#define EXTRA_CLOBBER
-#endif
 #define switch_to(prev, next, last)					\
 do {	if (test_thread_flag(TIF_PERFCTR)) {				\
 		unsigned long __tmp;					\
 		read_pcr(__tmp);					\
 		current_thread_info()->pcr_reg = __tmp;			\
--- linux-2.6.15-rc5-mm3-full/include/linux/byteorder/generic.h.old	2005-12-15 13:41:19.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/include/linux/byteorder/generic.h	2005-12-15 13:41:27.000000000 +0100
@@ -154,11 +154,11 @@
 extern __u32			ntohl(__be32);
 extern __be32			htonl(__u32);
 extern __u16			ntohs(__be16);
 extern __be16			htons(__u16);
 
-#if defined(__GNUC__) && (__GNUC__ >= 2) && defined(__OPTIMIZE__)
+#if defined(__GNUC__) && defined(__OPTIMIZE__)
 
 #define ___htonl(x) __cpu_to_be32(x)
 #define ___htons(x) __cpu_to_be16(x)
 #define ___ntohl(x) __be32_to_cpu(x)
 #define ___ntohs(x) __be16_to_cpu(x)
--- linux-2.6.15-rc5-mm3-full/include/linux/byteorder/swab.h.old	2005-12-15 13:41:34.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/include/linux/byteorder/swab.h	2005-12-15 13:41:45.000000000 +0100
@@ -108,11 +108,11 @@
 
 
 /*
  * Allow constant folding
  */
-#if defined(__GNUC__) && (__GNUC__ >= 2) && defined(__OPTIMIZE__)
+#if defined(__GNUC__) && defined(__OPTIMIZE__)
 #  define __swab16(x) \
 (__builtin_constant_p((__u16)(x)) ? \
  ___swab16((x)) : \
  __fswab16((x)))
 #  define __swab32(x) \
--- linux-2.6.15-rc5-mm3-full/include/linux/byteorder/swabb.h.old	2005-12-15 13:41:52.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/include/linux/byteorder/swabb.h	2005-12-15 13:42:00.000000000 +0100
@@ -75,11 +75,11 @@
 
 
 /*
  * Allow constant folding
  */
-#if defined(__GNUC__) && (__GNUC__ >= 2) && defined(__OPTIMIZE__)
+#if defined(__GNUC__) && defined(__OPTIMIZE__)
 #  define __swahw32(x) \
 (__builtin_constant_p((__u32)(x)) ? \
  ___swahw32((x)) : \
  __fswahw32((x)))
 #  define __swahb32(x) \
--- linux-2.6.15-rc5-mm3-full/arch/i386/Makefile.old	2005-12-15 13:42:54.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/arch/i386/Makefile	2005-12-15 13:43:12.000000000 +0100
@@ -35,14 +35,11 @@
 CFLAGS += $(call cc-option,-mpreferred-stack-boundary=2)
 
 # CPU-specific tuning. Anything which can be shared with UML should go here.
 include $(srctree)/arch/i386/Makefile.cpu
 
-# -mregparm=3 works ok on gcc-3.0 and later
-#
-GCC_VERSION			:= $(call cc-version)
-cflags-$(CONFIG_REGPARM) 	+= $(shell if [ $(GCC_VERSION) -ge 0300 ] ; then echo "-mregparm=3"; fi ;)
+cflags-$(CONFIG_REGPARM) 	+= -mregparm=3
 
 # Disable unit-at-a-time mode, it makes gcc use a lot more stack
 # due to the lack of sharing of stacklots.
 CFLAGS += $(call cc-option,-fno-unit-at-a-time)
 
--- linux-2.6.15-rc5-mm3-full/arch/i386/Makefile.cpu.old	2005-12-15 13:53:25.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/arch/i386/Makefile.cpu	2005-12-15 14:00:34.000000000 +0100
@@ -1,9 +1,9 @@
 # CPU tuning section - shared with UML.
 # Must change only cflags-y (or [yn]), not CFLAGS! That makes a difference for UML.
 
-#-mtune exists since gcc 3.4, and some -mcpu flavors didn't exist in gcc 2.95.
+#-mtune exists since gcc 3.4
 HAS_MTUNE	:= $(call cc-option-yn, -mtune=i386)
 ifeq ($(HAS_MTUNE),y)
 tune		= $(call cc-option,-mtune=$(1),)
 else
 tune		= $(call cc-option,-mcpu=$(1),)
@@ -12,21 +12,21 @@
 align := $(cc-option-align)
 cflags-$(CONFIG_M386)		+= -march=i386
 cflags-$(CONFIG_M486)		+= -march=i486
 cflags-$(CONFIG_M586)		+= -march=i586
 cflags-$(CONFIG_M586TSC)	+= -march=i586
-cflags-$(CONFIG_M586MMX)	+= $(call cc-option,-march=pentium-mmx,-march=i586)
+cflags-$(CONFIG_M586MMX)	+= -march=pentium-mmx
 cflags-$(CONFIG_M686)		+= -march=i686
 cflags-$(CONFIG_MPENTIUMII)	+= -march=i686 $(call tune,pentium2)
 cflags-$(CONFIG_MPENTIUMIII)	+= -march=i686 $(call tune,pentium3)
 cflags-$(CONFIG_MPENTIUMM)	+= -march=i686 $(call tune,pentium3)
 cflags-$(CONFIG_MPENTIUM4)	+= -march=i686 $(call tune,pentium4)
 cflags-$(CONFIG_MK6)		+= -march=k6
 # Please note, that patches that add -march=athlon-xp and friends are pointless.
 # They make zero difference whatsosever to performance at this time.
-cflags-$(CONFIG_MK7)		+= $(call cc-option,-march=athlon,-march=i686 $(align)-functions=4)
-cflags-$(CONFIG_MK8)		+= $(call cc-option,-march=k8,$(call cc-option,-march=athlon,-march=i686 $(align)-functions=4))
+cflags-$(CONFIG_MK7)		+= -march=athlon
+cflags-$(CONFIG_MK8)		+= $(call cc-option,-march=k8,-march=athlon)
 cflags-$(CONFIG_MCRUSOE)	+= -march=i686 $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
 cflags-$(CONFIG_MEFFICEON)	+= -march=i686 $(call tune,pentium3) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
 cflags-$(CONFIG_MWINCHIPC6)	+= $(call cc-option,-march=winchip-c6,-march=i586)
 cflags-$(CONFIG_MWINCHIP2)	+= $(call cc-option,-march=winchip2,-march=i586)
 cflags-$(CONFIG_MWINCHIP3D)	+= $(call cc-option,-march=winchip2,-march=i586)
@@ -35,7 +35,7 @@
 
 # AMD Elan support
 cflags-$(CONFIG_X86_ELAN)	+= -march=i486
 
 # Geode GX1 support
-cflags-$(CONFIG_MGEODEGX1)		+= $(call cc-option,-march=pentium-mmx,-march=i486)
+cflags-$(CONFIG_MGEODEGX1)	+= -march=pentium-mmx
 
--- linux-2.6.15-rc5-mm3-full/arch/ia64/Makefile.old	2005-12-15 13:43:28.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/arch/ia64/Makefile	2005-12-15 13:43:57.000000000 +0100
@@ -35,14 +35,10 @@
 	static binary of such an assembler at:					\
 										\
 		ftp://ftp.hpl.hp.com/pub/linux-ia64/gas-030124.tar.gz)
 endif
 
-ifneq ($(shell if [ $(GCC_VERSION) -lt 0300 ] ; then echo "bad"; fi ;),)
-$(error Sorry, your compiler is too old.  GCC v2.96 is known to generate bad code.)
-endif
-
 ifeq ($(GCC_VERSION),0304)
 	cflags-$(CONFIG_ITANIUM)	+= -mtune=merced
 	cflags-$(CONFIG_MCKINLEY)	+= -mtune=mckinley
 endif
 
--- linux-2.6.15-rc5-mm3-full/arch/i386/Kconfig.old	2005-12-15 13:45:06.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/arch/i386/Kconfig	2005-12-15 13:45:15.000000000 +0100
@@ -628,14 +628,10 @@
 	help
 	Compile the kernel with -mregparm=3. This uses a different ABI
 	and passes the first three arguments of a function call in registers.
 	This will probably break binary only modules.
 
-	This feature is only enabled for gcc-3.0 and later - earlier compilers
-	generate incorrect output with certain kernel constructs when
-	-mregparm=3 is used.
-
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
 	default y
 	help

