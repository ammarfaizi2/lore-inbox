Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317310AbSFLCyS>; Tue, 11 Jun 2002 22:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317311AbSFLCyR>; Tue, 11 Jun 2002 22:54:17 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:61030 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S317310AbSFLCyQ>; Tue, 11 Jun 2002 22:54:16 -0400
Date: Wed, 12 Jun 2002 03:54:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Rohland <cr@sap.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tmpfs 2/4 mknod times
In-Reply-To: <Pine.LNX.4.21.0206120348170.1036-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0206120352260.1036-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shmem_mknod should not update directory times if it cannot get an inode.

--- 2.4.19-pre10/mm/shmem.c	Tue Jun 11 19:02:30 2002
+++ linux/mm/shmem.c	Tue Jun 11 19:02:30 2002
@@ -987,8 +987,8 @@
 	struct inode * inode = shmem_get_inode(dir->i_sb, mode, dev);
 	int error = -ENOSPC;
 
-	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	if (inode) {
+		dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 		d_instantiate(dentry, inode);
 		dget(dentry); /* Extra count - pin the dentry in core */
 		error = 0;

