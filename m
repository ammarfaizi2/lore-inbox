Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030508AbWJJVqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030508AbWJJVqL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030507AbWJJVqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:46:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41924 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030506AbWJJVp6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:45:58 -0400
To: torvalds@osdl.org
Subject: [PATCH] tipc __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPQD-0007LM-7E@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:45:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/tipc/socket.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 32d7784..acfb852 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -941,7 +941,7 @@ static int recv_stream(struct kiocb *ioc
 	int sz_to_copy;
 	int sz_copied = 0;
 	int needed;
-	char *crs = m->msg_iov->iov_base;
+	char __user *crs = m->msg_iov->iov_base;
 	unsigned char *buf_crs;
 	u32 err;
 	int res;
@@ -1496,7 +1496,7 @@ static int setsockopt(struct socket *soc
 		return -ENOPROTOOPT;
 	if (ol < sizeof(value))
 		return -EINVAL;
-        if ((res = get_user(value, (u32 *)ov)))
+        if ((res = get_user(value, (u32 __user *)ov)))
 		return res;
 
 	if (down_interruptible(&tsock->sem)) 
@@ -1541,7 +1541,7 @@ static int setsockopt(struct socket *soc
  */
 
 static int getsockopt(struct socket *sock, 
-		      int lvl, int opt, char __user *ov, int *ol)
+		      int lvl, int opt, char __user *ov, int __user *ol)
 {
 	struct tipc_sock *tsock = tipc_sk(sock->sk);
         int len;
-- 
1.4.2.GIT


