Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276312AbRJ2Qhm>; Mon, 29 Oct 2001 11:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276361AbRJ2QhV>; Mon, 29 Oct 2001 11:37:21 -0500
Received: from ns.caldera.de ([212.34.180.1]:14721 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S276255AbRJ2Qgt>;
	Mon, 29 Oct 2001 11:36:49 -0500
Date: Mon, 29 Oct 2001 17:37:11 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] syscall exports - against 2.4.14-pre3
Message-ID: <20011029173711.B24272@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

once again the syscall export patch - back to EXPORT_SYMBOL
vs EXPORT_SYMBOL_GPL due to some complaints, more syscalls
as I dropped sys_call_table abuse in linux-abi.

Could you _please_ apply it - it is badly needed for foreign
personalities compiled as modules.

	Christoph

P.S. Linux-ABI is at ftp.openlinux.org:/pub/people/hch/linux-abi -
	no need to ask again :)
-- 
Of course it doesn't work. We've performed a software upgrade.

diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/include/asm-alpha/syscall.h linux/include/asm-alpha/syscall.h
--- ../master/linux-2.4.14-pre3/include/asm-alpha/syscall.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-alpha/syscall.h	Mon Oct 29 17:22:02 2001
@@ -0,0 +1,8 @@
+#ifndef _ASM_SYSCALL_H
+#define _ASM_SYSCALL_H
+
+/*
+ * Prototypes for architecture-specific Linux syscalls.
+ */
+
+#endif /* _ASM_SYSCALL_H */
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/include/asm-arm/syscall.h linux/include/asm-arm/syscall.h
--- ../master/linux-2.4.14-pre3/include/asm-arm/syscall.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-arm/syscall.h	Mon Oct 29 17:22:02 2001
@@ -0,0 +1,8 @@
+#ifndef _ASM_SYSCALL_H
+#define _ASM_SYSCALL_H
+
+/*
+ * Prototypes for architecture-specific Linux syscalls.
+ */
+
+#endif /* _ASM_SYSCALL_H */
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/include/asm-cris/syscall.h linux/include/asm-cris/syscall.h
--- ../master/linux-2.4.14-pre3/include/asm-cris/syscall.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-cris/syscall.h	Mon Oct 29 17:22:02 2001
@@ -0,0 +1,8 @@
+#ifndef _ASM_SYSCALL_H
+#define _ASM_SYSCALL_H
+
+/*
+ * Prototypes for architecture-specific Linux syscalls.
+ */
+
+#endif /* _ASM_SYSCALL_H */
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/include/asm-i386/syscall.h linux/include/asm-i386/syscall.h
--- ../master/linux-2.4.14-pre3/include/asm-i386/syscall.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-i386/syscall.h	Mon Oct 29 17:22:02 2001
@@ -0,0 +1,31 @@
+#ifndef _ASM_SYSCALL_H
+#define _ASM_SYSCALL_H
+
+/*
+ * Prototypes for architecture-specific Linux syscalls.
+ */
+
+#include <linux/sched.h>	/* struct pt_regs */
+#include <asm/signal.h>		/* old_sigset_t */
+
+
+/* arch/i386/kernel/ldt.c */
+extern asmlinkage int	sys_modify_ldt(int, void *, unsigned long);
+
+/* arch/i386/kernel/process.c */
+extern asmlinkage int	sys_fork(struct pt_regs regs);                                                      
+
+/* arch/i386/kernel/ptrace.c */
+extern asmlinkage int	sys_ptrace(long request, long pid,
+				long addr, long data);
+
+/* arch/i386/kernel/signal.c */
+extern int		sigsuspend1(struct pt_regs *regs, old_sigset_t mask);
+
+/* arch/i386/kernel/sys_i386.c */
+extern asmlinkage int	sys_ipc(uint call, int first, int second,
+				int third, void *ptr, long fifth);
+extern asmlinkage int	sys_pause(void);
+extern asmlinkage int	sys_pipe(unsigned long * fildes);
+
+#endif /* _ASM_SYSCALL_H */
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/include/asm-ia64/syscall.h linux/include/asm-ia64/syscall.h
--- ../master/linux-2.4.14-pre3/include/asm-ia64/syscall.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-ia64/syscall.h	Mon Oct 29 17:22:02 2001
@@ -0,0 +1,8 @@
+#ifndef _ASM_SYSCALL_H
+#define _ASM_SYSCALL_H
+
+/*
+ * Prototypes for architecture-specific Linux syscalls.
+ */
+
+#endif /* _ASM_SYSCALL_H */
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/include/asm-m68k/syscall.h linux/include/asm-m68k/syscall.h
--- ../master/linux-2.4.14-pre3/include/asm-m68k/syscall.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-m68k/syscall.h	Mon Oct 29 17:22:02 2001
@@ -0,0 +1,8 @@
+#ifndef _ASM_SYSCALL_H
+#define _ASM_SYSCALL_H
+
+/*
+ * Prototypes for architecture-specific Linux syscalls.
+ */
+
+#endif /* _ASM_SYSCALL_H */
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/include/asm-mips/syscall.h linux/include/asm-mips/syscall.h
--- ../master/linux-2.4.14-pre3/include/asm-mips/syscall.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-mips/syscall.h	Mon Oct 29 17:22:02 2001
@@ -0,0 +1,8 @@
+#ifndef _ASM_SYSCALL_H
+#define _ASM_SYSCALL_H
+
+/*
+ * Prototypes for architecture-specific Linux syscalls.
+ */
+
+#endif /* _ASM_SYSCALL_H */
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/include/asm-mips64/syscall.h linux/include/asm-mips64/syscall.h
--- ../master/linux-2.4.14-pre3/include/asm-mips64/syscall.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-mips64/syscall.h	Mon Oct 29 17:22:02 2001
@@ -0,0 +1,8 @@
+#ifndef _ASM_SYSCALL_H
+#define _ASM_SYSCALL_H
+
+/*
+ * Prototypes for architecture-specific Linux syscalls.
+ */
+
+#endif /* _ASM_SYSCALL_H */
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/include/asm-parisc/syscall.h linux/include/asm-parisc/syscall.h
--- ../master/linux-2.4.14-pre3/include/asm-parisc/syscall.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-parisc/syscall.h	Mon Oct 29 17:22:02 2001
@@ -0,0 +1,8 @@
+#ifndef _ASM_SYSCALL_H
+#define _ASM_SYSCALL_H
+
+/*
+ * Prototypes for architecture-specific Linux syscalls.
+ */
+
+#endif /* _ASM_SYSCALL_H */
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/include/asm-ppc/syscall.h linux/include/asm-ppc/syscall.h
--- ../master/linux-2.4.14-pre3/include/asm-ppc/syscall.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-ppc/syscall.h	Mon Oct 29 17:22:02 2001
@@ -0,0 +1,8 @@
+#ifndef _ASM_SYSCALL_H
+#define _ASM_SYSCALL_H
+
+/*
+ * Prototypes for architecture-specific Linux syscalls.
+ */
+
+#endif /* _ASM_SYSCALL_H */
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/include/asm-s390/syscall.h linux/include/asm-s390/syscall.h
--- ../master/linux-2.4.14-pre3/include/asm-s390/syscall.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-s390/syscall.h	Mon Oct 29 17:22:02 2001
@@ -0,0 +1,8 @@
+#ifndef _ASM_SYSCALL_H
+#define _ASM_SYSCALL_H
+
+/*
+ * Prototypes for architecture-specific Linux syscalls.
+ */
+
+#endif /* _ASM_SYSCALL_H */
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/include/asm-s390x/syscall.h linux/include/asm-s390x/syscall.h
--- ../master/linux-2.4.14-pre3/include/asm-s390x/syscall.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-s390x/syscall.h	Mon Oct 29 17:22:02 2001
@@ -0,0 +1,8 @@
+#ifndef _ASM_SYSCALL_H
+#define _ASM_SYSCALL_H
+
+/*
+ * Prototypes for architecture-specific Linux syscalls.
+ */
+
+#endif /* _ASM_SYSCALL_H */
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/include/asm-sh/syscall.h linux/include/asm-sh/syscall.h
--- ../master/linux-2.4.14-pre3/include/asm-sh/syscall.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-sh/syscall.h	Mon Oct 29 17:22:02 2001
@@ -0,0 +1,8 @@
+#ifndef _ASM_SYSCALL_H
+#define _ASM_SYSCALL_H
+
+/*
+ * Prototypes for architecture-specific Linux syscalls.
+ */
+
+#endif /* _ASM_SYSCALL_H */
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/include/asm-sparc/syscall.h linux/include/asm-sparc/syscall.h
--- ../master/linux-2.4.14-pre3/include/asm-sparc/syscall.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-sparc/syscall.h	Mon Oct 29 17:22:02 2001
@@ -0,0 +1,8 @@
+#ifndef _ASM_SYSCALL_H
+#define _ASM_SYSCALL_H
+
+/*
+ * Prototypes for architecture-specific Linux syscalls.
+ */
+
+#endif /* _ASM_SYSCALL_H */
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/include/asm-sparc64/syscall.h linux/include/asm-sparc64/syscall.h
--- ../master/linux-2.4.14-pre3/include/asm-sparc64/syscall.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-sparc64/syscall.h	Mon Oct 29 17:22:02 2001
@@ -0,0 +1,8 @@
+#ifndef _ASM_SYSCALL_H
+#define _ASM_SYSCALL_H
+
+/*
+ * Prototypes for architecture-specific Linux syscalls.
+ */
+
+#endif /* _ASM_SYSCALL_H */
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/include/linux/syscall.h linux/include/linux/syscall.h
--- ../master/linux-2.4.14-pre3/include/linux/syscall.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/syscall.h	Mon Oct 29 17:22:02 2001
@@ -0,0 +1,288 @@
+#ifndef _LINUX_SYSCALL_H
+#define _LINUX_SYSCALL_H
+
+/*
+ * Prototypes for Linux syscalls.
+ *
+ * Maybe this could be automatically generated from some kind of
+ * master file (like BSD's syscalls.master), so it is always coherent
+ * to the actual syscalls (which may as well be arch-specific).
+ */
+
+#include <asm/syscall.h>
+
+struct itimerval;
+struct msghdr;
+struct pollfd;
+struct rlimit;
+struct sigaction;
+struct sockaddr;
+struct statfs;
+struct timespec;
+struct timeval;
+struct timezone;
+struct tms;
+struct utimbuf;
+
+
+/* fs/exec.c */
+extern asmlinkage long sys_uselib(const char * library);
+
+/* fs/buffer.c */
+extern asmlinkage long sys_sync(void);
+extern asmlinkage long sys_fsync(unsigned int fd);
+extern asmlinkage long sys_fdatasync(unsigned int fd);
+
+/* fs/fcntl.c */
+extern asmlinkage long sys_dup(unsigned int fildes);
+extern asmlinkage long sys_dup2(unsigned int oldfd, unsigned int newfd);
+extern asmlinkage long sys_fcntl(unsigned int fd, unsigned int cmd,
+		unsigned long arg);
+#if (BITS_PER_LONG == 32)
+extern asmlinkage long sys_fcntl64(unsigned int fd, unsigned int cmd,
+		unsigned long arg);
+#endif
+
+/* fs/ioctl.c */
+extern asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, void *);
+
+/* fs/namei.c */
+extern asmlinkage long sys_link(const char * oldname, const char * newname);
+extern asmlinkage long sys_mkdir(const char * pathname, int mode);
+extern asmlinkage long sys_mknod(const char * filename, int mode, dev_t dev);
+extern asmlinkage long sys_rename(const char * oldname, const char * newname);
+extern asmlinkage long sys_rmdir(const char * pathname);
+extern asmlinkage long sys_symlink(const char * oldname, const char * newname);
+extern asmlinkage long sys_unlink(const char * pathname);
+
+/* fs/namespace.c */
+extern asmlinkage long sys_umount(char * name, int flags);
+extern asmlinkage long sys_oldumount(char * name);
+extern asmlinkage long sys_mount(char * dev_name, char * dir_name,
+		char * type, unsigned long flags, void * data);
+extern asmlinkage long sys_pivot_root(const char *new_root,
+		const char *put_old);
+
+/* fs/open.c */
+extern asmlinkage long sys_access(const char * filename, int mode);            
+extern asmlinkage long sys_chdir(const char * filename);
+extern asmlinkage long sys_fchdir(unsigned int fd);
+extern asmlinkage long sys_chroot(const char * filename);
+extern asmlinkage long sys_chmod(const char * filename, mode_t mode);
+extern asmlinkage long sys_fchmod(unsigned int fd, mode_t mode);
+extern asmlinkage long sys_chown(const char * filename, uid_t user,
+		gid_t group);
+extern asmlinkage long sys_lchown(const char * filename, uid_t user,
+		gid_t group);
+extern asmlinkage long sys_fchown(unsigned int fd, uid_t user, gid_t group);
+extern asmlinkage long sys_close(unsigned int fd);
+#if !defined(__alpha__)
+extern asmlinkage long sys_creat(const char * pathname, int mode);
+#endif
+extern asmlinkage long sys_open(const char * filename, int flags, int mode);
+extern asmlinkage long sys_statfs(const char * path, struct statfs * buf);
+extern asmlinkage long sys_fstatfs(unsigned int fd, struct statfs * buf);
+extern asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length);
+extern asmlinkage long sys_ftruncate64(unsigned int fd, loff_t length);
+extern asmlinkage long sys_truncate(const char * path, unsigned long length);
+extern asmlinkage long sys_truncate64(const char * path, loff_t length);
+#if !defined(__alpha__) && !defined(__ia64__)
+extern asmlinkage long sys_utime(char * filename, struct utimbuf * times);
+#endif
+extern asmlinkage long sys_utimes(char * filename, struct timeval * utimes);
+extern asmlinkage long sys_vhangup(void);
+
+
+/* fs/read_write.c */
+extern asmlinkage off_t	sys_lseek(unsigned int fd, off_t offset,
+		unsigned int origin);
+#if !defined(__alpha__)
+extern asmlinkage long sys_llseek(unsigned int fd, unsigned long offset_high,
+		unsigned long offset_low, loff_t * result, unsigned int origin);
+#endif
+extern asmlinkage ssize_t sys_read(unsigned int fd, char * buf, size_t count);
+extern asmlinkage ssize_t sys_readv(unsigned long fd,
+		const struct iovec * vector, unsigned long count);
+extern asmlinkage ssize_t sys_pread(unsigned int fd, char * buf,
+		size_t count, loff_t pos);
+extern asmlinkage ssize_t sys_pwrite(unsigned int fd, const char * buf,
+		size_t count, loff_t pos);
+extern asmlinkage ssize_t sys_write(unsigned int fd, const char * buf,
+		size_t count);
+extern asmlinkage ssize_t sys_writev(unsigned long fd,
+		const struct iovec * vector, unsigned long count);
+
+
+
+/* fs/readdir.c */
+extern asmlinkage int old_readdir(unsigned int fd, void * dirent,
+				unsigned int count);
+
+/* fs/select.c */
+extern asmlinkage long sys_poll(struct pollfd * ufds, unsigned int nfds,
+				long timeout);
+extern asmlinkage int sys_select(int, fd_set *, fd_set *, fd_set *,
+				struct timeval *);
+
+/* fs/stat.c */
+extern asmlinkage long sys_readlink(const char * path, char * buf,
+				int bufsiz);
+
+/* fs/super.c */
+extern asmlinkage long sys_sysfs(int option, unsigned long arg1,
+				unsigned long arg2);
+
+/* kernel/acct.c */
+extern asmlinkage long sys_acct(const char *name);
+
+/* kernel/exit.c */
+extern asmlinkage long sys_exit(int error_code);
+
+/* kernel/itimer.c */
+extern asmlinkage long sys_getitimer(int which, struct itimerval *value);
+extern asmlinkage long sys_setitimer(int which, struct itimerval *value,
+				struct itimerval *ovalue);
+
+/* kernel/sched.c */
+#if !defined(__alpha__)
+extern asmlinkage long sys_nice(int increment);
+#endif
+extern asmlinkage long sys_sched_setscheduler(pid_t pid, int policy,
+		struct sched_param *param);
+extern asmlinkage long sys_sched_setparam(pid_t pid,
+		struct sched_param *param);
+extern asmlinkage long sys_sched_getscheduler(pid_t pid);
+extern asmlinkage long sys_sched_getparam(pid_t pid,
+		struct sched_param *param);
+extern asmlinkage long sys_sched_yield(void);
+extern asmlinkage long sys_sched_get_priority_max(int policy);
+extern asmlinkage long sys_sched_get_priority_min(int policy);
+extern asmlinkage long sys_sched_rr_get_interval(pid_t pid,
+		struct timespec *interval);
+
+/* kernel/signal.c */
+extern asmlinkage long sys_kill(int pid, int sig);
+extern asmlinkage long sys_rt_sigaction(int sig, const struct sigaction *act,
+				struct sigaction *oact, size_t sigsetsize);
+extern asmlinkage long sys_rt_sigpending(sigset_t *set, size_t sigsetsize);
+extern asmlinkage long sys_rt_sigprocmask(int how, sigset_t *set,
+				sigset_t *oset, size_t sigsetsize);
+extern asmlinkage long sys_rt_sigtimedwait(const sigset_t *uthese,
+				siginfo_t *uinfo, const struct timespec *uts,
+				size_t sigsetsize);
+extern asmlinkage long sys_sigaltstack(const stack_t *uss, stack_t *uoss);
+extern asmlinkage long sys_sigpending(old_sigset_t *set);
+extern asmlinkage long sys_sigprocmask(int how, old_sigset_t *set,
+				old_sigset_t *oset);
+extern asmlinkage int sys_sigsuspend(int history0, int history1,
+				old_sigset_t mask);
+
+/* kernel/sys.c */
+extern asmlinkage long sys_gethostname(char *name, int len);
+extern asmlinkage long sys_sethostname(char *name, int len);
+extern asmlinkage long sys_setdomainname(char *name, int len);
+extern asmlinkage long sys_getrlimit(unsigned int resource,
+				struct rlimit *rlim);
+extern asmlinkage long sys_setsid(void);
+extern asmlinkage long sys_getsid(pid_t pid);
+extern asmlinkage long sys_getpgid(pid_t pid);
+extern asmlinkage long sys_setpgid(pid_t pid, pid_t pgid);
+extern asmlinkage long sys_getgroups(int gidsetsize, gid_t *grouplist);
+extern asmlinkage long sys_setgroups(int gidsetsize, gid_t *grouplist);
+extern asmlinkage long sys_setpriority(int which, int who, int niceval);
+extern asmlinkage long sys_getpriority(int which, int who);
+extern asmlinkage long sys_reboot(int magic1, int magic2, unsigned int cmd,
+		void * arg);
+extern asmlinkage long sys_setgid(gid_t gid);
+extern asmlinkage long sys_setuid(uid_t uid);
+extern asmlinkage long sys_times(struct tms * tbuf);
+extern asmlinkage long sys_umask(int mask);
+extern asmlinkage long sys_prctl(int option, unsigned long arg2,
+		unsigned long arg3, unsigned long arg4, unsigned long arg5);
+extern asmlinkage long sys_setreuid(uid_t ruid, uid_t euid);
+extern asmlinkage long sys_setregid(gid_t rgid, gid_t egid);
+
+/* kernel/time.c */
+extern asmlinkage long sys_gettimeofday(struct timeval *tv,
+				struct timezone *tz);
+extern asmlinkage long sys_settimeofday(struct timeval *tv,
+				struct timezone *tz);
+extern asmlinkage long sys_stime(int * tptr);
+extern asmlinkage long sys_time(int * tloc);
+
+/* kernel/timer.c */
+#if !defined(__alpha__) && !defined(__ia64__)
+extern asmlinkage unsigned long sys_alarm(unsigned int seconds);
+#endif
+#if !defined(__alpha__)
+extern asmlinkage long sys_getpid(void);
+extern asmlinkage long sys_getppid(void);
+extern asmlinkage long sys_getuid(void);
+extern asmlinkage long sys_geteuid(void);
+extern asmlinkage long sys_getgid(void);
+extern asmlinkage long sys_getegid(void);
+#endif
+extern asmlinkage long sys_gettid(void);
+extern asmlinkage long sys_nanosleep(struct timespec *rqtp,
+		struct timespec *rmtp);
+
+#if defined(CONFIG_UID16)
+/* kernel/uid16.c */
+extern asmlinkage long sys_setreuid16(old_uid_t ruid, old_uid_t euid);
+extern asmlinkage long sys_setregid16(old_gid_t rgid, old_gid_t egid);
+extern asmlinkage long sys_getgroups16(int gidsetsize, old_gid_t *grouplist);
+extern asmlinkage long sys_setgroups16(int gidsetsize, old_gid_t *grouplist);
+#endif /* CONFIG_UID16 */
+
+/* mm/filemap.c */
+extern asmlinkage ssize_t sys_sendfile(int out_fd, int in_fd, off_t *offset,
+		size_t count);
+extern asmlinkage long sys_msync(unsigned long start, size_t len, int flags);
+extern asmlinkage long sys_madvise(unsigned long start, size_t len,
+		int behavior);
+extern asmlinkage long sys_mincore(unsigned long start, size_t len,
+		unsigned char * vec);
+
+/* mm/mmap.c */
+extern asmlinkage unsigned long sys_brk(unsigned long brk);
+extern asmlinkage long sys_munmap(unsigned long addr, size_t len);
+
+/* mm/mprotect.c */
+extern asmlinkage long sys_mprotect(unsigned long start, size_t len,
+		unsigned long prot);
+
+/* net/socket.c */
+extern asmlinkage long sys_socket(int family, int type, int protocol);
+extern asmlinkage long sys_socketpair(int family, int type,
+				int protocol, int usockvec[2]);
+extern asmlinkage long sys_bind(int fd, struct sockaddr *umyaddr,
+				int addrlen);
+extern asmlinkage long sys_listen(int fd, int backlog);
+extern asmlinkage long sys_accept(int fd, struct sockaddr *upeer_sockaddr,
+				int *upeer_addrlen);
+extern asmlinkage long sys_connect(int fd, struct sockaddr *uservaddr,
+				int addrlen);
+extern asmlinkage long sys_getsockname(int fd, struct sockaddr *usockaddr,
+				int *usockaddr_len);
+extern asmlinkage long sys_getpeername(int fd, struct sockaddr *usockaddr,
+				int *usockaddr_len);
+extern asmlinkage long sys_sendto(int fd, void * buff, size_t len,
+				unsigned flags, struct sockaddr *addr,
+				int addr_len);
+extern asmlinkage long sys_send(int fd, void * buff, size_t len,
+					unsigned flags);
+extern asmlinkage long sys_recvfrom(int fd, void * ubuf, size_t size,
+				unsigned flags, struct sockaddr *addr,
+				int *addr_len);
+extern asmlinkage long sys_setsockopt(int fd, int level, int optname,
+				char *optval, int optlen);
+extern asmlinkage long sys_getsockopt(int fd, int level, int optname,
+				char *optval, int *optlen);
+extern asmlinkage long sys_shutdown(int fd, int how);
+extern asmlinkage long sys_sendmsg(int fd, struct msghdr *msg,
+				unsigned flags);
+extern asmlinkage long sys_recvmsg(int fd, struct msghdr *msg,
+				unsigned int flags);
+extern asmlinkage long sys_socketcall(int call, unsigned long *args);
+
+#endif /* _LINUX_SYSCALL_H */
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/kernel/Makefile linux/kernel/Makefile
--- ../master/linux-2.4.14-pre3/kernel/Makefile	Sun Sep 23 21:21:03 2001
+++ linux/kernel/Makefile	Mon Oct 29 17:22:34 2001
@@ -9,12 +9,13 @@
 
 O_TARGET := kernel.o
 
-export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o
+export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o printk.o \
+		exec_domain.o syscall_ksyms.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o
+	    signal.o sys.o kmod.o context.o syscall_ksyms.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/kernel/ksyms.c linux/kernel/ksyms.c
--- ../master/linux-2.4.14-pre3/kernel/ksyms.c	Thu Oct 25 19:05:49 2001
+++ linux/kernel/ksyms.c	Mon Oct 29 17:22:02 2001
@@ -147,7 +147,6 @@
 EXPORT_SYMBOL(__user_walk);
 EXPORT_SYMBOL(lookup_one_len);
 EXPORT_SYMBOL(lookup_hash);
-EXPORT_SYMBOL(sys_close);
 EXPORT_SYMBOL(dcache_lock);
 EXPORT_SYMBOL(d_alloc_root);
 EXPORT_SYMBOL(d_delete);
diff -uNr -Xdontdiff ../master/linux-2.4.14-pre3/kernel/syscall_ksyms.c linux/kernel/syscall_ksyms.c
--- ../master/linux-2.4.14-pre3/kernel/syscall_ksyms.c	Thu Jan  1 01:00:00 1970
+++ linux/kernel/syscall_ksyms.c	Mon Oct 29 17:22:02 2001
@@ -0,0 +1,178 @@
+/*
+ * Exports all Linux syscalls.
+ * Christoph Hellwig (hch@caldera.de), 2001
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/syscall.h>
+#include <linux/msg.h>
+#include <linux/sem.h>
+#include <linux/shm.h>
+
+EXPORT_SYMBOL(sys_uselib);
+EXPORT_SYMBOL(sys_sync);
+EXPORT_SYMBOL(sys_fsync);
+EXPORT_SYMBOL(sys_fdatasync);
+EXPORT_SYMBOL(sys_dup);
+EXPORT_SYMBOL(sys_dup2);
+EXPORT_SYMBOL(sys_fcntl);
+#if (BITS_PER_LONG == 32)
+EXPORT_SYMBOL(sys_fcntl64);
+#endif
+EXPORT_SYMBOL(sys_ioctl);
+EXPORT_SYMBOL(sys_link);
+EXPORT_SYMBOL(sys_mkdir);
+EXPORT_SYMBOL(sys_mknod);
+EXPORT_SYMBOL(sys_rename);
+EXPORT_SYMBOL(sys_rmdir);
+EXPORT_SYMBOL(sys_symlink);
+EXPORT_SYMBOL(sys_unlink);
+EXPORT_SYMBOL(sys_umount);
+EXPORT_SYMBOL(sys_oldumount);
+EXPORT_SYMBOL(sys_mount);
+EXPORT_SYMBOL(sys_pivot_root);
+EXPORT_SYMBOL(sys_access);
+EXPORT_SYMBOL(sys_chdir);
+EXPORT_SYMBOL(sys_fchdir);
+EXPORT_SYMBOL(sys_chroot);
+EXPORT_SYMBOL(sys_chmod);
+EXPORT_SYMBOL(sys_fchmod);
+EXPORT_SYMBOL(sys_chown);
+EXPORT_SYMBOL(sys_lchown);
+EXPORT_SYMBOL(sys_fchown);
+EXPORT_SYMBOL(sys_close);
+#if !defined(__alpha__)
+EXPORT_SYMBOL(sys_creat);
+#endif
+EXPORT_SYMBOL(sys_open);
+EXPORT_SYMBOL(sys_statfs);
+EXPORT_SYMBOL(sys_fstatfs);
+EXPORT_SYMBOL(sys_ftruncate);
+EXPORT_SYMBOL(sys_ftruncate64);
+EXPORT_SYMBOL(sys_truncate);
+EXPORT_SYMBOL(sys_truncate64);
+#if !defined(__alpha__) && !defined(__ia64__)
+EXPORT_SYMBOL(sys_utime);
+#endif
+EXPORT_SYMBOL(sys_utimes);
+EXPORT_SYMBOL(sys_vhangup);
+#if !defined(__alpha__)
+EXPORT_SYMBOL(sys_lseek);
+#endif
+EXPORT_SYMBOL(sys_llseek);
+EXPORT_SYMBOL(sys_read);
+EXPORT_SYMBOL(sys_readv);
+EXPORT_SYMBOL(sys_pread);
+EXPORT_SYMBOL(sys_pwrite);
+EXPORT_SYMBOL(sys_write);
+EXPORT_SYMBOL(sys_writev);
+EXPORT_SYMBOL(old_readdir);
+EXPORT_SYMBOL(sys_poll);
+EXPORT_SYMBOL(sys_select);
+EXPORT_SYMBOL(sys_readlink);
+EXPORT_SYMBOL(sys_sysfs);
+EXPORT_SYMBOL(sys_acct);
+EXPORT_SYMBOL(sys_exit);
+EXPORT_SYMBOL(sys_getitimer);
+EXPORT_SYMBOL(sys_setitimer);
+EXPORT_SYMBOL(sys_gettimeofday);
+EXPORT_SYMBOL(sys_settimeofday);
+EXPORT_SYMBOL(sys_stime);
+EXPORT_SYMBOL(sys_time);
+#if !defined(__alpha__)
+EXPORT_SYMBOL(sys_nice);
+#endif
+EXPORT_SYMBOL(sys_sched_setscheduler);
+EXPORT_SYMBOL(sys_sched_setparam);
+EXPORT_SYMBOL(sys_sched_getscheduler);
+EXPORT_SYMBOL(sys_sched_getparam);
+EXPORT_SYMBOL(sys_sched_yield);
+EXPORT_SYMBOL(sys_sched_get_priority_max);
+EXPORT_SYMBOL(sys_sched_get_priority_min);
+EXPORT_SYMBOL(sys_sched_rr_get_interval);
+EXPORT_SYMBOL(sys_kill);
+EXPORT_SYMBOL(sys_rt_sigaction);
+EXPORT_SYMBOL(sys_rt_sigpending);
+EXPORT_SYMBOL(sys_rt_sigprocmask);
+EXPORT_SYMBOL(sys_rt_sigtimedwait);
+EXPORT_SYMBOL(sys_sigaltstack);
+EXPORT_SYMBOL(sys_sigpending);
+EXPORT_SYMBOL(sys_sigprocmask);
+EXPORT_SYMBOL(sys_sigsuspend);
+EXPORT_SYMBOL(sys_gethostname);
+EXPORT_SYMBOL(sys_sethostname);
+EXPORT_SYMBOL(sys_setdomainname);
+EXPORT_SYMBOL(sys_getrlimit);
+EXPORT_SYMBOL(sys_setsid);
+EXPORT_SYMBOL(sys_getsid);
+EXPORT_SYMBOL(sys_getpgid);
+EXPORT_SYMBOL(sys_setpgid);
+EXPORT_SYMBOL(sys_getgroups);
+EXPORT_SYMBOL(sys_setgroups);
+EXPORT_SYMBOL(sys_setpriority);
+EXPORT_SYMBOL(sys_getpriority);
+EXPORT_SYMBOL(sys_reboot);
+EXPORT_SYMBOL(sys_setgid);
+EXPORT_SYMBOL(sys_setuid);
+EXPORT_SYMBOL(sys_times);
+EXPORT_SYMBOL(sys_umask);
+EXPORT_SYMBOL(sys_prctl);
+EXPORT_SYMBOL(sys_setreuid);
+EXPORT_SYMBOL(sys_setregid);
+#if !defined(__alpha__) && !defined(__ia64__)
+EXPORT_SYMBOL(sys_alarm);
+#endif
+#if !defined(__alpha__)
+EXPORT_SYMBOL(sys_getpid);
+EXPORT_SYMBOL(sys_getppid);
+EXPORT_SYMBOL(sys_getuid);
+EXPORT_SYMBOL(sys_geteuid);
+EXPORT_SYMBOL(sys_getgid);
+EXPORT_SYMBOL(sys_getegid);
+#endif
+EXPORT_SYMBOL(sys_gettid);
+EXPORT_SYMBOL(sys_nanosleep);
+#if defined(CONFIG_UID16)
+EXPORT_SYMBOL(sys_setreuid16);
+EXPORT_SYMBOL(sys_setregid16);
+EXPORT_SYMBOL(sys_getgroups16);
+EXPORT_SYMBOL(sys_setgroups16);
+#endif
+EXPORT_SYMBOL(sys_wait4);
+EXPORT_SYMBOL(sys_sendfile);
+EXPORT_SYMBOL(sys_brk);
+EXPORT_SYMBOL(sys_msync);
+EXPORT_SYMBOL(sys_madvise);
+EXPORT_SYMBOL(sys_mincore);
+EXPORT_SYMBOL(sys_munmap);
+EXPORT_SYMBOL(sys_mprotect);
+EXPORT_SYMBOL(sys_socket);
+EXPORT_SYMBOL(sys_socketpair);
+EXPORT_SYMBOL(sys_bind);
+EXPORT_SYMBOL(sys_listen);
+EXPORT_SYMBOL(sys_accept);
+EXPORT_SYMBOL(sys_connect);
+EXPORT_SYMBOL(sys_getsockname);
+EXPORT_SYMBOL(sys_getpeername);
+EXPORT_SYMBOL(sys_sendto);
+EXPORT_SYMBOL(sys_send);
+EXPORT_SYMBOL(sys_recvfrom);
+EXPORT_SYMBOL(sys_setsockopt);
+EXPORT_SYMBOL(sys_getsockopt);
+EXPORT_SYMBOL(sys_shutdown);
+EXPORT_SYMBOL(sys_sendmsg);
+EXPORT_SYMBOL(sys_recvmsg);
+EXPORT_SYMBOL(sys_socketcall);
+
+EXPORT_SYMBOL(sys_msgget);
+EXPORT_SYMBOL(sys_msgsnd);
+EXPORT_SYMBOL(sys_msgrcv);
+EXPORT_SYMBOL(sys_msgctl);
+EXPORT_SYMBOL(sys_semget);
+EXPORT_SYMBOL(sys_semop);
+EXPORT_SYMBOL(sys_semctl);
+EXPORT_SYMBOL(sys_shmget);
+EXPORT_SYMBOL(sys_shmat);
+EXPORT_SYMBOL(sys_shmdt);
+EXPORT_SYMBOL(sys_shmctl);
