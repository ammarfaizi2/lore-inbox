Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317036AbSFAUDm>; Sat, 1 Jun 2002 16:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSFAUDm>; Sat, 1 Jun 2002 16:03:42 -0400
Received: from p508872AA.dip.t-dialin.net ([80.136.114.170]:47035 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317036AbSFAUCk>; Sat, 1 Jun 2002 16:02:40 -0400
Date: Sat, 1 Jun 2002 14:01:28 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Kernel Build -- Daniel Phillips <phillips@bonn-fries.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] kbuild-2.5: UltraSPARC dependant stuff
Message-ID: <Pine.LNX.4.44.0206011400410.4854-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild-2.5 - sparc64 dependant stuff

You will need this patch for kbuild-2.5 on sparc64 (aka UltraSPARC).
You will need most other kbuild-2.5 patches, too!

This patch is also available from
<URL:ftp://luckynet.dynu.com/pub/linux/kbuild-2.5/many-files/kbuild-2.5-arch-sparc64.patch>

diff -Nur kbuild-2.5/arch/sparc64/asm-offsets.c kbuild-2.5/arch/sparc64/asm-offsets.c
--- kbuild-2.5/arch/sparc64/asm-offsets.c Fri May 31 15:49:46 2002
+++ kbuild-2.5/arch/sparc64/asm-offsets.c Fri May 31 15:49:46 2002 +0000 thunder (thunder-2.5/arch/sparc64/asm-offsets.c 1.1 0644)
@@ -0,0 +1,45 @@
+/*
+ * Generate definitions needed by assembly language modules.
+ * This code generates raw asm output which is post-processed to extract
+ * and format the required data.
+ */
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+
+/* Use marker if you need to separate the values later */
+
+#define DEFINE(sym, val, marker) \
+  asm volatile("\n-> " #sym " %0 " #val " " #marker : : "i" (val))
+
+#define BLANK() asm volatile("\n->" : : )
+
+int
+main(void)
+{
+  DEFINE(TI_TASK,		offsetof(struct thread_info, task),);
+  DEFINE(TI_FLAGS,		offsetof(struct thread_info, flags),);
+  DEFINE(TI_CPU,		offsetof(struct thread_info, cpu),);
+  DEFINE(TI_FPSAVED,		offsetof(struct thread_info, fpsaved),);
+  DEFINE(TI_KSP,		offsetof(struct thread_info, ksp),);
+  DEFINE(TI_FAULT_ADDR,		offsetof(struct thread_info, fault_address),);
+  DEFINE(TI_KREGS,		offsetof(struct thread_info, kregs),);
+  DEFINE(TI_EXEC_DOMAIN,	offsetof(struct thread_info, exec_domain),);
+  DEFINE(TI_PRE_COUNT,		offsetof(struct thread_info, preempt_count),);
+  DEFINE(TI_UTRAPS,		offsetof(struct thread_info, utraps),);
+  DEFINE(TI_REG_WINDOW,		offsetof(struct thread_info, reg_window),);
+  DEFINE(TI_RWIN_SPTRS,		offsetof(struct thread_info, rwbuf_stkptrs),);
+  DEFINE(TI_GSR,		offsetof(struct thread_info, gsr),);
+  DEFINE(TI_XFSR,		offsetof(struct thread_info, xfsr),);
+  DEFINE(TI_USER_CNTD0,		offsetof(struct thread_info, user_cntd0),);
+  DEFINE(TI_USER_CNTD1,		offsetof(struct thread_info, user_cntd1),);
+  DEFINE(TI_KERN_CNTD0,		offsetof(struct thread_info, kernel_cntd0),);
+  DEFINE(TI_KERN_CNTD1,		offsetof(struct thread_info, kernel_cntd1),);
+  DEFINE(TI_PCR,		offsetof(struct thread_info, pcr_reg),);
+  DEFINE(TI_CEE_STUFF,		offsetof(struct thread_info, cee_stuff),);
+  DEFINE(TI_FPREGS,		offsetof(struct thread_info, fpregs),);
+  BLANK();
+
+  return 0;
+}
diff -Nur kbuild-2.5/arch/sparc64/boot/config.install-2.5 kbuild-2.5/arch/sparc64/boot/config.install-2.5
--- kbuild-2.5/arch/sparc64/boot/config.install-2.5 Fri May 31 15:49:46 2002
+++ kbuild-2.5/arch/sparc64/boot/config.install-2.5 Fri May 31 15:49:46 2002 +0000 thunder (thunder-2.5/arch/sparc64/boot/config.install-2.5 1.1 0644)
@@ -0,0 +1,44 @@
+mainmenu_name "Sparc64 Installation"
+
+choice 'Format to compile kernel in' \
+	"vmlinux	CONFIG_VMLINUX \
+	 vmlinuz	CONFIG_VMLINUZ \
+	 tftpboot.img	CONFIG_TFTPBOOT" vmlinuz
+
+bool 'Use a prefix on install paths' CONFIG_INSTALL_PREFIX
+if [ "$CONFIG_INSTALL_PREFIX" = "y" ]; then
+  string '  Prefix for install paths' CONFIG_INSTALL_PREFIX_NAME ""
+fi
+string 'Where to install the kernel' CONFIG_INSTALL_KERNEL_NAME "/lib/modules/KERNELRELEASE/vmlinuz"
+bool 'Install System.map' CONFIG_INSTALL_SYSTEM_MAP
+if [ "$CONFIG_INSTALL_SYSTEM_MAP" = "y" ]; then
+  string '  Where to install System.map' CONFIG_INSTALL_SYSTEM_MAP_NAME "/lib/modules/KERNELRELEASE/System.map"
+fi
+bool 'Install .config' CONFIG_INSTALL_CONFIG
+if [ "$CONFIG_INSTALL_CONFIG" = "y" ]; then
+  string '  Where to install .config' CONFIG_INSTALL_CONFIG_NAME "/lib/modules/KERNELRELEASE/.config"
+fi
+if [ "$CONFIG_VMLINUX" != "y" ]; then
+  bool '  Install vmlinux for debugging' CONFIG_INSTALL_VMLINUX
+  if [ "$CONFIG_INSTALL_VMLINUX" = "y" ]; then
+    string '    Where to install vmlinux' CONFIG_INSTALL_VMLINUX_NAME "/lib/modules/KERNELRELEASE/vmlinux"
+  fi
+fi
+bool 'Run a post-install script or command' CONFIG_INSTALL_SCRIPT
+if [ "$CONFIG_INSTALL_SCRIPT" = "y" ]; then
+  string '  Post-install script or command name' CONFIG_INSTALL_SCRIPT_NAME ""
+fi
+
+# FIXME: These critical config options should be in arch/$(ARCH)/config.in.  For
+# coexistence of kbuild 2.4 and 2.5 it is easier to put them here, move them
+# later.  KAO
+
+# FIXME more: Update to sparc64 critical variables.  KAO
+
+#define_string CONFIG_KBUILD_CRITICAL_ARCH "CONFIG_M386 CONFIG_M486 \
+#	CONFIG_M586 CONFIG_M586TSC CONFIG_M586MMX CONFIG_M686 \
+#	CONFIG_MPENTIUMIII CONFIG_MPENTIUM4 \
+#	CONFIG_MK6 CONFIG_MK7 \
+#	CONFIG_MCRUSOE \
+#	CONFIG_MWINCHIPC6 CONFIG_MWINCHIP2 CONFIG_MWINCHIP3D \
+#	CONFIG_MCYRIXIII"
diff -Nur kbuild-2.5/arch/sparc64/boot/rules-2.5.cml kbuild-2.5/arch/sparc64/boot/rules-2.5.cml
--- kbuild-2.5/arch/sparc64/boot/rules-2.5.cml Fri May 31 15:49:46 2002
+++ kbuild-2.5/arch/sparc64/boot/rules-2.5.cml Fri May 31 15:49:46 2002 +0000 thunder (thunder-2.5/arch/sparc64/boot/rules-2.5.cml 1.1 0644)
@@ -0,0 +1,28 @@
+symbols
+kernel_format_sparc64	'The format used for the installed kernel' text
+All kernel builds create vmlinux as an ELF object.  vmlinux may not be
+suitable for loading, either because your bootloader cannot handle ELF
+or the object is too large.  This option selects the format for the
+installed kernel.  If unsure, use vmlinuz.
+.
+VMLINUX_SPARC64 'vmlinux' like VMLINUX_help
+VMLINUZ_SPARC64 'vmlinuz' like VMLINUZ_help
+TFTPBOOT_SPARC64 'tftpboot.img' like TFTPBOOT_help
+
+private VMLINUX_SPARC64 VMLINUZ_SPARC64 TFTPBOOT_SPARC64
+
+choices kernel_format_sparc64 # The format that the kernel is to be compiled in
+	VMLINUX_SPARC64 VMLINUZ_SPARC64 TFTPBOOT_SPARC64 default VMLINUZ_SPARC64
+
+# FIXME: These critical config options should be in arch/$(ARCH)/rules.cml.  For
+# coexistence of kbuild 2.4 and 2.5 it is easier to put them here, move them
+# later.  KAO
+
+# FIXME: more: Set the real sparc64 critical options.
+
+derive KBUILD_CRITICAL_ARCH_SPARC64 from "???"
+
+menu installation
+	kernel_format_sparc64
+
+unless SPARC64 suppress kernel_format_sparc64
diff -Nur kbuild-2.5/arch/sparc64/kernel/entry.S kbuild-2.5/arch/sparc64/kernel/entry.S
--- kbuild-2.5/arch/sparc64/kernel/entry.S Fri May 31 15:49:47 2002
+++ kbuild-2.5/arch/sparc64/kernel/entry.S Fri May 31 15:49:47 2002 +0000 thunder (thunder-2.5/arch/sparc64/kernel/entry.S 1.1 0644)
@@ -21,6 +21,11 @@
 #include <asm/visasm.h>
 #include <asm/estate.h>
 
+#include <linux/config.h>	/* Remove this line after kbuild 2.5 is in */
+#ifdef CONFIG_KBUILD_2_5	/* Remove this line after kbuild 2.5 is in */
+#include "asm-offsets.h"	/* This is all that is required for kbuild 2.5 */
+#endif				/* Remove this line after kbuild 2.5 is in */
+
 /* #define SYSCALL_TRACING	1 */
 
 #define curptr      g6
diff -Nur kbuild-2.5/arch/sparc64/kernel/etrap.S kbuild-2.5/arch/sparc64/kernel/etrap.S
--- kbuild-2.5/arch/sparc64/kernel/etrap.S Fri May 31 15:49:47 2002
+++ kbuild-2.5/arch/sparc64/kernel/etrap.S Fri May 31 15:49:47 2002 +0000 thunder (thunder-2.5/arch/sparc64/kernel/etrap.S 1.1 0644)
@@ -15,6 +15,11 @@
 #include <asm/head.h>
 #include <asm/processor.h>
 
+#include <linux/config.h>	/* Remove this line after kbuild 2.5 is in */
+#ifdef CONFIG_KBUILD_2_5	/* Remove this line after kbuild 2.5 is in */
+#include "asm-offsets.h"	/* This is all that is required for kbuild 2.5 */
+#endif				/* Remove this line after kbuild 2.5 is in */
+
 #define		TASK_REGOFF		(THREAD_SIZE-TRACEREG_SZ-REGWIN_SZ)
 #define		ETRAP_PSTATE1		(PSTATE_RMO | PSTATE_PRIV)
 #define		ETRAP_PSTATE2		(PSTATE_RMO | PSTATE_PEF | PSTATE_PRIV | PSTATE_IE)
diff -Nur kbuild-2.5/arch/sparc64/kernel/head.S kbuild-2.5/arch/sparc64/kernel/head.S
--- kbuild-2.5/arch/sparc64/kernel/head.S Fri May 31 15:49:48 2002
+++ kbuild-2.5/arch/sparc64/kernel/head.S Fri May 31 15:49:48 2002 +0000 thunder (thunder-2.5/arch/sparc64/kernel/head.S 1.1 0644)
@@ -25,6 +25,10 @@
 #include <asm/dcu.h>
 #include <asm/head.h>
 #include <asm/ttable.h>
+
+#ifdef CONFIG_KBUILD_2_5	/* Remove this line after kbuild 2.5 is in */
+#include "asm-offsets.h"	/* This is all that is required for kbuild 2.5 */
+#endif				/* Remove this line after kbuild 2.5 is in */
 	
 /* This section from from _start to sparc64_boot_end should fit into
  * 0x0000.0000.0040.4000 to 0x0000.0000.0040.8000 and will be sharing space
diff -Nur kbuild-2.5/arch/sparc64/kernel/trampoline.S kbuild-2.5/arch/sparc64/kernel/trampoline.S
--- kbuild-2.5/arch/sparc64/kernel/trampoline.S Fri May 31 15:49:48 2002
+++ kbuild-2.5/arch/sparc64/kernel/trampoline.S Fri May 31 15:49:48 2002 +0000 thunder (thunder-2.5/arch/sparc64/kernel/trampoline.S 1.1 0644)
@@ -16,6 +16,11 @@
 #include <asm/processor.h>
 #include <asm/thread_info.h>
 
+#include <linux/config.h>
+#ifdef CONFIG_KBUILD_2_5
+#include "asm-offsets.h"
+#endif
+
 	.data
 	.align	8
 call_method:
diff -Nur kbuild-2.5/arch/sparc64/kernel/traps.c kbuild-2.5/arch/sparc64/kernel/traps.c
--- kbuild-2.5/arch/sparc64/kernel/traps.c Fri May 31 15:49:49 2002
+++ kbuild-2.5/arch/sparc64/kernel/traps.c Fri May 31 15:49:49 2002 +0000 thunder (thunder-2.5/arch/sparc64/kernel/traps.c 1.1 0644)
@@ -1706,6 +1706,7 @@
 /* Only invoked on boot processor. */
 void __init trap_init(void)
 {
+#ifndef CONFIG_KBUILD_2_5
 	/* Compile time sanity check. */
 	if (TI_TASK != offsetof(struct thread_info, task) ||
 	    TI_FLAGS != offsetof(struct thread_info, flags) ||
@@ -1730,6 +1731,7 @@
 	    TI_FPREGS != offsetof(struct thread_info, fpregs) ||
 	    (TI_FPREGS & (64 - 1)))
 		thread_info_offsets_are_bolixed_dave();
+#endif /* !CONFIG_KBUILD_2_5 */
 
 	/* Attach to the address space of init_task.  On SMP we
 	 * do this in smp.c:smp_callin for other cpus.
diff -Nur kbuild-2.5/arch/sparc64/lib/VIScopy.S kbuild-2.5/arch/sparc64/lib/VIScopy.S
--- kbuild-2.5/arch/sparc64/lib/VIScopy.S Fri May 31 15:49:49 2002
+++ kbuild-2.5/arch/sparc64/lib/VIScopy.S Fri May 31 15:49:49 2002 +0000 thunder (thunder-2.5/arch/sparc64/lib/VIScopy.S 1.1 0644)
@@ -28,6 +28,10 @@
 #include <asm/visasm.h>
 #include <asm/thread_info.h>
 
+#ifdef CONFIG_KBUILD_2_5
+#include "asm-offsets.h"
+#endif
+
 #define FPU_CLEAN_RETL					\
 	ldub		[%g6 + TI_CURRENT_DS], %o1;	\
 	VISExit						\
diff -Nur kbuild-2.5/arch/sparc64/lib/VIScsum.S kbuild-2.5/arch/sparc64/lib/VIScsum.S
--- kbuild-2.5/arch/sparc64/lib/VIScsum.S Fri May 31 15:49:50 2002
+++ kbuild-2.5/arch/sparc64/lib/VIScsum.S Fri May 31 15:49:50 2002 +0000 thunder (thunder-2.5/arch/sparc64/lib/VIScsum.S 1.1 0644)
@@ -29,6 +29,12 @@
 #include <asm/asi.h>
 #include <asm/visasm.h>
 #include <asm/thread_info.h>
+
+#include <linux/config.h>
+#ifdef		CONFIG_KBUILD_2_5
+#include "asm-offsets.h"
+#endif		/* CONFIG_KBUILD_2_5 */
+
 #else
 #define ASI_BLK_P	0xf0
 #define FRPS_FEF	0x04
diff -Nur kbuild-2.5/arch/sparc64/lib/VIScsumcopy.S kbuild-2.5/arch/sparc64/lib/VIScsumcopy.S
--- kbuild-2.5/arch/sparc64/lib/VIScsumcopy.S Fri May 31 15:49:50 2002
+++ kbuild-2.5/arch/sparc64/lib/VIScsumcopy.S Fri May 31 15:49:50 2002 +0000 thunder (thunder-2.5/arch/sparc64/lib/VIScsumcopy.S 1.1 0644)
@@ -32,6 +32,12 @@
 #define ASI_BLK_XOR	0
 #define ASI_BLK_XOR1	(ASI_BLK_P ^ (ASI_BLK_P >> 3) ^ ASI_P)
 #define ASI_BLK_OR	(ASI_BLK_P & ~ASI_P)
+
+#include <linux/config.h>
+#ifdef 		CONFIG_KBUILD_2_5
+#include "asm-offsets.h"
+#endif 		/* CONFIG_KBUILD_2_5 */
+
 #else
 #define ASI_P		0x80
 #define ASI_BLK_P	0xf0
diff -Nur kbuild-2.5/arch/sparc64/lib/VIScsumcopyusr.S kbuild-2.5/arch/sparc64/lib/VIScsumcopyusr.S
--- kbuild-2.5/arch/sparc64/lib/VIScsumcopyusr.S Fri May 31 15:49:51 2002
+++ kbuild-2.5/arch/sparc64/lib/VIScsumcopyusr.S Fri May 31 15:49:51 2002 +0000 thunder (thunder-2.5/arch/sparc64/lib/VIScsumcopyusr.S 1.1 0644)
@@ -33,6 +33,12 @@
 #define ASI_BLK_XOR	0
 #define ASI_BLK_XOR1	(ASI_BLK_P ^ (ASI_BLK_P >> 3) ^ ASI_P)
 #define ASI_BLK_OR	(ASI_BLK_P & ~ASI_P)
+
+#include <linux/config.h>
+#ifdef 		CONFIG_KBUILD_2_5
+#include "asm-offsets.h"
+#endif		/* CONFIG_KBUILD_2_5 */
+
 #else
 #define ASI_P		0x80
 #define ASI_BLK_P	0xf0
diff -Nur kbuild-2.5/arch/sparc64/lib/VISsave.S kbuild-2.5/arch/sparc64/lib/VISsave.S
--- kbuild-2.5/arch/sparc64/lib/VISsave.S Fri May 31 15:49:51 2002
+++ kbuild-2.5/arch/sparc64/lib/VISsave.S Fri May 31 15:49:51 2002 +0000 thunder (thunder-2.5/arch/sparc64/lib/VISsave.S 1.1 0644)
@@ -12,6 +12,11 @@
 #include <asm/visasm.h>
 #include <asm/thread_info.h>
 
+#include <linux/config.h>	/* Remove this line after kbuild 2.5 is in */
+#ifdef CONFIG_KBUILD_2_5	/* Remove this line after kbuild 2.5 is in */
+#include "asm-offsets.h"	/* This is all that is required for kbuild 2.5 */
+#endif				/* Remove this line after kbuild 2.5 is in */
+
 	.text
 	.globl		VISenter, VISenterhalf
 
diff -Nur kbuild-2.5/arch/sparc64/solaris/entry64.S kbuild-2.5/arch/sparc64/solaris/entry64.S
--- kbuild-2.5/arch/sparc64/solaris/entry64.S Fri May 31 15:49:52 2002
+++ kbuild-2.5/arch/sparc64/solaris/entry64.S Fri May 31 15:49:52 2002 +0000 thunder (thunder-2.5/arch/sparc64/solaris/entry64.S 1.1 0644)
@@ -17,6 +17,11 @@
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 
+#include <linux/config.h>	/* Remove this line after kbuild 2.5 is in */
+#ifdef CONFIG_KBUILD_2_5	/* Remove this line after kbuild 2.5 is in */
+#include "asm-offsets.h"	/* This is all that is required for kbuild 2.5 */
+#endif				/* Remove this line after kbuild 2.5 is in */
+
 #include "conv.h"
 
 #define NR_SYSCALLS	256
diff -Nur kbuild-2.5/arch/sparc64/vmlinux.lds.S kbuild-2.5/arch/sparc64/vmlinux.lds.S
--- kbuild-2.5/arch/sparc64/vmlinux.lds.S Fri May 31 15:49:52 2002
+++ kbuild-2.5/arch/sparc64/vmlinux.lds.S Fri May 31 15:49:52 2002 +0000 thunder (thunder-2.5/arch/sparc64/vmlinux.lds.S 1.1 0644)
@@ -0,0 +1,92 @@
+/* ld script to make UltraLinux kernel */
+OUTPUT_FORMAT("elf64-sparc", "elf64-sparc", "elf64-sparc")
+OUTPUT_ARCH(sparc:v9a)
+ENTRY(_start)
+
+SECTIONS
+{
+  swapper_pmd_dir = 0x0000000000402000;
+  empty_pg_dir = 0x0000000000403000;
+  . = 0x4000;
+  .text 0x0000000000404000 :
+  {
+    *(.text)
+    *(.gnu.warning)
+  } =0
+  _etext = .;
+  PROVIDE (etext = .);
+  .rodata    : { *(.rodata) *(.rodata.*) }
+  .rodata1   : { *(.rodata1) }
+  .data    :
+  {
+    *(.data)
+    CONSTRUCTORS
+  }
+  .data1   : { *(.data1) }
+  _edata  =  .;
+  PROVIDE (edata = .);
+  .fixup   : { *(.fixup) }
+  . = ALIGN(16);
+  __start___ex_table = .;
+  __ex_table : { *(__ex_table) }
+  __stop___ex_table = .;
+  __start___ksymtab = .;
+  __ksymtab  : { *(__ksymtab) }
+  __stop___ksymtab = .;
+  __kstrtab  : { *(.kstrtab) }
+  __start___kallsyms = .;	/* All kernel symbols */
+  __kallsyms : { *(__kallsyms) }
+  __stop___kallsyms = .;
+  . = ALIGN(8192);
+  __init_begin = .;
+  .text.init : { *(.text.init) }
+  .data.init : { *(.data.init) }
+  . = ALIGN(16);
+  __setup_start = .;
+  .setup_init : { *(.setup.init) }
+  __setup_end = .;
+  __initcall_start = .;
+  .initcall.init : {
+	*(.initcall1.init) 
+	*(.initcall2.init) 
+	*(.initcall3.init) 
+	*(.initcall4.init) 
+	*(.initcall5.init) 
+	*(.initcall6.init) 
+	*(.initcall7.init)
+  }
+  __initcall_end = .;
+  . = ALIGN(32);
+  __per_cpu_start = .;
+  .data.percpu  : { *(.data.percpu) }
+  __per_cpu_end = .;
+  . = ALIGN(8192);
+  __init_end = .;
+  . = ALIGN(64);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+  __bss_start = .;
+  .sbss      : { *(.sbss) *(.scommon) }
+  .bss       :
+  {
+   *(.dynbss)
+   *(.bss)
+   *(COMMON)
+  }
+  _end = . ;
+  PROVIDE (end = .);
+  /* Stabs debugging sections.  */
+  .stab 0 : { *(.stab) }
+  .stabstr 0 : { *(.stabstr) }
+  .stab.excl 0 : { *(.stab.excl) }
+  .stab.exclstr 0 : { *(.stab.exclstr) }
+  .stab.index 0 : { *(.stab.index) }
+  .stab.indexstr 0 : { *(.stab.indexstr) }
+  .comment 0 : { *(.comment) }
+  .debug          0 : { *(.debug) }
+  .debug_srcinfo  0 : { *(.debug_srcinfo) }
+  .debug_aranges  0 : { *(.debug_aranges) }
+  .debug_pubnames 0 : { *(.debug_pubnames) }
+  .debug_sfnames  0 : { *(.debug_sfnames) }
+  .line           0 : { *(.line) }
+  /DISCARD/ : { *(.text.exit) *(.data.exit) *(.exitcall.exit) }
+}
diff -Nur kbuild-2.5/include/asm-sparc64/system.h kbuild-2.5/include/asm-sparc64/system.h
--- kbuild-2.5/include/asm-sparc64/system.h Fri May 31 15:49:52 2002
+++ kbuild-2.5/include/asm-sparc64/system.h Fri May 31 15:49:52 2002 +0000 thunder (thunder-2.5/include/asm-sparc64/system.h 1.1 0644)
@@ -2,6 +2,11 @@
 #ifndef __SPARC64_SYSTEM_H
 #define __SPARC64_SYSTEM_H
 
+#ifdef CONFIG_KBUILD_2_5
+#ifndef		KBUILD_SETUP
+#include "asm-offsets.h"
+#endif
+#endif  /* CONFIG_KBUILD_2_5 */
 #include <linux/config.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
diff -Nur kbuild-2.5/include/asm-sparc64/thread_info.h kbuild-2.5/include/asm-sparc64/thread_info.h
--- kbuild-2.5/include/asm-sparc64/thread_info.h Fri May 31 15:49:53 2002
+++ kbuild-2.5/include/asm-sparc64/thread_info.h Fri May 31 15:49:53 2002 +0000 thunder (thunder-2.5/include/asm-sparc64/thread_info.h 1.1 0644)
@@ -67,15 +67,18 @@
 
 #endif /* !(__ASSEMBLY__) */
 
+#ifndef CONFIG_KBUILD_2_5
 /* offsets into the thread_info struct for assembly code access */
 #define TI_TASK		0x00000000
 #define TI_FLAGS	0x00000008
+#endif /* CONFIG_KBUILD_2_5 */
 #define TI_FAULT_CODE	(TI_FLAGS + TI_FLAG_BYTE_FAULT_CODE)
 #define TI_WSTATE	(TI_FLAGS + TI_FLAG_BYTE_WSTATE)
 #define TI_CWP		(TI_FLAGS + TI_FLAG_BYTE_CWP)
 #define TI_CURRENT_DS	(TI_FLAGS + TI_FLAG_BYTE_CURRENT_DS)
 #define TI_FPDEPTH	(TI_FLAGS + TI_FLAG_BYTE_FPDEPTH)
 #define TI_WSAVED	(TI_FLAGS + TI_FLAG_BYTE_WSAVED)
+#ifndef CONFIG_KBUILD_2_5
 #define TI_CPU		0x00000010
 #define TI_FPSAVED	0x00000011
 #define TI_KSP		0x00000018
@@ -95,6 +98,7 @@
 #define TI_PCR		0x00000490
 #define TI_CEE_STUFF	0x00000498
 #define TI_FPREGS	0x000004c0
+#endif /* !CONFIG_KBUILD_2_5 */
 
 /* We embed this in the uppermost byte of thread_info->flags */
 #define FAULT_CODE_WRITE	0x01	/* Write access, implies D-TLB		*/

