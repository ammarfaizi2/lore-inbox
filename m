Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270620AbUJUAqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270620AbUJUAqq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270621AbUJUAmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:42:46 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:63899 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S270581AbUJUAlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 20:41:03 -0400
Date: Thu, 21 Oct 2004 02:41:27 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: accept should return ENFILE if it runs out of inodes
Message-ID: <20041021004127.GO24619@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EMFILE is only for the per-process fds limit, all other cases where
sock_alloc fails already returns -ENFILE too, must have been a typo.

patch for 2.4:

--- 2.4.23aa3/net/socket.c.~1~	2004-07-04 02:09:33.000000000 +0200
+++ 2.4.23aa3/net/socket.c	2004-10-21 02:36:45.704715960 +0200
@@ -1068,7 +1068,7 @@ asmlinkage long sys_accept(int fd, struc
 	if (!sock)
 		goto out;
 
-	err = -EMFILE;
+	err = -ENFILE;
 	if (!(newsock = sock_alloc())) 
 		goto out_put;
 

patch for 2.6:

Index: linux-2.5/net/socket.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/net/socket.c,v
retrieving revision 1.90
diff -u -p -r1.90 socket.c
--- linux-2.5/net/socket.c	8 Aug 2004 02:05:19 -0000	1.90
+++ linux-2.5/net/socket.c	21 Oct 2004 00:37:12 -0000
@@ -1354,7 +1354,7 @@ asmlinkage long sys_accept(int fd, struc
 	if (!sock)
 		goto out;
 
-	err = -EMFILE;
+	err = -ENFILE;
 	if (!(newsock = sock_alloc())) 
 		goto out_put;
 
