Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUBCBqc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 20:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265814AbUBCBqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 20:46:32 -0500
Received: from users.ccur.com ([208.248.32.211]:46708 "HELO jedi.ccur.com")
	by vger.kernel.org with SMTP id S265808AbUBCBqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 20:46:31 -0500
From: lindad@jedi.ccur.com (Linda Dunaphant)
Message-Id: <200402030146.BAA22183@jedi.ccur.com>
Subject: [PATCH] 2.6.1 nfs4 mount version message
To: linux-kernel@vger.kernel.org
Date: Mon, 2 Feb 2004 20:46:29 -0500 (EST)
Reply-To: linda.dunaphant@ccur.com
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the file fs/nfs/inode.c in nfs4_get_sb() there is a test that compares
the version of the incoming nfs4_mount_data versus NFS4_MOUNT_VERSION. If
these do not match, a warning message is printed. Inside the printk() for
this warning message, there is another test of the versions to determine
whether the string "older" or "newer" should be printed.

Shouldn't this second test be comparing NFS4_MOUNT_VERSION instead of
NFS_MOUNT_VERSION? 

I have included a patch for linux-2.6.1.

Linda

diff -ur base.linux-2.6.1/fs/nfs/inode.c new.linux-2.6.1/fs/nfs/inode.c
--- base.linux-2.6.1/fs/nfs/inode.c     2004-01-09 01:59:55.000000000 -0500
+++ new.linux-2.6.1/fs/nfs/inode.c      2004-01-30 15:47:55.000000000 -0500
@@ -1499,7 +1499,7 @@
  
        if (data->version != NFS4_MOUNT_VERSION) {
                printk("nfs warning: mount version %s than kernel\n",
-                       data->version < NFS_MOUNT_VERSION ? "older" : "newer");
+                       data->version < NFS4_MOUNT_VERSION ? "older" : "newer");        }
  
        p = nfs_copy_user_string(NULL, &data->hostname, 256);
