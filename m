Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTKYQdw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 11:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTKYQdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 11:33:51 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:4879 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S262111AbTKYQds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 11:33:48 -0500
Date: Tue, 25 Nov 2003 16:34:13 +0000
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>
Subject: [Patch 4/5] dm: set io restriction defaults
Message-ID: <20031125163412.GE524@reti>
References: <20031125162451.GA524@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031125162451.GA524@reti>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that a target has a sensible set of default io restrictions.
--- diff/drivers/md/dm-table.c	2003-11-25 15:47:38.000000000 +0000
+++ source/drivers/md/dm-table.c	2003-11-25 15:47:59.000000000 +0000
@@ -630,6 +630,16 @@
 	return 0;
 }
 
+static void set_default_limits(struct io_restrictions *rs)
+{
+	rs->max_sectors = MAX_SECTORS;
+	rs->max_phys_segments = MAX_PHYS_SEGMENTS;
+	rs->max_hw_segments = MAX_HW_SEGMENTS;
+	rs->hardsect_size = 1 << SECTOR_SHIFT;
+	rs->max_segment_size = MAX_SEGMENT_SIZE;
+	rs->seg_boundary_mask = -1;
+}
+
 int dm_table_add_target(struct dm_table *t, const char *type,
 			sector_t start, sector_t len, char *params)
 {
@@ -642,6 +652,7 @@
 
 	tgt = t->targets + t->num_targets;
 	memset(tgt, 0, sizeof(*tgt));
+	set_default_limits(&tgt->limits);
 
 	tgt->type = dm_get_target_type(type);
 	if (!tgt->type) {
