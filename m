Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267791AbTAHJtE>; Wed, 8 Jan 2003 04:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267792AbTAHJs6>; Wed, 8 Jan 2003 04:48:58 -0500
Received: from cmailm2.svr.pol.co.uk ([195.92.193.210]:44041 "EHLO
	cmailm2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267791AbTAHJsz>; Wed, 8 Jan 2003 04:48:55 -0500
Date: Wed, 8 Jan 2003 09:57:06 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/10] dm: Call dm_put_target_type() *after* calling the destructor
Message-ID: <20030108095706.GF2063@reti>
References: <20030108095221.GA2063@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108095221.GA2063@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Call dm_put_target_type() *after* calling the destructor.
--- diff/drivers/md/dm-table.c	2002-12-30 10:17:13.000000000 +0000
+++ source/drivers/md/dm-table.c	2003-01-02 11:26:35.000000000 +0000
@@ -250,12 +250,12 @@
 
 	/* free the targets */
 	for (i = 0; i < t->num_targets; i++) {
-		struct dm_target *tgt = &t->targets[i];
-
-		dm_put_target_type(t->targets[i].type);
+		struct dm_target *tgt = t->targets + i;
 
 		if (tgt->type->dtr)
 			tgt->type->dtr(tgt);
+
+		dm_put_target_type(tgt->type);
 	}
 
 	vfree(t->highs);
