Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWAXBSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWAXBSR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 20:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWAXBR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 20:17:57 -0500
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:39382 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030268AbWAXBRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 20:17:51 -0500
Date: Mon, 23 Jan 2006 20:16:23 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 6/9] ia32 syscalls: rename some x86_64 ia32 syscalls
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Jeff Dike <jdike@addtoit.com>
Message-ID: <200601232017_MC3-1-B683-9F3E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <200601231938_MC3-1-B687-7C42@compuserve.com>
In-Reply-To: <200601231938_MC3-1-B687-7C42@compuserve.com>

Shared ia32 syscall table 6/9:

Prepare for sharing x86_64 ia32 syscall table with i386
by renaming some syscalls to better match i386 names.

	quiet_ni_syscall -> sys32_ni_syscall
	sys32_mmap	 -> sys32_old_mmap
	sys32_pread	 -> sys32_pread64
	sys32_pwrite	 -> sys32_pwrite64

Signed-Off-By: Chuck Ebbert <76306.1226@compuserve.com>

---

 arch/x86_64/ia32/ia32entry.S |   54 +++++++++++++++++++++----------------------
 arch/x86_64/ia32/sys_ia32.c  |    6 ++--
 2 files changed, 30 insertions(+), 30 deletions(-)

--- 2.6.16-rc1-mm2.orig/arch/x86_64/ia32/ia32entry.S
+++ 2.6.16-rc1-mm2/arch/x86_64/ia32/ia32entry.S
@@ -322,7 +322,7 @@ ni_syscall:
 	movq %rax,%rdi
 	jmp  sys32_ni_syscall			
 
-quiet_ni_syscall:
+sys32_ni_syscall:
 	movq $-ENOSYS,%rax
 	ret
 	CFI_ENDPROC
@@ -390,7 +390,7 @@ ia32_sys_call_table:
 	.quad sys_mknod
 	.quad sys_chmod		/* 15 */
 	.quad sys_lchown16
-	.quad quiet_ni_syscall			/* old break syscall holder */
+	.quad sys32_ni_syscall			/* old break syscall holder */
 	.quad sys_stat
 	.quad sys32_lseek
 	.quad sys_getpid		/* 20 */
@@ -404,11 +404,11 @@ ia32_sys_call_table:
 	.quad sys_fstat	/* (old)fstat */
 	.quad sys_pause
 	.quad compat_sys_utime	/* 30 */
-	.quad quiet_ni_syscall	/* old stty syscall holder */
-	.quad quiet_ni_syscall	/* old gtty syscall holder */
+	.quad sys32_ni_syscall	/* old stty syscall holder */
+	.quad sys32_ni_syscall	/* old gtty syscall holder */
 	.quad sys_access
 	.quad sys_nice	
-	.quad quiet_ni_syscall	/* 35 */	/* old ftime syscall holder */
+	.quad sys32_ni_syscall	/* 35 */	/* old ftime syscall holder */
 	.quad sys_sync
 	.quad sys32_kill
 	.quad sys_rename
@@ -417,7 +417,7 @@ ia32_sys_call_table:
 	.quad sys_dup
 	.quad sys32_pipe
 	.quad compat_sys_times
-	.quad quiet_ni_syscall			/* old prof syscall holder */
+	.quad sys32_ni_syscall			/* old prof syscall holder */
 	.quad sys_brk		/* 45 */
 	.quad sys_setgid16
 	.quad sys_getgid16
@@ -426,12 +426,12 @@ ia32_sys_call_table:
 	.quad sys_getegid16	/* 50 */
 	.quad sys_acct
 	.quad sys_umount			/* new_umount */
-	.quad quiet_ni_syscall			/* old lock syscall holder */
+	.quad sys32_ni_syscall			/* old lock syscall holder */
 	.quad compat_sys_ioctl
 	.quad compat_sys_fcntl64		/* 55 */
-	.quad quiet_ni_syscall			/* old mpx syscall holder */
+	.quad sys32_ni_syscall			/* old mpx syscall holder */
 	.quad sys_setpgid
-	.quad quiet_ni_syscall			/* old ulimit syscall holder */
+	.quad sys32_ni_syscall			/* old ulimit syscall holder */
 	.quad sys32_olduname
 	.quad sys_umask		/* 60 */
 	.quad sys_chroot
@@ -462,12 +462,12 @@ ia32_sys_call_table:
 #ifdef CONFIG_IA32_AOUT
 	.quad sys_uselib
 #else
-	.quad quiet_ni_syscall
+	.quad sys32_ni_syscall
 #endif
 	.quad sys_swapon
 	.quad sys_reboot
 	.quad compat_sys_old_readdir
-	.quad sys32_mmap		/* 90 */
+	.quad sys32_old_mmap		/* 90 */
 	.quad sys_munmap
 	.quad sys_truncate
 	.quad sys_ftruncate
@@ -475,7 +475,7 @@ ia32_sys_call_table:
 	.quad sys_fchown16		/* 95 */
 	.quad sys_getpriority
 	.quad sys_setpriority
-	.quad quiet_ni_syscall			/* old profil syscall holder */
+	.quad sys32_ni_syscall			/* old profil syscall holder */
 	.quad compat_sys_statfs
 	.quad compat_sys_fstatfs		/* 100 */
 	.quad sys_ioperm
@@ -489,7 +489,7 @@ ia32_sys_call_table:
 	.quad sys32_uname
 	.quad stub32_iopl		/* 110 */
 	.quad sys_vhangup
-	.quad quiet_ni_syscall	/* old "idle" system call */
+	.quad sys32_ni_syscall	/* old "idle" system call */
 	.quad sys32_vm86_warning	/* vm86old */ 
 	.quad compat_sys_wait4
 	.quad sys_swapoff		/* 115 */
@@ -504,17 +504,17 @@ ia32_sys_call_table:
 	.quad sys32_adjtimex
 	.quad sys32_mprotect		/* 125 */
 	.quad compat_sys_sigprocmask
-	.quad quiet_ni_syscall		/* create_module */
+	.quad sys32_ni_syscall		/* create_module */
 	.quad sys_init_module
 	.quad sys_delete_module
-	.quad quiet_ni_syscall		/* 130  get_kernel_syms */
+	.quad sys32_ni_syscall		/* 130  get_kernel_syms */
 	.quad sys_quotactl
 	.quad sys_getpgid
 	.quad sys_fchdir
-	.quad quiet_ni_syscall	/* bdflush */
+	.quad sys32_ni_syscall	/* bdflush */
 	.quad sys_sysfs		/* 135 */
 	.quad sys_personality
-	.quad quiet_ni_syscall	/* for afs_syscall */
+	.quad sys32_ni_syscall	/* for afs_syscall */
 	.quad sys_setfsuid16
 	.quad sys_setfsgid16
 	.quad sys_llseek		/* 140 */
@@ -544,7 +544,7 @@ ia32_sys_call_table:
 	.quad sys_setresuid16
 	.quad sys_getresuid16	/* 165 */
 	.quad sys32_vm86_warning	/* vm86 */ 
-	.quad quiet_ni_syscall	/* query_module */
+	.quad sys32_ni_syscall	/* query_module */
 	.quad sys_poll
 	.quad compat_sys_nfsservctl
 	.quad sys_setresgid16	/* 170 */
@@ -557,16 +557,16 @@ ia32_sys_call_table:
 	.quad compat_sys_rt_sigtimedwait
 	.quad sys32_rt_sigqueueinfo
 	.quad stub32_rt_sigsuspend
-	.quad sys32_pread		/* 180 */
-	.quad sys32_pwrite
+	.quad sys32_pread64		/* 180 */
+	.quad sys32_pwrite64
 	.quad sys_chown16
 	.quad sys_getcwd
 	.quad sys_capget
 	.quad sys_capset
 	.quad stub32_sigaltstack
 	.quad sys32_sendfile
-	.quad quiet_ni_syscall		/* streams1 */
-	.quad quiet_ni_syscall		/* streams2 */
+	.quad sys32_ni_syscall		/* streams1 */
+	.quad sys32_ni_syscall		/* streams2 */
 	.quad stub32_vfork            /* 190 */
 	.quad compat_sys_getrlimit
 	.quad sys32_mmap2
@@ -599,8 +599,8 @@ ia32_sys_call_table:
 	.quad sys_madvise
 	.quad compat_sys_getdents64	/* 220 getdents64 */
 	.quad compat_sys_fcntl64	
-	.quad quiet_ni_syscall		/* tux */
-	.quad quiet_ni_syscall    	/* security */
+	.quad sys32_ni_syscall		/* tux */
+	.quad sys32_ni_syscall    	/* security */
 	.quad sys_gettid	
 	.quad sys_readahead	/* 225 */
 	.quad sys_setxattr
@@ -628,7 +628,7 @@ ia32_sys_call_table:
 	.quad compat_sys_io_submit
 	.quad sys_io_cancel
 	.quad sys_fadvise64		/* 250 */
-	.quad quiet_ni_syscall 	/* free_huge_pages */
+	.quad sys32_ni_syscall 	/* free_huge_pages */
 	.quad sys_exit_group
 	.quad sys32_lookup_dcookie
 	.quad sys_epoll_create
@@ -650,7 +650,7 @@ ia32_sys_call_table:
 	.quad sys_tgkill		/* 270 */
 	.quad compat_sys_utimes
 	.quad sys32_fadvise64_64
-	.quad quiet_ni_syscall	/* sys_vserver */
+	.quad sys32_ni_syscall	/* sys_vserver */
 	.quad sys_mbind
 	.quad compat_sys_get_mempolicy	/* 275 */
 	.quad sys_set_mempolicy
@@ -662,7 +662,7 @@ ia32_sys_call_table:
 	.quad compat_sys_mq_getsetattr
 	.quad compat_sys_kexec_load	/* reserved for kexec */
 	.quad compat_sys_waitid
-	.quad quiet_ni_syscall		/* 285: sys_altroot */
+	.quad sys32_ni_syscall		/* 285: sys_altroot */
 	.quad sys_add_key
 	.quad sys_request_key
 	.quad sys_keyctl
--- 2.6.16-rc1-mm2.orig/arch/x86_64/ia32/sys_ia32.c
+++ 2.6.16-rc1-mm2/arch/x86_64/ia32/sys_ia32.c
@@ -196,7 +196,7 @@ struct mmap_arg_struct {
 };
 
 asmlinkage long
-sys32_mmap(struct mmap_arg_struct __user *arg)
+sys32_old_mmap(struct mmap_arg_struct __user *arg)
 {
 	struct mmap_arg_struct a;
 	struct file *file = NULL;
@@ -710,14 +710,14 @@ sys32_sysctl(struct sysctl_ia32 __user *
 
 /* warning: next two assume little endian */ 
 asmlinkage long
-sys32_pread(unsigned int fd, char __user *ubuf, u32 count, u32 poslo, u32 poshi)
+sys32_pread64(unsigned int fd, char __user *ubuf, u32 count, u32 poslo, u32 poshi)
 {
 	return sys_pread64(fd, ubuf, count,
 			 ((loff_t)AA(poshi) << 32) | AA(poslo));
 }
 
 asmlinkage long
-sys32_pwrite(unsigned int fd, char __user *ubuf, u32 count, u32 poslo, u32 poshi)
+sys32_pwrite64(unsigned int fd, char __user *ubuf, u32 count, u32 poslo, u32 poshi)
 {
 	return sys_pwrite64(fd, ubuf, count,
 			  ((loff_t)AA(poshi) << 32) | AA(poslo));
-- 
Chuck
