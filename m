Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVKRO70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVKRO70 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 09:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVKRO70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 09:59:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4760 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750757AbVKRO7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 09:59:25 -0500
Date: Fri, 18 Nov 2005 14:59:21 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>
Subject: [PATCH] device-mapper: add dm_get_md
Message-ID: <20051118145921.GN11878@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	David Teigland <teigland@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add dm_get_dev() to get a mapped device given its dev_t.

From: David Teigland <teigland@redhat.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.14/drivers/md/dm.c
===================================================================
--- linux-2.6.14.orig/drivers/md/dm.c	2005-11-18 14:40:48.000000000 +0000
+++ linux-2.6.14/drivers/md/dm.c	2005-11-18 14:40:52.000000000 +0000
@@ -932,6 +932,16 @@ static struct mapped_device *dm_find_md(
 	return md;
 }
 
+struct mapped_device *dm_get_md(dev_t dev)
+{
+	struct mapped_device *md = dm_find_md(dev);
+
+	if (md)
+		dm_get(md);
+
+	return md;
+}
+
 void *dm_get_mdptr(dev_t dev)
 {
 	struct mapped_device *md;
Index: linux-2.6.14/drivers/md/dm.h
===================================================================
--- linux-2.6.14.orig/drivers/md/dm.h	2005-11-18 14:40:40.000000000 +0000
+++ linux-2.6.14/drivers/md/dm.h	2005-11-18 14:40:52.000000000 +0000
@@ -58,6 +58,7 @@ int dm_create(struct mapped_device **md)
 int dm_create_with_minor(unsigned int minor, struct mapped_device **md);
 void dm_set_mdptr(struct mapped_device *md, void *ptr);
 void *dm_get_mdptr(dev_t dev);
+struct mapped_device *dm_get_md(dev_t dev);
 
 /*
  * Reference counting for md.
