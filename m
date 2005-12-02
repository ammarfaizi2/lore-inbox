Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbVLBVoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbVLBVoH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 16:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVLBVoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 16:44:06 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:12457 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750806AbVLBVoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 16:44:05 -0500
Subject: Re: [PATCH] fs: remove s_old_blocksize from struct super_block
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, joe@perches.com
In-Reply-To: <1133558437.31065.6.camel@localhost>
References: <1133558437.31065.6.camel@localhost>
Date: Fri, 02 Dec 2005 23:44:03 +0200
Message-Id: <1133559843.31065.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lets kill the variable too as suggested by Joe.

[PATCH] fs: remove s_old_blocksize from struct super_block

This patch inlines the single user of struct super_block field
s_old_blocksize and removes the field.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fs/super.c         |    3 +--
 include/linux/fs.h |    1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

Index: 2.6/fs/super.c
===================================================================
--- 2.6.orig/fs/super.c
+++ 2.6/fs/super.c
@@ -710,8 +710,7 @@ struct super_block *get_sb_bdev(struct f
 
 		s->s_flags = flags;
 		strlcpy(s->s_id, bdevname(bdev, b), sizeof(s->s_id));
-		s->s_old_blocksize = block_size(bdev);
-		sb_set_blocksize(s, s->s_old_blocksize);
+		sb_set_blocksize(s, block_size(bdev));
 		error = fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
 		if (error) {
 			up_write(&s->s_umount);
Index: 2.6/include/linux/fs.h
===================================================================
--- 2.6.orig/include/linux/fs.h
+++ 2.6/include/linux/fs.h
@@ -777,7 +777,6 @@ struct super_block {
 	struct list_head	s_list;		/* Keep this first */
 	dev_t			s_dev;		/* search index; _not_ kdev_t */
 	unsigned long		s_blocksize;
-	unsigned long		s_old_blocksize;
 	unsigned char		s_blocksize_bits;
 	unsigned char		s_dirt;
 	unsigned long long	s_maxbytes;	/* Max file size */


