Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264414AbUE3VzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbUE3VzJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 17:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbUE3VzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 17:55:08 -0400
Received: from aun.it.uu.se ([130.238.12.36]:30113 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264414AbUE3VzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 17:55:05 -0400
Date: Sun, 30 May 2004 23:54:50 +0200 (MEST)
Message-Id: <200405302154.i4ULso3l014496@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.27-pre4] tcp_input.c compile-time error
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net/ipv4/tcp_input.c in 2.4.27-pre4 fails to compile:

tcp_input.c: In function `tcp_rcv_space_adjust':
tcp_input.c:479: error: structure has no member named `sk_rcvbuf'
tcp_input.c:480: error: structure has no member named `sk_rcvbuf'
make[3]: *** [tcp_input.o] Error 1

The patch below appears to fix this problem, although some netdev
person should probably check it.

/Mikael

diff -ruN linux-2.4.27-pre4/net/ipv4/tcp_input.c linux-2.4.27-pre4.tcp_input-fix/net/ipv4/tcp_input.c
--- linux-2.4.27-pre4/net/ipv4/tcp_input.c	2004-05-30 23:18:16.000000000 +0200
+++ linux-2.4.27-pre4.tcp_input-fix/net/ipv4/tcp_input.c	2004-05-30 23:45:52.000000000 +0200
@@ -476,8 +476,8 @@
 				  16 + sizeof(struct sk_buff));
 			space *= rcvmem;
 			space = min(space, sysctl_tcp_rmem[2]);
-			if (space > sk->sk_rcvbuf)
-				sk->sk_rcvbuf = space;
+			if (space > sk->rcvbuf)
+				sk->rcvbuf = space;
 		}
 	}
 	
