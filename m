Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbUCEW5G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 17:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbUCEW5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 17:57:06 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:56711 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261407AbUCEW5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 17:57:02 -0500
Date: Fri, 5 Mar 2004 22:55:56 +0000
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] mismatched syscall protos.
Message-ID: <20040305225556.GA18732@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse noticed a bunch of mismatched prototypes in the new syscalls.h file
when compiling net/socket.c  Whilst most of them are just missing __user
tags, the last argument of sys_socketpair was completely different.

		Dave

--- bk-linus/include/linux/syscalls.h~	Fri Mar  5 17:52:01 2004
+++ bk-linus/include/linux/syscalls.h	Fri Mar  5 17:55:40 2004
@@ -386,24 +386,24 @@
 				unsigned int count);
 
 asmlinkage long sys_setsockopt(int fd, int level, int optname,
-				char *optval, int optlen);
+				char __user *optval, int optlen);
 asmlinkage long sys_getsockopt(int fd, int level, int optname,
 				char __user *optval, int __user *optlen);
-asmlinkage long sys_bind(int, struct sockaddr *, int);
-asmlinkage long sys_connect(int, struct sockaddr *, int);
-asmlinkage long sys_accept(int, struct sockaddr *, int *);
-asmlinkage long sys_getsockname(int, struct sockaddr *, int *);
-asmlinkage long sys_getpeername(int, struct sockaddr *, int *);
-asmlinkage long sys_send(int, void *, size_t, unsigned);
-asmlinkage long sys_sendto(int, void *, size_t, unsigned,
-				struct sockaddr *, int);
+asmlinkage long sys_bind(int, struct sockaddr __user *, int);
+asmlinkage long sys_connect(int, struct sockaddr __user *, int);
+asmlinkage long sys_accept(int, struct sockaddr __user *, int __user *);
+asmlinkage long sys_getsockname(int, struct sockaddr __user *, int __user *);
+asmlinkage long sys_getpeername(int, struct sockaddr __user *, int __user *);
+asmlinkage long sys_send(int, void __user *, size_t, unsigned);
+asmlinkage long sys_sendto(int, void __user *, size_t, unsigned,
+				struct sockaddr __user *, int);
 asmlinkage long sys_sendmsg(int fd, struct msghdr __user *msg, unsigned flags);
-asmlinkage long sys_recv(int, void *, size_t, unsigned);
-asmlinkage long sys_recvfrom(int, void *, size_t, unsigned,
-				struct sockaddr *, int *);
+asmlinkage long sys_recv(int, void __user *, size_t, unsigned);
+asmlinkage long sys_recvfrom(int, void __user *, size_t, unsigned,
+				struct sockaddr __user *, int __user *);
 asmlinkage long sys_recvmsg(int fd, struct msghdr __user *msg, unsigned flags);
 asmlinkage long sys_socket(int, int, int);
-asmlinkage long sys_socketpair(int, int, int, int [2]);
+asmlinkage long sys_socketpair(int, int, int, int __user *);
 asmlinkage long sys_socketcall(int call, unsigned long __user *args);
 asmlinkage long sys_listen(int, int);
 asmlinkage long sys_poll(struct pollfd __user *ufds, unsigned int nfds,
