Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbTBLDCJ>; Tue, 11 Feb 2003 22:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266224AbTBLC4M>; Tue, 11 Feb 2003 21:56:12 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:11529 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S266095AbTBLCzv>; Tue, 11 Feb 2003 21:55:51 -0500
Date: Tue, 11 Feb 2003 20:57:52 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for drivers/char/random.c
Message-ID: <20030212025752.GF914@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch adds C99 initializer to the file to remove warnings if '-W'
is used, add to aid readability.

Art Haas

===== drivers/char/random.c 1.30 vs edited =====
--- 1.30/drivers/char/random.c	Mon Dec 30 06:47:26 2002
+++ edited/drivers/char/random.c	Tue Feb 11 20:56:55 2003
@@ -1850,27 +1850,62 @@
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
+		.strategy	= &poolsize_strategy
+	},
+	{
+		.ctl_name	= RANDOM_ENTROPY_COUNT,
+		.procname	= "entropy_avail",
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec
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
+		.extra2		= &max_read_thresh
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
+		.extra2		= &max_write_thresh
+	},
+	{
+		.ctl_name	= RANDOM_BOOT_ID,
+		.procname	= "boot_id",
+		.data		= &sysctl_bootid,
+		.maxlen		= 16,
+		.mode		= 0444,
+		.proc_handler	= &proc_do_uuid,
+		.strategy	= &uuid_strategy
+	},
+	{
+		.ctl_name	= RANDOM_UUID,
+		.procname	= "uuid",
+		.maxlen		= 16,
+		.mode		= 0444,
+		.proc_handler	= &proc_do_uuid,
+		.strategy	= &uuid_strategy
+	},
+	{ .ctl_name = 0 }
 };
 
 static void sysctl_init_random(struct entropy_store *random_state)
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
