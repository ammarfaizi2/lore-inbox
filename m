Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVBHRe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVBHRe7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 12:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVBHRe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 12:34:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7366 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261603AbVBHRe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 12:34:57 -0500
Date: Tue, 8 Feb 2005 17:34:51 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: Export map_info
Message-ID: <20050208173451.GU10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Export map_info (part of bio->bi_private) for targets like
multipath to use for storing context.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
--- diff/drivers/md/dm.c	2005-02-08 16:38:49.000000000 +0000
+++ source/drivers/md/dm.c	2005-02-08 16:41:09.000000000 +0000
@@ -43,6 +43,13 @@
 	union map_info info;
 };
 
+union map_info *dm_get_mapinfo(struct bio *bio)
+{
+        if (bio && bio->bi_private)
+                return &((struct target_io *)bio->bi_private)->info;
+        return NULL;
+}
+
 /*
  * Bits for the md->flags field.
  */
@@ -1164,6 +1171,8 @@
 	.owner = THIS_MODULE
 };
 
+EXPORT_SYMBOL(dm_get_mapinfo);
+
 /*
  * module hooks
  */
--- diff/drivers/md/dm.h	2005-02-08 16:39:46.000000000 +0000
+++ source/drivers/md/dm.h	2005-02-08 16:41:09.000000000 +0000
@@ -190,5 +190,6 @@
 void dm_stripe_exit(void);
 
 void *dm_vcalloc(unsigned long nmemb, unsigned long elem_size);
+union map_info *dm_get_mapinfo(struct bio *bio);
 
 #endif
