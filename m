Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261282AbTCYAFi>; Mon, 24 Mar 2003 19:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261281AbTCYAFi>; Mon, 24 Mar 2003 19:05:38 -0500
Received: from zok.SGI.COM ([204.94.215.101]:33509 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S261282AbTCYAFh>;
	Mon, 24 Mar 2003 19:05:37 -0500
Date: Mon, 24 Mar 2003 16:16:44 -0800
From: Jeremy Brown <mee@sgi.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.66
Message-ID: <20030325001644.GA35311@miine.engr.sgi.com>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I encountered a minor build failure in fs/cramfs, which I was able to
fix with the following patch. I'm not sure if it's exactly the right
fix - does the original author really mean to have zeroes for those
values? Anyway, please consider applying to 2.5.66 if it's okay.

Jeremy Brown



--- linux-2.5.66/fs/cramfs/inode.c.orig 2003-03-24 16:01:07.000000000 -0800
+++ linux-2.5.66/fs/cramfs/inode.c      2003-03-24 16:09:18.000000000 -0800
@@ -43,6 +43,7 @@
 static struct inode *get_cramfs_inode(struct super_block *sb, struct cramfs_inode * cramfs_inode)
 {
        struct inode * inode = new_inode(sb);
+       struct timespec zerotime = {0, 0};

        if (inode) {
                inode->i_mode = cramfs_inode->mode;
@@ -51,7 +52,7 @@
                inode->i_blocks = (cramfs_inode->size - 1) / 512 + 1;
                inode->i_blksize = PAGE_CACHE_SIZE;
                inode->i_gid = cramfs_inode->gid;
-               inode->i_mtime = inode->i_atime = inode->i_ctime = 0;
+               inode->i_mtime = inode->i_atime = inode->i_ctime = zerotime;
                inode->i_ino = CRAMINO(cramfs_inode);
                /* inode->i_nlink is left 1 - arguably wrong for directories,
                   but it's the best we can do without reading the directory
