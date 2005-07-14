Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262785AbVGNWYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbVGNWYk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVGNWXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:23:35 -0400
Received: from coderock.org ([193.77.147.115]:46753 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262492AbVGNWVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 18:21:03 -0400
Message-Id: <20050714222057.196354000@homer>
Date: Fri, 15 Jul 2005 00:20:57 +0200
From: domen@coderock.org
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, Christophe Lucas <clucas@rotomalug.org>,
       domen@coderock.org
Subject: [patch 1/2] block/cpqarray: Audit return code of create_proc_*
Content-Disposition: inline; filename=return_code-drivers_block_cpqarray
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Lucas <clucas@rotomalug.org>


Audit return of create_proc_* functions.

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 cpqarray.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Index: quilt/drivers/block/cpqarray.c
===================================================================
--- quilt.orig/drivers/block/cpqarray.c
+++ quilt/drivers/block/cpqarray.c
@@ -212,13 +212,18 @@ static struct proc_dir_entry *proc_array
  */
 static void __init ida_procinit(int i)
 {
+	struct proc_dir_entry *ent;
+
 	if (proc_array == NULL) {
 		proc_array = proc_mkdir("cpqarray", proc_root_driver);
 		if (!proc_array) return;
 	}
 
-	create_proc_read_entry(hba[i]->devname, 0, proc_array,
+	ent = create_proc_read_entry(hba[i]->devname, 0, proc_array,
 			       ida_proc_get_info, hba[i]);
+	if (!ent)
+		printk(KERN_WARNING 
+			"cpqarray: Unable to create /proc entry.\n");
 }
 
 /*

--
