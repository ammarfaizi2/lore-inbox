Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264384AbUD0WpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264384AbUD0WpA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 18:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbUD0WpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 18:45:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:3779 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264384AbUD0Wo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 18:44:57 -0400
Date: Tue, 27 Apr 2004 15:47:11 -0700
From: Dave Olien <dmo@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] trivial patch to dm-snap.c
Message-ID: <20040427224711.GA16883@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just added to function declarations to make them static, and fixed up
an unused function declaration.

diff -ur linux-2.6.6-rc2-mm1-udm1-original/drivers/md/dm-snap.c linux-2.6.6-rc2-mm1-udm1-patched/drivers/md/dm-snap.c
--- linux-2.6.6-rc2-mm1-udm1-original/drivers/md/dm-snap.c	2004-04-27 15:10:27.000000000 -0700
+++ linux-2.6.6-rc2-mm1-udm1-patched/drivers/md/dm-snap.c	2004-04-27 14:53:54.000000000 -0700
@@ -608,9 +608,9 @@
 	return NULL;
 }
 
+#if 0
 static void check_free_space(struct dm_snapshot *s)
 {
-#if 0
 	sector_t numerator, denominator;
 	double n, d;
 	unsigned pc;
@@ -628,8 +628,8 @@
 		dm_table_event(s->table);
 		s->last_percent = pc - pc % WAKE_UP_PERCENT;
 	}
-#endif
 }
+#endif
 
 static void pending_complete(struct pending_exception *pe, int success)
 {
@@ -667,8 +667,10 @@
 		flush_bios(bio_list_get(&pe->snapshot_bios));
 		DMDEBUG("Exception completed successfully.");
 
+#if 0
 		/* Notify any interested parties */
 		//check_free_space(s);
+#endif
 
 	} else {
 		/* Read/write error - snapshot is unusable */
@@ -889,7 +891,7 @@
 	return r;
 }
 
-void snapshot_resume(struct dm_target *ti)
+static void snapshot_resume(struct dm_target *ti)
 {
 	struct dm_snapshot *s = (struct dm_snapshot *) ti->private;
 
@@ -1040,7 +1042,7 @@
 /*
  * Called on a write from the origin driver.
  */
-int do_origin(struct dm_dev *origin, struct bio *bio)
+static int do_origin(struct dm_dev *origin, struct bio *bio)
 {
 	struct origin *o;
 	int r;
