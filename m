Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751576AbWFUNXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbWFUNXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 09:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbWFUNXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 09:23:46 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:25003 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751573AbWFUNXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 09:23:45 -0400
Date: Wed, 21 Jun 2006 15:23:23 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Theodore Tso <tytso@thunk.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 1/8] inode_diet: Replace inode.u.generic_ip with
 inode.i_private
In-Reply-To: <20060621125216.044675000@candygram.thunk.org>
Message-ID: <Pine.LNX.4.61.0606211515001.3383@yvahk01.tjqt.qr>
References: <20060621125146.508341000@candygram.thunk.org>
 <20060621125216.044675000@candygram.thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>--- linux-2.6.17.orig/fs/jffs/inode-v23.c	2006-06-18 18:58:51.000000000 -0400
>+++ linux-2.6.17/fs/jffs/inode-v23.c	2006-06-18 18:58:55.000000000 -0400
>@@ -369,7 +369,7 @@
> 
> 	f = jffs_find_file(c, raw_inode->ino);
> 
>-	inode->u.generic_ip = (void *)f;
>+	inode->i_private = (void *)f;
> 	insert_inode_hash(inode);
> 
> 	return inode;

struct jffs_file *                                                              
jffs_find_file(struct jffs_control *c, __u32 ino)
Cast not required.

>@@ -739,7 +739,7 @@
> 	unsigned long read_len;
> 	int result;
> 	struct inode *inode = (struct inode*)page->mapping->host;
>-	struct jffs_file *f = (struct jffs_file *)inode->u.generic_ip;
>+	struct jffs_file *f = (struct jffs_file *)inode->i_private;
> 	struct jffs_control *c = (struct jffs_control *)inode->i_sb->s_fs_info;
> 	int r;
> 	loff_t offset;

Same.

>--- linux-2.6.17.orig/fs/inode.c	2006-06-18 18:58:51.000000000 -0400
>+++ linux-2.6.17/fs/inode.c	2006-06-18 18:58:55.000000000 -0400
>@@ -164,7 +164,7 @@
> 				bdi = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
> 			mapping->backing_dev_info = bdi;
> 		}
>-		memset(&inode->u, 0, sizeof(inode->u));
>+		inode->i_private = 0;

inode->i_private = NULL;


Looks good!


Jan Engelhardt
-- 
