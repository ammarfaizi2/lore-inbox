Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030476AbWBHDSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030476AbWBHDSj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWBHDSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:18:09 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:55424 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751136AbWBHDSH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:18:07 -0500
To: torvalds@osdl.org
Subject: [PATCH 03/29] drive_info removal outside of arch/i386
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6fqI-0006BU-Vl@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:18:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1135189486 -0500

drive_info is used only by hd.c and that happens under #ifdef __i386__.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/cris/kernel/setup.c                |    1 -
 arch/ia64/dig/setup.c                   |   10 ----------
 arch/ia64/sn/kernel/setup.c             |   14 --------------
 arch/m32r/kernel/m32r_ksyms.c           |    5 -----
 arch/m32r/kernel/setup.c                |    6 ------
 arch/powerpc/platforms/powermac/setup.c |    2 --
 arch/sh64/kernel/sh_ksyms.c             |    8 --------
 arch/x86_64/kernel/setup.c              |    2 --
 arch/x86_64/kernel/x8664_ksyms.c        |    5 -----
 9 files changed, 0 insertions(+), 53 deletions(-)

4fb7d9827e89cc0a4ad2fde32ffa08f77cc0b7fe
diff --git a/arch/cris/kernel/setup.c b/arch/cris/kernel/setup.c
index d11206e..1ba57ef 100644
--- a/arch/cris/kernel/setup.c
+++ b/arch/cris/kernel/setup.c
@@ -24,7 +24,6 @@
 /*
  * Setup options
  */
-struct drive_info_struct { char dummy[32]; } drive_info;
 struct screen_info screen_info;
 
 extern int root_mountflags;
diff --git a/arch/ia64/dig/setup.c b/arch/ia64/dig/setup.c
index d58003f..c9104bf 100644
--- a/arch/ia64/dig/setup.c
+++ b/arch/ia64/dig/setup.c
@@ -25,16 +25,6 @@
 #include <asm/machvec.h>
 #include <asm/system.h>
 
-/*
- * This is here so we can use the CMOS detection in ide-probe.c to
- * determine what drives are present.  In theory, we don't need this
- * as the auto-detection could be done via ide-probe.c:do_probe() but
- * in practice that would be much slower, which is painful when
- * running in the simulator.  Note that passing zeroes in DRIVE_INFO
- * is sufficient (the IDE driver will autodetect the drive geometry).
- */
-char drive_info[4*16];
-
 void __init
 dig_setup (char **cmdline_p)
 {
diff --git a/arch/ia64/sn/kernel/setup.c b/arch/ia64/sn/kernel/setup.c
index ee36bff..aac1ba3 100644
--- a/arch/ia64/sn/kernel/setup.c
+++ b/arch/ia64/sn/kernel/setup.c
@@ -125,20 +125,6 @@ struct screen_info sn_screen_info = {
 };
 
 /*
- * This is here so we can use the CMOS detection in ide-probe.c to
- * determine what drives are present.  In theory, we don't need this
- * as the auto-detection could be done via ide-probe.c:do_probe() but
- * in practice that would be much slower, which is painful when
- * running in the simulator.  Note that passing zeroes in DRIVE_INFO
- * is sufficient (the IDE driver will autodetect the drive geometry).
- */
-#ifdef CONFIG_IA64_GENERIC
-extern char drive_info[4 * 16];
-#else
-char drive_info[4 * 16];
-#endif
-
-/*
  * This routine can only be used during init, since
  * smp_boot_data is an init data structure.
  * We have to use smp_boot_data.cpu_phys_id to find
diff --git a/arch/m32r/kernel/m32r_ksyms.c b/arch/m32r/kernel/m32r_ksyms.c
index dbc8a39..be8b711 100644
--- a/arch/m32r/kernel/m32r_ksyms.c
+++ b/arch/m32r/kernel/m32r_ksyms.c
@@ -18,11 +18,6 @@
 #include <asm/irq.h>
 #include <asm/tlbflush.h>
 
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_HD) || defined(CONFIG_BLK_DEV_IDE_MODULE) || defined(CONFIG_BLK_DEV_HD_MODULE)
-extern struct drive_info_struct drive_info;
-EXPORT_SYMBOL(drive_info);
-#endif
-
 /* platform dependent support */
 EXPORT_SYMBOL(boot_cpu_data);
 EXPORT_SYMBOL(dump_fpu);
diff --git a/arch/m32r/kernel/setup.c b/arch/m32r/kernel/setup.c
index c2e4dcc..d742037 100644
--- a/arch/m32r/kernel/setup.c
+++ b/arch/m32r/kernel/setup.c
@@ -37,12 +37,6 @@
 extern void init_mmu(void);
 #endif
 
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_HD)	\
-	|| defined(CONFIG_BLK_DEV_IDE_MODULE)			\
-	|| defined(CONFIG_BLK_DEV_HD_MODULE)
-struct drive_info_struct { char dummy[32]; } drive_info;
-#endif
-
 extern char _end[];
 
 /*
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 89c4c36..1955462 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -82,8 +82,6 @@
 
 #undef SHOW_GATWICK_IRQS
 
-unsigned char drive_info;
-
 int ppc_override_l2cr = 0;
 int ppc_override_l2cr_value;
 int has_l2cache = 0;
diff --git a/arch/sh64/kernel/sh_ksyms.c b/arch/sh64/kernel/sh_ksyms.c
index 472b450..de29c45 100644
--- a/arch/sh64/kernel/sh_ksyms.c
+++ b/arch/sh64/kernel/sh_ksyms.c
@@ -31,14 +31,6 @@
 
 extern int dump_fpu(struct pt_regs *, elf_fpregset_t *);
 
-#if 0
-/* Not yet - there's no declaration of drive_info anywhere. */
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_HD) || defined(CONFIG_BLK_DEV_IDE_MODULE) || defined(CONFIG_BLK_DEV_HD_MODULE)
-extern struct drive_info_struct drive_info;
-EXPORT_SYMBOL(drive_info);
-#endif
-#endif
-
 /* platform dependent support */
 EXPORT_SYMBOL(dump_fpu);
 EXPORT_SYMBOL(iounmap);
diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
index 363db5a..9435ab7 100644
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -94,7 +94,6 @@ unsigned long saved_video_mode;
 /*
  * Setup options
  */
-struct drive_info_struct { char dummy[32]; } drive_info;
 struct screen_info screen_info;
 struct sys_desc_table_struct {
 	unsigned short length;
@@ -572,7 +571,6 @@ void __init setup_arch(char **cmdline_p)
 	unsigned long kernel_end;
 
  	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
- 	drive_info = DRIVE_INFO;
  	screen_info = SCREEN_INFO;
 	edid_info = EDID_INFO;
 	saved_video_mode = SAVED_VIDEO_MODE;
diff --git a/arch/x86_64/kernel/x8664_ksyms.c b/arch/x86_64/kernel/x8664_ksyms.c
index b614d54..3496abc 100644
--- a/arch/x86_64/kernel/x8664_ksyms.c
+++ b/arch/x86_64/kernel/x8664_ksyms.c
@@ -39,11 +39,6 @@ extern void __write_lock_failed(rwlock_t
 extern void __read_lock_failed(rwlock_t *rw);
 #endif
 
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_HD) || defined(CONFIG_BLK_DEV_IDE_MODULE) || defined(CONFIG_BLK_DEV_HD_MODULE)
-extern struct drive_info_struct drive_info;
-EXPORT_SYMBOL(drive_info);
-#endif
-
 /* platform dependent support */
 EXPORT_SYMBOL(boot_cpu_data);
 //EXPORT_SYMBOL(dump_fpu);
-- 
0.99.9.GIT

