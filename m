Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268216AbUIGO5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268216AbUIGO5U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268190AbUIGOyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:54:31 -0400
Received: from verein.lst.de ([213.95.11.210]:65177 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268185AbUIGOvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:51:39 -0400
Date: Tue, 7 Sep 2004 16:51:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mark dq_list_lock static
Message-ID: <20040907145134.GB8889@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

only used in dq_list_lock these days


--- 1.89/fs/dquot.c	2004-07-11 10:52:11 +02:00
+++ edited/fs/dquot.c	2004-09-07 16:52:21 +02:00
@@ -120,7 +120,7 @@
  * i_sem on quota files is special (it's below dqio_sem)
  */
 
-spinlock_t dq_list_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t dq_list_lock = SPIN_LOCK_UNLOCKED;
 spinlock_t dq_data_lock = SPIN_LOCK_UNLOCKED;
 
 static char *quotatypes[] = INITQFNAMES;
@@ -1792,7 +1792,6 @@
 EXPORT_SYMBOL(register_quota_format);
 EXPORT_SYMBOL(unregister_quota_format);
 EXPORT_SYMBOL(dqstats);
-EXPORT_SYMBOL(dq_list_lock);
 EXPORT_SYMBOL(dq_data_lock);
 EXPORT_SYMBOL(vfs_quota_on);
 EXPORT_SYMBOL(vfs_quota_on_mount);
--- 1.29/include/linux/quota.h	2004-05-10 12:26:52 +02:00
+++ edited/include/linux/quota.h	2004-09-07 13:14:31 +02:00
@@ -45,7 +45,6 @@
 typedef __kernel_uid32_t qid_t; /* Type in which we store ids in memory */
 typedef __u64 qsize_t;          /* Type in which we store sizes */
 
-extern spinlock_t dq_list_lock;
 extern spinlock_t dq_data_lock;
 
 /* Size of blocks in which are counted size limits */
