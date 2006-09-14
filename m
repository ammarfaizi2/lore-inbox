Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWINVrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWINVrB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWINVrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:47:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15831 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751194AbWINVqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:46:54 -0400
Date: Thu, 14 Sep 2006 22:46:49 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 14/25] dm mpath: use kzalloc
Message-ID: <20060914214649.GV3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>

Use kzalloc() instead of kmalloc() + memset().

Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.18-rc7/drivers/md/dm-mpath.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-mpath.c	2006-09-14 20:54:49.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-mpath.c	2006-09-14 20:55:20.000000000 +0100
@@ -114,12 +114,10 @@ static void trigger_event(void *data);
 
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
@@ -133,12 +131,10 @@ static struct priority_group *alloc_prio
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
@@ -172,9 +168,8 @@ static struct multipath *alloc_multipath
 {
 	struct multipath *m;
 
-	m = kmalloc(sizeof(*m), GFP_KERNEL);
+	m = kzalloc(sizeof(*m), GFP_KERNEL);
 	if (m) {
-		memset(m, 0, sizeof(*m));
 		INIT_LIST_HEAD(&m->priority_groups);
 		spin_lock_init(&m->lock);
 		m->queue_io = 1;
