Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbULLLQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbULLLQS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 06:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbULLLQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 06:16:17 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:35594 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261773AbULLLQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 06:16:12 -0500
Date: Sun, 12 Dec 2004 12:01:12 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [Announce] Squashfs 2.1 released (compressed filesystem)
Message-ID: <20041212110112.GE17946@alpha.home.local>
References: <41BA0245.4050502@lougher.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BA0245.4050502@lougher.demon.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

> Many smaller improvements have also been made in this release, and there 
> are, for the first time, the results of some tests of Squashfs lookup 
> and I/O performance against Zisofs, Cloop, and CRAMFS.

I've checked you tests, numbers are appealing :-)

BTW, you need to apply the following patch to build mksquashfs with gcc < 3.

Thanks for still improving this great FS !
Willy

--- squashfs2.1/squashfs-tools/mksquashfs.c.orig	Sun Dec 12 12:10:35 2004
+++ squashfs2.1/squashfs-tools/mksquashfs.c	Sun Dec 12 12:14:55 2004
@@ -526,11 +526,10 @@
 	else if(type == SQUASHFS_LDIR_TYPE) {
 		int i;
 		unsigned char *p;
+		squashfs_ldir_inode_header *dir = &inode_header.ldir, *inodep;
 
 		if(byte_size >= 1 << 27)
 			BAD_ERROR("directory greater than 2^27-1 bytes!\n");
-
-		squashfs_ldir_inode_header *dir = &inode_header.ldir, *inodep;
 
 		inode = get_inode(sizeof(*dir) + i_size);
 		inodep = (squashfs_ldir_inode_header *) inode;


