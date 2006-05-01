Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWEAK2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWEAK2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 06:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWEAK2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 06:28:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:3720 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751125AbWEAK2e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 06:28:34 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] sockaddr patch
Message-Id: <E1FaVdp-000518-Hn@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 01 May 2006 11:28:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Grubb <sgrubb@redhat.com>
Date: Thu Mar 30 12:20:22 2006 -0500

On Thursday 23 March 2006 09:08, John D. Ramsdell wrote:
>  I noticed that a socketcall(bind) and socketcall(connect) event contain a
>  record of type=SOCKADDR, but I cannot see one for a system call event
>  associated with socketcall(accept).  Recording the sockaddr of an accepted
>  socket is important for cross platform information flow analys

Thanks for pointing this out. The following patch should address this.

Signed-off-by: Steve Grubb <sgrubb@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 net/socket.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

d6fe3945b42d09a1eca7ad180a1646e585b8594f
diff --git a/net/socket.c b/net/socket.c
index 0ce12df..02948b6 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -267,6 +267,8 @@ int move_addr_to_user(void *kaddr, int k
 		return -EINVAL;
 	if(len)
 	{
+		if (audit_sockaddr(klen, kaddr))
+			return -ENOMEM;
 		if(copy_to_user(uaddr,kaddr,len))
 			return -EFAULT;
 	}
-- 
1.3.0.g0080f

