Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267378AbSLRXMl>; Wed, 18 Dec 2002 18:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267379AbSLRXMl>; Wed, 18 Dec 2002 18:12:41 -0500
Received: from dexter.citi.umich.edu ([141.211.133.33]:1920 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S267378AbSLRXMj>; Wed, 18 Dec 2002 18:12:39 -0500
Date: Wed, 18 Dec 2002 18:20:37 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] give NFS client a "set_page_dirty" address space op.
Message-ID: <Pine.LNX.4.44.0212181819520.1373-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
  The default set_page_dirty address space op is too heavyweight for NFS,
  which doesn't use buffers.

Apply against:
  2.5.52


diff -Naurp 01-kmap_atomic/fs/nfs/file.c 02-set_page_dirty/fs/nfs/file.c
--- 01-kmap_atomic/fs/nfs/file.c	Sun Dec 15 21:08:12 2002
+++ 02-set_page_dirty/fs/nfs/file.c	Wed Dec 18 17:37:07 2002
@@ -168,6 +168,7 @@ static int nfs_commit_write(struct file 
 struct address_space_operations nfs_file_aops = {
 	.readpage = nfs_readpage,
 	.readpages = nfs_readpages,
+	.set_page_dirty = __set_page_dirty_nobuffers,
 	.writepage = nfs_writepage,
 	.writepages = nfs_writepages,
 	.prepare_write = nfs_prepare_write,

