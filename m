Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265427AbUEUHhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265427AbUEUHhG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 03:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265430AbUEUHhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 03:37:06 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:23742
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265427AbUEUHhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 03:37:04 -0400
Date: Fri, 21 May 2004 09:37:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: ramfs lfs limit
Message-ID: <20040521073702.GM3044@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

this fixes the 2G limit on ramfs

--- sles/fs/ramfs/inode.c.~1~	2003-10-31 05:54:29.000000000 +0100
+++ sles/fs/ramfs/inode.c	2004-05-21 07:55:07.394369104 +0200
@@ -181,6 +181,7 @@ static int ramfs_fill_super(struct super
 	struct inode * inode;
 	struct dentry * root;
 
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = RAMFS_MAGIC;
