Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314676AbSD1Ec5>; Sun, 28 Apr 2002 00:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314677AbSD1Ec4>; Sun, 28 Apr 2002 00:32:56 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:9715 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S314676AbSD1Ecr>; Sun, 28 Apr 2002 00:32:47 -0400
Message-ID: <3CCB7ACE.7060403@didntduck.org>
Date: Sun, 28 Apr 2002 00:30:06 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Dave Jones <davej@suse.de>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Removing SYMBOL_NAME part 5
Content-Type: multipart/mixed;
 boundary="------------050403050708060502080205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050403050708060502080205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

ARM arch

-- 

						Brian Gerst

--------------050403050708060502080205
Content-Type: text/plain;
 name="symbol_name-5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="symbol_name-5"

diff -urN linux-sn4/arch/arm/boot/compressed/head-shark.S linux/arch/arm/boot/compressed/head-shark.S
--- linux-sn4/arch/arm/boot/compressed/head-shark.S	Mon Apr 22 19:17:22 2002
+++ linux/arch/arm/boot/compressed/head-shark.S	Sat Apr 27 23:19:54 2002
@@ -38,7 +38,7 @@
 		adr	r1, __ofw_data
 		add	r2, r1, #4
 		mov	lr, pc
-		b	SYMBOL_NAME(ofw_init)
+		b	ofw_init
 		mov	r1, #0
 
 		adr	r2, __mmu_off			@ calculate physical address
@@ -109,7 +109,7 @@
 		add	sp, sp, #128
 		adr	r0, __ofw_data
 		mov	lr, pc
-		b	SYMBOL_NAME(create_params)
+		b	create_params
 	
 		mov	r8, #0
 		mov	r7, #15
diff -urN linux-sn4/arch/arm/boot/compressed/head.S linux/arch/arm/boot/compressed/head.S
--- linux-sn4/arch/arm/boot/compressed/head.S	Mon Apr 22 19:17:22 2002
+++ linux/arch/arm/boot/compressed/head.S	Sat Apr 27 23:23:43 2002
@@ -185,7 +185,7 @@
 		mov	r5, r2			@ decompress after malloc space
 		mov	r0, r5
 		mov	r3, r7
-		bl	SYMBOL_NAME(decompress_kernel)
+		bl	decompress_kernel
 
 		add	r0, r0, #127
 		bic	r0, r0, #127		@ align the kernel length
@@ -219,7 +219,7 @@
  */
 wont_overwrite:	mov	r0, r4
 		mov	r3, r7
-		bl	SYMBOL_NAME(decompress_kernel)
+		bl	decompress_kernel
 		b	call_kernel
 
 		.type	LC0, #object
diff -urN linux-sn4/arch/arm/boot/compressed/ll_char_wr.S linux/arch/arm/boot/compressed/ll_char_wr.S
--- linux-sn4/arch/arm/boot/compressed/ll_char_wr.S	Thu Mar  7 21:18:19 2002
+++ linux/arch/arm/boot/compressed/ll_char_wr.S	Sat Apr 27 23:19:54 2002
@@ -27,10 +27,10 @@
 #define FLASH           0x08
 #define INVERSE         0x10
 
-LC0:		.word	SYMBOL_NAME(bytes_per_char_h)
-		.word	SYMBOL_NAME(video_size_row)
-		.word	SYMBOL_NAME(acorndata_8x8)
-		.word	SYMBOL_NAME(con_charconvtable)
+LC0:		.word	bytes_per_char_h
+		.word	video_size_row
+		.word	acorndata_8x8
+		.word	con_charconvtable
 
 ENTRY(ll_write_char)
 		stmfd	sp!, {r4 - r7, lr}
diff -urN linux-sn4/arch/arm/kernel/calls.S linux/arch/arm/kernel/calls.S
--- linux-sn4/arch/arm/kernel/calls.S	Thu Mar  7 21:18:32 2002
+++ linux/arch/arm/kernel/calls.S	Sat Apr 27 23:19:54 2002
@@ -14,248 +14,248 @@
 #else
 
 __syscall_start:
-/* 0 */		.long	SYMBOL_NAME(sys_ni_syscall)
-		.long	SYMBOL_NAME(sys_exit)
-		.long	SYMBOL_NAME(sys_fork_wrapper)
-		.long	SYMBOL_NAME(sys_read)
-		.long	SYMBOL_NAME(sys_write)
-/* 5 */		.long	SYMBOL_NAME(sys_open)
-		.long	SYMBOL_NAME(sys_close)
-		.long	SYMBOL_NAME(sys_ni_syscall)		/* was sys_waitpid */
-		.long	SYMBOL_NAME(sys_creat)
-		.long	SYMBOL_NAME(sys_link)
-/* 10 */	.long	SYMBOL_NAME(sys_unlink)
-		.long	SYMBOL_NAME(sys_execve_wrapper)
-		.long	SYMBOL_NAME(sys_chdir)
-		.long	SYMBOL_NAME(sys_time)			/* used by libc4 */
-		.long	SYMBOL_NAME(sys_mknod)
-/* 15 */	.long	SYMBOL_NAME(sys_chmod)
-		.long	SYMBOL_NAME(sys_lchown16)
-		.long	SYMBOL_NAME(sys_ni_syscall)		/* was sys_break */
-		.long	SYMBOL_NAME(sys_ni_syscall)		/* was sys_stat */
-		.long	SYMBOL_NAME(sys_lseek)
-/* 20 */	.long	SYMBOL_NAME(sys_getpid)
-		.long	SYMBOL_NAME(sys_mount)
-		.long	SYMBOL_NAME(sys_oldumount)		/* used by libc4 */
-		.long	SYMBOL_NAME(sys_setuid16)
-		.long	SYMBOL_NAME(sys_getuid16)
-/* 25 */	.long	SYMBOL_NAME(sys_stime)
-		.long	SYMBOL_NAME(sys_ptrace)
-		.long	SYMBOL_NAME(sys_alarm)			/* used by libc4 */
-		.long	SYMBOL_NAME(sys_ni_syscall)		/* was sys_fstat */
-		.long	SYMBOL_NAME(sys_pause)
-/* 30 */	.long	SYMBOL_NAME(sys_utime)			/* used by libc4 */
-		.long	SYMBOL_NAME(sys_ni_syscall)		/* was sys_stty */
-		.long	SYMBOL_NAME(sys_ni_syscall)		/* was sys_getty */
-		.long	SYMBOL_NAME(sys_access)
-		.long	SYMBOL_NAME(sys_nice)
-/* 35 */	.long	SYMBOL_NAME(sys_ni_syscall)		/* was sys_ftime */
-		.long	SYMBOL_NAME(sys_sync)
-		.long	SYMBOL_NAME(sys_kill)
-		.long	SYMBOL_NAME(sys_rename)
-		.long	SYMBOL_NAME(sys_mkdir)
-/* 40 */	.long	SYMBOL_NAME(sys_rmdir)
-		.long	SYMBOL_NAME(sys_dup)
-		.long	SYMBOL_NAME(sys_pipe)
-		.long	SYMBOL_NAME(sys_times)
-		.long	SYMBOL_NAME(sys_ni_syscall)		/* was sys_prof */
-/* 45 */	.long	SYMBOL_NAME(sys_brk)
-		.long	SYMBOL_NAME(sys_setgid16)
-		.long	SYMBOL_NAME(sys_getgid16)
-		.long	SYMBOL_NAME(sys_ni_syscall)		/* was sys_signal */
-		.long	SYMBOL_NAME(sys_geteuid16)
-/* 50 */	.long	SYMBOL_NAME(sys_getegid16)
-		.long	SYMBOL_NAME(sys_acct)
-		.long	SYMBOL_NAME(sys_umount)
-		.long	SYMBOL_NAME(sys_ni_syscall)		/* was sys_lock */
-		.long	SYMBOL_NAME(sys_ioctl)
-/* 55 */	.long	SYMBOL_NAME(sys_fcntl)
-		.long	SYMBOL_NAME(sys_ni_syscall)		/* was sys_mpx */
-		.long	SYMBOL_NAME(sys_setpgid)
-		.long	SYMBOL_NAME(sys_ni_syscall)		/* was sys_ulimit */
-		.long	SYMBOL_NAME(sys_ni_syscall)		/* was sys_olduname */
-/* 60 */	.long	SYMBOL_NAME(sys_umask)
-		.long	SYMBOL_NAME(sys_chroot)
-		.long	SYMBOL_NAME(sys_ustat)
-		.long	SYMBOL_NAME(sys_dup2)
-		.long	SYMBOL_NAME(sys_getppid)
-/* 65 */	.long	SYMBOL_NAME(sys_getpgrp)
-		.long	SYMBOL_NAME(sys_setsid)
-		.long	SYMBOL_NAME(sys_sigaction)
-		.long	SYMBOL_NAME(sys_ni_syscall)		/* was sys_sgetmask */
-		.long	SYMBOL_NAME(sys_ni_syscall)		/* was sys_ssetmask */
-/* 70 */	.long	SYMBOL_NAME(sys_setreuid16)
-		.long	SYMBOL_NAME(sys_setregid16)
-		.long	SYMBOL_NAME(sys_sigsuspend_wrapper)
-		.long	SYMBOL_NAME(sys_sigpending)
-		.long	SYMBOL_NAME(sys_sethostname)
-/* 75 */	.long	SYMBOL_NAME(sys_setrlimit)
-		.long	SYMBOL_NAME(sys_old_getrlimit)		/* used by libc4 */
-		.long	SYMBOL_NAME(sys_getrusage)
-		.long	SYMBOL_NAME(sys_gettimeofday)
-		.long	SYMBOL_NAME(sys_settimeofday)
-/* 80 */	.long	SYMBOL_NAME(sys_getgroups16)
-		.long	SYMBOL_NAME(sys_setgroups16)
-		.long	SYMBOL_NAME(old_select)			/* used by libc4 */
-		.long	SYMBOL_NAME(sys_symlink)
-		.long	SYMBOL_NAME(sys_ni_syscall)		/* was sys_lstat */
-/* 85 */	.long	SYMBOL_NAME(sys_readlink)
-		.long	SYMBOL_NAME(sys_uselib)
-		.long	SYMBOL_NAME(sys_swapon)
-		.long	SYMBOL_NAME(sys_reboot)
-		.long	SYMBOL_NAME(old_readdir)		/* used by libc4 */
-/* 90 */	.long	SYMBOL_NAME(old_mmap)			/* used by libc4 */
-		.long	SYMBOL_NAME(sys_munmap)
-		.long	SYMBOL_NAME(sys_truncate)
-		.long	SYMBOL_NAME(sys_ftruncate)
-		.long	SYMBOL_NAME(sys_fchmod)
-/* 95 */	.long	SYMBOL_NAME(sys_fchown16)
-		.long	SYMBOL_NAME(sys_getpriority)
-		.long	SYMBOL_NAME(sys_setpriority)
-		.long	SYMBOL_NAME(sys_ni_syscall)		/* was sys_profil */
-		.long	SYMBOL_NAME(sys_statfs)
-/* 100 */	.long	SYMBOL_NAME(sys_fstatfs)
-		.long	SYMBOL_NAME(sys_ni_syscall)
-		.long	SYMBOL_NAME(sys_socketcall)
-		.long	SYMBOL_NAME(sys_syslog)
-		.long	SYMBOL_NAME(sys_setitimer)
-/* 105 */	.long	SYMBOL_NAME(sys_getitimer)
-		.long	SYMBOL_NAME(sys_newstat)
-		.long	SYMBOL_NAME(sys_newlstat)
-		.long	SYMBOL_NAME(sys_newfstat)
-		.long	SYMBOL_NAME(sys_ni_syscall)		/* was sys_uname */
-/* 110 */	.long	SYMBOL_NAME(sys_ni_syscall)		/* was sys_iopl */
-		.long	SYMBOL_NAME(sys_vhangup)
-		.long	SYMBOL_NAME(sys_ni_syscall)
-		.long	SYMBOL_NAME(sys_syscall)		/* call a syscall */
-		.long	SYMBOL_NAME(sys_wait4)
-/* 115 */	.long	SYMBOL_NAME(sys_swapoff)
-		.long	SYMBOL_NAME(sys_sysinfo)
-		.long	SYMBOL_NAME(sys_ipc)
-		.long	SYMBOL_NAME(sys_fsync)
-		.long	SYMBOL_NAME(sys_sigreturn_wrapper)
-/* 120 */	.long	SYMBOL_NAME(sys_clone_wapper)
-		.long	SYMBOL_NAME(sys_setdomainname)
-		.long	SYMBOL_NAME(sys_newuname)
-		.long	SYMBOL_NAME(sys_ni_syscall)
-		.long	SYMBOL_NAME(sys_adjtimex)
-/* 125 */	.long	SYMBOL_NAME(sys_mprotect)
-		.long	SYMBOL_NAME(sys_sigprocmask)
-		.long	SYMBOL_NAME(sys_create_module)
-		.long	SYMBOL_NAME(sys_init_module)
-		.long	SYMBOL_NAME(sys_delete_module)
-/* 130 */	.long	SYMBOL_NAME(sys_get_kernel_syms)
-		.long	SYMBOL_NAME(sys_quotactl)
-		.long	SYMBOL_NAME(sys_getpgid)
-		.long	SYMBOL_NAME(sys_fchdir)
-		.long	SYMBOL_NAME(sys_bdflush)
-/* 135 */	.long	SYMBOL_NAME(sys_sysfs)
-		.long	SYMBOL_NAME(sys_personality)
-		.long	SYMBOL_NAME(sys_ni_syscall)		/* .long	_sys_afs_syscall */
-		.long	SYMBOL_NAME(sys_setfsuid16)
-		.long	SYMBOL_NAME(sys_setfsgid16)
-/* 140 */	.long	SYMBOL_NAME(sys_llseek)
-		.long	SYMBOL_NAME(sys_getdents)
-		.long	SYMBOL_NAME(sys_select)
-		.long	SYMBOL_NAME(sys_flock)
-		.long	SYMBOL_NAME(sys_msync)
-/* 145 */	.long	SYMBOL_NAME(sys_readv)
-		.long	SYMBOL_NAME(sys_writev)
-		.long	SYMBOL_NAME(sys_getsid)
-		.long	SYMBOL_NAME(sys_fdatasync)
-		.long	SYMBOL_NAME(sys_sysctl)
-/* 150 */	.long	SYMBOL_NAME(sys_mlock)
-		.long	SYMBOL_NAME(sys_munlock)
-		.long	SYMBOL_NAME(sys_mlockall)
-		.long	SYMBOL_NAME(sys_munlockall)
-		.long	SYMBOL_NAME(sys_sched_setparam)
-/* 155 */	.long	SYMBOL_NAME(sys_sched_getparam)
-		.long	SYMBOL_NAME(sys_sched_setscheduler)
-		.long	SYMBOL_NAME(sys_sched_getscheduler)
-		.long	SYMBOL_NAME(sys_sched_yield)
-		.long	SYMBOL_NAME(sys_sched_get_priority_max)
-/* 160 */	.long	SYMBOL_NAME(sys_sched_get_priority_min)
-		.long	SYMBOL_NAME(sys_sched_rr_get_interval)
-		.long	SYMBOL_NAME(sys_nanosleep)
-		.long	SYMBOL_NAME(sys_arm_mremap)
-		.long	SYMBOL_NAME(sys_setresuid16)
-/* 165 */	.long	SYMBOL_NAME(sys_getresuid16)
-		.long	SYMBOL_NAME(sys_ni_syscall)
-		.long	SYMBOL_NAME(sys_query_module)
-		.long	SYMBOL_NAME(sys_poll)
-		.long	SYMBOL_NAME(sys_nfsservctl)
-/* 170 */	.long	SYMBOL_NAME(sys_setresgid16)
-		.long	SYMBOL_NAME(sys_getresgid16)
-		.long	SYMBOL_NAME(sys_prctl)
-		.long	SYMBOL_NAME(sys_rt_sigreturn_wrapper)
-		.long	SYMBOL_NAME(sys_rt_sigaction)
-/* 175 */	.long	SYMBOL_NAME(sys_rt_sigprocmask)
-		.long	SYMBOL_NAME(sys_rt_sigpending)
-		.long	SYMBOL_NAME(sys_rt_sigtimedwait)
-		.long	SYMBOL_NAME(sys_rt_sigqueueinfo)
-		.long	SYMBOL_NAME(sys_rt_sigsuspend_wrapper)
-/* 180 */	.long	SYMBOL_NAME(sys_pread)
-		.long	SYMBOL_NAME(sys_pwrite)
-		.long	SYMBOL_NAME(sys_chown16)
-		.long	SYMBOL_NAME(sys_getcwd)
-		.long	SYMBOL_NAME(sys_capget)
-/* 185 */	.long	SYMBOL_NAME(sys_capset)
-		.long	SYMBOL_NAME(sys_sigaltstack_wrapper)
-		.long	SYMBOL_NAME(sys_sendfile)
-		.long	SYMBOL_NAME(sys_ni_syscall)
-		.long	SYMBOL_NAME(sys_ni_syscall)
-/* 190 */	.long	SYMBOL_NAME(sys_vfork_wrapper)
-		.long	SYMBOL_NAME(sys_getrlimit)
-		.long	SYMBOL_NAME(sys_mmap2)
-		.long	SYMBOL_NAME(sys_truncate64)
-		.long	SYMBOL_NAME(sys_ftruncate64)
-/* 195 */	.long	SYMBOL_NAME(sys_stat64)
-		.long	SYMBOL_NAME(sys_lstat64)
-		.long	SYMBOL_NAME(sys_fstat64)
-		.long	SYMBOL_NAME(sys_lchown)
-		.long	SYMBOL_NAME(sys_getuid)
-/* 200 */	.long	SYMBOL_NAME(sys_getgid)
-		.long	SYMBOL_NAME(sys_geteuid)
-		.long	SYMBOL_NAME(sys_getegid)
-		.long	SYMBOL_NAME(sys_setreuid)
-		.long	SYMBOL_NAME(sys_setregid)
-/* 205 */	.long	SYMBOL_NAME(sys_getgroups)
-		.long	SYMBOL_NAME(sys_setgroups)
-		.long	SYMBOL_NAME(sys_fchown)
-		.long	SYMBOL_NAME(sys_setresuid)
-		.long	SYMBOL_NAME(sys_getresuid)
-/* 210 */	.long	SYMBOL_NAME(sys_setresgid)
-		.long	SYMBOL_NAME(sys_getresgid)
-		.long	SYMBOL_NAME(sys_chown)
-		.long	SYMBOL_NAME(sys_setuid)
-		.long	SYMBOL_NAME(sys_setgid)
-/* 215 */	.long	SYMBOL_NAME(sys_setfsuid)
-		.long	SYMBOL_NAME(sys_setfsgid)
-		.long	SYMBOL_NAME(sys_getdents64)
-		.long	SYMBOL_NAME(sys_pivot_root)
-		.long	SYMBOL_NAME(sys_mincore)
-/* 220 */	.long	SYMBOL_NAME(sys_madvise)
-		.long	SYMBOL_NAME(sys_fcntl64)
-		.long	SYMBOL_NAME(sys_ni_syscall) /* TUX */
-		.long	SYMBOL_NAME(sys_ni_syscall) /* Security */
-		.long	SYMBOL_NAME(sys_gettid)
-/* 225 */	.long	SYMBOL_NAME(sys_readahead)
-		.long	SYMBOL_NAME(sys_setxattr)
-		.long	SYMBOL_NAME(sys_lsetxattr)
-		.long	SYMBOL_NAME(sys_fsetxattr)
-		.long	SYMBOL_NAME(sys_getxattr)
-/* 230 */	.long	SYMBOL_NAME(sys_lgetxattr)
-		.long	SYMBOL_NAME(sys_fgetxattr)
-		.long	SYMBOL_NAME(sys_listxattr)
-		.long	SYMBOL_NAME(sys_llistxattr)
-		.long	SYMBOL_NAME(sys_flistxattr)
-/* 235 */	.long	SYMBOL_NAME(sys_removexattr)
-		.long	SYMBOL_NAME(sys_lremovexattr)
-		.long	SYMBOL_NAME(sys_fremovexattr)
-		.long	SYMBOL_NAME(sys_tkill)
+/* 0 */		.long	sys_ni_syscall
+		.long	sys_exit
+		.long	sys_fork_wrapper
+		.long	sys_read
+		.long	sys_write
+/* 5 */		.long	sys_open
+		.long	sys_close
+		.long	sys_ni_syscall		/* was sys_waitpid */
+		.long	sys_creat
+		.long	sys_link
+/* 10 */	.long	sys_unlink
+		.long	sys_execve_wrapper
+		.long	sys_chdir
+		.long	sys_time		/* used by libc4 */
+		.long	sys_mknod
+/* 15 */	.long	sys_chmod
+		.long	sys_lchown16
+		.long	sys_ni_syscall		/* was sys_break */
+		.long	sys_ni_syscall		/* was sys_stat */
+		.long	sys_lseek
+/* 20 */	.long	sys_getpid
+		.long	sys_mount
+		.long	sys_oldumount		/* used by libc4 */
+		.long	sys_setuid16
+		.long	sys_getuid16
+/* 25 */	.long	sys_stime
+		.long	sys_ptrace
+		.long	sys_alarm		/* used by libc4 */
+		.long	sys_ni_syscall		/* was sys_fstat */
+		.long	sys_pause
+/* 30 */	.long	sys_utime		/* used by libc4 */
+		.long	sys_ni_syscall		/* was sys_stty */
+		.long	sys_ni_syscall		/* was sys_getty */
+		.long	sys_access
+		.long	sys_nice
+/* 35 */	.long	sys_ni_syscall		/* was sys_ftime */
+		.long	sys_sync
+		.long	sys_kill
+		.long	sys_rename
+		.long	sys_mkdir
+/* 40 */	.long	sys_rmdir
+		.long	sys_dup
+		.long	sys_pipe
+		.long	sys_times
+		.long	sys_ni_syscall		/* was sys_prof */
+/* 45 */	.long	sys_brk
+		.long	sys_setgid16
+		.long	sys_getgid16
+		.long	sys_ni_syscall		/* was sys_signal */
+		.long	sys_geteuid16
+/* 50 */	.long	sys_getegid16
+		.long	sys_acct
+		.long	sys_umount
+		.long	sys_ni_syscall		/* was sys_lock */
+		.long	sys_ioctl
+/* 55 */	.long	sys_fcntl
+		.long	sys_ni_syscall		/* was sys_mpx */
+		.long	sys_setpgid
+		.long	sys_ni_syscall		/* was sys_ulimit */
+		.long	sys_ni_syscall		/* was sys_olduname */
+/* 60 */	.long	sys_umask
+		.long	sys_chroot
+		.long	sys_ustat
+		.long	sys_dup2
+		.long	sys_getppid
+/* 65 */	.long	sys_getpgrp
+		.long	sys_setsid
+		.long	sys_sigaction
+		.long	sys_ni_syscall		/* was sys_sgetmask */
+		.long	sys_ni_syscall		/* was sys_ssetmask */
+/* 70 */	.long	sys_setreuid16
+		.long	sys_setregid16
+		.long	sys_sigsuspend_wrapper
+		.long	sys_sigpending
+		.long	sys_sethostname
+/* 75 */	.long	sys_setrlimit
+		.long	sys_old_getrlimit	/* used by libc4 */
+		.long	sys_getrusage
+		.long	sys_gettimeofday
+		.long	sys_settimeofday
+/* 80 */	.long	sys_getgroups16
+		.long	sys_setgroups16
+		.long	old_select		/* used by libc4 */
+		.long	sys_symlink
+		.long	sys_ni_syscall		/* was sys_lstat */
+/* 85 */	.long	sys_readlink
+		.long	sys_uselib
+		.long	sys_swapon
+		.long	sys_reboot
+		.long	old_readdir		/* used by libc4 */
+/* 90 */	.long	old_mmap		/* used by libc4 */
+		.long	sys_munmap
+		.long	sys_truncate
+		.long	sys_ftruncate
+		.long	sys_fchmod
+/* 95 */	.long	sys_fchown16
+		.long	sys_getpriority
+		.long	sys_setpriority
+		.long	sys_ni_syscall		/* was sys_profil */
+		.long	sys_statfs
+/* 100 */	.long	sys_fstatfs
+		.long	sys_ni_syscall
+		.long	sys_socketcall
+		.long	sys_syslog
+		.long	sys_setitimer
+/* 105 */	.long	sys_getitimer
+		.long	sys_newstat
+		.long	sys_newlstat
+		.long	sys_newfstat
+		.long	sys_ni_syscall		/* was sys_uname */
+/* 110 */	.long	sys_ni_syscall		/* was sys_iopl */
+		.long	sys_vhangup
+		.long	sys_ni_syscall
+		.long	sys_syscall		/* call a syscall */
+		.long	sys_wait4
+/* 115 */	.long	sys_swapoff
+		.long	sys_sysinfo
+		.long	sys_ipc
+		.long	sys_fsync
+		.long	sys_sigreturn_wrapper
+/* 120 */	.long	sys_clone_wapper
+		.long	sys_setdomainname
+		.long	sys_newuname
+		.long	sys_ni_syscall
+		.long	sys_adjtimex
+/* 125 */	.long	sys_mprotect
+		.long	sys_sigprocmask
+		.long	sys_create_module
+		.long	sys_init_module
+		.long	sys_delete_module
+/* 130 */	.long	sys_get_kernel_syms
+		.long	sys_quotactl
+		.long	sys_getpgid
+		.long	sys_fchdir
+		.long	sys_bdflush
+/* 135 */	.long	sys_sysfs
+		.long	sys_personality
+		.long	sys_ni_syscall		/* .long	_sys_afs_syscall */
+		.long	sys_setfsuid16
+		.long	sys_setfsgid16
+/* 140 */	.long	sys_llseek
+		.long	sys_getdents
+		.long	sys_select
+		.long	sys_flock
+		.long	sys_msync
+/* 145 */	.long	sys_readv
+		.long	sys_writev
+		.long	sys_getsid
+		.long	sys_fdatasync
+		.long	sys_sysctl
+/* 150 */	.long	sys_mlock
+		.long	sys_munlock
+		.long	sys_mlockall
+		.long	sys_munlockall
+		.long	sys_sched_setparam
+/* 155 */	.long	sys_sched_getparam
+		.long	sys_sched_setscheduler
+		.long	sys_sched_getscheduler
+		.long	sys_sched_yield
+		.long	sys_sched_get_priority_max
+/* 160 */	.long	sys_sched_get_priority_min
+		.long	sys_sched_rr_get_interval
+		.long	sys_nanosleep
+		.long	sys_arm_mremap
+		.long	sys_setresuid16
+/* 165 */	.long	sys_getresuid16
+		.long	sys_ni_syscall
+		.long	sys_query_module
+		.long	sys_poll
+		.long	sys_nfsservctl
+/* 170 */	.long	sys_setresgid16
+		.long	sys_getresgid16
+		.long	sys_prctl
+		.long	sys_rt_sigreturn_wrapper
+		.long	sys_rt_sigaction
+/* 175 */	.long	sys_rt_sigprocmask
+		.long	sys_rt_sigpending
+		.long	sys_rt_sigtimedwait
+		.long	sys_rt_sigqueueinfo
+		.long	sys_rt_sigsuspend_wrapper
+/* 180 */	.long	sys_pread
+		.long	sys_pwrite
+		.long	sys_chown16
+		.long	sys_getcwd
+		.long	sys_capget
+/* 185 */	.long	sys_capset
+		.long	sys_sigaltstack_wrapper
+		.long	sys_sendfile
+		.long	sys_ni_syscall
+		.long	sys_ni_syscall
+/* 190 */	.long	sys_vfork_wrapper
+		.long	sys_getrlimit
+		.long	sys_mmap2
+		.long	sys_truncate64
+		.long	sys_ftruncate64
+/* 195 */	.long	sys_stat64
+		.long	sys_lstat64
+		.long	sys_fstat64
+		.long	sys_lchown
+		.long	sys_getuid
+/* 200 */	.long	sys_getgid
+		.long	sys_geteuid
+		.long	sys_getegid
+		.long	sys_setreuid
+		.long	sys_setregid
+/* 205 */	.long	sys_getgroups
+		.long	sys_setgroups
+		.long	sys_fchown
+		.long	sys_setresuid
+		.long	sys_getresuid
+/* 210 */	.long	sys_setresgid
+		.long	sys_getresgid
+		.long	sys_chown
+		.long	sys_setuid
+		.long	sys_setgid
+/* 215 */	.long	sys_setfsuid
+		.long	sys_setfsgid
+		.long	sys_getdents64
+		.long	sys_pivot_root
+		.long	sys_mincore
+/* 220 */	.long	sys_madvise
+		.long	sys_fcntl64
+		.long	sys_ni_syscall /* TUX */
+		.long	sys_ni_syscall /* Security */
+		.long	sys_gettid
+/* 225 */	.long	sys_readahead
+		.long	sys_setxattr
+		.long	sys_lsetxattr
+		.long	sys_fsetxattr
+		.long	sys_getxattr
+/* 230 */	.long	sys_lgetxattr
+		.long	sys_fgetxattr
+		.long	sys_listxattr
+		.long	sys_llistxattr
+		.long	sys_flistxattr
+/* 235 */	.long	sys_removexattr
+		.long	sys_lremovexattr
+		.long	sys_fremovexattr
+		.long	sys_tkill
 __syscall_end:
 
 		.rept	NR_syscalls - (__syscall_end - __syscall_start) / 4
-			.long	SYMBOL_NAME(sys_ni_syscall)
+			.long	sys_ni_syscall
 		.endr
 #endif
diff -urN linux-sn4/arch/arm/kernel/entry-armo.S linux/arch/arm/kernel/entry-armo.S
--- linux-sn4/arch/arm/kernel/entry-armo.S	Thu Mar  7 21:18:19 2002
+++ linux/arch/arm/kernel/entry-armo.S	Sat Apr 27 23:19:54 2002
@@ -147,7 +147,7 @@
 		mov	r0, r0
 		stmfd	sp!, {r0 - r3, ip, lr}
 		adr	r0, Lfiqmsg
-		bl	SYMBOL_NAME(printk)
+		bl	printk
 		ldmfd	sp!, {r0 - r3, ip, lr}
 		teqp	pc, #0x0c000001
 		mov	r0, r0
@@ -174,12 +174,12 @@
 		ldr	r4, .LC2
 		ldr	pc, [r4]			@ Call FP module USR entry point
 
-		.globl	SYMBOL_NAME(fpundefinstr)
-SYMBOL_NAME(fpundefinstr):				@ Called by FP module on undefined instr
+		.globl	fpundefinstr
+fpundefinstr:						@ Called by FP module on undefined instr
 		mov	r0, lr
 		mov	r1, sp
 		teqp	pc, #MODE_SVC
-		bl	SYMBOL_NAME(do_undefinstr)
+		bl	do_undefinstr
 		b	ret_from_exception		@ Normal FP exit
 
 __und_svc:	SVC_SAVE_ALL				@ Non-user mode
@@ -187,7 +187,7 @@
 		and	r2, lr, #3
 		sub	r0, r0, #4
 		mov	r1, sp
-		bl	SYMBOL_NAME(do_undefinstr)
+		bl	do_undefinstr
 		SVC_RESTORE_ALL
 
 #if defined CONFIG_FPE_NWFPE || defined CONFIG_FPE_FASTFPE
@@ -232,7 +232,7 @@
 		.word	0x0f0f0f00
 #endif
 
-.LC2:		.word	SYMBOL_NAME(fp_enter)
+.LC2:		.word	fp_enter
 
 /*=============================================================================
  * Prefetch abort handler
@@ -247,12 +247,12 @@
 		teqp	pc, #0x00000003		@ NOT a problem - doesnt change mode
 		mask_pc	r0, lr			@ Address of abort
 		mov	r1, sp			@ Tasks registers
-		bl	SYMBOL_NAME(do_PrefetchAbort)
+		bl	do_PrefetchAbort
 		teq	r0, #0			@ If non-zero, we believe this abort..
 		bne	ret_from_exception
 #ifdef DEBUG_UNDEF
 		adr	r0, t
-		bl	SYMBOL_NAME(printk)
+		bl	printk
 #endif
 		ldr	lr, [sp,#S_PC]		@ program to test this on.  I think its
 		b	.Lbug_undef		@ broken at the moment though!)
@@ -261,7 +261,7 @@
 		mov	r0, sp				@ Prefetch aborts are definitely *not*
 		mov	r1, #BAD_PREFETCH		@ allowed in non-user modes.  We cant
 		and	r2, lr, #3			@ recover from this problem.
-		b	SYMBOL_NAME(bad_mode)
+		b	bad_mode
 
 #ifdef DEBUG_UNDEF
 t:		.ascii "*** undef ***\r\n\0"
@@ -287,7 +287,7 @@
 		mov	r1, sp			@ Point to registers
 		mov	r2, #0x400
 		mov	lr, pc
-		bl	SYMBOL_NAME(do_excpt)
+		bl	do_excpt
 		b	ret_from_exception
 
 Laddrexcptn_not_user:
@@ -299,7 +299,7 @@
 		mask_pc	r0, lr
 		mov	r1, sp
 		orr	r2, r2, #0x400
-		bl	SYMBOL_NAME(do_excpt)
+		bl	do_excpt
 		ldmia	sp, {r0 - lr}		@ I cant remember the reason I changed this...
 		add	sp, sp, #15*4
 		movs	pc, lr
@@ -324,7 +324,7 @@
 		stmfd	sp!, {r0-r7}
 		mov	r0, sp
 		mov	r1, #BAD_ADDREXCPTN
-		b	SYMBOL_NAME(bad_mode)
+		b	bad_mode
 
 /*=============================================================================
  * Interrupt (IRQ) handler
@@ -382,7 +382,7 @@
 
 __irq_invalid:	mov	r0, sp
 		mov	r1, #BAD_IRQ
-		b	SYMBOL_NAME(bad_mode)
+		b	bad_mode
 
 /*=============================================================================
  * Data abort handler code
@@ -418,7 +418,7 @@
 Ldata_illegal_mode:
 		mov	r0, sp
 		mov	r1, #BAD_DATA
-		b	SYMBOL_NAME(bad_mode)
+		b	bad_mode
 
 Ldata_do:	mov	r3, sp
 		ldr	r4, [r0]		@ Get instruction
@@ -460,7 +460,7 @@
 #ifdef FAULT_CODE_LDRSTRPOST
 		orr	r2, r2, #FAULT_CODE_LDRSTRPOST
 #endif
-		b	SYMBOL_NAME(do_DataAbort)
+		b	do_DataAbort
 
 Ldata_ldrstr_numindex:
 		mov	r0, r4, lsr #14		@ Get Rn
@@ -476,7 +476,7 @@
 #ifdef FAULT_CODE_LDRSTRPRE
 		orr	r2, r2, #FAULT_CODE_LDRSTRPRE
 #endif
-		b	SYMBOL_NAME(do_DataAbort)
+		b	do_DataAbort
 
 Ldata_ldrstr_regindex:
 		mov	r0, r4, lsr #14		@ Get Rn
@@ -506,7 +506,7 @@
 #ifdef FAULT_CODE_LDRSTRREG
 		orr	r2, r2, #FAULT_CODE_LDRSTRREG
 #endif
-		b	SYMBOL_NAME(do_DataAbort)
+		b	do_DataAbort
 
 Ldata_ldmstm:
 		mov	r7, #0x11
@@ -543,7 +543,7 @@
 #ifdef FAULT_CODE_LDMSTM
 		orr	r2, r2, #FAULT_CODE_LDMSTM
 #endif
-		b	SYMBOL_NAME(do_DataAbort)
+		b	do_DataAbort
 
 Ldata_ldcstc_pre:
 		mov	r0, r4, lsr #14		@ Get Rn
@@ -559,7 +559,7 @@
 #ifdef FAULT_CODE_LDCSTC
 		orr	r2, r2, #FAULT_CODE_LDCSTC
 #endif
-		b	SYMBOL_NAME(do_DataAbort)
+		b	do_DataAbort
 
 
 /*
diff -urN linux-sn4/arch/arm/kernel/entry-armv.S linux/arch/arm/kernel/entry-armv.S
--- linux-sn4/arch/arm/kernel/entry-armv.S	Mon Apr 22 19:17:22 2002
+++ linux/arch/arm/kernel/entry-armv.S	Sat Apr 27 23:23:21 2002
@@ -653,7 +653,7 @@
 		stmia	r4, {r5 - r7}			@ Save XXX pc, cpsr, old_r0
 		mov	r0, sp
 		and	r2, r6, #31			@ int mode
-		b	SYMBOL_NAME(bad_mode)
+		b	bad_mode
 
 #if defined CONFIG_FPE_NWFPE || defined CONFIG_FPE_FASTFPE
 		/* The FPE is always present */
@@ -725,7 +725,7 @@
 #endif
 		msr	cpsr_c, r9
 		mov	r2, sp
-		bl	SYMBOL_NAME(do_DataAbort)
+		bl	do_DataAbort
 		set_cpsr_c r0, #PSR_I_BIT | MODE_SVC
 		ldr	r0, [sp, #S_PSR]
 		msr	spsr, r0
@@ -778,7 +778,7 @@
 		mov	r7, #PREEMPT_ACTIVE
 		str	r7, [r8, #TI_PREEMPT]		@ set PREEMPT_ACTIVE
 1:		set_cpsr_c r2, #MODE_SVC		@ enable IRQs
-		bl	SYMBOL_NAME(schedule)
+		bl	schedule
 		set_cpsr_c r0, #PSR_I_BIT | MODE_SVC	@ disable IRQs
 		ldr	r0, [r8, #TI_FLAGS]		@ get new tasks TI_FLAGS
 		tst	r0, #_TIF_NEED_RESCHED
@@ -801,7 +801,7 @@
 
 		mov	r0, r5				@ unsigned long pc
 		mov	r1, sp				@ struct pt_regs *regs
-		bl	SYMBOL_NAME(do_undefinstr)
+		bl	do_undefinstr
 
 1:		set_cpsr_c r0, #PSR_I_BIT | MODE_SVC
 		ldr	lr, [sp, #S_PSR]		@ Get SVC cpsr
@@ -823,7 +823,7 @@
 		msr	cpsr_c, r9
 		mov	r0, r2				@ address (pc)
 		mov	r1, sp				@ regs
-		bl	SYMBOL_NAME(do_PrefetchAbort)	@ call abort handler
+		bl	do_PrefetchAbort		@ call abort handler
 		set_cpsr_c r0, #PSR_I_BIT | MODE_SVC
 		ldr	r0, [sp, #S_PSR]
 		msr	spsr, r0
@@ -834,11 +834,11 @@
 .LCund:		.word	__temp_und
 .LCabt:		.word	__temp_abt
 #ifdef MULTI_ABORT
-.LCprocfns:	.word	SYMBOL_NAME(processor)
+.LCprocfns:	.word	processor
 #endif
-.LCfp:		.word	SYMBOL_NAME(fp_enter)
+.LCfp:		.word	fp_enter
 #ifdef CONFIG_PREEMPT
-.LCirq_stat:	.word	SYMBOL_NAME(irq_stat)
+.LCirq_stat:	.word	irq_stat
 #endif
 
 		irq_prio_table
@@ -867,7 +867,7 @@
 		set_cpsr_c r2, #MODE_SVC		@ Enable interrupts
 		mov	r2, sp
 		adrsvc	al, lr, ret_from_exception
-		b	SYMBOL_NAME(do_DataAbort)
+		b	do_DataAbort
 
 		.align	5
 __irq_usr:	sub	sp, sp, #S_FRAME_SIZE
@@ -929,7 +929,7 @@
 		mov	r0, lr
 		mov	r1, sp
 		adrsvc	al, lr, ret_from_exception
-		b	SYMBOL_NAME(do_undefinstr)
+		b	do_undefinstr
 
 		.align	5
 __pabt_usr:	sub	sp, sp, #S_FRAME_SIZE		@ Allocate frame size in one go
@@ -944,7 +944,7 @@
 		set_cpsr_c r0, #MODE_SVC		@ Enable interrupts
 		mov	r0, r5				@ address (pc)
 		mov	r1, sp				@ regs
-		bl	SYMBOL_NAME(do_PrefetchAbort)	@ call abort handler
+		bl	do_PrefetchAbort		@ call abort handler
 		/* fall through */
 /*
  * This is the return code to user mode for abort handlers
@@ -1230,9 +1230,9 @@
 		.word	0				@ Saved spsr_abt
 		.word	-1				@ old_r0
 
-		.globl	SYMBOL_NAME(cr_alignment)
-		.globl	SYMBOL_NAME(cr_no_alignment)
-SYMBOL_NAME(cr_alignment):
+		.globl	cr_alignment
+		.globl	cr_no_alignment
+cr_alignment:
 		.space	4
-SYMBOL_NAME(cr_no_alignment):
+cr_no_alignment:
 		.space	4
diff -urN linux-sn4/arch/arm/kernel/entry-common.S linux/arch/arm/kernel/entry-common.S
--- linux-sn4/arch/arm/kernel/entry-common.S	Mon Apr 22 19:17:22 2002
+++ linux/arch/arm/kernel/entry-common.S	Sat Apr 27 23:19:54 2002
@@ -49,7 +49,7 @@
 	b	work_pending
 
 work_resched:
-	bl	SYMBOL_NAME(schedule)
+	bl	schedule
 /*
  * "slow" syscall return path.  "why" tells us if this was a real syscall.
  */
@@ -70,7 +70,7 @@
 __do_notify_resume:
 	mov	r0, sp				@ 'regs'
 	mov	r2, why				@ 'syscall'
-	b	SYMBOL_NAME(do_notify_resume)	@ note the bl above sets lr
+	b	do_notify_resume		@ note the bl above sets lr
 
 /*
  * This is how we return from a fork.
@@ -86,7 +86,7 @@
 	beq	ret_slow_syscall
 	mov	r1, sp
 	mov	r0, #1				@ trace exit [IP = 1]
-	bl	SYMBOL_NAME(syscall_trace)
+	bl	syscall_trace
 	b	ret_slow_syscall
 	
 
@@ -154,8 +154,8 @@
 2:	mov	why, #0				@ no longer a real syscall
 	cmp	scno, #ARMSWI_OFFSET
 	eor	r0, scno, #OS_NUMBER << 20	@ put OS number back
-	bcs	SYMBOL_NAME(arm_syscall)	
-	b	SYMBOL_NAME(sys_ni_syscall)	@ not private func
+	bcs	arm_syscall	
+	b	sys_ni_syscall			@ not private func
 
 	/*
 	 * This is the really slow path.  We're going to be doing
@@ -164,7 +164,7 @@
 __sys_trace:
 	add	r1, sp, #S_OFF
 	mov	r0, #0				@ trace entry [IP = 0]
-	bl	SYMBOL_NAME(syscall_trace)
+	bl	syscall_trace
 
 	adrsvc	al, lr, __sys_trace_return	@ return address
 	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
@@ -177,14 +177,14 @@
 	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
 	mov	r1, sp
 	mov	r0, #1				@ trace exit [IP = 1]
-	bl	SYMBOL_NAME(syscall_trace)
+	bl	syscall_trace
 	b	ret_slow_syscall
 
 	.align	5
 #ifdef CONFIG_ALIGNMENT_TRAP
 	.type	__cr_alignment, #object
 __cr_alignment:
-	.word	SYMBOL_NAME(cr_alignment)
+	.word	cr_alignment
 #endif
 
 	.type	sys_call_table, #object
@@ -197,7 +197,7 @@
 @ r0 = syscall number
 @ r5 = syscall table
 		.type	sys_syscall, #function
-SYMBOL_NAME(sys_syscall):
+sys_syscall:
 		eor	scno, r0, #OS_NUMBER << 20
 		cmp	scno, #NR_syscalls	@ check range
 		stmleia	sp, {r5, r6}		@ shuffle args
@@ -210,35 +210,35 @@
 
 sys_fork_wrapper:
 		add	r0, sp, #S_OFF
-		b	SYMBOL_NAME(sys_fork)
+		b	sys_fork
 
 sys_vfork_wrapper:
 		add	r0, sp, #S_OFF
-		b	SYMBOL_NAME(sys_vfork)
+		b	sys_vfork
 
 sys_execve_wrapper:
 		add	r3, sp, #S_OFF
-		b	SYMBOL_NAME(sys_execve)
+		b	sys_execve
 
 sys_clone_wapper:
 		add	r2, sp, #S_OFF
-		b	SYMBOL_NAME(sys_clone)
+		b	sys_clone
 
 sys_sigsuspend_wrapper:
 		add	r3, sp, #S_OFF
-		b	SYMBOL_NAME(sys_sigsuspend)
+		b	sys_sigsuspend
 
 sys_rt_sigsuspend_wrapper:
 		add	r2, sp, #S_OFF
-		b	SYMBOL_NAME(sys_rt_sigsuspend)
+		b	sys_rt_sigsuspend
 
 sys_sigreturn_wrapper:
 		add	r0, sp, #S_OFF
-		b	SYMBOL_NAME(sys_sigreturn)
+		b	sys_sigreturn
 
 sys_rt_sigreturn_wrapper:
 		add	r0, sp, #S_OFF
-		b	SYMBOL_NAME(sys_rt_sigreturn)
+		b	sys_rt_sigreturn
 
 sys_sigaltstack_wrapper:
 		ldr	r2, [sp, #S_OFF + S_SP]
diff -urN linux-sn4/arch/arm/kernel/head.S linux/arch/arm/kernel/head.S
--- linux-sn4/arch/arm/kernel/head.S	Thu Mar  7 21:18:04 2002
+++ linux/arch/arm/kernel/head.S	Sat Apr 27 23:19:54 2002
@@ -35,8 +35,8 @@
 #error TEXTADDR must start at 0xXXXX8000
 #endif
 
-		.globl	SYMBOL_NAME(swapper_pg_dir)
-		.equ	SYMBOL_NAME(swapper_pg_dir), TEXTADDR - 0x4000
+		.globl	swapper_pg_dir
+		.equ	swapper_pg_dir, TEXTADDR - 0x4000
 
 		.macro	pgtbl, reg, rambase
 		adr	\reg, stext
@@ -144,13 +144,13 @@
 
 		.type	__switch_data, %object
 __switch_data:	.long	__mmap_switched
-		.long	SYMBOL_NAME(compat)
-		.long	SYMBOL_NAME(__bss_start)
-		.long	SYMBOL_NAME(_end)
-		.long	SYMBOL_NAME(processor_id)
-		.long	SYMBOL_NAME(__machine_arch_type)
-		.long	SYMBOL_NAME(cr_alignment)
-		.long	SYMBOL_NAME(init_thread_union)+8192
+		.long	compat
+		.long	__bss_start
+		.long	_end
+		.long	processor_id
+		.long	__machine_arch_type
+		.long	cr_alignment
+		.long	init_thread_union+8192
 
 		.type	__ret, %function
 __ret:		ldr	lr, __switch_data
@@ -187,7 +187,7 @@
 #endif
 		bic	r2, r0, #2			@ Clear 'A' bit
 		stmia	r8, {r0, r2}			@ Save control register values
-		b	SYMBOL_NAME(start_kernel)
+		b	start_kernel
 
 
 
diff -urN linux-sn4/arch/arm/lib/backtrace.S linux/arch/arm/lib/backtrace.S
--- linux-sn4/arch/arm/lib/backtrace.S	Thu Mar  7 21:18:15 2002
+++ linux/arch/arm/lib/backtrace.S	Sat Apr 27 23:19:54 2002
@@ -60,7 +60,7 @@
 		adr	r0, .Lfe
 		mov	r1, save
 		bic	r2, r2, mask
-		bl	SYMBOL_NAME(printk)	@ print pc and link register
+		bl	printk			@ print pc and link register
 
 		sub	r0, frame, #16
 1002:		ldr	r1, [save, #4]		@ get instruction at function+4
@@ -89,7 +89,7 @@
 		.align	0
 1004:		ldr	r0, =.Lbad
 		mov	r1, frame
-		bl	SYMBOL_NAME(printk)
+		bl	printk
 		LOADREGS(fd, sp!, {r4 - r8, pc})
 		.ltorg
 		.previous
@@ -121,12 +121,12 @@
 		ldr	r2, [stack], #-4
 		mov	r1, reg
 		adr	r0, .Lfp
-		bl	SYMBOL_NAME(printk)
+		bl	printk
 2:		subs	reg, reg, #1
 		bpl	1b
 		teq	r7, #0
 		adrne	r0, .Lcr
-		blne	SYMBOL_NAME(printk)
+		blne	printk
 		mov	r0, stack
 		LOADREGS(fd, sp!, {instr, reg, stack, r7, pc})
 
diff -urN linux-sn4/arch/arm/lib/delay.S linux/arch/arm/lib/delay.S
--- linux-sn4/arch/arm/lib/delay.S	Thu Mar  7 21:18:32 2002
+++ linux/arch/arm/lib/delay.S	Sat Apr 27 23:19:54 2002
@@ -11,7 +11,7 @@
 #include <asm/assembler.h>
 		.text
 
-LC0:		.word	SYMBOL_NAME(loops_per_jiffy)
+LC0:		.word	loops_per_jiffy
 
 /*
  * 0 <= r0 <= 2000
@@ -53,5 +53,5 @@
 		RETINSTR(movls,pc,lr)
 		subs	r0, r0, #1
 #endif
-		bhi	SYMBOL_NAME(__delay)
+		bhi	__delay
 		RETINSTR(mov,pc,lr)
diff -urN linux-sn4/arch/arm/lib/floppydma.S linux/arch/arm/lib/floppydma.S
--- linux-sn4/arch/arm/lib/floppydma.S	Thu Mar  7 21:18:27 2002
+++ linux/arch/arm/lib/floppydma.S	Sat Apr 27 23:19:54 2002
@@ -11,16 +11,16 @@
 #include <asm/assembler.h>
 		.text
 
-		.global	SYMBOL_NAME(floppy_fiqin_end)
+		.global	floppy_fiqin_end
 ENTRY(floppy_fiqin_start)
 		subs	r9, r9, #1
 		ldrgtb	r12, [r11, #-4]
 		ldrleb	r12, [r11], #0
 		strb	r12, [r10], #1
 		subs	pc, lr, #4
-SYMBOL_NAME(floppy_fiqin_end):
+floppy_fiqin_end:
 
-		.global	SYMBOL_NAME(floppy_fiqout_end)
+		.global	floppy_fiqout_end
 ENTRY(floppy_fiqout_start)
 		subs	r9, r9, #1
 		ldrgeb	r12, [r10], #1
@@ -29,4 +29,4 @@
 		subles	pc, lr, #4
 		strb	r12, [r11, #-4]
 		subs	pc, lr, #4
-SYMBOL_NAME(floppy_fiqout_end):
+floppy_fiqout_end:
diff -urN linux-sn4/arch/arm/lib/io-acorn.S linux/arch/arm/lib/io-acorn.S
--- linux-sn4/arch/arm/lib/io-acorn.S	Thu Mar  7 21:18:14 2002
+++ linux/arch/arm/lib/io-acorn.S	Sat Apr 27 23:19:54 2002
@@ -52,7 +52,7 @@
 ENTRY(outsl)
 		adr	r0, .iosl_warning
 		mov	r1, lr
-		b	SYMBOL_NAME(printk)
+		b	printk
 
 @ Purpose: write a memc register
 @ Proto  : void memc_write(int register, int value);
diff -urN linux-sn4/arch/arm/lib/io-readsw-armv3.S linux/arch/arm/lib/io-readsw-armv3.S
--- linux-sn4/arch/arm/lib/io-readsw-armv3.S	Thu Mar  7 21:18:03 2002
+++ linux/arch/arm/lib/io-readsw-armv3.S	Sat Apr 27 23:19:54 2002
@@ -14,7 +14,7 @@
 .insw_bad_alignment:
 		adr	r0, .insw_bad_align_msg
 		mov	r2, lr
-		b	SYMBOL_NAME(panic)
+		b	panic
 .insw_bad_align_msg:
 		.asciz	"insw: bad buffer alignment (0x%p, lr=0x%08lX)\n"
 		.align
diff -urN linux-sn4/arch/arm/lib/io-readsw-armv4.S linux/arch/arm/lib/io-readsw-armv4.S
--- linux-sn4/arch/arm/lib/io-readsw-armv4.S	Thu Mar  7 21:18:54 2002
+++ linux/arch/arm/lib/io-readsw-armv4.S	Sat Apr 27 23:19:54 2002
@@ -14,7 +14,7 @@
 .insw_bad_alignment:
 		adr	r0, .insw_bad_align_msg
 		mov	r2, lr
-		b	SYMBOL_NAME(panic)
+		b	panic
 .insw_bad_align_msg:
 		.asciz	"insw: bad buffer alignment (0x%p, lr=0x%08lX)\n"
 		.align
diff -urN linux-sn4/arch/arm/lib/io-writesw-armv3.S linux/arch/arm/lib/io-writesw-armv3.S
--- linux-sn4/arch/arm/lib/io-writesw-armv3.S	Thu Mar  7 21:18:54 2002
+++ linux/arch/arm/lib/io-writesw-armv3.S	Sat Apr 27 23:19:54 2002
@@ -14,7 +14,7 @@
 .outsw_bad_alignment:
 		adr	r0, .outsw_bad_align_msg
 		mov	r2, lr
-		b	SYMBOL_NAME(panic)
+		b	panic
 .outsw_bad_align_msg:
 		.asciz	"outsw: bad buffer alignment (0x%p, lr=0x%08lX)\n"
 		.align
diff -urN linux-sn4/arch/arm/lib/io-writesw-armv4.S linux/arch/arm/lib/io-writesw-armv4.S
--- linux-sn4/arch/arm/lib/io-writesw-armv4.S	Thu Mar  7 21:18:57 2002
+++ linux/arch/arm/lib/io-writesw-armv4.S	Sat Apr 27 23:19:54 2002
@@ -14,7 +14,7 @@
 .outsw_bad_alignment:
 		adr	r0, .outsw_bad_align_msg
 		mov	r2, lr
-		b	SYMBOL_NAME(panic)
+		b	panic
 .outsw_bad_align_msg:
 		.asciz	"outsw: bad buffer alignment (0x%p, lr=0x%08lX)\n"
 		.align
diff -urN linux-sn4/arch/arm/lib/uaccess-armo.S linux/arch/arm/lib/uaccess-armo.S
--- linux-sn4/arch/arm/lib/uaccess-armo.S	Thu Mar  7 21:18:11 2002
+++ linux/arch/arm/lib/uaccess-armo.S	Sat Apr 27 23:19:54 2002
@@ -15,8 +15,8 @@
 
 		.text
 
-		.globl	SYMBOL_NAME(uaccess_user)
-SYMBOL_NAME(uaccess_user):
+		.globl	uaccess_user
+uaccess_user:
 		.word	uaccess_user_put_byte
 		.word	uaccess_user_get_byte
 		.word	uaccess_user_put_half
@@ -84,8 +84,8 @@
 
 
 
-		.globl	SYMBOL_NAME(uaccess_kernel)
-SYMBOL_NAME(uaccess_kernel):
+		.globl	uaccess_kernel
+uaccess_kernel:
 		.word	uaccess_kernel_put_byte
 		.word	uaccess_kernel_get_byte
 		.word	uaccess_kernel_put_half
@@ -154,7 +154,7 @@
  */
 uaccess_kernel_copy:
 		stmfd	sp!, {lr}
-		bl	SYMBOL_NAME(memcpy)
+		bl	memcpy
 		mov	r0, #0
 		ldmfd	sp!, {pc}^
 
diff -urN linux-sn4/arch/arm/lib/uaccess.S linux/arch/arm/lib/uaccess.S
--- linux-sn4/arch/arm/lib/uaccess.S	Thu Mar  7 21:18:06 2002
+++ linux/arch/arm/lib/uaccess.S	Sat Apr 27 23:19:54 2002
@@ -544,7 +544,7 @@
 		ldr	r1, [sp], #4			@ unsigned long count
 		subs	r4, r1, r2			@ bytes left to copy
 		movne	r1, r4
-		blne	SYMBOL_NAME(__memzero)
+		blne	__memzero
 		mov	r0, r4
 		LOADREGS(fd,sp!, {r4 - r7, pc})
 		.previous
diff -urN linux-sn4/arch/arm/mach-arc/head.S linux/arch/arm/mach-arc/head.S
--- linux-sn4/arch/arm/mach-arc/head.S	Thu Mar  7 21:18:56 2002
+++ linux/arch/arm/mach-arc/head.S	Sat Apr 27 23:19:54 2002
@@ -13,8 +13,8 @@
 #include <linux/linkage.h>
 #include <asm/mach-types.h>
 
-		.globl	SYMBOL_NAME(swapper_pg_dir)
-		.equ	SYMBOL_NAME(swapper_pg_dir),	0x0207d000
+		.globl	swapper_pg_dir
+		.equ	swapper_pg_dir,	0x0207d000
 
 /*
  * Entry point.
@@ -38,14 +38,14 @@
 		str	r0, [r5]
 
 		mov	fp, #0
-		b	SYMBOL_NAME(start_kernel)
+		b	start_kernel
 
-LC0:		.word	SYMBOL_NAME(_stext)
-		.word	SYMBOL_NAME(__bss_start)		@ r2
-		.word	SYMBOL_NAME(_end)			@ r3
-		.word	SYMBOL_NAME(processor_id)		@ r4
-		.word	SYMBOL_NAME(__machine_arch_type)	@ r5
-		.word	SYMBOL_NAME(init_task_union)+8192	@ sp
+LC0:		.word	_stext
+		.word	__bss_start		@ r2
+		.word	_end			@ r3
+		.word	processor_id		@ r4
+		.word	__machine_arch_type	@ r5
+		.word	init_task_union+8192	@ sp
 arm2_id:	.long	0x41560200
 arm250_id:	.long	0x41560250
 		.align
diff -urN linux-sn4/arch/arm/mach-sa1100/sleep.S linux/arch/arm/mach-sa1100/sleep.S
--- linux-sn4/arch/arm/mach-sa1100/sleep.S	Thu Mar  7 21:18:19 2002
+++ linux/arch/arm/mach-sa1100/sleep.S	Sat Apr 27 23:19:54 2002
@@ -72,12 +72,12 @@
 	@ delay 90us and set CPU PLL to lowest speed
 	@ fixes resume problem on high speed SA1110
 	mov	r0, #90
-	bl	SYMBOL_NAME(udelay)
+	bl	udelay
 	ldr	r0, =PPCR
 	mov	r1, #0
 	str	r1, [r0]
 	mov	r0, #90
-	bl	SYMBOL_NAME(udelay)
+	bl	udelay
 
 
 /* setup up register contents for jump to page containing SA1110 SDRAM controller bug fix suspend code
diff -urN linux-sn4/arch/arm/mm/proc-arm2,3.S linux/arch/arm/mm/proc-arm2,3.S
--- linux-sn4/arch/arm/mm/proc-arm2,3.S	Wed Apr 10 19:59:37 2002
+++ linux/arch/arm/mm/proc-arm2,3.S	Sat Apr 27 23:19:54 2002
@@ -189,7 +189,7 @@
  * Params  : pgd	New page tables/MEMC mapping
  * Purpose : update MEMC hardware with new mapping
  */
-		.word	SYMBOL_NAME(page_nr)
+		.word	page_nr
 _arm3_set_pgd:	mcr	p15, 0, r1, c1, c0, 0		@ flush cache
 _arm2_set_pgd:	stmfd	sp!, {lr}
 		ldr	r1, _arm3_set_pgd - 4
@@ -285,8 +285,8 @@
  * Purpose : Function pointers used to access above functions - all calls
  *	     come through these
  */
-		.globl	SYMBOL_NAME(arm2_processor_functions)
-SYMBOL_NAME(arm2_processor_functions):
+		.globl	arm2_processor_functions
+arm2_processor_functions:
 		.word	_arm2_3_check_bugs
 		.word	_arm2_proc_init
 		.word	_arm2_proc_fin
@@ -298,8 +298,8 @@
 		.long	armvlsi_name
 		.long	_arm2_name
 
-		.globl	SYMBOL_NAME(arm250_processor_functions)
-SYMBOL_NAME(arm250_processor_functions):
+		.globl	arm250_processor_functions
+arm250_processor_functions:
 		.word	_arm2_3_check_bugs
 		.word	_arm2_proc_init
 		.word	_arm2_proc_fin
@@ -311,8 +311,8 @@
 		.long	armvlsi_name
 		.long	_arm250_name
 
-		.globl	SYMBOL_NAME(arm3_processor_functions)
-SYMBOL_NAME(arm3_processor_functions):
+		.globl	arm3_processor_functions
+arm3_processor_functions:
 		.word	_arm2_3_check_bugs
 		.word	_arm3_proc_init
 		.word	_arm3_proc_fin
@@ -340,7 +340,7 @@
 		.long	arm2_elf_name
 		.long	0
 		.long	cpu_arm2_info
-		.long	SYMBOL_NAME(arm2_processor_functions)
+		.long	arm2_processor_functions
 		.long	0
 		.long	0
 
@@ -352,7 +352,7 @@
 		.long	arm3_elf_name
 		.long	0
 		.long	cpu_arm250_info
-		.long	SYMBOL_NAME(arm250_processor_functions)
+		.long	arm250_processor_functions
 		.long	0
 		.long	0
 
@@ -364,7 +364,7 @@
 		.long	arm3_elf_name
 		.long	0
 		.long	cpu_arm3_info
-		.long	SYMBOL_NAME(arm3_processor_functions)
+		.long	arm3_processor_functions
 		.long	0
 		.long	0
 
diff -urN linux-sn4/include/asm-arm/proc-armo/locks.h linux/include/asm-arm/proc-armo/locks.h
--- linux-sn4/include/asm-arm/proc-armo/locks.h	Thu Mar  7 21:18:29 2002
+++ linux/include/asm-arm/proc-armo/locks.h	Sat Apr 27 23:19:55 2002
@@ -28,7 +28,7 @@
 "	orrmi	ip, ip, #0x80000000	@ set N\n" \
 "	teqp	ip, #0\n"			\
 "	movmi	ip, %0\n"			\
-"	blmi	" SYMBOL_NAME_STR(fail)		\
+"	blmi	" #fail				\
 	:					\
 	: "r" (ptr)				\
 	: "ip", "lr", "cc");			\
@@ -50,7 +50,7 @@
 "	teqp	ip, #0\n"			\
 "	movmi	ip, %1\n"			\
 "	movpl	ip, #0\n"			\
-"	blmi	" SYMBOL_NAME_STR(fail) "\n"	\
+"	blmi	" #fail "\n"			\
 "	mov	%0, ip"				\
 	: "=&r" (result)			\
 	: "r" (ptr)				\
@@ -72,7 +72,7 @@
 "	orrle	ip, ip, #0x80000000	@ set N - should this be mi ??? DAG ! \n" \
 "	teqp	ip, #0\n"			\
 "	movmi	ip, %0\n"			\
-"	blmi	" SYMBOL_NAME_STR(wake)		\
+"	blmi	" #wake				\
 	:					\
 	: "r" (ptr)				\
 	: "ip", "lr", "cc");			\
@@ -104,7 +104,7 @@
 " orreq ip, ip, #0x40000000 @ set Z \n"\
 "	teqp	ip, #0\n"			\
 "	movne	ip, %0\n"			\
-"	blne	" SYMBOL_NAME_STR(fail)		\
+"	blne	" #fail				\
 	:					\
 	: "r" (ptr), "I" (RW_LOCK_BIAS)		\
 	: "ip", "lr", "cc");			\
@@ -127,7 +127,7 @@
 " orrcs ip, ip, #0x20000000 @ set C\n" \
 "	teqp	ip, #0\n"			\
 "	movcs	ip, %0\n"			\
-"	blcs	" SYMBOL_NAME_STR(wake)		\
+"	blcs	" #wake				\
 	:					\
 	: "r" (ptr), "I" (RW_LOCK_BIAS)		\
 	: "ip", "lr", "cc");			\
@@ -152,7 +152,7 @@
 " orreq ip, ip, #0x40000000 @ Set Z \n" \
 "	teqp	ip, #0\n"			\
 "	moveq	ip, %0\n"			\
-"	bleq	" SYMBOL_NAME_STR(wake)		\
+"	bleq	" #wake				\
 	:					\
 	: "r" (ptr), "I" (1)			\
 	: "ip", "lr", "cc");			\
diff -urN linux-sn4/include/asm-arm/proc-armv/locks.h linux/include/asm-arm/proc-armv/locks.h
--- linux-sn4/include/asm-arm/proc-armv/locks.h	Thu Mar  7 21:18:57 2002
+++ linux/include/asm-arm/proc-armv/locks.h	Sat Apr 27 23:19:55 2002
@@ -24,7 +24,7 @@
 "	str	lr, [%0]\n"			\
 "	msr	cpsr_c, ip\n"			\
 "	movmi	ip, %0\n"			\
-"	blmi	" SYMBOL_NAME_STR(fail)		\
+"	blmi	" #fail				\
 	:					\
 	: "r" (ptr), "I" (1)			\
 	: "ip", "lr", "cc");			\
@@ -44,7 +44,7 @@
 "	msr	cpsr_c, ip\n"			\
 "	movmi	ip, %1\n"			\
 "	movpl	ip, #0\n"			\
-"	blmi	" SYMBOL_NAME_STR(fail) "\n"	\
+"	blmi	" #fail "\n"			\
 "	mov	%0, ip"				\
 	: "=&r" (ret)				\
 	: "r" (ptr), "I" (1)			\
@@ -64,7 +64,7 @@
 "	str	lr, [%0]\n"			\
 "	msr	cpsr_c, ip\n"			\
 "	movle	ip, %0\n"			\
-"	blle	" SYMBOL_NAME_STR(wake)		\
+"	blle	" #wake				\
 	:					\
 	: "r" (ptr), "I" (1)			\
 	: "ip", "lr", "cc");			\
@@ -91,7 +91,7 @@
 "	str	lr, [%0]\n"			\
 "	msr	cpsr_c, ip\n"			\
 "	movne	ip, %0\n"			\
-"	blne	" SYMBOL_NAME_STR(fail)		\
+"	blne	" #fail				\
 	:					\
 	: "r" (ptr), "I" (RW_LOCK_BIAS)		\
 	: "ip", "lr", "cc");			\
@@ -109,7 +109,7 @@
 "	str	lr, [%0]\n"			\
 "	msr	cpsr_c, ip\n"			\
 "	movcs	ip, %0\n"			\
-"	blcs	" SYMBOL_NAME_STR(wake)		\
+"	blcs	" #wake				\
 	:					\
 	: "r" (ptr), "I" (RW_LOCK_BIAS)		\
 	: "ip", "lr", "cc");			\
@@ -130,7 +130,7 @@
 "	str	lr, [%0]\n"			\
 "	msr	cpsr_c, ip\n"			\
 "	moveq	ip, %0\n"			\
-"	bleq	" SYMBOL_NAME_STR(wake)		\
+"	bleq	" #wake				\
 	:					\
 	: "r" (ptr), "I" (1)			\
 	: "ip", "lr", "cc");			\

--------------050403050708060502080205--

