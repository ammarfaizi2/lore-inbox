Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265334AbUATK2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 05:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbUATK2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 05:28:17 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:62187 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265334AbUATK1x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 05:27:53 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16397.678.367057.65252@laputa.namesys.com>
Date: Tue, 20 Jan 2004 13:27:50 +0300
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] const vs. __attribute__((const)) confusion
In-Reply-To: <200401192348.i0JNm5aJ002485@hera.kernel.org>
References: <200401192348.i0JNm5aJ002485@hera.kernel.org>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List writes:
 > ChangeSet 1.1490.3.216, 2004/01/19 10:43:54-08:00, akpm@osdl.org
 > 
 > 	[PATCH] const vs. __attribute__((const)) confusion
 > 	
 > 	From: "H. Peter Anvin" <hpa@zytor.com>
 > 	
 > 	Declaring a function to return a const scalar value is pretty meaningless. 
 > 	These functions are really trying to say that they don't alter any external
 > 	state.
 > 	
 > 	Fix that up by using __attribute__((const)), if the compiler supports that.
 > 

Let's then also replace all existing usages of __attribute__((const))
with __attribute_const__, while we are here.

I don't have the hardware to test this patch, but at least it compiles.

Nikita.
===== arch/ia64/kernel/unwind.c 1.35 vs edited =====
--- 1.35/arch/ia64/kernel/unwind.c	Mon Jan  5 18:47:54 2004
+++ edited/arch/ia64/kernel/unwind.c	Tue Jan 20 13:13:07 2004
@@ -650,7 +650,7 @@
 
 /* Unwind decoder routines */
 
-static enum unw_register_index __attribute__((const))
+static enum unw_register_index __attribute_const__
 decode_abreg (unsigned char abreg, int memory)
 {
 	switch (abreg) {
===== drivers/usb/class/audio.c 1.42 vs edited =====
--- 1.42/drivers/usb/class/audio.c	Thu Oct 23 16:59:04 2003
+++ edited/drivers/usb/class/audio.c	Tue Jan 20 13:13:39 2004
@@ -203,12 +203,12 @@
 
 #define AUDIO_DEBUG 1
 
-#define SND_DEV_DSP16   5 
+#define SND_DEV_DSP16   5
 
 #define dprintk(x)
 
 #undef abs
-extern int abs(int __x) __attribute__ ((__const__)); /* Shut up warning */
+extern int abs(int __x) __attribute_const__; /* Shut up warning */
 
 /* --------------------------------------------------------------------- */
 
===== include/asm-alpha/byteorder.h 1.2 vs edited =====
--- 1.2/include/asm-alpha/byteorder.h	Wed Feb 19 22:30:42 2003
+++ edited/include/asm-alpha/byteorder.h	Tue Jan 20 13:23:50 2004
@@ -6,7 +6,7 @@
 
 #ifdef __GNUC__
 
-static __inline __u32 __attribute__((__const)) __arch__swab32(__u32 x)
+static __inline __u32 __attribute_const__ __arch__swab32(__u32 x)
 {
 	/*
 	 * Unfortunately, we can't use the 6 instruction sequence
===== include/asm-arm/current.h 1.3 vs edited =====
--- 1.3/include/asm-arm/current.h	Sat Dec 28 19:26:45 2002
+++ edited/include/asm-arm/current.h	Tue Jan 20 13:23:50 2004
@@ -3,7 +3,7 @@
 
 #include <linux/thread_info.h>
 
-static inline struct task_struct *get_current(void) __attribute__ (( __const__ ));
+static inline struct task_struct *get_current(void) __attribute_const__;
 
 static inline struct task_struct *get_current(void)
 {
===== include/asm-arm/thread_info.h 1.8 vs edited =====
--- 1.8/include/asm-arm/thread_info.h	Wed Sep  3 21:17:58 2003
+++ edited/include/asm-arm/thread_info.h	Tue Jan 20 13:22:10 2004
@@ -76,7 +76,7 @@
 /*
  * how to get the thread information struct from C
  */
-static inline struct thread_info *current_thread_info(void) __attribute__ (( __const__ ));
+static inline struct thread_info *current_thread_info(void) __attribute_const__;
 
 static inline struct thread_info *current_thread_info(void)
 {
===== include/asm-arm26/current.h 1.1 vs edited =====
--- 1.1/include/asm-arm26/current.h	Wed Jun  4 15:14:10 2003
+++ edited/include/asm-arm26/current.h	Tue Jan 20 13:23:50 2004
@@ -3,7 +3,7 @@
 
 #include <linux/thread_info.h>
 
-static inline struct task_struct *get_current(void) __attribute__ (( __const__ ));
+static inline struct task_struct *get_current(void) __attribute_const__;
 
 static inline struct task_struct *get_current(void)
 {
===== include/asm-arm26/thread_info.h 1.2 vs edited =====
--- 1.2/include/asm-arm26/thread_info.h	Mon Jul  7 03:40:02 2003
+++ edited/include/asm-arm26/thread_info.h	Tue Jan 20 13:23:50 2004
@@ -71,7 +71,7 @@
 /*
  * how to get the thread information struct from C
  */
-static inline struct thread_info *current_thread_info(void) __attribute__ (( __const__ ));
+static inline struct thread_info *current_thread_info(void) __attribute_const__;
 
 static inline struct thread_info *current_thread_info(void)
 {
===== include/asm-m68k/virtconvert.h 1.4 vs edited =====
--- 1.4/include/asm-m68k/virtconvert.h	Mon Jan 19 09:35:43 2004
+++ edited/include/asm-m68k/virtconvert.h	Tue Jan 20 13:13:07 2004
@@ -19,8 +19,8 @@
  * Change virtual addresses to physical addresses and vv.
  */
 #ifndef CONFIG_SUN3
-extern unsigned long mm_vtop(unsigned long addr) __attribute__ ((const));
-extern unsigned long mm_ptov(unsigned long addr) __attribute__ ((const));
+extern unsigned long mm_vtop(unsigned long addr) __attribute_const__;
+extern unsigned long mm_ptov(unsigned long addr) __attribute_const__;
 #else
 static inline unsigned long mm_vtop(unsigned long vaddr)
 {
===== include/asm-ppc/io.h 1.14 vs edited =====
--- 1.14/include/asm-ppc/io.h	Wed Sep  3 16:16:34 2003
+++ edited/include/asm-ppc/io.h	Tue Jan 20 13:13:07 2004
@@ -208,7 +208,7 @@
 #define ioremap_nocache(addr, size)	ioremap((addr), (size))
 extern void iounmap(void *addr);
 extern unsigned long iopa(unsigned long addr);
-extern unsigned long mm_ptov(unsigned long addr) __attribute__ ((const));
+extern unsigned long mm_ptov(unsigned long addr) __attribute_const__;
 extern void io_block_mapping(unsigned long virt, phys_addr_t phys,
 			     unsigned int size, int flags);
 
===== include/asm-ppc/pgtable.h 1.27 vs edited =====
--- 1.27/include/asm-ppc/pgtable.h	Mon Jan 19 09:35:58 2004
+++ edited/include/asm-ppc/pgtable.h	Tue Jan 20 13:13:07 2004
@@ -626,7 +626,7 @@
 extern void cache_push(__u32 addr, int length);
 extern int mm_end_of_chunk (unsigned long addr, int len);
 extern unsigned long iopa(unsigned long addr);
-extern unsigned long mm_ptov(unsigned long addr) __attribute__ ((const));
+extern unsigned long mm_ptov(unsigned long addr) __attribute_const__;
 
 /* Values for nocacheflag and cmode */
 /* These are not used by the APUS kernel_map, but prevents
===== include/asm-sparc/btfixup.h 1.2 vs edited =====
--- 1.2/include/asm-sparc/btfixup.h	Thu Jun  6 10:08:28 2002
+++ edited/include/asm-sparc/btfixup.h	Tue Jan 20 13:13:07 2004
@@ -39,7 +39,7 @@
 	extern __type ___f_##__name(__args);						\
 	extern unsigned ___fs_##__name[3];
 #define BTFIXUPDEF_CALL_CONST(__type, __name, __args...) 				\
-	extern __type ___f_##__name(__args) __attribute__((const));			\
+	extern __type ___f_##__name(__args) __attribute_const__;			\
 	extern unsigned ___fs_##__name[3];
 #define BTFIXUP_CALL(__name) ___f_##__name
 
@@ -49,7 +49,7 @@
 /* Put bottom 13bits into some register variable */
 
 #define BTFIXUPDEF_SIMM13(__name)							\
-	extern unsigned int ___sf_##__name(void) __attribute__((const));		\
+	extern unsigned int ___sf_##__name(void) __attribute_const__;		\
 	extern unsigned ___ss_##__name[2];						\
 	extern __inline__ unsigned int ___sf_##__name(void) {				\
 		unsigned int ret;							\
@@ -57,7 +57,7 @@
 		return ret;								\
 	}
 #define BTFIXUPDEF_SIMM13_INIT(__name,__val)						\
-	extern unsigned int ___sf_##__name(void) __attribute__((const));		\
+	extern unsigned int ___sf_##__name(void) __attribute_const__;		\
 	extern unsigned ___ss_##__name[2];						\
 	extern __inline__ unsigned int ___sf_##__name(void) {				\
 		unsigned int ret;							\
@@ -71,7 +71,7 @@
  */
 
 #define BTFIXUPDEF_HALF(__name)								\
-	extern unsigned int ___af_##__name(void) __attribute__((const));		\
+	extern unsigned int ___af_##__name(void) __attribute_const__;		\
 	extern unsigned ___as_##__name[2];						\
 	extern __inline__ unsigned int ___af_##__name(void) {				\
 		unsigned int ret;							\
@@ -79,7 +79,7 @@
 		return ret;								\
 	}
 #define BTFIXUPDEF_HALF_INIT(__name,__val)						\
-	extern unsigned int ___af_##__name(void) __attribute__((const));		\
+	extern unsigned int ___af_##__name(void) __attribute_const__;		\
 	extern unsigned ___as_##__name[2];						\
 	extern __inline__ unsigned int ___af_##__name(void) {				\
 		unsigned int ret;							\
@@ -90,7 +90,7 @@
 /* Put upper 22 bits into some register variable */
 
 #define BTFIXUPDEF_SETHI(__name)							\
-	extern unsigned int ___hf_##__name(void) __attribute__((const));		\
+	extern unsigned int ___hf_##__name(void) __attribute_const__;		\
 	extern unsigned ___hs_##__name[2];						\
 	extern __inline__ unsigned int ___hf_##__name(void) {				\
 		unsigned int ret;							\
@@ -98,7 +98,7 @@
 		return ret;								\
 	}
 #define BTFIXUPDEF_SETHI_INIT(__name,__val)						\
-	extern unsigned int ___hf_##__name(void) __attribute__((const));		\
+	extern unsigned int ___hf_##__name(void) __attribute_const__;		\
 	extern unsigned ___hs_##__name[2];						\
 	extern __inline__ unsigned int ___hf_##__name(void) {				\
 		unsigned int ret;							\
===== include/asm-sparc/pgtable.h 1.17 vs edited =====
--- 1.17/include/asm-sparc/pgtable.h	Thu Oct  2 11:11:59 2003
+++ edited/include/asm-sparc/pgtable.h	Tue Jan 20 13:13:07 2004
@@ -80,7 +80,7 @@
 BTFIXUPDEF_SETHI(pmd_size)
 BTFIXUPDEF_SETHI(pmd_mask)
 
-extern unsigned int pmd_align(unsigned int addr) __attribute__((const));
+extern unsigned int pmd_align(unsigned int addr) __attribute_const__;
 extern __inline__ unsigned int pmd_align(unsigned int addr)
 {
 	return ((addr + ~BTFIXUP_SETHI(pmd_mask)) & BTFIXUP_SETHI(pmd_mask));
@@ -90,7 +90,7 @@
 BTFIXUPDEF_SETHI(pgdir_size)
 BTFIXUPDEF_SETHI(pgdir_mask)
 
-extern unsigned int pgdir_align(unsigned int addr) __attribute__((const));
+extern unsigned int pgdir_align(unsigned int addr) __attribute_const__;
 extern __inline__ unsigned int pgdir_align(unsigned int addr)
 {
 	return ((addr + ~BTFIXUP_SETHI(pgdir_mask)) & BTFIXUP_SETHI(pgdir_mask));
@@ -248,19 +248,19 @@
 BTFIXUPDEF_HALF(pte_dirtyi)
 BTFIXUPDEF_HALF(pte_youngi)
 
-extern int pte_write(pte_t pte) __attribute__((const));
+extern int pte_write(pte_t pte) __attribute_const__;
 extern __inline__ int pte_write(pte_t pte)
 {
 	return pte_val(pte) & BTFIXUP_HALF(pte_writei);
 }
 
-extern int pte_dirty(pte_t pte) __attribute__((const));
+extern int pte_dirty(pte_t pte) __attribute_const__;
 extern __inline__ int pte_dirty(pte_t pte)
 {
 	return pte_val(pte) & BTFIXUP_HALF(pte_dirtyi);
 }
 
-extern int pte_young(pte_t pte) __attribute__((const));
+extern int pte_young(pte_t pte) __attribute_const__;
 extern __inline__ int pte_young(pte_t pte)
 {
 	return pte_val(pte) & BTFIXUP_HALF(pte_youngi);
@@ -271,7 +271,7 @@
  */
 BTFIXUPDEF_HALF(pte_filei)
 
-extern int pte_file(pte_t pte) __attribute__((const));
+extern int pte_file(pte_t pte) __attribute_const__;
 extern __inline__ int pte_file(pte_t pte)
 {
 	return pte_val(pte) & BTFIXUP_HALF(pte_filei);
@@ -283,19 +283,19 @@
 BTFIXUPDEF_HALF(pte_mkcleani)
 BTFIXUPDEF_HALF(pte_mkoldi)
 
-extern pte_t pte_wrprotect(pte_t pte) __attribute__((const));
+extern pte_t pte_wrprotect(pte_t pte) __attribute_const__;
 extern __inline__ pte_t pte_wrprotect(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~BTFIXUP_HALF(pte_wrprotecti));
 }
 
-extern pte_t pte_mkclean(pte_t pte) __attribute__((const));
+extern pte_t pte_mkclean(pte_t pte) __attribute_const__;
 extern __inline__ pte_t pte_mkclean(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~BTFIXUP_HALF(pte_mkcleani));
 }
 
-extern pte_t pte_mkold(pte_t pte) __attribute__((const));
+extern pte_t pte_mkold(pte_t pte) __attribute_const__;
 extern __inline__ pte_t pte_mkold(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~BTFIXUP_HALF(pte_mkoldi));
@@ -332,7 +332,7 @@
 
 BTFIXUPDEF_INT(pte_modify_mask)
 
-extern pte_t pte_modify(pte_t pte, pgprot_t newprot) __attribute__((const));
+extern pte_t pte_modify(pte_t pte, pgprot_t newprot) __attribute_const__;
 extern __inline__ pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return __pte((pte_val(pte) & BTFIXUP_INT(pte_modify_mask)) |
===== include/linux/reiserfs_fs.h 1.53 vs edited =====
--- 1.53/include/linux/reiserfs_fs.h	Tue Dec 30 11:44:59 2003
+++ edited/include/linux/reiserfs_fs.h	Tue Jan 20 13:23:50 2004
@@ -90,7 +90,7 @@
 #define RFALSE( cond, format, args... ) do {;} while( 0 )
 #endif
 
-#define CONSTF __attribute__( ( const ) )
+#define CONSTF __attribute_const__
 /*
  * Disk Data Structures
  */
