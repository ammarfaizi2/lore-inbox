Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264543AbTCZF15>; Wed, 26 Mar 2003 00:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264552AbTCZF15>; Wed, 26 Mar 2003 00:27:57 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:29098 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S264543AbTCZF1z>; Wed, 26 Mar 2003 00:27:55 -0500
Message-ID: <3E813E66.1060802@on-demand-tech.com>
Date: Tue, 25 Mar 2003 23:45:10 -0600
From: Adam Kelly <akelly@on-demand-tech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@math.psu.edu, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] linux-2.5.66/fs/cramfs/inode.c typecheck - int vs. struct
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very minor change. GCC now does more type checking, so This just zeros a 
timespec struct
so that i_mtime, etc will match types.

gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)
compiling linux-2.5.66

 -Adam

--- inode.c.orig        2003-03-25 22:50:17.000000000 -0600
+++ inode.c     2003-03-25 23:00:50.000000000 -0600
@@ -44,6 +44,8 @@
 {
        struct inode * inode = new_inode(sb);
 
+       const struct timespec zero_timespec = {0};
+
        if (inode) {
                inode->i_mode = cramfs_inode->mode;
                inode->i_uid = cramfs_inode->uid;
@@ -51,7 +53,7 @@
                inode->i_blocks = (cramfs_inode->size - 1) / 512 + 1;
                inode->i_blksize = PAGE_CACHE_SIZE;
                inode->i_gid = cramfs_inode->gid;
-               inode->i_mtime = inode->i_atime = inode->i_ctime = 0;
+               inode->i_mtime = inode->i_atime = inode->i_ctime = 
zero_timespec;
                inode->i_ino = CRAMINO(cramfs_inode);
                /* inode->i_nlink is left 1 - arguably wrong for 
directories,
                   but it's the best we can do without reading the 
directory  

