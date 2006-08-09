Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWHIPSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWHIPSB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 11:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWHIPSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 11:18:00 -0400
Received: from rere.qmqm.pl ([86.63.132.164]:36063 "EHLO rere.qmqm.pl")
	by vger.kernel.org with ESMTP id S1750954AbWHIPSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 11:18:00 -0400
Date: Wed, 9 Aug 2006 17:17:46 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] dm-mpath: kmalloc+memset -> kzalloc
Message-ID: <20060809151746.GA31694@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use kzalloc() instead of kmalloc() + memset().

Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>

diff -urN linux-2.6.17.8-routes-esfq-mq/drivers/md/dm-mpath.c linux-fixes/drivers/md/dm-mpath.c
--- linux-2.6.17.8-routes-esfq-mq/drivers/md/dm-mpath.c	2006-08-07 15:25:07.000000000 +0200
+++ linux-fixes/drivers/md/dm-mpath.c	2006-08-09 17:05:48.000000000 +0200
@@ -113,12 +113,10 @@
 
 static struct pgpath *alloc_pgpath(void)
 {
-	struct pgpath *pgpath = kmalloc(sizeof(*pgpath), GFP_KERNEL);
+	struct pgpath *pgpath = kzalloc(sizeof(*pgpath), GFP_KERNEL);
 
-	if (pgpath) {
-		memset(pgpath, 0, sizeof(*pgpath));
+	if (pgpath)
 		pgpath->path.is_active = 1;
-	}
 
 	return pgpath;
 }
@@ -132,12 +130,10 @@
 {
 	struct priority_group *pg;
 
-	pg = kmalloc(sizeof(*pg), GFP_KERNEL);
-	if (!pg)
-		return NULL;
+	pg = kzalloc(sizeof(*pg), GFP_KERNEL);
 
-	memset(pg, 0, sizeof(*pg));
-	INIT_LIST_HEAD(&pg->pgpaths);
+	if (pg)
+		INIT_LIST_HEAD(&pg->pgpaths);
 
 	return pg;
 }
@@ -171,9 +167,8 @@
 {
 	struct multipath *m;
 
-	m = kmalloc(sizeof(*m), GFP_KERNEL);
+	m = kzalloc(sizeof(*m), GFP_KERNEL);
 	if (m) {
-		memset(m, 0, sizeof(*m));
 		INIT_LIST_HEAD(&m->priority_groups);
 		spin_lock_init(&m->lock);
 		m->queue_io = 1;
