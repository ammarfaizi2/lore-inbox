Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbUKCDzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbUKCDzi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 22:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbUKCDzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 22:55:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29928 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261371AbUKCDyy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 22:54:54 -0500
Date: Wed, 3 Nov 2004 03:54:53 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org
Subject: compat syscalls naming standardisation
Message-ID: <20041103035453.GR24690@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On PA-RISC, we have a unified syscall table for 32 and 64 bit that uses
macros to generate the appropriate syscall names (native vs compat).
For this to work, we need consistent compat syscall names.  Unfortunately,
some recent additions drop the 'sys_'.  This patch won't apply now that
the sys_ni.c patch is in.  I'll rediff it against -bk tomorrow morning
and submit it.

diff -urpNX dontdiff linux-2.6.10-rc1-bk12/arch/ia64/ia32/ia32_entry.S parisc-2.6-bk/arch/ia64/ia32/ia32_entry.S
--- linux-2.6.10-rc1-bk12/arch/ia64/ia32/ia32_entry.S	Fri Oct 22 15:39:40 2004
+++ parisc-2.6-bk/arch/ia64/ia32/ia32_entry.S	Tue Nov  2 08:14:03 2004
@@ -470,16 +470,16 @@ ia32_syscall_table:
 	data8 sys_remap_file_pages
 	data8 sys_set_tid_address
  	data8 sys32_timer_create
- 	data8 compat_timer_settime	/* 260 */
- 	data8 compat_timer_gettime
+ 	data8 compat_sys_timer_settime	/* 260 */
+ 	data8 compat_sys_timer_gettime
  	data8 sys_timer_getoverrun
  	data8 sys_timer_delete
- 	data8 compat_clock_settime
- 	data8 compat_clock_gettime /* 265 */
- 	data8 compat_clock_getres
- 	data8 compat_clock_nanosleep
-	data8 compat_statfs64
-	data8 compat_fstatfs64
+ 	data8 compat_sys_clock_settime
+ 	data8 compat_sys_clock_gettime /* 265 */
+ 	data8 compat_sys_clock_getres
+ 	data8 compat_sys_clock_nanosleep
+	data8 compat_sys_statfs64
+	data8 compat_sys_fstatfs64
  	data8 sys_tgkill	/* 270 */
  	data8 compat_sys_utimes
  	data8 sys32_fadvise64_64
diff -urpNX dontdiff linux-2.6.10-rc1-bk12/arch/ppc64/kernel/misc.S parisc-2.6-bk/arch/ppc64/kernel/misc.S
--- linux-2.6.10-rc1-bk12/arch/ppc64/kernel/misc.S	Tue Nov  2 07:52:20 2004
+++ parisc-2.6-bk/arch/ppc64/kernel/misc.S	Tue Nov  2 08:14:09 2004
@@ -935,27 +935,27 @@ _GLOBAL(sys_call_table32)
 	.llong .sys_epoll_wait
 	.llong .sys_remap_file_pages
 	.llong .ppc32_timer_create	/* 240 */
-	.llong .compat_timer_settime
-	.llong .compat_timer_gettime
+	.llong .compat_sys_timer_settime
+	.llong .compat_sys_timer_gettime
 	.llong .sys_timer_getoverrun
 	.llong .sys_timer_delete
-	.llong .compat_clock_settime	/* 245 */
-	.llong .compat_clock_gettime
-	.llong .compat_clock_getres
-	.llong .compat_clock_nanosleep
+	.llong .compat_sys_clock_settime	/* 245 */
+	.llong .compat_sys_clock_gettime
+	.llong .compat_sys_clock_getres
+	.llong .compat_sys_clock_nanosleep
 	.llong .ppc32_swapcontext
 	.llong .sys32_tgkill		/* 250 */
 	.llong .sys32_utimes
-	.llong .compat_statfs64
-	.llong .compat_fstatfs64
+	.llong .compat_sys_statfs64
+	.llong .compat_sys_fstatfs64
 	.llong .ppc32_fadvise64_64	/* 32bit only fadvise64_64 */
 	.llong .ppc_rtas		/* 255 */
 	.llong .sys_ni_syscall		/* 256 reserved for sys_debug_setcontext */
 	.llong .sys_ni_syscall		/* 257 reserved for vserver */
 	.llong .sys_ni_syscall		/* 258 reserved for new sys_remap_file_pages */
-	.llong .compat_mbind
-	.llong .compat_get_mempolicy	/* 260 */
-	.llong .compat_set_mempolicy
+	.llong .compat_sys_mbind
+	.llong .compat_sys_get_mempolicy	/* 260 */
+	.llong .compat_sys_set_mempolicy
 	.llong .compat_sys_mq_open
 	.llong .sys_mq_unlink
 	.llong .compat_sys_mq_timedsend
diff -urpNX dontdiff linux-2.6.10-rc1-bk12/arch/s390/kernel/compat_wrapper.S parisc-2.6-bk/arch/s390/kernel/compat_wrapper.S
--- linux-2.6.10-rc1-bk12/arch/s390/kernel/compat_wrapper.S	Fri Oct 22 15:40:29 2004
+++ parisc-2.6-bk/arch/s390/kernel/compat_wrapper.S	Tue Nov  2 08:14:11 2004
@@ -1262,19 +1262,19 @@ sys32_fadvise64_64_wrapper:
 sys32_clock_settime_wrapper:
 	lgfr	%r2,%r2			# clockid_t (int)
 	llgtr	%r3,%r3			# struct compat_timespec *
-	jg	compat_clock_settime
+	jg	compat_sys_clock_settime
 
 	.globl	sys32_clock_gettime_wrapper
 sys32_clock_gettime_wrapper:
 	lgfr	%r2,%r2			# clockid_t (int)
 	llgtr	%r3,%r3			# struct compat_timespec *
-	jg	compat_clock_gettime
+	jg	compat_sys_clock_gettime
 
 	.globl	sys32_clock_getres_wrapper
 sys32_clock_getres_wrapper:
 	lgfr	%r2,%r2			# clockid_t (int)
 	llgtr	%r3,%r3			# struct compat_timespec *
-	jg	compat_clock_getres
+	jg	compat_sys_clock_getres
 
 	.globl	sys32_clock_nanosleep_wrapper
 sys32_clock_nanosleep_wrapper:
@@ -1282,7 +1282,7 @@ sys32_clock_nanosleep_wrapper:
 	lgfr	%r3,%r3			# int
 	llgtr	%r4,%r4			# struct compat_timespec *
 	llgtr	%r5,%r5			# struct compat_timespec *
-	jg	compat_clock_nanosleep
+	jg	compat_sys_clock_nanosleep
 
 	.globl	sys32_timer_create_wrapper
 sys32_timer_create_wrapper:
@@ -1297,13 +1297,13 @@ sys32_timer_settime_wrapper:
 	lgfr	%r3,%r3			# int
 	llgtr	%r4,%r4			# struct compat_itimerspec *
 	llgtr	%r5,%r5			# struct compat_itimerspec *
-	jg	compat_timer_settime
+	jg	compat_sys_timer_settime
 
 	.globl	sys32_timer_gettime_wrapper
 sys32_timer_gettime_wrapper:
 	lgfr	%r2,%r2			# timer_t (int)
 	llgtr	%r3,%r3			# struct compat_itimerspec *
-	jg	compat_timer_gettime
+	jg	compat_sys_timer_gettime
 
 	.globl	sys32_timer_getoverrun_wrapper
 sys32_timer_getoverrun_wrapper:
@@ -1354,14 +1354,14 @@ compat_sys_statfs64_wrapper:
 	llgtr	%r2,%r2			# const char *
 	llgfr	%r3,%r3			# compat_size_t
 	llgtr	%r4,%r4			# struct compat_statfs64 *
-	jg	compat_statfs64
+	jg	compat_sys_statfs64
 
 	.globl compat_sys_fstatfs64_wrapper
 compat_sys_fstatfs64_wrapper:
 	llgfr	%r2,%r2			# unsigned int fd
 	llgfr	%r3,%r3			# compat_size_t
 	llgtr	%r4,%r4			# struct compat_statfs64 *
-	jg	compat_fstatfs64
+	jg	compat_sys_fstatfs64
 
 	.globl	compat_sys_mq_open_wrapper
 compat_sys_mq_open_wrapper:
diff -urpNX dontdiff linux-2.6.10-rc1-bk12/arch/sparc64/kernel/sys32.S parisc-2.6-bk/arch/sparc64/kernel/sys32.S
--- linux-2.6.10-rc1-bk12/arch/sparc64/kernel/sys32.S	Fri Oct 22 15:38:39 2004
+++ parisc-2.6-bk/arch/sparc64/kernel/sys32.S	Tue Nov  2 08:14:12 2004
@@ -84,9 +84,9 @@ SIGN2(sys32_fadvise64_64, compat_sys_fad
 SIGN2(sys32_bdflush, sys_bdflush, %o0, %o1)
 SIGN1(sys32_mlockall, sys_mlockall, %o0)
 SIGN1(sys32_nfsservctl, compat_sys_nfsservctl, %o0)
-SIGN1(sys32_clock_settime, compat_clock_settime, %o1)
-SIGN1(sys32_clock_nanosleep, compat_clock_nanosleep, %o1)
-SIGN1(sys32_timer_settime, compat_timer_settime, %o1)
+SIGN1(sys32_clock_settime, compat_sys_clock_settime, %o1)
+SIGN1(sys32_clock_nanosleep, compat_sys_clock_nanosleep, %o1)
+SIGN1(sys32_timer_settime, compat_sys_timer_settime, %o1)
 SIGN1(sys32_io_submit, compat_sys_io_submit, %o1)
 SIGN1(sys32_mq_open, compat_sys_mq_open, %o1)
 SIGN1(sys32_select, compat_sys_select, %o0)
diff -urpNX dontdiff linux-2.6.10-rc1-bk12/arch/sparc64/kernel/systbls.S parisc-2.6-bk/arch/sparc64/kernel/systbls.S
--- linux-2.6.10-rc1-bk12/arch/sparc64/kernel/systbls.S	Tue Nov  2 07:52:20 2004
+++ parisc-2.6-bk/arch/sparc64/kernel/systbls.S	Tue Nov  2 08:14:12 2004
@@ -60,19 +60,19 @@ sys_call_table32:
 	.word sys32_setpgid, sys32_fremovexattr, sys32_tkill, sys32_exit_group, sparc64_newuname
 /*190*/	.word sys32_init_module, sparc64_personality, sys_remap_file_pages, sys32_epoll_create, sys32_epoll_ctl
 	.word sys32_epoll_wait, sys_nis_syscall, sys_getppid, sys32_sigaction, sys_sgetmask
-/*200*/	.word sys32_ssetmask, sys_sigsuspend, compat_sys_newlstat, sys_uselib, compat_old_readdir
+/*200*/	.word sys32_ssetmask, sys_sigsuspend, compat_sys_newlstat, sys_uselib, compat_sys_old_readdir
 	.word sys32_readahead, sys32_socketcall, sys32_syslog, sys32_lookup_dcookie, sys32_fadvise64
 /*210*/	.word sys32_fadvise64_64, sys32_tgkill, sys32_waitpid, sys_swapoff, sys32_sysinfo
 	.word sys32_ipc, sys32_sigreturn, sys_clone, sys_nis_syscall, sys32_adjtimex
 /*220*/	.word sys32_sigprocmask, sys_ni_syscall, sys32_delete_module, sys_ni_syscall, sys32_getpgid
 	.word sys32_bdflush, sys32_sysfs, sys_nis_syscall, sys32_setfsuid16, sys32_setfsgid16
-/*230*/	.word sys32_select, sys_time, sys_nis_syscall, sys_stime, compat_statfs64
-	.word compat_fstatfs64, sys_llseek, sys_mlock, sys_munlock, sys32_mlockall
+/*230*/	.word sys32_select, sys_time, sys_nis_syscall, sys_stime, compat_sys_statfs64
+	.word compat_sys_fstatfs64, sys_llseek, sys_mlock, sys_munlock, sys32_mlockall
 /*240*/	.word sys_munlockall, sys32_sched_setparam, sys32_sched_getparam, sys32_sched_setscheduler, sys32_sched_getscheduler
 	.word sys_sched_yield, sys32_sched_get_priority_max, sys32_sched_get_priority_min, sys32_sched_rr_get_interval, compat_sys_nanosleep
 /*250*/	.word sys32_mremap, sys32_sysctl, sys32_getsid, sys_fdatasync, sys32_nfsservctl
-	.word sys_ni_syscall, sys32_clock_settime, compat_clock_gettime, compat_clock_getres, sys32_clock_nanosleep
-/*260*/	.word compat_sys_sched_getaffinity, compat_sys_sched_setaffinity, sys32_timer_settime, compat_timer_gettime, sys_timer_getoverrun
+	.word sys_ni_syscall, sys32_clock_settime, compat_sys_clock_gettime, compat_sys_clock_getres, sys32_clock_nanosleep
+/*260*/	.word compat_sys_sched_getaffinity, compat_sys_sched_setaffinity, sys32_timer_settime, compat_sys_timer_gettime, sys_timer_getoverrun
 	.word sys_timer_delete, sys32_timer_create, sys_ni_syscall, compat_sys_io_setup, sys_io_destroy
 /*270*/	.word sys32_io_submit, sys_io_cancel, compat_sys_io_getevents, sys32_mq_open, sys_mq_unlink
 	.word sys_mq_timedsend, sys_mq_timedreceive, compat_sys_mq_notify, compat_sys_mq_getsetattr, compat_sys_waitid
diff -urpNX dontdiff linux-2.6.10-rc1-bk12/arch/x86_64/ia32/ia32entry.S parisc-2.6-bk/arch/x86_64/ia32/ia32entry.S
--- linux-2.6.10-rc1-bk12/arch/x86_64/ia32/ia32entry.S	Fri Oct 22 15:39:07 2004
+++ parisc-2.6-bk/arch/x86_64/ia32/ia32entry.S	Tue Nov  2 08:14:12 2004
@@ -562,22 +562,22 @@ ia32_sys_call_table:
 	.quad sys_remap_file_pages
 	.quad sys_set_tid_address
 	.quad sys32_timer_create
-	.quad compat_timer_settime	/* 260 */
-	.quad compat_timer_gettime
+	.quad compat_sys_timer_settime	/* 260 */
+	.quad compat_sys_timer_gettime
 	.quad sys_timer_getoverrun
 	.quad sys_timer_delete
-	.quad compat_clock_settime
-	.quad compat_clock_gettime	/* 265 */
-	.quad compat_clock_getres
-	.quad compat_clock_nanosleep
-	.quad compat_statfs64
-	.quad compat_fstatfs64
+	.quad compat_sys_clock_settime
+	.quad compat_sys_clock_gettime	/* 265 */
+	.quad compat_sys_clock_getres
+	.quad compat_sys_clock_nanosleep
+	.quad compat_sys_statfs64
+	.quad compat_sys_fstatfs64
 	.quad sys_tgkill		/* 270 */
 	.quad compat_sys_utimes
 	.quad sys32_fadvise64_64
 	.quad quiet_ni_syscall	/* sys_vserver */
 	.quad sys_mbind
-	.quad compat_get_mempolicy	/* 275 */
+	.quad compat_sys_get_mempolicy	/* 275 */
 	.quad sys_set_mempolicy
 	.quad compat_sys_mq_open
 	.quad sys_mq_unlink
diff -urpNX dontdiff linux-2.6.10-rc1-bk12/fs/compat.c parisc-2.6-bk/fs/compat.c
--- linux-2.6.10-rc1-bk12/fs/compat.c	Fri Oct 22 15:39:07 2004
+++ parisc-2.6-bk/fs/compat.c	Tue Nov  2 08:14:31 2004
@@ -205,7 +205,7 @@ static int put_compat_statfs64(struct co
 	return 0;
 }
 
-asmlinkage long compat_statfs64(const char __user *path, compat_size_t sz, struct compat_statfs64 __user *buf)
+asmlinkage long compat_sys_statfs64(const char __user *path, compat_size_t sz, struct compat_statfs64 __user *buf)
 {
 	struct nameidata nd;
 	int error;
@@ -224,7 +224,7 @@ asmlinkage long compat_statfs64(const ch
 	return error;
 }
 
-asmlinkage long compat_fstatfs64(unsigned int fd, compat_size_t sz, struct compat_statfs64 __user *buf)
+asmlinkage long compat_sys_fstatfs64(unsigned int fd, compat_size_t sz, struct compat_statfs64 __user *buf)
 {
 	struct file * file;
 	struct kstatfs tmp;
diff -urpNX dontdiff linux-2.6.10-rc1-bk12/kernel/compat.c parisc-2.6-bk/kernel/compat.c
--- linux-2.6.10-rc1-bk12/kernel/compat.c	Fri Oct 22 15:39:19 2004
+++ parisc-2.6-bk/kernel/compat.c	Tue Nov  2 08:14:43 2004
@@ -484,7 +485,7 @@ static int put_compat_itimerspec(struct 
 	return 0;
 } 
 
-long compat_timer_settime(timer_t timer_id, int flags, 
+long compat_sys_timer_settime(timer_t timer_id, int flags, 
 			  struct compat_itimerspec __user *new, 
 			  struct compat_itimerspec __user *old)
 { 
@@ -507,7 +508,7 @@ long compat_timer_settime(timer_t timer_
 	return err;
 } 
 
-long compat_timer_gettime(timer_t timer_id,
+long compat_sys_timer_gettime(timer_t timer_id,
 		struct compat_itimerspec __user *setting)
 { 
 	long err;
@@ -524,7 +525,7 @@ long compat_timer_gettime(timer_t timer_
 	return err;
 } 
 
-long compat_clock_settime(clockid_t which_clock,
+long compat_sys_clock_settime(clockid_t which_clock,
 		struct compat_timespec __user *tp)
 {
 	long err;
@@ -541,7 +542,7 @@ long compat_clock_settime(clockid_t whic
 	return err;
 } 
 
-long compat_clock_gettime(clockid_t which_clock,
+long compat_sys_clock_gettime(clockid_t which_clock,
 		struct compat_timespec __user *tp)
 {
 	long err;
@@ -558,7 +559,7 @@ long compat_clock_gettime(clockid_t whic
 	return err;
 } 
 
-long compat_clock_getres(clockid_t which_clock,
+long compat_sys_clock_getres(clockid_t which_clock,
 		struct compat_timespec __user *tp)
 {
 	long err;
@@ -575,7 +576,7 @@ long compat_clock_getres(clockid_t which
 	return err;
 } 
 
-long compat_clock_nanosleep(clockid_t which_clock, int flags,
+long compat_sys_clock_nanosleep(clockid_t which_clock, int flags,
 			    struct compat_timespec __user *rqtp,
 			    struct compat_timespec __user *rmtp)
 {
diff -urpNX dontdiff linux-2.6.10-rc1-bk12/kernel/sys.c parisc-2.6-bk/kernel/sys.c
--- linux-2.6.10-rc1-bk12/kernel/sys.c	Tue Nov  2 07:52:28 2004
+++ parisc-2.6-bk/kernel/sys.c	Tue Nov  2 08:14:43 2004
@@ -280,9 +280,9 @@ cond_syscall(compat_sys_mq_getsetattr)
 cond_syscall(sys_mbind)
 cond_syscall(sys_get_mempolicy)
 cond_syscall(sys_set_mempolicy)
-cond_syscall(compat_mbind)
-cond_syscall(compat_get_mempolicy)
-cond_syscall(compat_set_mempolicy)
+cond_syscall(compat_sys_mbind)
+cond_syscall(compat_sys_get_mempolicy)
+cond_syscall(compat_sys_set_mempolicy)
 cond_syscall(sys_add_key)
 cond_syscall(sys_request_key)
 cond_syscall(sys_keyctl)
diff -urpNX dontdiff linux-2.6.10-rc1-bk12/mm/mempolicy.c parisc-2.6-bk/mm/mempolicy.c
--- linux-2.6.10-rc1-bk12/mm/mempolicy.c	Tue Nov  2 07:52:28 2004
+++ parisc-2.6-bk/mm/mempolicy.c	Tue Nov  2 08:14:44 2004
@@ -530,7 +530,7 @@ asmlinkage long sys_get_mempolicy(int __
 
 #ifdef CONFIG_COMPAT
 
-asmlinkage long compat_get_mempolicy(int __user *policy,
+asmlinkage long compat_sys_get_mempolicy(int __user *policy,
 				     compat_ulong_t __user *nmask,
 				     compat_ulong_t maxnode,
 				     compat_ulong_t addr, compat_ulong_t flags)
@@ -558,7 +558,7 @@ asmlinkage long compat_get_mempolicy(int
 	return err;
 }
 
-asmlinkage long compat_set_mempolicy(int mode, compat_ulong_t __user *nmask,
+asmlinkage long compat_sys_set_mempolicy(int mode, compat_ulong_t __user *nmask,
 				     compat_ulong_t maxnode)
 {
 	long err = 0;
@@ -581,7 +581,7 @@ asmlinkage long compat_set_mempolicy(int
 	return sys_set_mempolicy(mode, nm, nr_bits+1);
 }
 
-asmlinkage long compat_mbind(compat_ulong_t start, compat_ulong_t len,
+asmlinkage long compat_sys_mbind(compat_ulong_t start, compat_ulong_t len,
 			     compat_ulong_t mode, compat_ulong_t __user *nmask,
 			     compat_ulong_t maxnode, compat_ulong_t flags)
 {

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
