Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272636AbTHKNlo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272584AbTHKNlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:41:44 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:40843 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272636AbTHKNlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:41:07 -0400
To: torvalds@transmeta.com
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] c99 initialisers for random.c
Message-Id: <E19mCuO-0003da-00@tetrachloride>
Date: Mon, 11 Aug 2003 14:40:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/random.c linux-2.5/drivers/char/random.c
--- bk-linus/drivers/char/random.c	2003-08-04 01:00:22.000000000 +0100
+++ linux-2.5/drivers/char/random.c	2003-08-06 18:59:31.000000000 +0100
@@ -1850,27 +1850,62 @@ static int uuid_strategy(ctl_table *tabl
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
