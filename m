Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWAXAwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWAXAwd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 19:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWAXAwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 19:52:32 -0500
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:57278 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030262AbWAXAwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 19:52:32 -0500
Date: Mon, 23 Jan 2006 19:50:05 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 3/9] ia32 syscalls: add new table
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Jeff Dike <jdike@addtoit.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601231952_MC3-1-B687-C046@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shared ia32 syscall table 3/9:

Add new shared syscall table for ia32.  This is
a new file; a later patch will remove the old one.

Signed-Off-By: Chuck Ebbert <76306.1226@compuserve.com>

--- /dev/null
+++ 2.6.16-rc1-mm2/arch/i386/kernel/syscall_tbl.S
@@ -0,0 +1,330 @@
+/*
+ * Common ia32 syscall table for i386, UML/i386 and x86_64.
+ *
+ * UML and x86_64 override some of these pointers.
+ *
+ * If syscall pointer type is undefined, assume native 32-bit
+ * environment and 'traditional' cpp.
+ */
+#ifndef syscall_ptr_type
+#  define syscall_ptr_type	.long
+#  define SYSCALL(func)	RAWSYSCALL(sys_/**/func)
+#  define SYS32CALL		SYSCALL
+#  define STUB32CALL		SYSCALL
+#  define COMPATCALL		SYSCALL
+#endif
+
+#define RAWSYSCALL(func)	syscall_ptr_type func
+
+	SYSCALL(restart_syscall)	/* 0 - old "setup()", used for restarting */
+	SYSCALL(exit)
+	STUB32CALL(fork)
+	SYSCALL(read)
+	SYSCALL(write)
+	COMPATCALL(open)		/* 5 */
+	SYSCALL(close)
+	SYS32CALL(waitpid)
+	SYSCALL(creat)
+	SYSCALL(link)
+	SYSCALL(unlink)			/* 10 */
+	STUB32CALL(execve)
+	SYSCALL(chdir)
+	COMPATCALL(time)
+	SYSCALL(mknod)
+	SYSCALL(chmod)			/* 15 */
+	SYSCALL(lchown16)
+	SYS32CALL(ni_syscall)		/* old break syscall holder */
+	SYSCALL(stat)
+	SYS32CALL(lseek)
+	SYSCALL(getpid)			/* 20 */
+	COMPATCALL(mount)
+	SYSCALL(oldumount)
+	SYSCALL(setuid16)
+	SYSCALL(getuid16)
+	COMPATCALL(stime)		/* 25 */
+	SYS32CALL(ptrace)
+	SYSCALL(alarm)
+	SYSCALL(fstat)
+	SYSCALL(pause)
+	COMPATCALL(utime)		/* 30 */
+	SYS32CALL(ni_syscall)		/* old stty syscall holder */
+	SYS32CALL(ni_syscall)		/* old gtty syscall holder */
+	SYSCALL(access)
+	SYSCALL(nice)
+	SYS32CALL(ni_syscall)		/* 35 - old ftime syscall holder */
+	SYSCALL(sync)
+	SYS32CALL(kill)
+	SYSCALL(rename)
+	SYSCALL(mkdir)
+	SYSCALL(rmdir)			/* 40 */
+	SYSCALL(dup)
+	SYS32CALL(pipe)
+	COMPATCALL(times)
+	SYS32CALL(ni_syscall)		/* old prof syscall holder */
+	SYSCALL(brk)			/* 45 */
+	SYSCALL(setgid16)
+	SYSCALL(getgid16)
+	SYSCALL(signal)
+	SYSCALL(geteuid16)
+	SYSCALL(getegid16)		/* 50 */
+	SYSCALL(acct)
+	SYSCALL(umount)			/* recycled never used phys() */
+	SYS32CALL(ni_syscall)		/* old lock syscall holder */
+	COMPATCALL(ioctl)
+	COMPATCALL(fcntl)		/* 55 */
+	SYS32CALL(ni_syscall)		/* old mpx syscall holder */
+	SYSCALL(setpgid)
+	SYS32CALL(ni_syscall)		/* old ulimit syscall holder */
+	SYS32CALL(olduname)
+	SYSCALL(umask)			/* 60 */
+	SYSCALL(chroot)
+	SYS32CALL(ustat)
+	SYSCALL(dup2)
+	SYSCALL(getppid)
+	SYSCALL(getpgrp)		/* 65 */
+	SYSCALL(setsid)
+	SYS32CALL(sigaction)
+	SYSCALL(sgetmask)
+	SYSCALL(ssetmask)
+	SYSCALL(setreuid16)		/* 70 */
+	SYSCALL(setregid16)
+	STUB32CALL(sigsuspend)
+	COMPATCALL(sigpending)
+	SYSCALL(sethostname)
+	COMPATCALL(setrlimit)		/* 75 */
+	COMPATCALL(old_getrlimit)
+	COMPATCALL(getrusage)
+	SYS32CALL(gettimeofday)
+	SYS32CALL(settimeofday)
+	SYSCALL(getgroups16)		/* 80 */
+	SYSCALL(setgroups16)
+	SYS32CALL(old_select)
+	SYSCALL(symlink)
+	SYSCALL(lstat)
+	SYSCALL(readlink)		/* 85 */
+	SYSCALL(uselib)
+	SYSCALL(swapon)
+	SYSCALL(reboot)
+	RAWSYSCALL(old_readdir)		/* RAWSYSCALL */
+	SYS32CALL(old_mmap)		/* 90 */
+	SYSCALL(munmap)
+	SYSCALL(truncate)
+	SYSCALL(ftruncate)
+	SYSCALL(fchmod)
+	SYSCALL(fchown16)		/* 95 */
+	SYSCALL(getpriority)
+	SYSCALL(setpriority)
+	SYS32CALL(ni_syscall)		/* old profil syscall holder */
+	COMPATCALL(statfs)
+	COMPATCALL(fstatfs)		/* 100 */
+	SYSCALL(ioperm)
+	COMPATCALL(socketcall)
+	SYSCALL(syslog)
+	COMPATCALL(setitimer)
+	COMPATCALL(getitimer)		/* 105 */
+	COMPATCALL(newstat)
+	COMPATCALL(newlstat)
+	COMPATCALL(newfstat)
+	SYS32CALL(uname)
+	STUB32CALL(iopl)		/* 110 */
+	SYSCALL(vhangup)
+	SYS32CALL(ni_syscall)		/* old "idle" system call */
+	SYS32CALL(vm86old)
+	COMPATCALL(wait4)
+	SYSCALL(swapoff)		/* 115 */
+	SYS32CALL(sysinfo)
+	SYS32CALL(ipc)
+	SYSCALL(fsync)
+	STUB32CALL(sigreturn)
+	STUB32CALL(clone)		/* 120 */
+	SYSCALL(setdomainname)
+	SYSCALL(newuname)
+	SYSCALL(modify_ldt)
+	SYS32CALL(adjtimex)
+	SYS32CALL(mprotect)		/* 125 */
+	COMPATCALL(sigprocmask)
+	SYS32CALL(ni_syscall)		/* old "create_module" */
+	SYSCALL(init_module)
+	SYSCALL(delete_module)
+	SYS32CALL(ni_syscall)		/* 130:	old "get_kernel_syms" */
+	SYSCALL(quotactl)
+	SYSCALL(getpgid)
+	SYSCALL(fchdir)
+	SYSCALL(bdflush)
+	SYSCALL(sysfs)			/* 135 */
+	SYSCALL(personality)
+	SYS32CALL(ni_syscall)		/* reserved for afs_syscall */
+	SYSCALL(setfsuid16)
+	SYSCALL(setfsgid16)
+	SYSCALL(llseek)			/* 140 */
+	COMPATCALL(getdents)
+	COMPATCALL(select)
+	SYSCALL(flock)
+	SYSCALL(msync)
+	COMPATCALL(readv)		/* 145 */
+	COMPATCALL(writev)
+	SYSCALL(getsid)
+	SYSCALL(fdatasync)
+	SYS32CALL(sysctl)
+	SYSCALL(mlock)			/* 150 */
+	SYSCALL(munlock)
+	SYSCALL(mlockall)
+	SYSCALL(munlockall)
+	SYSCALL(sched_setparam)
+	SYSCALL(sched_getparam)   	/* 155 */
+	SYSCALL(sched_setscheduler)
+	SYSCALL(sched_getscheduler)
+	SYSCALL(sched_yield)
+	SYSCALL(sched_get_priority_max)
+	SYSCALL(sched_get_priority_min)	/* 160 */
+	SYSCALL(sched_rr_get_interval)
+	COMPATCALL(nanosleep)
+	SYSCALL(mremap)
+	SYSCALL(setresuid16)
+	SYSCALL(getresuid16)		/* 165 */
+	SYS32CALL(vm86)
+	SYS32CALL(ni_syscall)		/* Old sys_query_module */
+	SYSCALL(poll)
+	COMPATCALL(nfsservctl)
+	SYSCALL(setresgid16)		/* 170 */
+	SYSCALL(getresgid16)
+	SYSCALL(prctl)
+	STUB32CALL(rt_sigreturn)
+	SYS32CALL(rt_sigaction)
+	SYS32CALL(rt_sigprocmask)	/* 175 */
+	SYS32CALL(rt_sigpending)
+	COMPATCALL(rt_sigtimedwait)
+	SYS32CALL(rt_sigqueueinfo)
+	STUB32CALL(rt_sigsuspend)
+	SYS32CALL(pread64)		/* 180 */
+	SYS32CALL(pwrite64)
+	SYSCALL(chown16)
+	SYSCALL(getcwd)
+	SYSCALL(capget)
+	SYSCALL(capset)			/* 185 */
+	STUB32CALL(sigaltstack)
+	SYS32CALL(sendfile)
+	SYS32CALL(ni_syscall)		/* reserved for streams1 */
+	SYS32CALL(ni_syscall)		/* reserved for streams2 */
+	STUB32CALL(vfork)		/* 190 */
+	COMPATCALL(getrlimit)
+	SYS32CALL(mmap2)
+	SYS32CALL(truncate64)
+	SYS32CALL(ftruncate64)
+	SYS32CALL(stat64)		/* 195 */
+	SYS32CALL(lstat64)
+	SYS32CALL(fstat64)
+	SYSCALL(lchown)
+	SYSCALL(getuid)
+	SYSCALL(getgid)			/* 200 */
+	SYSCALL(geteuid)
+	SYSCALL(getegid)
+	SYSCALL(setreuid)
+	SYSCALL(setregid)
+	SYSCALL(getgroups)		/* 205 */
+	SYSCALL(setgroups)
+	SYSCALL(fchown)
+	SYSCALL(setresuid)
+	SYSCALL(getresuid)
+	SYSCALL(setresgid)		/* 210 */
+	SYSCALL(getresgid)
+	SYSCALL(chown)
+	SYSCALL(setuid)
+	SYSCALL(setgid)
+	SYSCALL(setfsuid)		/* 215 */
+	SYSCALL(setfsgid)
+	SYSCALL(pivot_root)
+	SYSCALL(mincore)
+	SYSCALL(madvise)
+	COMPATCALL(getdents64)		/* 220 */
+	COMPATCALL(fcntl64)
+	SYS32CALL(ni_syscall)		/* TUX */
+	SYS32CALL(ni_syscall)		/* security */
+	SYSCALL(gettid)
+	SYSCALL(readahead)		/* 225 */
+	SYSCALL(setxattr)
+	SYSCALL(lsetxattr)
+	SYSCALL(fsetxattr)
+	SYSCALL(getxattr)
+	SYSCALL(lgetxattr)		/* 230 */
+	SYSCALL(fgetxattr)
+	SYSCALL(listxattr)
+	SYSCALL(llistxattr)
+	SYSCALL(flistxattr)
+	SYSCALL(removexattr)		/* 235 */
+	SYSCALL(lremovexattr)
+	SYSCALL(fremovexattr)
+	SYSCALL(tkill)
+	SYSCALL(sendfile64)
+	COMPATCALL(futex)		/* 240 */
+	COMPATCALL(sched_setaffinity)
+	COMPATCALL(sched_getaffinity)
+	SYS32CALL(set_thread_area)
+	SYS32CALL(get_thread_area)
+	COMPATCALL(io_setup)		/* 245 */
+	SYSCALL(io_destroy)
+	COMPATCALL(io_getevents)
+	COMPATCALL(io_submit)
+	SYSCALL(io_cancel)
+	SYSCALL(fadvise64)		/* 250 */
+	SYS32CALL(ni_syscall)		/* free_huge_pages */
+	SYSCALL(exit_group)
+	SYS32CALL(lookup_dcookie)
+	SYSCALL(epoll_create)
+	SYSCALL(epoll_ctl)		/* 255 */
+	SYSCALL(epoll_wait)
+ 	SYSCALL(remap_file_pages)
+ 	SYSCALL(set_tid_address)
+ 	COMPATCALL(timer_create)
+ 	COMPATCALL(timer_settime) 	/* 260 */
+ 	COMPATCALL(timer_gettime)
+ 	SYSCALL(timer_getoverrun)
+ 	SYSCALL(timer_delete)
+ 	COMPATCALL(clock_settime)
+ 	COMPATCALL(clock_gettime)	/* 265 */
+ 	COMPATCALL(clock_getres)
+ 	COMPATCALL(clock_nanosleep)
+	COMPATCALL(statfs64)
+	COMPATCALL(fstatfs64)
+	SYSCALL(tgkill)			/* 270 */
+	COMPATCALL(utimes)
+ 	SYS32CALL(fadvise64_64)
+	SYS32CALL(ni_syscall)		/* vserver */
+	SYSCALL(mbind)
+	COMPATCALL(get_mempolicy)	/* 275 */
+	SYSCALL(set_mempolicy)
+	COMPATCALL(mq_open)
+	SYSCALL(mq_unlink)
+	COMPATCALL(mq_timedsend)
+	COMPATCALL(mq_timedreceive)	/* 280 */
+	COMPATCALL(mq_notify)
+	COMPATCALL(mq_getsetattr)
+	COMPATCALL(kexec_load)
+	COMPATCALL(waitid)
+	SYS32CALL(ni_syscall)		/* 285 - altroot */
+	SYSCALL(add_key)
+	SYSCALL(request_key)
+	SYSCALL(keyctl)
+	SYSCALL(ioprio_set)
+	SYSCALL(ioprio_get)		/* 290 */
+	SYSCALL(inotify_init)
+	SYSCALL(inotify_add_watch)
+	SYSCALL(inotify_rm_watch)
+	SYSCALL(migrate_pages)
+	COMPATCALL(openat)		/* 295 */
+	SYSCALL(mkdirat)
+	SYSCALL(mknodat)
+	SYSCALL(fchownat)
+	COMPATCALL(futimesat)
+	COMPATCALL(newfstatat)		/* 300 */
+	SYSCALL(unlinkat)
+	SYSCALL(renameat)
+	SYSCALL(linkat)
+	SYSCALL(symlinkat)
+	SYSCALL(readlinkat)		/* 305 */
+	SYSCALL(fchmodat)
+	SYSCALL(faccessat)
+	SYSCALL(pselect6)
+	SYSCALL(ppoll)
+	SYSCALL(unshare)		/* 310 */
+	SYSCALL(epoll_pwait)
-- 
Chuck
