Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbUKKRTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbUKKRTG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 12:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUKKRR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:17:58 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:65498 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262302AbUKKRPV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:15:21 -0500
Date: Thu, 11 Nov 2004 18:15:10 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 1/10] s390: core changes.
Message-ID: <20041111171510.GC4900@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/10] s390: core changes.

From: Stefan Bader <shbader@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>

s390 core changes:
 - Store correct set of registers to core dumps.
 - Fix make install with separate obj directory.
 - Regenerate default configuration.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/boot/Makefile         |    2 +-
 arch/s390/defconfig             |   27 ++++++++++++++++++++-------
 arch/s390/kernel/binfmt_elf32.c |   29 ++++++++++++++++++++++++++++-
 include/asm-s390/elf.h          |   11 +++++++++--
 4 files changed, 58 insertions(+), 11 deletions(-)

diff -urN linux-2.6/arch/s390/boot/Makefile linux-2.6-patched/arch/s390/boot/Makefile
--- linux-2.6/arch/s390/boot/Makefile	2004-10-18 23:55:36.000000000 +0200
+++ linux-2.6-patched/arch/s390/boot/Makefile	2004-11-11 15:06:53.000000000 +0100
@@ -14,5 +14,5 @@
 	$(call if_changed,objcopy)
 
 install: $(CONFIGURE) $(obj)/image
-	sh -x $(obj)/install.sh $(KERNELRELEASE) $(obj)/image \
+	sh -x  $(srctree)/$(obj)/install.sh $(KERNELRELEASE) $(obj)/image \
 	      System.map Kerntypes "$(INSTALL_PATH)"
diff -urN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2004-11-11 15:06:35.000000000 +0100
+++ linux-2.6-patched/arch/s390/defconfig	2004-11-11 15:06:53.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.9
-# Fri Oct 22 13:50:22 2004
+# Linux kernel version: 2.6.10-rc1
+# Thu Nov 11 12:54:21 2004
 #
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
@@ -13,6 +13,7 @@
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
+CONFIG_LOCK_KERNEL=y
 
 #
 # General setup
@@ -35,12 +36,12 @@
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
 
 #
@@ -177,6 +178,14 @@
 # CONFIG_DASD_CMB is not set
 
 #
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+
+#
 # Multi-device support (RAID and LVM)
 #
 CONFIG_MD=y
@@ -262,6 +271,8 @@
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+CONFIG_IP_TCPDIAG_IPV6=y
 CONFIG_IPV6=y
 # CONFIG_IPV6_PRIVACY is not set
 # CONFIG_INET6_AH is not set
@@ -289,7 +300,6 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -408,6 +418,7 @@
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 # CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 
@@ -516,6 +527,7 @@
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_INFO is not set
 
 #
@@ -548,6 +560,7 @@
 # CONFIG_CRYPTO_TEA is not set
 # CONFIG_CRYPTO_ARC4 is not set
 # CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_ANUBIS is not set
 # CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
diff -urN linux-2.6/arch/s390/kernel/binfmt_elf32.c linux-2.6-patched/arch/s390/kernel/binfmt_elf32.c
--- linux-2.6/arch/s390/kernel/binfmt_elf32.c	2004-10-18 23:55:07.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/binfmt_elf32.c	2004-11-11 15:06:53.000000000 +0100
@@ -56,6 +56,9 @@
 
 #define ELF_CORE_COPY_REGS(pr_reg, regs) dump_regs32(regs, &pr_reg);
 
+#define ELF_CORE_COPY_TASK_REGS(tsk, regs) dump_task_regs32(tsk, regs)
+
+#define ELF_CORE_COPY_FPREGS(tsk, fpregs) dump_task_fpu(tsk, fpregs)
 
 /* This yields a mask that user programs can use to figure out what
    instruction set this CPU supports. */
@@ -99,13 +102,37 @@
 	int i;
 
 	memcpy(&regs->psw.mask, &ptregs->psw.mask, 4);
-	memcpy(&regs->psw.addr, &ptregs->psw.addr, 4);
+	memcpy(&regs->psw.addr, (char *)&ptregs->psw.addr + 4, 4);
 	for (i = 0; i < NUM_GPRS; i++)
 		regs->gprs[i] = ptregs->gprs[i];
+	save_access_regs(regs->acrs);
 	regs->orig_gpr2 = ptregs->orig_gpr2;
 	return 1;
 }
 
+static inline int dump_task_regs32(struct task_struct *tsk, elf_gregset_t *regs)
+{
+	struct pt_regs *ptregs = __KSTK_PTREGS(tsk);
+	int i;
+
+	memcpy(&regs->psw.mask, &ptregs->psw.mask, 4);
+	memcpy(&regs->psw.addr, (char *)&ptregs->psw.addr + 4, 4);
+	for (i = 0; i < NUM_GPRS; i++)
+		regs->gprs[i] = ptregs->gprs[i];
+	memcpy(regs->acrs, tsk->thread.acrs, sizeof(regs->acrs));
+	regs->orig_gpr2 = ptregs->orig_gpr2;
+	return 1;
+}
+
+static inline int dump_task_fpu(struct task_struct *tsk, elf_fpregset_t *fpregs)
+{
+	if (tsk == current)
+		save_fp_regs((s390_fp_regs *) fpregs);
+	else
+		memcpy(fpregs, &tsk->thread.fp_regs, sizeof(elf_fpregset_t));
+	return 1;
+}
+
 #include <asm/processor.h>
 #include <linux/module.h>
 #include <linux/config.h>
diff -urN linux-2.6/include/asm-s390/elf.h linux-2.6-patched/include/asm-s390/elf.h
--- linux-2.6/include/asm-s390/elf.h	2004-10-18 23:55:07.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/elf.h	2004-11-11 15:06:53.000000000 +0100
@@ -98,6 +98,7 @@
 
 #include <asm/ptrace.h>
 #include <asm/user.h>
+#include <asm/system.h>		/* for save_access_regs */
 
 
 typedef s390_fp_regs elf_fpregset_t;
@@ -152,6 +153,7 @@
 static inline int dump_regs(struct pt_regs *ptregs, elf_gregset_t *regs)
 {
 	memcpy(&regs->psw, &ptregs->psw, sizeof(regs->psw)+sizeof(regs->gprs));
+	save_access_regs(regs->acrs);
 	regs->orig_gpr2 = ptregs->orig_gpr2;
 	return 1;
 }
@@ -160,8 +162,10 @@
 
 static inline int dump_task_regs(struct task_struct *tsk, elf_gregset_t *regs)
 {
-	dump_regs(__KSTK_PTREGS(tsk), regs);
+	struct pt_regs *ptregs = __KSTK_PTREGS(tsk);
+	memcpy(&regs->psw, &ptregs->psw, sizeof(regs->psw)+sizeof(regs->gprs));
 	memcpy(regs->acrs, tsk->thread.acrs, sizeof(regs->acrs));
+	regs->orig_gpr2 = ptregs->orig_gpr2;
 	return 1;
 }
 
@@ -169,7 +173,10 @@
 
 static inline int dump_task_fpu(struct task_struct *tsk, elf_fpregset_t *fpregs)
 {
-	memcpy(fpregs, &tsk->thread.fp_regs, sizeof(elf_fpregset_t));
+	if (tsk == current)
+		save_fp_regs(fpregs);
+	else
+		memcpy(fpregs, &tsk->thread.fp_regs, sizeof(elf_fpregset_t));
 	return 1;
 }
 
