Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264986AbSJPJYO>; Wed, 16 Oct 2002 05:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264988AbSJPJYN>; Wed, 16 Oct 2002 05:24:13 -0400
Received: from dp.samba.org ([66.70.73.150]:49817 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264986AbSJPJYM>;
	Wed, 16 Oct 2002 05:24:12 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: [PATCH] Trivial ext2-as-a-module fix vs 2.5.43
Date: Wed, 16 Oct 2002 19:14:28 +1000
Message-Id: <20021016093009.C33772C07F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Needs these two symbols exported, as I think, does ext3.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31492-2.5.43-module.pre/mm/filemap.c .31492-2.5.43-module/mm/filemap.c
--- .31492-2.5.43-module.pre/mm/filemap.c	2002-10-16 15:01:26.000000000 +1000
+++ .31492-2.5.43-module/mm/filemap.c	2002-10-16 19:07:56.000000000 +1000
@@ -891,6 +891,7 @@ generic_file_aio_read(struct kiocb *iocb
 	BUG_ON(iocb->ki_pos != pos);
 	return __generic_file_aio_read(iocb, &local_iov, 1, &iocb->ki_pos);
 }
+EXPORT_SYMBOL(generic_file_aio_read);
 
 ssize_t
 generic_file_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
@@ -1650,6 +1651,7 @@ ssize_t generic_file_aio_write(struct ki
 {
 	return generic_file_write(iocb->ki_filp, buf, count, &iocb->ki_pos);
 }
+EXPORT_SYMBOL(generic_file_aio_write);
 
 ssize_t generic_file_write(struct file *file, const char *buf,
 			   size_t count, loff_t *ppos)

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
