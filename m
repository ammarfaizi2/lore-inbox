Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWJEK4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWJEK4r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 06:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWJEK4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 06:56:47 -0400
Received: from mail.gmx.de ([213.165.64.20]:35289 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932073AbWJEK4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 06:56:46 -0400
X-Authenticated: #704063
Subject: [Patch] Dereference in fs/jbd/journal.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Zoltan.Menyhart@bull.net
Content-Type: text/plain
Date: Thu, 05 Oct 2006 12:56:41 +0200
Message-Id: <1160045801.6153.9.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

since the commit http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d1807793e1e7e502e3dc047115e9dbc3b50e4534
we dereference a NULL pointer. Coverity id #1432.
We set journal to NULL, and use it directly afterwards.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.19-rc1/fs/jbd/journal.c.orig	2006-10-05 12:53:24.000000000 +0200
+++ linux-2.6.19-rc1/fs/jbd/journal.c	2006-10-05 12:53:41.000000000 +0200
@@ -724,7 +724,7 @@ journal_t * journal_init_dev(struct bloc
 		printk(KERN_ERR "%s: Cant allocate bhs for commit thread\n",
 			__FUNCTION__);
 		kfree(journal);
-		journal = NULL;
+		return NULL;
 	}
 	journal->j_dev = bdev;
 	journal->j_fs_dev = fs_dev;


