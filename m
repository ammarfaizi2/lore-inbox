Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262970AbSJBFJQ>; Wed, 2 Oct 2002 01:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262971AbSJBFJQ>; Wed, 2 Oct 2002 01:09:16 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:62104
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262970AbSJBFJP>; Wed, 2 Oct 2002 01:09:15 -0400
Date: Wed, 2 Oct 2002 00:38:12 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] sctp: possible sleep w/ lock held
Message-ID: <Pine.LNX.4.44.0210020036320.32388-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.40/net/sctp/protocol.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.40/net/sctp/protocol.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 protocol.c
--- linux-2.5.40/net/sctp/protocol.c	1 Oct 2002 12:29:11 -0000	1.1.1.1
+++ linux-2.5.40/net/sctp/protocol.c	2 Oct 2002 03:26:30 -0000
@@ -119,8 +119,7 @@
 
 	for (ifa = in_dev->ifa_list; ifa; ifa = ifa->ifa_next) {
 		/* Add the address to the local list.  */
-		/* XXX BUG: sleeping allocation with lock held -DaveM */
-		addr = t_new(struct sockaddr_storage_list, GFP_KERNEL);
+		addr = t_new(struct sockaddr_storage_list, GFP_ATOMIC);
 		if (addr) {
 			INIT_LIST_HEAD(&addr->list);
 			addr->a.v4.sin_family = AF_INET;
@@ -157,8 +156,7 @@
 	read_lock_bh(&in6_dev->lock);
 	for (ifp = in6_dev->addr_list; ifp; ifp = ifp->if_next) {
 		/* Add the address to the local list.  */
-		/* XXX BUG: sleeping allocation with lock held -DaveM */
-		addr = t_new(struct sockaddr_storage_list, GFP_KERNEL);
+		addr = t_new(struct sockaddr_storage_list, GFP_ATOMIC);
 		if (addr) {
 			addr->a.v6.sin6_family = AF_INET6;
 			addr->a.v6.sin6_port = 0;

-- 
function.linuxpower.ca

