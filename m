Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261557AbSJMR76>; Sun, 13 Oct 2002 13:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261558AbSJMR76>; Sun, 13 Oct 2002 13:59:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55926 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261557AbSJMR75>; Sun, 13 Oct 2002 13:59:57 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.42 Allow building with CONFIG_NET=n
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Oct 2002 12:04:29 -0600
Message-ID: <m1n0pimd02.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a minimal patch that allows 2.5.42 to build when
you don't want networking support.

Eric

--- linux-2.5.42/net/socket.c	Fri Oct 11 22:21:39 2002
+++ linux-2.5.42.eb1/net/socket.c	Sun Oct 13 11:40:03 2002
@@ -691,6 +691,7 @@
 
 	unlock_kernel();
 	sock = SOCKET_I(inode);
+#ifdef CONFIG_NET
 	if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
 		err = dev_ioctl(cmd, (void *)arg);
 	} else
@@ -699,6 +700,7 @@
 		err = dev_ioctl(cmd, (void *)arg);
 	} else
 #endif	/* WIRELESS_EXT */
+#endif /* CONFIG_NET */
 	switch (cmd) {
 		case FIOSETOWN:
 		case SIOCSPGRP:
