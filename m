Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUC2TBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 14:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbUC2TBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 14:01:09 -0500
Received: from hera.cwi.nl ([192.16.191.8]:59380 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263085AbUC2TBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 14:01:02 -0500
Date: Mon, 29 Mar 2004 21:00:54 +0200 (MEST)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <UTC200403291900.i2TJ0sC14336.aeb@smtp.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org, trond.myklebust@fys.uio.no
Subject: [patch] silence nfs mount messages
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

People complain about the kernel messages when mounting NFS.
(Just like last time a new NFS version was introduced.)
It is perfectly normal to have mount newer than the kernel,
or the kernel newer than mount. No messages are needed or useful.

Andries

diff -uprN -X /linux/dontdiff a/fs/nfs/inode.c b/fs/nfs/inode.c
--- a/fs/nfs/inode.c	2004-02-18 11:33:18.000000000 +0100
+++ b/fs/nfs/inode.c	2004-03-29 20:53:28.000000000 +0200
@@ -1292,8 +1292,10 @@ static struct super_block *nfs_get_sb(st
 		memset(root->data+root->size, 0, sizeof(root->data)-root->size);
 
 	if (data->version != NFS_MOUNT_VERSION) {
+#if 0
 		printk("nfs warning: mount version %s than kernel\n",
 			data->version < NFS_MOUNT_VERSION ? "older" : "newer");
+#endif
 		if (data->version < 2)
 			data->namlen = 0;
 		if (data->version < 3)
@@ -1599,10 +1601,12 @@ static struct super_block *nfs4_get_sb(s
 	/* Zero out the NFS state stuff */
 	init_nfsv4_state(server);
 
+#if 0
 	if (data->version != NFS4_MOUNT_VERSION) {
 		printk("nfs warning: mount version %s than kernel\n",
 			data->version < NFS_MOUNT_VERSION ? "older" : "newer");
 	}
+#endif
 
 	p = nfs_copy_user_string(NULL, &data->hostname, 256);
 	if (IS_ERR(p))
