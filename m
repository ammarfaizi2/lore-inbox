Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268806AbTBZQ62>; Wed, 26 Feb 2003 11:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268813AbTBZQ62>; Wed, 26 Feb 2003 11:58:28 -0500
Received: from cmailm3.svr.pol.co.uk ([195.92.193.19]:41995 "EHLO
	cmailm3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S268806AbTBZQ61>; Wed, 26 Feb 2003 11:58:27 -0500
Date: Wed, 26 Feb 2003 17:08:00 +0000
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/8] dm: ioctl interface wasn't dropping a table reference
Message-ID: <20030226170800.GA8369@fib011235813.fsnet.co.uk>
References: <20030226170537.GA8289@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226170537.GA8289@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.3i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When reloading a device the ioctl interface was forgetting to drop a
reference on the new table.

--- diff/drivers/md/dm-ioctl.c	2003-01-13 14:18:15.000000000 +0000
+++ source/drivers/md/dm-ioctl.c	2003-02-26 16:09:42.000000000 +0000
@@ -887,6 +887,7 @@
 		dm_table_put(t);
 		return r;
 	}
+	dm_table_put(t);	/* md will have taken its own reference */
 
 	set_disk_ro(dm_disk(md), (param->flags & DM_READONLY_FLAG));
 	dm_put(md);
