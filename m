Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262633AbTCYN0G>; Tue, 25 Mar 2003 08:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262635AbTCYN0G>; Tue, 25 Mar 2003 08:26:06 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:49406 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262633AbTCYN0C>;
	Tue, 25 Mar 2003 08:26:02 -0500
Date: Wed, 26 Mar 2003 00:36:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
Subject: [PATCH][COMPAT] more compat types
Message-Id: <20030326003649.331cb880.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Is creating new types like this sensible?  Basically this patch
creates compat_{int,uint,long,ulong}_t for use in generic
declarations of structures and generic compatibility code.

Is this going further than you wanted?  Or am I heading in
the direction?  I think this is where DaveM wants to go.

socklen_t comes from the user mode definition of the msghdr
strucure.

Yes, Dave, I put this through the corss compiler :-)
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.66-032517-32bit.1/include/asm-parisc/compat.h 2.5.66-032517-32bit.2/include/asm-parisc/compat.h
--- 2.5.66-032517-32bit.1/include/asm-parisc/compat.h	2003-03-25 12:08:24.000000000 +1100
+++ 2.5.66-032517-32bit.2/include/asm-parisc/compat.h	2003-03-25 16:10:11.000000000 +1100
@@ -23,6 +23,12 @@
 typedef u16	compat_ipc_pid_t;
 typedef s32	compat_daddr_t;
 typedef u32	compat_caddr_t;
+typedef s32		compat_socklen_t;
+
+typedef s32		compat_int_t;
+typedef s32		compat_long_t;
+typedef u32		compat_uint_t;
+typedef u32		compat_ulong_t;
 
 struct compat_timespec {
 	compat_time_t		tv_sec;
diff -ruN 2.5.66-032517-32bit.1/include/asm-ppc64/compat.h 2.5.66-032517-32bit.2/include/asm-ppc64/compat.h
--- 2.5.66-032517-32bit.1/include/asm-ppc64/compat.h	2003-03-25 12:08:24.000000000 +1100
+++ 2.5.66-032517-32bit.2/include/asm-ppc64/compat.h	2003-03-25 16:10:16.000000000 +1100
@@ -24,6 +24,12 @@
 typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
+typedef s32		compat_socklen_t;
+
+typedef s32		compat_int_t;
+typedef s32		compat_long_t;
+typedef u32		compat_uint_t;
+typedef u32		compat_ulong_t;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
diff -ruN 2.5.66-032517-32bit.1/include/asm-s390x/compat.h 2.5.66-032517-32bit.2/include/asm-s390x/compat.h
--- 2.5.66-032517-32bit.1/include/asm-s390x/compat.h	2003-03-25 12:08:24.000000000 +1100
+++ 2.5.66-032517-32bit.2/include/asm-s390x/compat.h	2003-03-25 16:10:20.000000000 +1100
@@ -24,6 +24,12 @@
 typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
+typedef s32		compat_socklen_t;
+
+typedef s32		compat_int_t;
+typedef s32		compat_long_t;
+typedef u32		compat_uint_t;
+typedef u32		compat_ulong_t;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
diff -ruN 2.5.66-032517-32bit.1/include/asm-sparc64/compat.h 2.5.66-032517-32bit.2/include/asm-sparc64/compat.h
--- 2.5.66-032517-32bit.1/include/asm-sparc64/compat.h	2003-03-25 12:08:24.000000000 +1100
+++ 2.5.66-032517-32bit.2/include/asm-sparc64/compat.h	2003-03-25 16:10:24.000000000 +1100
@@ -24,6 +24,12 @@
 typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
+typedef s32		compat_socklen_t;
+
+typedef s32		compat_int_t;
+typedef s32		compat_long_t;
+typedef u32		compat_uint_t;
+typedef u32		compat_ulong_t;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
diff -ruN 2.5.66-032517-32bit.1/include/asm-x86_64/compat.h 2.5.66-032517-32bit.2/include/asm-x86_64/compat.h
--- 2.5.66-032517-32bit.1/include/asm-x86_64/compat.h	2003-03-25 12:08:25.000000000 +1100
+++ 2.5.66-032517-32bit.2/include/asm-x86_64/compat.h	2003-03-25 16:10:31.000000000 +1100
@@ -26,6 +26,12 @@
 typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
+typedef s32		compat_socklen_t;
+
+typedef s32		compat_int_t;
+typedef s32		compat_long_t;
+typedef u32		compat_uint_t;
+typedef u32		compat_ulong_t;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
diff -ruN 2.5.66-032517-32bit.1/include/linux/compat.h 2.5.66-032517-32bit.2/include/linux/compat.h
--- 2.5.66-032517-32bit.1/include/linux/compat.h	2003-03-25 12:08:25.000000000 +1100
+++ 2.5.66-032517-32bit.2/include/linux/compat.h	2003-03-25 15:59:01.000000000 +1100
@@ -43,7 +43,7 @@
 extern int put_compat_timespec(struct timespec *, struct compat_timespec *);
 
 struct compat_iovec {
-	compat_uptr_t	iov_base;
+	compat_uptr_t	iov_base;	/* void * */
 	compat_size_t	iov_len;
 };
 
diff -ruN 2.5.66-032517-32bit.1/include/net/compat.h 2.5.66-032517-32bit.2/include/net/compat.h
--- 2.5.66-032517-32bit.1/include/net/compat.h	2003-03-25 12:08:26.000000000 +1100
+++ 2.5.66-032517-32bit.2/include/net/compat.h	2003-03-25 16:11:22.000000000 +1100
@@ -8,19 +8,19 @@
 #include <linux/compat.h>
 
 struct compat_msghdr {
-	compat_uptr_t	msg_name;
-	s32		msg_namelen;
-	compat_uptr_t	msg_iov;
+	compat_uptr_t	msg_name;	/* void * */
+	compat_socklen_t	msg_namelen;
+	compat_uptr_t	msg_iov;	/* struct compat_iovec * */
 	compat_size_t	msg_iovlen;
-	compat_uptr_t	msg_control;
+	compat_uptr_t	msg_control;	/* void * */
 	compat_size_t	msg_controllen;
-	u32		msg_flags;
+	compat_uint_t	msg_flags;
 };
 
 struct compat_cmsghdr {
 	compat_size_t	cmsg_len;
-	s32		cmsg_level;
-	s32		cmsg_type;
+	compat_int_t	cmsg_level;
+	compat_int_t	cmsg_type;
 };
 
 #else /* defined(CONFIG_COMPAT) */
@@ -29,8 +29,8 @@
 
 extern int get_compat_msghdr(struct msghdr *, struct compat_msghdr *);
 extern int verify_compat_iovec(struct msghdr *, struct iovec *, char *, int);
-extern asmlinkage long compat_sys_sendmsg(int,struct compat_msghdr *,unsigned);
-extern asmlinkage long compat_sys_recvmsg(int,struct compat_msghdr *,unsigned);
+extern asmlinkage long compat_sys_sendmsg(int, struct compat_msghdr *, unsigned);
+extern asmlinkage long compat_sys_recvmsg(int, struct compat_msghdr *, unsigned);
 extern asmlinkage long compat_sys_getsockopt(int, int, int, char *, int *);
 extern int put_cmsg_compat(struct msghdr*, int, int, int, void *);
 extern int put_compat_msg_controllen(struct msghdr *, struct compat_msghdr *,
