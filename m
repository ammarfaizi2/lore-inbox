Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbULLVQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbULLVQc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 16:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbULLVQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 16:16:31 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61190 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262133AbULLVPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 16:15:16 -0500
Date: Sun, 12 Dec 2004 22:15:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/socket.c: make a function static
Message-ID: <20041212211506.GY22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


diffstat output:
 include/linux/net.h |    4 ----
 net/socket.c        |    5 +++--
 2 files changed, 3 insertions(+), 6 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/linux/net.h.old	2004-12-12 19:03:55.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/net.h	2004-12-12 19:04:01.000000000 +0100
@@ -187,10 +187,6 @@
 				  size_t len);
 extern int	     sock_recvmsg(struct socket *sock, struct msghdr *msg,
 				  size_t size, int flags);
-extern int	     sock_readv_writev(int type, struct inode *inode,
-				       struct file *file,
-				       const struct iovec *iov, long count,
-				       size_t size);
 extern int 	     sock_map_fd(struct socket *sock);
 extern struct socket *sockfd_lookup(int fd, int *err);
 #define		     sockfd_put(sock) fput(sock->file)
--- linux-2.6.10-rc2-mm4-full/net/socket.c.old	2004-12-12 19:04:08.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/socket.c	2004-12-12 19:04:46.000000000 +0100
@@ -736,8 +736,9 @@
 	return sock->ops->sendpage(sock, page, offset, size, flags);
 }
 
-int sock_readv_writev(int type, struct inode * inode, struct file * file,
-		      const struct iovec * iov, long count, size_t size)
+static int sock_readv_writev(int type, struct inode * inode,
+			     struct file * file, const struct iovec * iov,
+			     long count, size_t size)
 {
 	struct msghdr msg;
 	struct socket *sock;

