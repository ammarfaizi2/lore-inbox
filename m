Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267573AbTCFBTQ>; Wed, 5 Mar 2003 20:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbTCFBTQ>; Wed, 5 Mar 2003 20:19:16 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:47601 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267573AbTCFBS5>;
	Wed, 5 Mar 2003 20:18:57 -0500
Message-ID: <3E66A44A.6000808@mvista.com>
Date: Wed, 05 Mar 2003 17:28:42 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Making it easy to add system calls
Content-Type: multipart/mixed;
 boundary="------------040908080409020106000408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------040908080409020106000408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch defines a new file 
(.../include/asm-i386/sys_calls.h) which defines all the system call 
names and numbers.  The number is defined via "enum".  The normal call 
has a well defined entry point to name relationship, but not all do, 
so a way to do the "non-confroming" calls is included.  To add a new 
call all one needs to do is to add a line at the end of the list in 
this header file, for example:

SYS_CALL(clock_nanosleep) \

This will put "sys_clock_nanosleep" in the call table in entry.S and 
define the "__NR_clock_nanosleep" for unistd.  The last entry of the 
enum is NR_syscalls, thus defineing and keeping this symbol current.

Of course we will be adding no more system calls, but it does make 
things a _lot_ easier.

The binary from entry.S was compared to the prior binary and found to 
be the same.  A small set of the library stubs was produced and also 
compared.  And a system was built and tested.  All worked fine.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------040908080409020106000408
Content-Type: text/plain;
 name="syscall-2.5.64-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syscall-2.5.64-1.0.patch"

diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.64-kb/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.64-kb/arch/i386/kernel/entry.S	2003-03-05 15:11:21.000000000 -0800
+++ linux/arch/i386/kernel/entry.S	2003-03-05 15:15:43.000000000 -0800
@@ -562,274 +562,9 @@
 
 .data
 ENTRY(sys_call_table)
-	.long sys_restart_syscall	/* 0 - old "setup()" system call, used for restarting */
-	.long sys_exit
-	.long sys_fork
-	.long sys_read
-	.long sys_write
-	.long sys_open		/* 5 */
-	.long sys_close
-	.long sys_waitpid
-	.long sys_creat
-	.long sys_link
-	.long sys_unlink	/* 10 */
-	.long sys_execve
-	.long sys_chdir
-	.long sys_time
-	.long sys_mknod
-	.long sys_chmod		/* 15 */
-	.long sys_lchown16
-	.long sys_ni_syscall	/* old break syscall holder */
-	.long sys_stat
-	.long sys_lseek
-	.long sys_getpid	/* 20 */
-	.long sys_mount
-	.long sys_oldumount
-	.long sys_setuid16
-	.long sys_getuid16
-	.long sys_stime		/* 25 */
-	.long sys_ptrace
-	.long sys_alarm
-	.long sys_fstat
-	.long sys_pause
-	.long sys_utime		/* 30 */
-	.long sys_ni_syscall	/* old stty syscall holder */
-	.long sys_ni_syscall	/* old gtty syscall holder */
-	.long sys_access
-	.long sys_nice
-	.long sys_ni_syscall	/* 35 - old ftime syscall holder */
-	.long sys_sync
-	.long sys_kill
-	.long sys_rename
-	.long sys_mkdir
-	.long sys_rmdir		/* 40 */
-	.long sys_dup
-	.long sys_pipe
-	.long sys_times
-	.long sys_ni_syscall	/* old prof syscall holder */
-	.long sys_brk		/* 45 */
-	.long sys_setgid16
-	.long sys_getgid16
-	.long sys_signal
-	.long sys_geteuid16
-	.long sys_getegid16	/* 50 */
-	.long sys_acct
-	.long sys_umount	/* recycled never used phys() */
-	.long sys_ni_syscall	/* old lock syscall holder */
-	.long sys_ioctl
-	.long sys_fcntl		/* 55 */
-	.long sys_ni_syscall	/* old mpx syscall holder */
-	.long sys_setpgid
-	.long sys_ni_syscall	/* old ulimit syscall holder */
-	.long sys_olduname
-	.long sys_umask		/* 60 */
-	.long sys_chroot
-	.long sys_ustat
-	.long sys_dup2
-	.long sys_getppid
-	.long sys_getpgrp	/* 65 */
-	.long sys_setsid
-	.long sys_sigaction
-	.long sys_sgetmask
-	.long sys_ssetmask
-	.long sys_setreuid16	/* 70 */
-	.long sys_setregid16
-	.long sys_sigsuspend
-	.long sys_sigpending
-	.long sys_sethostname
-	.long sys_setrlimit	/* 75 */
-	.long sys_old_getrlimit
-	.long sys_getrusage
-	.long sys_gettimeofday
-	.long sys_settimeofday
-	.long sys_getgroups16	/* 80 */
-	.long sys_setgroups16
-	.long old_select
-	.long sys_symlink
-	.long sys_lstat
-	.long sys_readlink	/* 85 */
-	.long sys_uselib
-	.long sys_swapon
-	.long sys_reboot
-	.long old_readdir
-	.long old_mmap		/* 90 */
-	.long sys_munmap
-	.long sys_truncate
-	.long sys_ftruncate
-	.long sys_fchmod
-	.long sys_fchown16	/* 95 */
-	.long sys_getpriority
-	.long sys_setpriority
-	.long sys_ni_syscall	/* old profil syscall holder */
-	.long sys_statfs
-	.long sys_fstatfs	/* 100 */
-	.long sys_ioperm
-	.long sys_socketcall
-	.long sys_syslog
-	.long sys_setitimer
-	.long sys_getitimer	/* 105 */
-	.long sys_newstat
-	.long sys_newlstat
-	.long sys_newfstat
-	.long sys_uname
-	.long sys_iopl		/* 110 */
-	.long sys_vhangup
-	.long sys_ni_syscall	/* old "idle" system call */
-	.long sys_vm86old
-	.long sys_wait4
-	.long sys_swapoff	/* 115 */
-	.long sys_sysinfo
-	.long sys_ipc
-	.long sys_fsync
-	.long sys_sigreturn
-	.long sys_clone		/* 120 */
-	.long sys_setdomainname
-	.long sys_newuname
-	.long sys_modify_ldt
-	.long sys_adjtimex
-	.long sys_mprotect	/* 125 */
-	.long sys_sigprocmask
-	.long sys_ni_syscall	/* old "create_module" */ 
-	.long sys_init_module
-	.long sys_delete_module
-	.long sys_ni_syscall	/* 130:	old "get_kernel_syms" */
-	.long sys_quotactl
-	.long sys_getpgid
-	.long sys_fchdir
-	.long sys_bdflush
-	.long sys_sysfs		/* 135 */
-	.long sys_personality
-	.long sys_ni_syscall	/* reserved for afs_syscall */
-	.long sys_setfsuid16
-	.long sys_setfsgid16
-	.long sys_llseek	/* 140 */
-	.long sys_getdents
-	.long sys_select
-	.long sys_flock
-	.long sys_msync
-	.long sys_readv		/* 145 */
-	.long sys_writev
-	.long sys_getsid
-	.long sys_fdatasync
-	.long sys_sysctl
-	.long sys_mlock		/* 150 */
-	.long sys_munlock
-	.long sys_mlockall
-	.long sys_munlockall
-	.long sys_sched_setparam
-	.long sys_sched_getparam   /* 155 */
-	.long sys_sched_setscheduler
-	.long sys_sched_getscheduler
-	.long sys_sched_yield
-	.long sys_sched_get_priority_max
-	.long sys_sched_get_priority_min  /* 160 */
-	.long sys_sched_rr_get_interval
-	.long sys_nanosleep
-	.long sys_mremap
-	.long sys_setresuid16
-	.long sys_getresuid16	/* 165 */
-	.long sys_vm86
-	.long sys_ni_syscall	/* Old sys_query_module */
-	.long sys_poll
-	.long sys_nfsservctl
-	.long sys_setresgid16	/* 170 */
-	.long sys_getresgid16
-	.long sys_prctl
-	.long sys_rt_sigreturn
-	.long sys_rt_sigaction
-	.long sys_rt_sigprocmask	/* 175 */
-	.long sys_rt_sigpending
-	.long sys_rt_sigtimedwait
-	.long sys_rt_sigqueueinfo
-	.long sys_rt_sigsuspend
-	.long sys_pread64	/* 180 */
-	.long sys_pwrite64
-	.long sys_chown16
-	.long sys_getcwd
-	.long sys_capget
-	.long sys_capset	/* 185 */
-	.long sys_sigaltstack
-	.long sys_sendfile
-	.long sys_ni_syscall	/* reserved for streams1 */
-	.long sys_ni_syscall	/* reserved for streams2 */
-	.long sys_vfork		/* 190 */
-	.long sys_getrlimit
-	.long sys_mmap2
-	.long sys_truncate64
-	.long sys_ftruncate64
-	.long sys_stat64	/* 195 */
-	.long sys_lstat64
-	.long sys_fstat64
-	.long sys_lchown
-	.long sys_getuid
-	.long sys_getgid	/* 200 */
-	.long sys_geteuid
-	.long sys_getegid
-	.long sys_setreuid
-	.long sys_setregid
-	.long sys_getgroups	/* 205 */
-	.long sys_setgroups
-	.long sys_fchown
-	.long sys_setresuid
-	.long sys_getresuid
-	.long sys_setresgid	/* 210 */
-	.long sys_getresgid
-	.long sys_chown
-	.long sys_setuid
-	.long sys_setgid
-	.long sys_setfsuid	/* 215 */
-	.long sys_setfsgid
-	.long sys_pivot_root
-	.long sys_mincore
-	.long sys_madvise
-	.long sys_getdents64	/* 220 */
-	.long sys_fcntl64
-	.long sys_ni_syscall	/* reserved for TUX */
-	.long sys_ni_syscall
-	.long sys_gettid
-	.long sys_readahead	/* 225 */
-	.long sys_setxattr
-	.long sys_lsetxattr
-	.long sys_fsetxattr
-	.long sys_getxattr
-	.long sys_lgetxattr	/* 230 */
-	.long sys_fgetxattr
-	.long sys_listxattr
-	.long sys_llistxattr
-	.long sys_flistxattr
-	.long sys_removexattr	/* 235 */
-	.long sys_lremovexattr
-	.long sys_fremovexattr
-	.long sys_tkill
-	.long sys_sendfile64
-	.long sys_futex		/* 240 */
-	.long sys_sched_setaffinity
-	.long sys_sched_getaffinity
-	.long sys_set_thread_area
-	.long sys_get_thread_area
-	.long sys_io_setup	/* 245 */
-	.long sys_io_destroy
-	.long sys_io_getevents
-	.long sys_io_submit
-	.long sys_io_cancel
-	.long sys_fadvise64	/* 250 */
-	.long sys_ni_syscall
-	.long sys_exit_group
-	.long sys_lookup_dcookie
-	.long sys_epoll_create
-	.long sys_epoll_ctl	/* 255 */
-	.long sys_epoll_wait
- 	.long sys_remap_file_pages
- 	.long sys_set_tid_address
- 	.long sys_timer_create
- 	.long sys_timer_settime		/* 260 */
- 	.long sys_timer_gettime
- 	.long sys_timer_getoverrun
- 	.long sys_timer_delete
- 	.long sys_clock_settime
- 	.long sys_clock_gettime		/* 265 */
- 	.long sys_clock_getres
- 	.long sys_clock_nanosleep
- 
+	
+#define SYS_CALL_PTRS
+#include <asm/sys_calls.h>
+
  
 nr_syscalls=(.-sys_call_table)/4
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.64-kb/include/asm-i386/sys_calls.h linux/include/asm-i386/sys_calls.h
--- linux-2.5.64-kb/include/asm-i386/sys_calls.h	1969-12-31 16:00:00.000000000 -0800
+++ linux/include/asm-i386/sys_calls.h	2003-03-05 15:25:50.000000000 -0800
@@ -0,0 +1,311 @@
+#ifndef SYS_CALLS_F
+#define SYS_CALLS_F
+
+#ifdef SYS_CALL_PTRS
+/* 
+ * For some unknown reason asm code is run through cpp with the 
+ * -traditional flag on.  We set this up so we don't care...
+ */
+#ifndef __STDC__
+#define SYS_CALL_F(fun)  sys_/**/fun
+#define SYS_CALL(fun)  , sys_/**/fun
+#else
+#define SYS_CALL_F(fun)  sys_ ## fun
+#define SYS_CALL(fun)  , sys_ ## fun
+#endif
+#define SYS_CALL_R(fun)  , sys_ni_syscall
+#define SYS_CALL_D(x, fun)  , fun
+#define SYS_CALL_END 
+#endif
+
+#ifdef SYS_CALL_NUMS
+#define SYS_CALL(fun)  __NR_ ##fun,
+#define SYS_CALL_F(fun)  SYS_CALL(fun)
+#define SYS_CALL_R(fun)  __NR_ ##fun,
+#define SYS_CALL_D(x, fun)   __NR_ ## x,
+#define SYS_CALL_END NR_syscalls
+#endif
+#define do_calls          \
+SYS_CALL_F(restart_syscall)	\
+SYS_CALL(exit)	\
+SYS_CALL(fork)	\
+SYS_CALL(read)	\
+SYS_CALL(write)	\
+SYS_CALL(open)	\
+SYS_CALL(close)	\
+SYS_CALL(waitpid)	\
+SYS_CALL(creat)	\
+SYS_CALL(link)	\
+SYS_CALL(unlink)	\
+SYS_CALL(execve)	\
+SYS_CALL(chdir)	\
+SYS_CALL(time)	\
+SYS_CALL(mknod)	\
+SYS_CALL(chmod)	\
+SYS_CALL_D(lchown, sys_lchown16)	\
+SYS_CALL_R(break)	\
+SYS_CALL_D(oldstat, sys_stat )	\
+SYS_CALL(lseek)	\
+SYS_CALL(getpid)	\
+SYS_CALL(mount)	\
+SYS_CALL_D(umount, sys_oldumount)	\
+SYS_CALL_D(setuid, sys_setuid16)	\
+SYS_CALL_D(getuid, sys_getuid16)	\
+SYS_CALL(stime)	\
+SYS_CALL(ptrace)	\
+SYS_CALL(alarm)	\
+SYS_CALL_D(oldfstat, sys_fstat)	\
+SYS_CALL(pause)	\
+SYS_CALL(utime)	\
+SYS_CALL_R(stty)	\
+SYS_CALL_R(gtty)	\
+SYS_CALL(access)	\
+SYS_CALL(nice)	\
+SYS_CALL_R(ftime)	\
+SYS_CALL(sync)	\
+SYS_CALL(kill)	\
+SYS_CALL(rename)	\
+SYS_CALL(mkdir)	\
+SYS_CALL(rmdir)	\
+SYS_CALL(dup)	\
+SYS_CALL(pipe)	\
+SYS_CALL(times)	\
+SYS_CALL_R(prof)	\
+SYS_CALL(brk)	\
+SYS_CALL_D(setgid, sys_setgid16)	\
+SYS_CALL_D(getgid, sys_getgid16)	\
+SYS_CALL(signal)	\
+SYS_CALL_D(geteuid, sys_geteuid16)	\
+SYS_CALL_D(getegid, sys_getegid16)	\
+SYS_CALL(acct)	\
+SYS_CALL_D(umount2, sys_umount)	\
+SYS_CALL_R(lock)	\
+SYS_CALL(ioctl)	\
+SYS_CALL(fcntl)	\
+SYS_CALL_R(mpx)	\
+SYS_CALL(setpgid)	\
+SYS_CALL_R(ulimit)	\
+SYS_CALL_D(oldolduname, sys_olduname)	\
+SYS_CALL(umask)	\
+SYS_CALL(chroot)	\
+SYS_CALL(ustat)	\
+SYS_CALL(dup2)	\
+SYS_CALL(getppid)	\
+SYS_CALL(getpgrp)	\
+SYS_CALL(setsid)	\
+SYS_CALL(sigaction)	\
+SYS_CALL(sgetmask)	\
+SYS_CALL(ssetmask)	\
+SYS_CALL_D(setreuid, sys_setreuid16)	\
+SYS_CALL_D(setregid, sys_setregid16)	\
+SYS_CALL(sigsuspend)	\
+SYS_CALL(sigpending)	\
+SYS_CALL(sethostname)	\
+SYS_CALL(setrlimit)	\
+SYS_CALL_D(getrlimit, sys_old_getrlimit)	\
+SYS_CALL(getrusage)	\
+SYS_CALL(gettimeofday)	\
+SYS_CALL(settimeofday)	\
+SYS_CALL_D(getgroups, sys_getgroups16)	\
+SYS_CALL_D(setgroups, sys_setgroups16)	\
+SYS_CALL_D(select, old_select)	\
+SYS_CALL(symlink)	\
+SYS_CALL_D(oldlstat, sys_lstat)	\
+SYS_CALL(readlink)	\
+SYS_CALL(uselib)	\
+SYS_CALL(swapon)	\
+SYS_CALL(reboot)	\
+SYS_CALL_D(readdir, old_readdir)	\
+SYS_CALL_D(mmap, old_mmap)	\
+SYS_CALL(munmap)	\
+SYS_CALL(truncate)	\
+SYS_CALL(ftruncate)	\
+SYS_CALL(fchmod)	\
+SYS_CALL_D(fchown, sys_fchown16)	\
+SYS_CALL(getpriority)	\
+SYS_CALL(setpriority)	\
+SYS_CALL_R(profil)	\
+SYS_CALL(statfs)	\
+SYS_CALL(fstatfs)	\
+SYS_CALL(ioperm)	\
+SYS_CALL(socketcall)	\
+SYS_CALL(syslog)	\
+SYS_CALL(setitimer)	\
+SYS_CALL(getitimer)	\
+SYS_CALL_D(stat, sys_newstat)	\
+SYS_CALL_D(lstat, sys_newlstat)	\
+SYS_CALL_D(fstat, sys_newfstat)	\
+SYS_CALL_D(olduname, sys_uname)	\
+SYS_CALL(iopl)	\
+SYS_CALL(vhangup)	\
+SYS_CALL_R(idle)	\
+SYS_CALL(vm86old)	\
+SYS_CALL(wait4)	\
+SYS_CALL(swapoff)	\
+SYS_CALL(sysinfo)	\
+SYS_CALL(ipc)	\
+SYS_CALL(fsync)	\
+SYS_CALL(sigreturn)	\
+SYS_CALL(clone)	\
+SYS_CALL(setdomainname)	\
+SYS_CALL_D(uname, sys_newuname)	\
+SYS_CALL(modify_ldt)	\
+SYS_CALL(adjtimex)	\
+SYS_CALL(mprotect)	\
+SYS_CALL(sigprocmask)	\
+SYS_CALL_R(create_module)	\
+SYS_CALL(init_module)	\
+SYS_CALL(delete_module)	\
+SYS_CALL_R(get_kernel_syms)	\
+SYS_CALL(quotactl)	\
+SYS_CALL(getpgid)	\
+SYS_CALL(fchdir)	\
+SYS_CALL(bdflush)	\
+SYS_CALL(sysfs)	\
+SYS_CALL(personality)	\
+SYS_CALL_R(afs_syscall)	\
+SYS_CALL_D(setfsuid, sys_setfsuid16)	\
+SYS_CALL_D(setfsgid, sys_setfsgid16)	\
+SYS_CALL_D(_llseek, sys_llseek)	\
+SYS_CALL(getdents)	\
+SYS_CALL_D(_newselect, sys_select)	\
+SYS_CALL(flock)	\
+SYS_CALL(msync)	\
+SYS_CALL(readv)	\
+SYS_CALL(writev)	\
+SYS_CALL(getsid)	\
+SYS_CALL(fdatasync)	\
+SYS_CALL_D(_sysctl, sys_sysctl)	\
+SYS_CALL(mlock)	\
+SYS_CALL(munlock)	\
+SYS_CALL(mlockall)	\
+SYS_CALL(munlockall)	\
+SYS_CALL(sched_setparam)	\
+SYS_CALL(sched_getparam)	\
+SYS_CALL(sched_setscheduler)	\
+SYS_CALL(sched_getscheduler)	\
+SYS_CALL(sched_yield)	\
+SYS_CALL(sched_get_priority_max)	\
+SYS_CALL(sched_get_priority_min)	\
+SYS_CALL(sched_rr_get_interval)	\
+SYS_CALL(nanosleep)	\
+SYS_CALL(mremap)	\
+SYS_CALL_D(setresuid, sys_setresuid16)	\
+SYS_CALL_D(getresuid, sys_getresuid16)	\
+SYS_CALL(vm86)	\
+SYS_CALL_R(query_module)	\
+SYS_CALL(poll)	\
+SYS_CALL(nfsservctl)	\
+SYS_CALL_D(setresgid, sys_setresgid16)	\
+SYS_CALL_D(getresgid, sys_getresgid16)	\
+SYS_CALL(prctl)	\
+SYS_CALL(rt_sigreturn)	\
+SYS_CALL(rt_sigaction)	\
+SYS_CALL(rt_sigprocmask)	\
+SYS_CALL(rt_sigpending)	\
+SYS_CALL(rt_sigtimedwait)	\
+SYS_CALL(rt_sigqueueinfo)	\
+SYS_CALL(rt_sigsuspend)	\
+SYS_CALL(pread64)	\
+SYS_CALL(pwrite64)	\
+SYS_CALL_D(chown, sys_chown16)	\
+SYS_CALL(getcwd)	\
+SYS_CALL(capget)	\
+SYS_CALL(capset)	\
+SYS_CALL(sigaltstack)	\
+SYS_CALL(sendfile)	\
+SYS_CALL_R(getpmsg)	\
+SYS_CALL_R(putpmsg)	\
+SYS_CALL(vfork)	\
+SYS_CALL_D(ugetrlimit, sys_getrlimit)	\
+SYS_CALL(mmap2)	\
+SYS_CALL(truncate64)	\
+SYS_CALL(ftruncate64)	\
+SYS_CALL(stat64)	\
+SYS_CALL(lstat64)	\
+SYS_CALL(fstat64)	\
+SYS_CALL_D(lchown32, sys_lchown)	\
+SYS_CALL_D(getuid32, sys_getuid)	\
+SYS_CALL_D(getgid32, sys_getgid)	\
+SYS_CALL_D(geteuid32, sys_geteuid)	\
+SYS_CALL_D(getegid32, sys_getegid)	\
+SYS_CALL_D(setreuid32, sys_setreuid)	\
+SYS_CALL_D(setregid32, sys_setregid)	\
+SYS_CALL_D(getgroups32, sys_getgroups)	\
+SYS_CALL_D(setgroups32, sys_setgroups)	\
+SYS_CALL_D(fchown32, sys_fchown)	\
+SYS_CALL_D(setresuid32, sys_setresuid)	\
+SYS_CALL_D(getresuid32, sys_getresuid)	\
+SYS_CALL_D(setresgid32, sys_setresgid)	\
+SYS_CALL_D(getresgid32, sys_getresgid)	\
+SYS_CALL_D(chown32, sys_chown)	\
+SYS_CALL_D(setuid32, sys_setuid)	\
+SYS_CALL_D(setgid32, sys_setgid)	\
+SYS_CALL_D(setfsuid32, sys_setfsuid)	\
+SYS_CALL_D(setfsgid32, sys_setfsgid)	\
+SYS_CALL(pivot_root)	\
+SYS_CALL(mincore)	\
+SYS_CALL(madvise)	\
+SYS_CALL(getdents64)	\
+SYS_CALL(fcntl64)	\
+SYS_CALL_R(tux1)	\
+SYS_CALL_R(tux2)	\
+SYS_CALL(gettid)	\
+SYS_CALL(readahead)	\
+SYS_CALL(setxattr)	\
+SYS_CALL(lsetxattr)	\
+SYS_CALL(fsetxattr)	\
+SYS_CALL(getxattr)	\
+SYS_CALL(lgetxattr)	\
+SYS_CALL(fgetxattr)	\
+SYS_CALL(listxattr)	\
+SYS_CALL(llistxattr)	\
+SYS_CALL(flistxattr)	\
+SYS_CALL(removexattr)	\
+SYS_CALL(lremovexattr)	\
+SYS_CALL(fremovexattr)	\
+SYS_CALL(tkill)	\
+SYS_CALL(sendfile64)	\
+SYS_CALL(futex)	\
+SYS_CALL(sched_setaffinity)	\
+SYS_CALL(sched_getaffinity)	\
+SYS_CALL(set_thread_area)	\
+SYS_CALL(get_thread_area)	\
+SYS_CALL(io_setup)	\
+SYS_CALL(io_destroy)	\
+SYS_CALL(io_getevents)	\
+SYS_CALL(io_submit)	\
+SYS_CALL(io_cancel)	\
+SYS_CALL(fadvise64)	\
+SYS_CALL_R(empty1)	\
+SYS_CALL(exit_group)	\
+SYS_CALL(lookup_dcookie)	\
+SYS_CALL(epoll_create)	\
+SYS_CALL(epoll_ctl)	\
+SYS_CALL(epoll_wait)	\
+SYS_CALL(remap_file_pages)	\
+SYS_CALL(set_tid_address)	\
+SYS_CALL(timer_create)	\
+SYS_CALL(timer_settime)	\
+SYS_CALL(timer_gettime)	\
+SYS_CALL(timer_getoverrun)	\
+SYS_CALL(timer_delete)	\
+SYS_CALL(clock_settime)	\
+SYS_CALL(clock_gettime)	\
+SYS_CALL(clock_getres)	\
+SYS_CALL(clock_nanosleep)	\
+SYS_CALL_END
+
+
+#ifdef SYS_CALL_PTRS
+     .long do_calls
+#endif
+#ifdef SYS_CALL_NUMS
+
+enum {
+do_calls
+};
+#define __NR_madvise1 __NR_madvise
+#endif
+
+#endif
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.64-kb/include/asm-i386/unistd.h linux/include/asm-i386/unistd.h
--- linux-2.5.64-kb/include/asm-i386/unistd.h	2003-03-05 15:09:47.000000000 -0800
+++ linux/include/asm-i386/unistd.h	2003-03-05 15:18:14.000000000 -0800
@@ -4,277 +4,8 @@
 /*
  * This file contains the system call numbers.
  */
-
-#define __NR_restart_syscall      0
-#define __NR_exit		  1
-#define __NR_fork		  2
-#define __NR_read		  3
-#define __NR_write		  4
-#define __NR_open		  5
-#define __NR_close		  6
-#define __NR_waitpid		  7
-#define __NR_creat		  8
-#define __NR_link		  9
-#define __NR_unlink		 10
-#define __NR_execve		 11
-#define __NR_chdir		 12
-#define __NR_time		 13
-#define __NR_mknod		 14
-#define __NR_chmod		 15
-#define __NR_lchown		 16
-#define __NR_break		 17
-#define __NR_oldstat		 18
-#define __NR_lseek		 19
-#define __NR_getpid		 20
-#define __NR_mount		 21
-#define __NR_umount		 22
-#define __NR_setuid		 23
-#define __NR_getuid		 24
-#define __NR_stime		 25
-#define __NR_ptrace		 26
-#define __NR_alarm		 27
-#define __NR_oldfstat		 28
-#define __NR_pause		 29
-#define __NR_utime		 30
-#define __NR_stty		 31
-#define __NR_gtty		 32
-#define __NR_access		 33
-#define __NR_nice		 34
-#define __NR_ftime		 35
-#define __NR_sync		 36
-#define __NR_kill		 37
-#define __NR_rename		 38
-#define __NR_mkdir		 39
-#define __NR_rmdir		 40
-#define __NR_dup		 41
-#define __NR_pipe		 42
-#define __NR_times		 43
-#define __NR_prof		 44
-#define __NR_brk		 45
-#define __NR_setgid		 46
-#define __NR_getgid		 47
-#define __NR_signal		 48
-#define __NR_geteuid		 49
-#define __NR_getegid		 50
-#define __NR_acct		 51
-#define __NR_umount2		 52
-#define __NR_lock		 53
-#define __NR_ioctl		 54
-#define __NR_fcntl		 55
-#define __NR_mpx		 56
-#define __NR_setpgid		 57
-#define __NR_ulimit		 58
-#define __NR_oldolduname	 59
-#define __NR_umask		 60
-#define __NR_chroot		 61
-#define __NR_ustat		 62
-#define __NR_dup2		 63
-#define __NR_getppid		 64
-#define __NR_getpgrp		 65
-#define __NR_setsid		 66
-#define __NR_sigaction		 67
-#define __NR_sgetmask		 68
-#define __NR_ssetmask		 69
-#define __NR_setreuid		 70
-#define __NR_setregid		 71
-#define __NR_sigsuspend		 72
-#define __NR_sigpending		 73
-#define __NR_sethostname	 74
-#define __NR_setrlimit		 75
-#define __NR_getrlimit		 76	/* Back compatible 2Gig limited rlimit */
-#define __NR_getrusage		 77
-#define __NR_gettimeofday	 78
-#define __NR_settimeofday	 79
-#define __NR_getgroups		 80
-#define __NR_setgroups		 81
-#define __NR_select		 82
-#define __NR_symlink		 83
-#define __NR_oldlstat		 84
-#define __NR_readlink		 85
-#define __NR_uselib		 86
-#define __NR_swapon		 87
-#define __NR_reboot		 88
-#define __NR_readdir		 89
-#define __NR_mmap		 90
-#define __NR_munmap		 91
-#define __NR_truncate		 92
-#define __NR_ftruncate		 93
-#define __NR_fchmod		 94
-#define __NR_fchown		 95
-#define __NR_getpriority	 96
-#define __NR_setpriority	 97
-#define __NR_profil		 98
-#define __NR_statfs		 99
-#define __NR_fstatfs		100
-#define __NR_ioperm		101
-#define __NR_socketcall		102
-#define __NR_syslog		103
-#define __NR_setitimer		104
-#define __NR_getitimer		105
-#define __NR_stat		106
-#define __NR_lstat		107
-#define __NR_fstat		108
-#define __NR_olduname		109
-#define __NR_iopl		110
-#define __NR_vhangup		111
-#define __NR_idle		112
-#define __NR_vm86old		113
-#define __NR_wait4		114
-#define __NR_swapoff		115
-#define __NR_sysinfo		116
-#define __NR_ipc		117
-#define __NR_fsync		118
-#define __NR_sigreturn		119
-#define __NR_clone		120
-#define __NR_setdomainname	121
-#define __NR_uname		122
-#define __NR_modify_ldt		123
-#define __NR_adjtimex		124
-#define __NR_mprotect		125
-#define __NR_sigprocmask	126
-#define __NR_create_module	127
-#define __NR_init_module	128
-#define __NR_delete_module	129
-#define __NR_get_kernel_syms	130
-#define __NR_quotactl		131
-#define __NR_getpgid		132
-#define __NR_fchdir		133
-#define __NR_bdflush		134
-#define __NR_sysfs		135
-#define __NR_personality	136
-#define __NR_afs_syscall	137 /* Syscall for Andrew File System */
-#define __NR_setfsuid		138
-#define __NR_setfsgid		139
-#define __NR__llseek		140
-#define __NR_getdents		141
-#define __NR__newselect		142
-#define __NR_flock		143
-#define __NR_msync		144
-#define __NR_readv		145
-#define __NR_writev		146
-#define __NR_getsid		147
-#define __NR_fdatasync		148
-#define __NR__sysctl		149
-#define __NR_mlock		150
-#define __NR_munlock		151
-#define __NR_mlockall		152
-#define __NR_munlockall		153
-#define __NR_sched_setparam		154
-#define __NR_sched_getparam		155
-#define __NR_sched_setscheduler		156
-#define __NR_sched_getscheduler		157
-#define __NR_sched_yield		158
-#define __NR_sched_get_priority_max	159
-#define __NR_sched_get_priority_min	160
-#define __NR_sched_rr_get_interval	161
-#define __NR_nanosleep		162
-#define __NR_mremap		163
-#define __NR_setresuid		164
-#define __NR_getresuid		165
-#define __NR_vm86		166
-#define __NR_query_module	167
-#define __NR_poll		168
-#define __NR_nfsservctl		169
-#define __NR_setresgid		170
-#define __NR_getresgid		171
-#define __NR_prctl              172
-#define __NR_rt_sigreturn	173
-#define __NR_rt_sigaction	174
-#define __NR_rt_sigprocmask	175
-#define __NR_rt_sigpending	176
-#define __NR_rt_sigtimedwait	177
-#define __NR_rt_sigqueueinfo	178
-#define __NR_rt_sigsuspend	179
-#define __NR_pread64		180
-#define __NR_pwrite64		181
-#define __NR_chown		182
-#define __NR_getcwd		183
-#define __NR_capget		184
-#define __NR_capset		185
-#define __NR_sigaltstack	186
-#define __NR_sendfile		187
-#define __NR_getpmsg		188	/* some people actually want streams */
-#define __NR_putpmsg		189	/* some people actually want streams */
-#define __NR_vfork		190
-#define __NR_ugetrlimit		191	/* SuS compliant getrlimit */
-#define __NR_mmap2		192
-#define __NR_truncate64		193
-#define __NR_ftruncate64	194
-#define __NR_stat64		195
-#define __NR_lstat64		196
-#define __NR_fstat64		197
-#define __NR_lchown32		198
-#define __NR_getuid32		199
-#define __NR_getgid32		200
-#define __NR_geteuid32		201
-#define __NR_getegid32		202
-#define __NR_setreuid32		203
-#define __NR_setregid32		204
-#define __NR_getgroups32	205
-#define __NR_setgroups32	206
-#define __NR_fchown32		207
-#define __NR_setresuid32	208
-#define __NR_getresuid32	209
-#define __NR_setresgid32	210
-#define __NR_getresgid32	211
-#define __NR_chown32		212
-#define __NR_setuid32		213
-#define __NR_setgid32		214
-#define __NR_setfsuid32		215
-#define __NR_setfsgid32		216
-#define __NR_pivot_root		217
-#define __NR_mincore		218
-#define __NR_madvise		219
-#define __NR_madvise1		219	/* delete when C lib stub is removed */
-#define __NR_getdents64		220
-#define __NR_fcntl64		221
-/* 223 is unused */
-#define __NR_gettid		224
-#define __NR_readahead		225
-#define __NR_setxattr		226
-#define __NR_lsetxattr		227
-#define __NR_fsetxattr		228
-#define __NR_getxattr		229
-#define __NR_lgetxattr		230
-#define __NR_fgetxattr		231
-#define __NR_listxattr		232
-#define __NR_llistxattr		233
-#define __NR_flistxattr		234
-#define __NR_removexattr	235
-#define __NR_lremovexattr	236
-#define __NR_fremovexattr	237
-#define __NR_tkill		238
-#define __NR_sendfile64		239
-#define __NR_futex		240
-#define __NR_sched_setaffinity	241
-#define __NR_sched_getaffinity	242
-#define __NR_set_thread_area	243
-#define __NR_get_thread_area	244
-#define __NR_io_setup		245
-#define __NR_io_destroy		246
-#define __NR_io_getevents	247
-#define __NR_io_submit		248
-#define __NR_io_cancel		249
-#define __NR_fadvise64		250
-
-#define __NR_exit_group		252
-#define __NR_lookup_dcookie	253
-#define __NR_epoll_create	254
-#define __NR_epoll_ctl		255
-#define __NR_epoll_wait		256
-#define __NR_remap_file_pages	257
-#define __NR_set_tid_address	258
-#define __NR_timer_create	259
-#define __NR_timer_settime	(__NR_timer_create+1)
-#define __NR_timer_gettime	(__NR_timer_create+2)
-#define __NR_timer_getoverrun	(__NR_timer_create+3)
-#define __NR_timer_delete	(__NR_timer_create+4)
-#define __NR_clock_settime	(__NR_timer_create+5)
-#define __NR_clock_gettime	(__NR_timer_create+6)
-#define __NR_clock_getres	(__NR_timer_create+7)
-#define __NR_clock_nanosleep	(__NR_timer_create+8)
-
-#define NR_syscalls 268
+#define SYS_CALL_NUMS
+#include <asm/sys_calls.h>
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
Binary files linux-2.5.64-kb/lib/gen_crc32table and linux/lib/gen_crc32table differ
Binary files linux-2.5.64-kb/scripts/docproc and linux/scripts/docproc differ
Binary files linux-2.5.64-kb/scripts/fixdep and linux/scripts/fixdep differ
Binary files linux-2.5.64-kb/scripts/kallsyms and linux/scripts/kallsyms differ
Binary files linux-2.5.64-kb/scripts/mk_elfconfig and linux/scripts/mk_elfconfig differ
Binary files linux-2.5.64-kb/scripts/modpost and linux/scripts/modpost differ
Binary files linux-2.5.64-kb/usr/gen_init_cpio and linux/usr/gen_init_cpio differ
Binary files linux-2.5.64-kb/usr/initramfs_data.cpio.gz and linux/usr/initramfs_data.cpio.gz differ

--------------040908080409020106000408--

