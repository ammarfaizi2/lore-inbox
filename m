Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268835AbTBZRFF>; Wed, 26 Feb 2003 12:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268832AbTBZRFA>; Wed, 26 Feb 2003 12:05:00 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:14088 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S268835AbTBZRD6>; Wed, 26 Feb 2003 12:03:58 -0500
Date: Wed, 26 Feb 2003 17:13:35 +0000
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/8] dm: return correct error codes from dm_table_add_target()
Message-ID: <20030226171335.GH8369@fib011235813.fsnet.co.uk>
References: <20030226170537.GA8289@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226170537.GA8289@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.3i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return correct error codes from dm_table_add_target().  [Kevin Corry]

--- diff/drivers/md/dm-table.c	2003-02-26 16:10:19.000000000 +0000
+++ source/drivers/md/dm-table.c	2003-02-26 16:10:24.000000000 +0000
@@ -591,7 +591,7 @@
 	tgt->type = dm_get_target_type(type);
 	if (!tgt->type) {
 		tgt->error = "unknown target type";
-		return r;
+		return -EINVAL;
 	}
 
 	tgt->table = t;
@@ -604,6 +604,7 @@
 	 */
 	if (!adjoin(t, tgt)) {
 		tgt->error = "Gap in table";
+		r = -EINVAL;
 		goto bad;
 	}
 
