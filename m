Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbUDLO0d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 10:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUDLOUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 10:20:34 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:20374 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262916AbUDLOTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 10:19:03 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Device-Mapper 5/9
Date: Mon, 12 Apr 2004 09:18:48 -0500
User-Agent: KMail/1.6
References: <200404120912.45870.kevcorry@us.ibm.com>
In-Reply-To: <200404120912.45870.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404120918.49001.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Log an error if the target has unknown target type, or zero length.

--- diff/drivers/md/dm-table.c	2004-04-09 09:40:14.000000000 -0500
+++ source/drivers/md/dm-table.c	2004-04-09 09:42:20.000000000 -0500
@@ -663,12 +663,14 @@
 
 	if (!len) {
 		tgt->error = "zero-length target";
+		DMERR(": %s\n", tgt->error);
 		return -EINVAL;
 	}
 
 	tgt->type = dm_get_target_type(type);
 	if (!tgt->type) {
 		tgt->error = "unknown target type";
+		DMERR(": %s\n", tgt->error);
 		return -EINVAL;
 	}
 
@@ -705,7 +707,7 @@
 	return 0;
 
  bad:
-	printk(KERN_ERR DM_NAME ": %s\n", tgt->error);
+	DMERR(": %s\n", tgt->error);
 	dm_put_target_type(tgt->type);
 	return r;
 }
