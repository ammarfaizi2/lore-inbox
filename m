Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262223AbSJNUkJ>; Mon, 14 Oct 2002 16:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262226AbSJNUkJ>; Mon, 14 Oct 2002 16:40:09 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:48268 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S262223AbSJNUkG>; Mon, 14 Oct 2002 16:40:06 -0400
Message-Id: <5.1.0.14.2.20021014134001.083de250@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 14 Oct 2002 13:45:50 -0700
To: linux-kernel@vger.kernel.org
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: [PATCH] Export sockfd_lookup function
Cc: davem@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can we export sockfd_lookup function ?
I need it in one of the Bluetooth modules which has to look up 'struct socket'
from fd in the ioctl handler.

Here is the patch

----------
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#                  ChangeSet    1.741   -> 1.742
#               net/socket.c    1.29    -> 1.30
#        include/linux/net.h    1.4     -> 1.5
#              net/netsyms.c    1.29    -> 1.30
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/13      maxk@qualcomm.com       1.742
# Export sockfd_lookup and sockfd_put functions
# --------------------------------------------
#
diff -Nru a/include/linux/net.h b/include/linux/net.h
--- a/include/linux/net.h       Sun Oct 13 05:05:42 2002
+++ b/include/linux/net.h       Sun Oct 13 05:05:42 2002
@@ -139,6 +139,9 @@
                                   const struct iovec * iov, long count, 
long size);
  extern int     sock_map_fd(struct socket *sock);

+extern struct socket *sockfd_lookup(int fd, int *err);
+#define         sockfd_put(sock) fput(sock->file)
+
  extern int     net_ratelimit(void);
  extern unsigned long net_random(void);
  extern void net_srandom(unsigned long);
diff -Nru a/net/netsyms.c b/net/netsyms.c
--- a/net/netsyms.c     Sun Oct 13 05:05:42 2002
+++ b/net/netsyms.c     Sun Oct 13 05:05:42 2002
@@ -161,6 +161,7 @@
  EXPORT_SYMBOL(sock_kmalloc);
  EXPORT_SYMBOL(sock_kfree_s);
  EXPORT_SYMBOL(sock_map_fd);
+EXPORT_SYMBOL(sockfd_lookup);

  #ifdef CONFIG_FILTER
  EXPORT_SYMBOL(sk_run_filter);
diff -Nru a/net/socket.c b/net/socket.c
--- a/net/socket.c      Sun Oct 13 05:05:42 2002
+++ b/net/socket.c      Sun Oct 13 05:05:42 2002
@@ -447,11 +447,6 @@
         return sock;
  }

-extern __inline__ void sockfd_put(struct socket *sock)
-{
-       fput(sock->file);
-}
-
  /**
   *     sock_alloc      -       allocate a socket
   *
-------------

Note. sockfd_put is #define instead of inline because fput() definition
is not available at this point.



Max

http://bluez.sf.net
http://vtun.sf.net

