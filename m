Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267804AbUIUQYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267804AbUIUQYa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 12:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267810AbUIUQYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 12:24:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56457 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267804AbUIUQYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 12:24:15 -0400
Date: Tue, 21 Sep 2004 17:24:10 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 1/2: device-mapper: rename emit macro
Message-ID: <20040921162410.GE11810@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename EMIT macro to DMEMIT and move to header file.
--- diff/drivers/md/dm-raid1.c	2004-09-21 16:36:14.000000000 +0100
+++ source/drivers/md/dm-raid1.c	2004-09-21 16:35:39.000000000 +0100
@@ -1185,32 +1185,29 @@
 	unsigned int m, sz = 0;
 	struct mirror_set *ms = (struct mirror_set *) ti->private;
 
-#define EMIT(x...) sz += ((sz >= maxlen) ? \
-			  0 : scnprintf(result + sz, maxlen - sz, x))
-
 	switch (type) {
 	case STATUSTYPE_INFO:
-		EMIT("%d ", ms->nr_mirrors);
+		DMEMIT("%d ", ms->nr_mirrors);
 
 		for (m = 0; m < ms->nr_mirrors; m++) {
 			format_dev_t(buffer, ms->mirror[m].dev->bdev->bd_dev);
-			EMIT("%s ", buffer);
+			DMEMIT("%s ", buffer);
 		}
 
-		EMIT(SECTOR_FORMAT "/" SECTOR_FORMAT,
-		     ms->rh.log->type->get_sync_count(ms->rh.log),
-		     ms->nr_regions);
+		DMEMIT(SECTOR_FORMAT "/" SECTOR_FORMAT,
+		       ms->rh.log->type->get_sync_count(ms->rh.log),
+		       ms->nr_regions);
 		break;
 
 	case STATUSTYPE_TABLE:
-		EMIT("%s 1 " SECTOR_FORMAT " %d ",
-		     ms->rh.log->type->name, ms->rh.region_size,
-		     ms->nr_mirrors);
+		DMEMIT("%s 1 " SECTOR_FORMAT " %d ",
+		       ms->rh.log->type->name, ms->rh.region_size,
+		       ms->nr_mirrors);
 
 		for (m = 0; m < ms->nr_mirrors; m++) {
 			format_dev_t(buffer, ms->mirror[m].dev->bdev->bd_dev);
-			EMIT("%s " SECTOR_FORMAT " ",
-			     buffer, ms->mirror[m].offset);
+			DMEMIT("%s " SECTOR_FORMAT " ",
+			       buffer, ms->mirror[m].offset);
 		}
 	}
 
--- diff/drivers/md/dm-stripe.c	2004-09-21 16:36:14.000000000 +0100
+++ source/drivers/md/dm-stripe.c	2004-09-21 16:35:39.000000000 +0100
@@ -191,20 +191,17 @@
 	unsigned int i;
 	char buffer[32];
 
-#define EMIT(x...) sz += ((sz >= maxlen) ? \
-			  0 : scnprintf(result + sz, maxlen - sz, x))
-
 	switch (type) {
 	case STATUSTYPE_INFO:
 		result[0] = '\0';
 		break;
 
 	case STATUSTYPE_TABLE:
-		EMIT("%d " SECTOR_FORMAT, sc->stripes, sc->chunk_mask + 1);
+		DMEMIT("%d " SECTOR_FORMAT, sc->stripes, sc->chunk_mask + 1);
 		for (i = 0; i < sc->stripes; i++) {
 			format_dev_t(buffer, sc->stripe[i].dev->bdev->bd_dev);
-			EMIT(" %s " SECTOR_FORMAT, buffer,
-			     sc->stripe[i].physical_start);
+			DMEMIT(" %s " SECTOR_FORMAT, buffer,
+			       sc->stripe[i].physical_start);
 		}
 		break;
 	}
--- diff/drivers/md/dm.h	2004-09-20 20:44:03.000000000 +0100
+++ source/drivers/md/dm.h	2004-09-21 16:35:39.000000000 +0100
@@ -19,6 +19,9 @@
 #define DMERR(f, x...) printk(KERN_ERR DM_NAME ": " f "\n" , ## x)
 #define DMINFO(f, x...) printk(KERN_INFO DM_NAME ": " f "\n" , ## x)
 
+#define DMEMIT(x...) sz += ((sz >= maxlen) ? \
+			  0 : scnprintf(result + sz, maxlen - sz, x))
+
 /*
  * FIXME: I think this should be with the definition of sector_t
  * in types.h.
