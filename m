Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161062AbWBHHLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbWBHHLV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbWBHHKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:10:47 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:8091 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161042AbWBHHKW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:10:22 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 03/17] s390x compat __user annotations
Cc: schwidefsky@de.ibm.com
Message-Id: <E1F6jT2-0002UC-VA@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:10:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138788975 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/s390/kernel/compat_linux.c |   83 ++++++++++++++++++++-------------------
 1 files changed, 42 insertions(+), 41 deletions(-)

24954a1418298058399581d6fcc4d46e928e1bf5
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index bf9a7a3..cc20f0e 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -100,12 +100,12 @@
 #define SET_STAT_UID(stat, uid)		(stat).st_uid = high2lowuid(uid)
 #define SET_STAT_GID(stat, gid)		(stat).st_gid = high2lowgid(gid)
 
-asmlinkage long sys32_chown16(const char * filename, u16 user, u16 group)
+asmlinkage long sys32_chown16(const char __user * filename, u16 user, u16 group)
 {
 	return sys_chown(filename, low2highuid(user), low2highgid(group));
 }
 
-asmlinkage long sys32_lchown16(const char * filename, u16 user, u16 group)
+asmlinkage long sys32_lchown16(const char __user * filename, u16 user, u16 group)
 {
 	return sys_lchown(filename, low2highuid(user), low2highgid(group));
 }
@@ -141,7 +141,7 @@ asmlinkage long sys32_setresuid16(u16 ru
 		low2highuid(suid));
 }
 
-asmlinkage long sys32_getresuid16(u16 *ruid, u16 *euid, u16 *suid)
+asmlinkage long sys32_getresuid16(u16 __user *ruid, u16 __user *euid, u16 __user *suid)
 {
 	int retval;
 
@@ -158,7 +158,7 @@ asmlinkage long sys32_setresgid16(u16 rg
 		low2highgid(sgid));
 }
 
-asmlinkage long sys32_getresgid16(u16 *rgid, u16 *egid, u16 *sgid)
+asmlinkage long sys32_getresgid16(u16 __user *rgid, u16 __user *egid, u16 __user *sgid)
 {
 	int retval;
 
@@ -179,7 +179,7 @@ asmlinkage long sys32_setfsgid16(u16 gid
 	return sys_setfsgid((gid_t)gid);
 }
 
-static int groups16_to_user(u16 *grouplist, struct group_info *group_info)
+static int groups16_to_user(u16 __user *grouplist, struct group_info *group_info)
 {
 	int i;
 	u16 group;
@@ -193,7 +193,7 @@ static int groups16_to_user(u16 *groupli
 	return 0;
 }
 
-static int groups16_from_user(struct group_info *group_info, u16 *grouplist)
+static int groups16_from_user(struct group_info *group_info, u16 __user *grouplist)
 {
 	int i;
 	u16 group;
@@ -207,7 +207,7 @@ static int groups16_from_user(struct gro
 	return 0;
 }
 
-asmlinkage long sys32_getgroups16(int gidsetsize, u16 *grouplist)
+asmlinkage long sys32_getgroups16(int gidsetsize, u16 __user *grouplist)
 {
 	int i;
 
@@ -231,7 +231,7 @@ out:
 	return i;
 }
 
-asmlinkage long sys32_setgroups16(int gidsetsize, u16 *grouplist)
+asmlinkage long sys32_setgroups16(int gidsetsize, u16 __user *grouplist)
 {
 	struct group_info *group_info;
 	int retval;
@@ -278,14 +278,14 @@ asmlinkage long sys32_getegid16(void)
 
 /* 32-bit timeval and related flotsam.  */
 
-static inline long get_tv32(struct timeval *o, struct compat_timeval *i)
+static inline long get_tv32(struct timeval *o, struct compat_timeval __user *i)
 {
 	return (!access_ok(VERIFY_READ, o, sizeof(*o)) ||
 		(__get_user(o->tv_sec, &i->tv_sec) ||
 		 __get_user(o->tv_usec, &i->tv_usec)));
 }
 
-static inline long put_tv32(struct compat_timeval *o, struct timeval *i)
+static inline long put_tv32(struct compat_timeval __user *o, struct timeval *i)
 {
 	return (!access_ok(VERIFY_WRITE, o, sizeof(*o)) ||
 		(__put_user(i->tv_sec, &o->tv_sec) ||
@@ -341,7 +341,7 @@ asmlinkage long sys32_ipc(u32 call, int 
 	return -ENOSYS;
 }
 
-asmlinkage long sys32_truncate64(const char * path, unsigned long high, unsigned long low)
+asmlinkage long sys32_truncate64(const char __user * path, unsigned long high, unsigned long low)
 {
 	if ((int)high < 0)
 		return -EINVAL;
@@ -357,7 +357,7 @@ asmlinkage long sys32_ftruncate64(unsign
 		return sys_ftruncate(fd, (high << 32) | low);
 }
 
-int cp_compat_stat(struct kstat *stat, struct compat_stat *statbuf)
+int cp_compat_stat(struct kstat *stat, struct compat_stat __user *statbuf)
 {
 	int err;
 
@@ -591,7 +591,7 @@ sys32_delete_module(const char __user *n
 
 extern struct timezone sys_tz;
 
-asmlinkage long sys32_gettimeofday(struct compat_timeval *tv, struct timezone *tz)
+asmlinkage long sys32_gettimeofday(struct compat_timeval __user *tv, struct timezone __user *tz)
 {
 	if (tv) {
 		struct timeval ktv;
@@ -606,7 +606,7 @@ asmlinkage long sys32_gettimeofday(struc
 	return 0;
 }
 
-static inline long get_ts32(struct timespec *o, struct compat_timeval *i)
+static inline long get_ts32(struct timespec *o, struct compat_timeval __user *i)
 {
 	long usec;
 
@@ -620,7 +620,7 @@ static inline long get_ts32(struct times
 	return 0;
 }
 
-asmlinkage long sys32_settimeofday(struct compat_timeval *tv, struct timezone *tz)
+asmlinkage long sys32_settimeofday(struct compat_timeval __user *tv, struct timezone __user *tz)
 {
 	struct timespec kts;
 	struct timezone ktz;
@@ -645,7 +645,7 @@ asmlinkage long sys32_pause(void)
 	return -ERESTARTNOHAND;
 }
 
-asmlinkage long sys32_pread64(unsigned int fd, char *ubuf,
+asmlinkage long sys32_pread64(unsigned int fd, char __user *ubuf,
 				size_t count, u32 poshi, u32 poslo)
 {
 	if ((compat_ssize_t) count < 0)
@@ -653,7 +653,7 @@ asmlinkage long sys32_pread64(unsigned i
 	return sys_pread64(fd, ubuf, count, ((loff_t)AA(poshi) << 32) | AA(poslo));
 }
 
-asmlinkage long sys32_pwrite64(unsigned int fd, const char *ubuf,
+asmlinkage long sys32_pwrite64(unsigned int fd, const char __user *ubuf,
 				size_t count, u32 poshi, u32 poslo)
 {
 	if ((compat_ssize_t) count < 0)
@@ -666,7 +666,7 @@ asmlinkage compat_ssize_t sys32_readahea
 	return sys_readahead(fd, ((loff_t)AA(offhi) << 32) | AA(offlo), count);
 }
 
-asmlinkage long sys32_sendfile(int out_fd, int in_fd, compat_off_t *offset, size_t count)
+asmlinkage long sys32_sendfile(int out_fd, int in_fd, compat_off_t __user *offset, size_t count)
 {
 	mm_segment_t old_fs = get_fs();
 	int ret;
@@ -686,7 +686,7 @@ asmlinkage long sys32_sendfile(int out_f
 }
 
 asmlinkage long sys32_sendfile64(int out_fd, int in_fd,
-				compat_loff_t *offset, s32 count)
+				compat_loff_t __user *offset, s32 count)
 {
 	mm_segment_t old_fs = get_fs();
 	int ret;
@@ -722,7 +722,7 @@ struct timex32 {
 
 extern int do_adjtimex(struct timex *);
 
-asmlinkage long sys32_adjtimex(struct timex32 *utp)
+asmlinkage long sys32_adjtimex(struct timex32 __user *utp)
 {
 	struct timex txc;
 	int ret;
@@ -789,12 +789,13 @@ struct __sysctl_args32 {
 	u32 __unused[4];
 };
 
-asmlinkage long sys32_sysctl(struct __sysctl_args32 *args)
+asmlinkage long sys32_sysctl(struct __sysctl_args32 __user *args)
 {
 	struct __sysctl_args32 tmp;
 	int error;
-	size_t oldlen, *oldlenp = NULL;
-	unsigned long addr = (((long)&args->__unused[0]) + 7) & ~7;
+	size_t oldlen;
+	size_t __user *oldlenp = NULL;
+	unsigned long addr = (((unsigned long)&args->__unused[0]) + 7) & ~7;
 
 	if (copy_from_user(&tmp, args, sizeof(tmp)))
 		return -EFAULT;
@@ -806,20 +807,20 @@ asmlinkage long sys32_sysctl(struct __sy
 		   basically copy the whole sysctl.c here, and
 		   glibc's __sysctl uses rw memory for the structure
 		   anyway.  */
-		if (get_user(oldlen, (u32 *)A(tmp.oldlenp)) ||
-		    put_user(oldlen, (size_t *)addr))
+		if (get_user(oldlen, (u32 __user *)compat_ptr(tmp.oldlenp)) ||
+		    put_user(oldlen, (size_t __user *)addr))
 			return -EFAULT;
-		oldlenp = (size_t *)addr;
+		oldlenp = (size_t __user *)addr;
 	}
 
 	lock_kernel();
-	error = do_sysctl((int *)A(tmp.name), tmp.nlen, (void *)A(tmp.oldval),
-			  oldlenp, (void *)A(tmp.newval), tmp.newlen);
+	error = do_sysctl(compat_ptr(tmp.name), tmp.nlen, compat_ptr(tmp.oldval),
+			  oldlenp, compat_ptr(tmp.newval), tmp.newlen);
 	unlock_kernel();
 	if (oldlenp) {
 		if (!error) {
-			if (get_user(oldlen, (size_t *)addr) ||
-			    put_user(oldlen, (u32 *)A(tmp.oldlenp)))
+			if (get_user(oldlen, (size_t __user *)addr) ||
+			    put_user(oldlen, (u32 __user *)compat_ptr(tmp.oldlenp)))
 				error = -EFAULT;
 		}
 		copy_to_user(args->__unused, tmp.__unused, sizeof(tmp.__unused));
@@ -853,7 +854,7 @@ struct stat64_emu31 {
 	unsigned long   st_ino;
 };	
 
-static int cp_stat64(struct stat64_emu31 *ubuf, struct kstat *stat)
+static int cp_stat64(struct stat64_emu31 __user *ubuf, struct kstat *stat)
 {
 	struct stat64_emu31 tmp;
 
@@ -877,7 +878,7 @@ static int cp_stat64(struct stat64_emu31
 	return copy_to_user(ubuf,&tmp,sizeof(tmp)) ? -EFAULT : 0; 
 }
 
-asmlinkage long sys32_stat64(char * filename, struct stat64_emu31 * statbuf)
+asmlinkage long sys32_stat64(char __user * filename, struct stat64_emu31 __user * statbuf)
 {
 	struct kstat stat;
 	int ret = vfs_stat(filename, &stat);
@@ -886,7 +887,7 @@ asmlinkage long sys32_stat64(char * file
 	return ret;
 }
 
-asmlinkage long sys32_lstat64(char * filename, struct stat64_emu31 * statbuf)
+asmlinkage long sys32_lstat64(char __user * filename, struct stat64_emu31 __user * statbuf)
 {
 	struct kstat stat;
 	int ret = vfs_lstat(filename, &stat);
@@ -895,7 +896,7 @@ asmlinkage long sys32_lstat64(char * fil
 	return ret;
 }
 
-asmlinkage long sys32_fstat64(unsigned long fd, struct stat64_emu31 * statbuf)
+asmlinkage long sys32_fstat64(unsigned long fd, struct stat64_emu31 __user * statbuf)
 {
 	struct kstat stat;
 	int ret = vfs_fstat(fd, &stat);
@@ -952,7 +953,7 @@ out:    
 
 
 asmlinkage unsigned long
-old32_mmap(struct mmap_arg_struct_emu31 *arg)
+old32_mmap(struct mmap_arg_struct_emu31 __user *arg)
 {
 	struct mmap_arg_struct_emu31 a;
 	int error = -EFAULT;
@@ -970,7 +971,7 @@ out:
 }
 
 asmlinkage long 
-sys32_mmap2(struct mmap_arg_struct_emu31 *arg)
+sys32_mmap2(struct mmap_arg_struct_emu31 __user *arg)
 {
 	struct mmap_arg_struct_emu31 a;
 	int error = -EFAULT;
@@ -982,7 +983,7 @@ out:
 	return error;
 }
 
-asmlinkage long sys32_read(unsigned int fd, char * buf, size_t count)
+asmlinkage long sys32_read(unsigned int fd, char __user * buf, size_t count)
 {
 	if ((compat_ssize_t) count < 0)
 		return -EINVAL; 
@@ -990,7 +991,7 @@ asmlinkage long sys32_read(unsigned int 
 	return sys_read(fd, buf, count);
 }
 
-asmlinkage long sys32_write(unsigned int fd, char * buf, size_t count)
+asmlinkage long sys32_write(unsigned int fd, char __user * buf, size_t count)
 {
 	if ((compat_ssize_t) count < 0)
 		return -EINVAL; 
@@ -1002,12 +1003,12 @@ asmlinkage long sys32_clone(struct pt_re
 {
         unsigned long clone_flags;
         unsigned long newsp;
-	int *parent_tidptr, *child_tidptr;
+	int __user *parent_tidptr, *child_tidptr;
 
         clone_flags = regs.gprs[3] & 0xffffffffUL;
         newsp = regs.orig_gpr2 & 0x7fffffffUL;
-	parent_tidptr = (int *) (regs.gprs[4] & 0x7fffffffUL);
-	child_tidptr = (int *) (regs.gprs[5] & 0x7fffffffUL);
+	parent_tidptr = compat_ptr(regs.gprs[4]);
+	child_tidptr = compat_ptr(regs.gprs[5]);
         if (!newsp)
                 newsp = regs.gprs[15];
         return do_fork(clone_flags, newsp, &regs, 0,
-- 
0.99.9.GIT

