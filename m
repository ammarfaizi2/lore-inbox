Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265314AbUFHVD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbUFHVD0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 17:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbUFHVD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 17:03:26 -0400
Received: from outmx004.isp.belgacom.be ([195.238.2.101]:39915 "EHLO
	outmx004.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265314AbUFHVCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 17:02:49 -0400
Subject: [PATCH 2.6.7-rc3] nr_free_files ?
From: FabF <fabian.frederick@skynet.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-HXJtszMg7w4gJDB3Hvvs"
Message-Id: <1086728685.3865.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 08 Jun 2004 23:04:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HXJtszMg7w4gJDB3Hvvs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

	Here's a patch removing nr_free_files.This one is unused in the whole
tree + file-nr was tri-int exposed in /proc.This patch gives file-nr
simple integer as file-max.Could you apply if this doesn't break
historical features ?

Regards,
FabF

--=-HXJtszMg7w4gJDB3Hvvs
Content-Disposition: attachment; filename=filenr1.diff
Content-Type: text/x-patch; name=filenr1.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur orig/include/linux/fs.h edited/include/linux/fs.h
--- orig/include/linux/fs.h	2004-06-08 00:04:43.000000000 +0200
+++ edited/include/linux/fs.h	2004-06-08 22:50:36.000000000 +0200
@@ -49,7 +49,6 @@
 /* And dynamically-tunable limits and defaults: */
 struct files_stat_struct {
 	int nr_files;		/* read only */
-	int nr_free_files;	/* read only */
 	int max_files;		/* tunable */
 };
 extern struct files_stat_struct files_stat;
diff -Naur orig/kernel/sysctl.c edited/kernel/sysctl.c
--- orig/kernel/sysctl.c	2004-06-08 00:04:44.000000000 +0200
+++ edited/kernel/sysctl.c	2004-06-08 22:53:09.000000000 +0200
@@ -822,8 +822,8 @@
 	{
 		.ctl_name	= FS_NRFILE,
 		.procname	= "file-nr",
-		.data		= &files_stat,
-		.maxlen		= 3*sizeof(int),
+		.data		= &files_stat.nr_files,
+		.maxlen		= sizeof(int),
 		.mode		= 0444,
 		.proc_handler	= &proc_dointvec,
 	},

--=-HXJtszMg7w4gJDB3Hvvs--

