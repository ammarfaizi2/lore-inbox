Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261842AbSKNWLz>; Thu, 14 Nov 2002 17:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbSKNWLa>; Thu, 14 Nov 2002 17:11:30 -0500
Received: from dexter.citi.umich.edu ([141.211.133.33]:36480 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S261613AbSKNWKL>; Thu, 14 Nov 2002 17:10:11 -0500
Date: Thu, 14 Nov 2002 17:17:00 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] add set_page_dirty method to NFS addr space ops
Message-ID: <Pine.LNX.4.44.0211141703080.25520-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

by default, set_page_dirty() assumes the caller wants buffer heads, which
is not true for NFS files.  trond determined this will suffice for now.

against 2.5.47.


diff -ruN 21-coalesce/fs/nfs/file.c 22-set_page_dirty/fs/nfs/file.c
--- 21-coalesce/fs/nfs/file.c	Sun Nov 10 22:28:26 2002
+++ 22-set_page_dirty/fs/nfs/file.c	Thu Nov 14 16:53:46 2002
@@ -168,6 +168,7 @@
 struct address_space_operations nfs_file_aops = {
 	.readpage = nfs_readpage,
 	.readpages = nfs_readpages,
+	.set_page_dirty = __set_page_dirty_nobuffers,
 	.writepage = nfs_writepage,
 	.writepages = nfs_writepages,
 	.prepare_write = nfs_prepare_write,

