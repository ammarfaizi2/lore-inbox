Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbSKZTax>; Tue, 26 Nov 2002 14:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbSKZTaf>; Tue, 26 Nov 2002 14:30:35 -0500
Received: from dexter.citi.umich.edu ([141.211.133.33]:5504 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S266615AbSKZT3V>; Tue, 26 Nov 2002 14:29:21 -0500
Date: Tue, 26 Nov 2002 14:36:36 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] give NFS client a "set_page_dirty" address space op.
Message-ID: <Pine.LNX.4.44.0211261434270.9482-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
  The default set_page_dirty address space op is too heavyweight for NFS,
  which doesn't use buffers.

Apply against:
  2.5.49

Test status:
  Passes Connectathon '02, fsx, and other stress tests on a UP HIGHMEM
  system.


diff -Naur 01-kmap-atomic/fs/nfs/file.c 02-set_page_dirty/fs/nfs/file.c
--- 01-kmap-atomic/fs/nfs/file.c	Fri Nov 22 16:40:51 2002
+++ 02-set_page_dirty/fs/nfs/file.c	Mon Nov 25 13:19:44 2002
@@ -168,6 +168,7 @@
 struct address_space_operations nfs_file_aops = {
 	.readpage = nfs_readpage,
 	.readpages = nfs_readpages,
+	.set_page_dirty = __set_page_dirty_nobuffers,
 	.writepage = nfs_writepage,
 	.writepages = nfs_writepages,
 	.prepare_write = nfs_prepare_write,

