Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268802AbTBZRBo>; Wed, 26 Feb 2003 12:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268813AbTBZRBn>; Wed, 26 Feb 2003 12:01:43 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:7943 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S268802AbTBZRBc>; Wed, 26 Feb 2003 12:01:32 -0500
Date: Wed, 26 Feb 2003 17:11:08 +0000
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/8] dm: bug in error path for unknown target type
Message-ID: <20030226171108.GE8369@fib011235813.fsnet.co.uk>
References: <20030226170537.GA8289@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226170537.GA8289@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.3i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Silly mistake in error path when an unknown target type is requested.

--- diff/drivers/md/dm-table.c	2003-02-26 16:09:47.000000000 +0000
+++ source/drivers/md/dm-table.c	2003-02-26 16:10:02.000000000 +0000
@@ -591,7 +591,7 @@
 	tgt->type = dm_get_target_type(type);
 	if (!tgt->type) {
 		tgt->error = "unknown target type";
-		goto bad;
+		return r;
 	}
 
 	tgt->table = t;
