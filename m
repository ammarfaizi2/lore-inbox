Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbTIYRzA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbTIYRye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:54:34 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:50655 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261376AbTIYRUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:20:48 -0400
Date: Thu, 25 Sep 2003 19:20:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (11/19): dasd partitions.
Message-ID: <20030925172008.GL2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix bug in CMS label recognition in ibm.c

diffstat:
 fs/partitions/ibm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -urN linux-2.6/fs/partitions/ibm.c linux-2.6-s390/fs/partitions/ibm.c
--- linux-2.6/fs/partitions/ibm.c	Mon Sep  8 21:50:41 2003
+++ linux-2.6-s390/fs/partitions/ibm.c	Thu Sep 25 18:33:29 2003
@@ -9,6 +9,7 @@
  * 07/10/00 Fixed detection of CMS formatted disks     
  * 02/13/00 VTOC partition support added
  * 12/27/01 fixed PL030593 (CMS reserved minidisk not detected on 64 bit)
+ * 07/24/03 no longer using contents of freed page for CMS label recognition (BZ3611)
  */
 
 #include <linux/config.h>
@@ -98,7 +99,7 @@
 		/*
 		 * VM style CMS1 labeled disk
 		 */
-		int *label = (int *) data;
+		int *label = (int *) vlabel;
 
 		if (label[13] != 0) {
 			printk("CMS1/%8s(MDSK):", name);
