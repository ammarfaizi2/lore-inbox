Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSHFWtb>; Tue, 6 Aug 2002 18:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316499AbSHFWta>; Tue, 6 Aug 2002 18:49:30 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:2052 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316465AbSHFWsb>; Tue, 6 Aug 2002 18:48:31 -0400
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] module cleanup (5/5)
Message-Id: <E17cDBN-0002vJ-00@scrub.xs4all.nl>
From: Roman Zippel <zippel@linux-m68k.org>
Date: Wed, 07 Aug 2002 00:52:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch removes the obsolete get_kernel_syms system call.

diff -ur linux-2.5/arch/alpha/kernel/entry.S linux-mod/arch/alpha/kernel/entry.S
--- linux-2.5/arch/alpha/kernel/entry.S	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/alpha/kernel/entry.S	Thu Aug  1 14:35:31 2002
@@ -1041,7 +1041,7 @@
 	.quad alpha_create_module
 	.quad sys_init_module
 	.quad sys_delete_module
-	.quad sys_get_kernel_syms
+	.quad sys_ni_syscall	/* get_kernel_syms */
 	.quad sys_syslog			/* 310 */
 	.quad sys_reboot
 	.quad sys_clone
diff -ur linux-2.5/arch/arm/kernel/calls.S linux-mod/arch/arm/kernel/calls.S
--- linux-2.5/arch/arm/kernel/calls.S	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/arm/kernel/calls.S	Thu Aug  1 14:35:31 2002
@@ -144,7 +144,7 @@
 		.long	sys_create_module
 		.long	sys_init_module
 		.long	sys_delete_module
-/* 130 */	.long	sys_get_kernel_syms
+/* 130 */	.long	sys_ni_syscall		/* get_kernel_syms */
 		.long	sys_quotactl
 		.long	sys_getpgid
 		.long	sys_fchdir
diff -ur linux-2.5/arch/cris/kernel/entry.S linux-mod/arch/cris/kernel/entry.S
--- linux-2.5/arch/cris/kernel/entry.S	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/cris/kernel/entry.S	Thu Aug  1 14:35:31 2002
@@ -919,7 +919,7 @@
 	.long sys_create_module
 	.long sys_init_module
 	.long sys_delete_module
-	.long sys_get_kernel_syms	/* 130 */
+	.long sys_ni_syscall	/* 130 */	/* get_kernel_syms */
 	.long sys_quotactl
 	.long sys_getpgid
 	.long sys_fchdir
diff -ur linux-2.5/arch/i386/kernel/entry.S linux-mod/arch/i386/kernel/entry.S
--- linux-2.5/arch/i386/kernel/entry.S	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/i386/kernel/entry.S	Thu Aug  1 14:35:31 2002
@@ -639,7 +639,7 @@
 	.long sys_create_module
 	.long sys_init_module
 	.long sys_delete_module
-	.long sys_get_kernel_syms	/* 130 */
+	.long sys_ni_syscall	/* 130 */	/* get_kernel_syms */
 	.long sys_quotactl
 	.long sys_getpgid
 	.long sys_fchdir
diff -ur linux-2.5/arch/ia64/kernel/entry.S linux-mod/arch/ia64/kernel/entry.S
--- linux-2.5/arch/ia64/kernel/entry.S	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/ia64/kernel/entry.S	Thu Aug  1 14:35:31 2002
@@ -1121,7 +1121,7 @@
 	data8 ia64_create_module
 	data8 sys_init_module
 	data8 sys_delete_module
-	data8 sys_get_kernel_syms		// 1135
+	data8 sys_ni_syscall			// 1135		/* was: get_kernel_syms */
 	data8 sys_query_module
 	data8 sys_quotactl
 	data8 sys_bdflush
diff -ur linux-2.5/arch/m68k/kernel/entry.S linux-mod/arch/m68k/kernel/entry.S
--- linux-2.5/arch/m68k/kernel/entry.S	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/m68k/kernel/entry.S	Thu Aug  1 14:35:31 2002
@@ -558,7 +558,7 @@
 	.long sys_create_module
 	.long sys_init_module
 	.long sys_delete_module
-	.long sys_get_kernel_syms	/* 130 */
+	.long sys_ni_syscall	/* 130 */		/* get_kernel_syms */
 	.long sys_quotactl
 	.long sys_getpgid
 	.long sys_fchdir
diff -ur linux-2.5/arch/mips/kernel/syscalls.h linux-mod/arch/mips/kernel/syscalls.h
--- linux-2.5/arch/mips/kernel/syscalls.h	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/mips/kernel/syscalls.h	Thu Aug  1 14:35:31 2002
@@ -144,7 +144,7 @@
 SYS(sys_create_module, 2)
 SYS(sys_init_module, 5)
 SYS(sys_delete_module, 1)
-SYS(sys_get_kernel_syms, 1)			/* 4130 */
+SYS(sys_ni_syscall, 0)	/* get_kernel_syms */	/* 4130 */
 SYS(sys_quotactl, 0)
 SYS(sys_getpgid, 1)
 SYS(sys_fchdir, 1)
diff -ur linux-2.5/arch/mips64/kernel/scall_64.S linux-mod/arch/mips64/kernel/scall_64.S
--- linux-2.5/arch/mips64/kernel/scall_64.S	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/mips64/kernel/scall_64.S	Thu Aug  1 14:35:31 2002
@@ -263,7 +263,7 @@
 	PTR	sys_create_module
 	PTR	sys_init_module
 	PTR	sys_delete_module
-	PTR	sys_get_kernel_syms 			/* 5130 */
+	PTR	sys_ni_syscall	 	/* get_kernel_syms */ /* 5130 */
 	PTR	sys_quotactl
 	PTR	sys_getpgid
 	PTR	sys_fchdir
diff -ur linux-2.5/arch/mips64/kernel/scall_o32.S linux-mod/arch/mips64/kernel/scall_o32.S
--- linux-2.5/arch/mips64/kernel/scall_o32.S	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/mips64/kernel/scall_o32.S	Thu Aug  1 14:35:31 2002
@@ -363,7 +363,7 @@
 	sys	sys_create_module 2
 	sys	sys_init_module	5
 	sys	sys_delete_module 1
-	sys	sys_get_kernel_syms 1			/* 4130 */
+	sys	sys_ni_syscall	0	/* get_kernel_syms */ /* 4130 */
 	sys	sys_quotactl	0
 	sys	sys_getpgid	1
 	sys	sys_fchdir	1
diff -ur linux-2.5/arch/parisc/kernel/syscall.S linux-mod/arch/parisc/kernel/syscall.S
--- linux-2.5/arch/parisc/kernel/syscall.S	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/parisc/kernel/syscall.S	Thu Aug  1 14:35:31 2002
@@ -459,8 +459,7 @@
 	 * if running under a 64 bit kernel */
 	ENTRY_SAME(init_module)
 	ENTRY_SAME(delete_module)
-	/* struct kernel_sym contains a long. Linus never heard of size_t? */
-	ENTRY_DIFF(get_kernel_syms)	/* 130 */
+	ENTRY_SAME(ni_syscall)	/* 130 */	/* get_kernel_syms */
 	ENTRY_SAME(quotactl)
 	ENTRY_SAME(getpgid)
 	ENTRY_SAME(fchdir)
diff -ur linux-2.5/arch/ppc/kernel/misc.S linux-mod/arch/ppc/kernel/misc.S
--- linux-2.5/arch/ppc/kernel/misc.S	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/ppc/kernel/misc.S	Thu Aug  1 14:35:31 2002
@@ -1202,7 +1202,7 @@
 	.long sys_create_module
 	.long sys_init_module
 	.long sys_delete_module
-	.long sys_get_kernel_syms	/* 130 */
+	.long sys_ni_syscall	/* 130 */	/* get_kernel_syms */
 	.long sys_quotactl
 	.long sys_getpgid
 	.long sys_fchdir
diff -ur linux-2.5/arch/ppc64/kernel/misc.S linux-mod/arch/ppc64/kernel/misc.S
--- linux-2.5/arch/ppc64/kernel/misc.S	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/ppc64/kernel/misc.S	Thu Aug  1 14:35:31 2002
@@ -634,7 +634,7 @@
 	.llong .sys32_create_module
 	.llong .sys32_init_module
 	.llong .sys32_delete_module
-	.llong .sys32_get_kernel_syms	/* 130 */
+	.llong .sys_ni_syscall	/* 130 */	/* get_kernel_syms */
 	.llong .sys_quotactl
 	.llong .sys32_getpgid
 	.llong .sys_fchdir
@@ -867,7 +867,7 @@
 	.llong .sys_create_module
 	.llong .sys_init_module
 	.llong .sys_delete_module
-	.llong .sys_get_kernel_syms	/* 130 */
+	.llong .sys_ni_syscall	/* 130 */	/* get_kernel_syms */
 	.llong .sys_quotactl
 	.llong .sys_getpgid
 	.llong .sys_fchdir
diff -ur linux-2.5/arch/ppc64/kernel/sys_ppc32.c linux-mod/arch/ppc64/kernel/sys_ppc32.c
--- linux-2.5/arch/ppc64/kernel/sys_ppc32.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/ppc64/kernel/sys_ppc32.c	Thu Aug  1 14:35:31 2002
@@ -1444,44 +1444,6 @@
 	return err;
 }
 
-
-
-struct kernel_sym32 {
-	u32 value;
-	char name[60];
-};
-		 
-extern asmlinkage long sys_get_kernel_syms(struct kernel_sym *table);
-
-asmlinkage long sys32_get_kernel_syms(struct kernel_sym32 *table)
-{
-	int len, i;
-	struct kernel_sym *tbl;
-	mm_segment_t old_fs;
-	
-	PPCDBG(PPCDBG_SYS32, "sys32_get_kernel_syms - entered - pid=%ld current=%lx comm=%s \n", current->pid, current, current->comm);
-
-	
-	len = sys_get_kernel_syms(NULL);
-	if (!table) return len;
-	tbl = kmalloc (len * sizeof (struct kernel_sym), GFP_KERNEL);
-	if (!tbl) return -ENOMEM;
-	old_fs = get_fs();
-	set_fs (KERNEL_DS);
-	sys_get_kernel_syms(tbl);
-	set_fs (old_fs);
-	for (i = 0; i < len; i++, table += sizeof (struct kernel_sym32)) {
-		if (put_user (tbl[i].value, &table->value) ||
-		    copy_to_user (table->name, tbl[i].name, 60))
-			break;
-	}
-	kfree (tbl);
-	
-	PPCDBG(PPCDBG_SYS32, "sys32_get_kernel_syms - exited - pid=%ld current=%lx comm=%s \n", current->pid, current, current->comm);
-
-	return i;
-}
-
 #else /* CONFIG_MODULES */
 
 asmlinkage unsigned long sys32_create_module(const char *name_user, size_t size)
@@ -1520,13 +1482,6 @@
 		return 0;
 
 	PPCDBG(PPCDBG_SYS32, "sys32_query_module - exited - pid=%ld current=%lx comm=%s\n", current->pid, current, current->comm);
-	return -ENOSYS;
-}
-
-asmlinkage long sys32_get_kernel_syms(struct kernel_sym *table)
-{
-	PPCDBG(PPCDBG_SYS32, "sys32_get_kernel_syms - running - pid=%ld, comm=%s\n", current->pid, current->comm);
-
 	return -ENOSYS;
 }
 
diff -ur linux-2.5/arch/s390/kernel/entry.S linux-mod/arch/s390/kernel/entry.S
--- linux-2.5/arch/s390/kernel/entry.S	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/s390/kernel/entry.S	Thu Aug  1 14:35:31 2002
@@ -470,7 +470,7 @@
         .long  sys_create_module
         .long  sys_init_module
         .long  sys_delete_module
-        .long  sys_get_kernel_syms       /* 130 */
+        .long  sys_ni_syscall            /* 130 */ /* get_kernel_syms */
         .long  sys_quotactl
         .long  sys_getpgid
         .long  sys_fchdir
diff -ur linux-2.5/arch/s390x/kernel/entry.S linux-mod/arch/s390x/kernel/entry.S
--- linux-2.5/arch/s390x/kernel/entry.S	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/s390x/kernel/entry.S	Thu Aug  1 14:35:31 2002
@@ -501,7 +501,7 @@
         .long  SYSCALL(sys_create_module,sys32_create_module_wrapper)
         .long  SYSCALL(sys_init_module,sys32_init_module_wrapper)
         .long  SYSCALL(sys_delete_module,sys32_delete_module_wrapper)
-        .long  SYSCALL(sys_get_kernel_syms,sys32_get_kernel_syms_wrapper) /* 130 */
+        .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* 130 */ /* get_kernel_syms */
         .long  SYSCALL(sys_quotactl,sys32_quotactl_wrapper)
         .long  SYSCALL(sys_getpgid,sys32_getpgid_wrapper)
         .long  SYSCALL(sys_fchdir,sys32_fchdir_wrapper)
diff -ur linux-2.5/arch/s390x/kernel/linux32.c linux-mod/arch/s390x/kernel/linux32.c
--- linux-2.5/arch/s390x/kernel/linux32.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/s390x/kernel/linux32.c	Thu Aug  1 14:35:31 2002
@@ -3459,36 +3459,6 @@
 	return err;
 }
 
-struct kernel_sym32 {
-	u32 value;
-	char name[60];
-};
-		 
-extern asmlinkage int sys_get_kernel_syms(struct kernel_sym *table);
-
-asmlinkage int sys32_get_kernel_syms(struct kernel_sym32 *table)
-{
-	int len, i;
-	struct kernel_sym *tbl;
-	mm_segment_t old_fs;
-	
-	len = sys_get_kernel_syms(NULL);
-	if (!table) return len;
-	tbl = kmalloc (len * sizeof (struct kernel_sym), GFP_KERNEL);
-	if (!tbl) return -ENOMEM;
-	old_fs = get_fs();
-	set_fs (KERNEL_DS);
-	sys_get_kernel_syms(tbl);
-	set_fs (old_fs);
-	for (i = 0; i < len; i++, table += sizeof (struct kernel_sym32)) {
-		if (put_user (tbl[i].value, &table->value) ||
-		    copy_to_user (table->name, tbl[i].name, 60))
-			break;
-	}
-	kfree (tbl);
-	return i;
-}
-
 #else /* CONFIG_MODULES */
 
 asmlinkage unsigned long
@@ -3518,12 +3488,6 @@
 	if (which == 0)
 		return 0;
 
-	return -ENOSYS;
-}
-
-asmlinkage int
-sys32_get_kernel_syms(struct kernel_sym *table)
-{
 	return -ENOSYS;
 }
 
diff -ur linux-2.5/arch/s390x/kernel/wrapper32.S linux-mod/arch/s390x/kernel/wrapper32.S
--- linux-2.5/arch/s390x/kernel/wrapper32.S	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/s390x/kernel/wrapper32.S	Thu Aug  1 14:35:31 2002
@@ -581,11 +581,6 @@
 	llgtr	%r2,%r2			# const char *
 	jg	sys32_delete_module	# branch to system call
 
-	.globl  sys32_get_kernel_syms_wrapper 
-sys32_get_kernel_syms_wrapper:
-	llgtr	%r2,%r2			# struct kernel_sym_emu31 *
-	jg	sys32_get_kernel_syms	# branch to system call
-
 	.globl  sys32_quotactl_wrapper 
 sys32_quotactl_wrapper:
 	lgfr	%r2,%r2			# int
diff -ur linux-2.5/arch/sh/kernel/entry.S linux-mod/arch/sh/kernel/entry.S
--- linux-2.5/arch/sh/kernel/entry.S	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/sh/kernel/entry.S	Thu Aug  1 14:35:31 2002
@@ -1103,7 +1103,7 @@
 	.long sys_create_module
 	.long sys_init_module
 	.long sys_delete_module
-	.long sys_get_kernel_syms	/* 130 */
+	.long sys_ni_syscall	/* 130 */ /* get_kernel_syms */
 	.long sys_quotactl
 	.long sys_getpgid
 	.long sys_fchdir
diff -ur linux-2.5/arch/sparc/kernel/systbls.S linux-mod/arch/sparc/kernel/systbls.S
--- linux-2.5/arch/sparc/kernel/systbls.S	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/sparc/kernel/systbls.S	Thu Aug  1 14:35:31 2002
@@ -62,7 +62,7 @@
 /*205*/	.long sys_readahead, sys_socketcall, sys_syslog, sys_nis_syscall, sys_nis_syscall
 /*210*/	.long sys_nis_syscall, sys_nis_syscall, sys_waitpid, sys_swapoff, sys_sysinfo
 /*215*/	.long sys_ipc, sys_sigreturn, sys_clone, sys_nis_syscall, sys_adjtimex
-/*220*/	.long sys_sigprocmask, sys_create_module, sys_delete_module, sys_get_kernel_syms, sys_getpgid
+/*220*/	.long sys_sigprocmask, sys_create_module, sys_delete_module, sys_nis_syscall, sys_getpgid
 /*225*/	.long sys_bdflush, sys_sysfs, sys_nis_syscall, sys_setfsuid16, sys_setfsgid16
 /*230*/	.long sys_select, sys_time, sys_nis_syscall, sys_stime, sys_nis_syscall
 					  /* "We are the Knights of the Forest of Ni!!" */
diff -ur linux-2.5/arch/sparc64/kernel/sys_sparc32.c linux-mod/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.5/arch/sparc64/kernel/sys_sparc32.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/sparc64/kernel/sys_sparc32.c	Thu Aug  1 14:35:31 2002
@@ -3322,36 +3322,6 @@
 	return err;
 }
 
-struct kernel_sym32 {
-	u32 value;
-	char name[60];
-};
-		 
-extern asmlinkage int sys_get_kernel_syms(struct kernel_sym *table);
-
-asmlinkage int sys32_get_kernel_syms(struct kernel_sym32 *table)
-{
-	int len, i;
-	struct kernel_sym *tbl;
-	mm_segment_t old_fs;
-	
-	len = sys_get_kernel_syms(NULL);
-	if (!table) return len;
-	tbl = kmalloc (len * sizeof (struct kernel_sym), GFP_KERNEL);
-	if (!tbl) return -ENOMEM;
-	old_fs = get_fs();
-	set_fs (KERNEL_DS);
-	sys_get_kernel_syms(tbl);
-	set_fs (old_fs);
-	for (i = 0; i < len; i++, table++) {
-		if (put_user (tbl[i].value, &table->value) ||
-		    copy_to_user (table->name, tbl[i].name, 60))
-			break;
-	}
-	kfree (tbl);
-	return i;
-}
-
 #else /* CONFIG_MODULES */
 
 asmlinkage unsigned long
@@ -3381,12 +3351,6 @@
 	if (which == 0)
 		return 0;
 
-	return -ENOSYS;
-}
-
-asmlinkage int
-sys32_get_kernel_syms(struct kernel_sym *table)
-{
 	return -ENOSYS;
 }
 
diff -ur linux-2.5/arch/sparc64/kernel/systbls.S linux-mod/arch/sparc64/kernel/systbls.S
--- linux-2.5/arch/sparc64/kernel/systbls.S	Thu Aug  1 16:43:07 2002
+++ linux-mod/arch/sparc64/kernel/systbls.S	Thu Aug  1 14:35:31 2002
@@ -63,7 +63,7 @@
 	.word sys32_readahead, sys32_socketcall, sys_syslog, sys_nis_syscall, sys_nis_syscall
 /*210*/	.word sys_nis_syscall, sys_nis_syscall, sys_waitpid, sys_swapoff, sys32_sysinfo
 	.word sys32_ipc, sys32_sigreturn, sys_clone, sys_nis_syscall, sys32_adjtimex
-/*220*/	.word sys32_sigprocmask, sys32_create_module, sys32_delete_module, sys32_get_kernel_syms, sys_getpgid
+/*220*/	.word sys32_sigprocmask, sys32_create_module, sys32_delete_module, sys_nis_syscall, sys_getpgid
 	.word sys32_bdflush, sys32_sysfs, sys_nis_syscall, sys32_setfsuid16, sys32_setfsgid16
 /*230*/	.word sys32_select, sys_time, sys_nis_syscall, sys_stime, sys_nis_syscall
 	.word sys_nis_syscall, sys_llseek, sys_mlock, sys_munlock, sys_mlockall
@@ -122,7 +122,7 @@
 	.word sys_readahead, sys_socketcall, sys_syslog, sys_nis_syscall, sys_nis_syscall
 /*210*/	.word sys_nis_syscall, sys_nis_syscall, sys_waitpid, sys_swapoff, sys_sysinfo
 	.word sys_ipc, sys_nis_syscall, sys_clone, sys_nis_syscall, sys_adjtimex
-/*220*/	.word sys_nis_syscall, sys_create_module, sys_delete_module, sys_get_kernel_syms, sys_getpgid
+/*220*/	.word sys_nis_syscall, sys_create_module, sys_delete_module, sys_nis_syscall, sys_getpgid
 	.word sys_bdflush, sys_sysfs, sys_nis_syscall, sys_setfsuid, sys_setfsgid
 /*230*/	.word sys_select, sys_nis_syscall, sys_nis_syscall, sys_stime, sys_nis_syscall
 	.word sys_nis_syscall, sys_llseek, sys_mlock, sys_munlock, sys_mlockall
diff -ur linux-2.5/include/linux/module.h linux-mod/include/linux/module.h
--- linux-2.5/include/linux/module.h	Thu Aug  1 16:43:07 2002
+++ linux-mod/include/linux/module.h	Thu Aug  1 14:41:01 2002
@@ -17,13 +17,6 @@
 /* Don't need to bring in all of uaccess.h just for this decl.  */
 struct exception_table_entry;
 
-/* Used by get_kernel_syms, which is obsolete.  */
-struct kernel_sym
-{
-	unsigned long value;
-	char name[60];		/* should have been 64-sizeof(long); oh well */
-};
-
 struct module_symbol
 {
 	unsigned long value;
diff -ur linux-2.5/kernel/module.c linux-mod/kernel/module.c
--- linux-2.5/kernel/module.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/kernel/module.c	Thu Aug  1 14:35:31 2002
@@ -944,68 +892,6 @@
 }
 
 /*
- * Copy the kernel symbol table to user space.  If the argument is
- * NULL, just return the size of the table.
- *
- * This call is obsolete.  New programs should use query_module+QM_SYMBOLS
- * which does not arbitrarily limit the length of symbols.
- */
-
-asmlinkage long
-sys_get_kernel_syms(struct kernel_sym *table)
-{
-	struct module *mod;
-	int i;
-	struct kernel_sym ksym;
-
-	lock_kernel();
-	for (mod = module_list, i = 0; mod; mod = mod->next) {
-		/* include the count for the module name! */
-		i += mod->nsyms + 1;
-	}
-
-	if (table == NULL)
-		goto out;
-
-	/* So that we don't give the user our stack content */
-	memset (&ksym, 0, sizeof (ksym));
-
-	for (mod = module_list, i = 0; mod; mod = mod->next) {
-		struct module_symbol *msym;
-		unsigned int j;
-
-		if (!MOD_CAN_QUERY(mod))
-			continue;
-
-		/* magic: write module info as a pseudo symbol */
-		ksym.value = (unsigned long)mod;
-		ksym.name[0] = '#';
-		strncpy(ksym.name+1, mod->name, sizeof(ksym.name)-1);
-		ksym.name[sizeof(ksym.name)-1] = '\0';
-
-		if (copy_to_user(table, &ksym, sizeof(ksym)) != 0)
-			goto out;
-		++i, ++table;
-
-		if (mod->nsyms == 0)
-			continue;
-
-		for (j = 0, msym = mod->syms; j < mod->nsyms; ++j, ++msym) {
-			ksym.value = msym->value;
-			strncpy(ksym.name, msym->name, sizeof(ksym.name));
-			ksym.name[sizeof(ksym.name)-1] = '\0';
-
-			if (copy_to_user(table, &ksym, sizeof(ksym)) != 0)
-				goto out;
-			++i, ++table;
-		}
-	}
-out:
-	unlock_kernel();
-	return i;
-}
-
-/*
  * Look for a module by name, ignoring modules marked for deletion.
  */
 
@@ -1251,12 +1137,6 @@
 	if (which == 0)
 		return 0;
 
-	return -ENOSYS;
-}
-
-asmlinkage long
-sys_get_kernel_syms(struct kernel_sym *table)
-{
 	return -ENOSYS;
 }
 
