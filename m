Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbUJ1Qrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbUJ1Qrx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbUJ1Qrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 12:47:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:7569 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261725AbUJ1QrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 12:47:20 -0400
Date: Thu, 28 Oct 2004 18:47:18 +0200
From: Jan Kara <jack@ucw.cz>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Configurable quota messages
Message-ID: <20041028164718.GA12340@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello Marcelo!

  Here is a patch which allows root to turn of quota messages to console
(some users don't like them because they disturb other console output).
If you think the patch could go into 2.4 tree then please apply it.

							Thanks
								Honza

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.4.27-quotawarn.diff"

diff -ru linux-2.4.27/fs/dquot.c linux-2.4.27-quotawarn/fs/dquot.c
--- linux-2.4.27/fs/dquot.c	2004-08-08 01:26:05.000000000 +0200
+++ linux-2.4.27-quotawarn/fs/dquot.c	2004-10-27 16:41:49.000000000 +0200
@@ -794,8 +794,13 @@
 	mark_dquot_dirty(dquot);
 }
 
+static int flag_print_warnings = 1;
+
 static inline int need_print_warning(struct dquot *dquot, int flag)
 {
+	if (!flag_print_warnings)
+		return 0;
+
 	switch (dquot->dq_type) {
 		case USRQUOTA:
 			return current->fsuid == dquot->dq_id && !(dquot->dq_flags & flag);
@@ -1498,6 +1503,7 @@
 	{FS_DQ_ALLOCATED, "allocated_dquots", &dqstats.allocated_dquots, sizeof(int), 0444, NULL, &proc_dointvec},
 	{FS_DQ_FREE, "free_dquots", &dqstats.free_dquots, sizeof(int), 0444, NULL, &proc_dointvec},
 	{FS_DQ_SYNCS, "syncs", &dqstats.syncs, sizeof(int), 0444, NULL, &proc_dointvec},
+	{FS_DQ_WARNINGS, "warnings", &flag_print_warnings, sizeof(int), 0644, NULL, &proc_dointvec},
 	{},
 };
 
diff -ru linux-2.4.27/include/linux/sysctl.h linux-2.4.27-quotawarn/include/linux/sysctl.h
--- linux-2.4.27/include/linux/sysctl.h	2004-08-08 01:26:06.000000000 +0200
+++ linux-2.4.27-quotawarn/include/linux/sysctl.h	2004-10-27 18:22:24.000000000 +0200
@@ -627,7 +627,7 @@
 	FS_LEASES=13,	/* int: leases enabled */
 	FS_DIR_NOTIFY=14,	/* int: directory notification enabled */
 	FS_LEASE_TIME=15,	/* int: maximum time to wait for a lease break */
-	FS_DQSTATS=16,	/* dir: disc quota usage statistics */
+	FS_DQSTATS=16,	/* dir: disc quota usage statistics and settings */
 	FS_XFS=17,	/* struct: control xfs parameters */
 };
 
@@ -641,6 +641,7 @@
 	FS_DQ_ALLOCATED = 6,
 	FS_DQ_FREE = 7,
 	FS_DQ_SYNCS = 8,
+	FS_DQ_WARNINGS = 9,
 };
 
 /* CTL_DEBUG names: */

--sdtB3X0nJg68CQEu--
