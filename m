Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTFFPf4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 11:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbTFFPf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 11:35:56 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:5381 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S261352AbTFFPfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 11:35:54 -0400
Date: Fri, 6 Jun 2003 10:49:24 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Add C99 initializers to drivers/char/random.c
Message-ID: <20030606154924.GE30166@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch add C99 initializers to the file in an effort to make the
code easier to read. I think an earlier version had appeared in an -ac
patchset.

Art Haas

===== drivers/char/random.c 1.33 vs edited =====
--- 1.33/drivers/char/random.c	Mon May  5 00:49:54 2003
+++ edited/drivers/char/random.c	Thu May  8 09:35:10 2003
@@ -1848,27 +1848,62 @@
 }
 
 ctl_table random_table[] = {
-	{RANDOM_POOLSIZE, "poolsize",
-	 &sysctl_poolsize, sizeof(int), 0644, NULL,
-	 &proc_do_poolsize, &poolsize_strategy},
-	{RANDOM_ENTROPY_COUNT, "entropy_avail",
-	 NULL, sizeof(int), 0444, NULL,
-	 &proc_dointvec},
-	{RANDOM_READ_THRESH, "read_wakeup_threshold",
-	 &random_read_wakeup_thresh, sizeof(int), 0644, NULL,
-	 &proc_dointvec_minmax, &sysctl_intvec, 0,
-	 &min_read_thresh, &max_read_thresh},
-	{RANDOM_WRITE_THRESH, "write_wakeup_threshold",
-	 &random_write_wakeup_thresh, sizeof(int), 0644, NULL,
-	 &proc_dointvec_minmax, &sysctl_intvec, 0,
-	 &min_write_thresh, &max_write_thresh},
-	{RANDOM_BOOT_ID, "boot_id",
-	 &sysctl_bootid, 16, 0444, NULL,
-	 &proc_do_uuid, &uuid_strategy},
-	{RANDOM_UUID, "uuid",
-	 NULL, 16, 0444, NULL,
-	 &proc_do_uuid, &uuid_strategy},
-	{0}
+	{
+		.ctl_name	= RANDOM_POOLSIZE,
+		.procname	= "poolsize",
+		.data		= &sysctl_poolsize,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_do_poolsize,
+		.strategy	= &poolsize_strategy,
+	},
+	{
+		.ctl_name	= RANDOM_ENTROPY_COUNT,
+		.procname	= "entropy_avail",
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= RANDOM_READ_THRESH,
+		.procname	= "read_wakeup_threshold",
+		.data		= &random_read_wakeup_thresh,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &min_read_thresh,
+		.extra2		= &max_read_thresh,
+	},
+	{
+		.ctl_name	= RANDOM_WRITE_THRESH,
+		.procname	= "write_wakeup_threshold",
+		.data		= &random_write_wakeup_thresh,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &min_write_thresh,
+		.extra2		= &max_write_thresh,
+	},
+	{
+		.ctl_name	= RANDOM_BOOT_ID,
+		.procname	= "boot_id",
+		.data		= &sysctl_bootid,
+		.maxlen		= 16,
+		.mode		= 0444,
+		.proc_handler	= &proc_do_uuid,
+		.strategy	= &uuid_strategy,
+	},
+	{
+		.ctl_name	= RANDOM_UUID,
+		.procname	= "uuid",
+		.maxlen		= 16,
+		.mode		= 0444,
+		.proc_handler	= &proc_do_uuid,
+		.strategy	= &uuid_strategy,
+	},
+	{ .ctl_name = 0 }
 };
 
 static void sysctl_init_random(struct entropy_store *random_state)
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
