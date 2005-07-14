Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVGNWAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVGNWAq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbVGNVob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 17:44:31 -0400
Received: from coderock.org ([193.77.147.115]:61344 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S263140AbVGNVnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 17:43:21 -0400
Message-Id: <20050714214256.703875000@homer>
Date: Thu, 14 Jul 2005 23:42:57 +0200
From: domen@coderock.org
To: jejb@steeleye.com
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
Subject: [patch 1/1] mca/mca-proc: Audit return code of create_proc_*
Content-Disposition: inline; filename=return_code-drivers_mca_mca-proc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Lucas <clucas@rotomalug.org>


---
 mca-proc.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

Index: quilt/drivers/mca/mca-proc.c
===================================================================
--- quilt.orig/drivers/mca/mca-proc.c
+++ quilt/drivers/mca/mca-proc.c
@@ -184,8 +184,14 @@ void __init mca_do_proc_init(void)
 	struct mca_device *mca_dev;
 
 	proc_mca = proc_mkdir("mca", &proc_root);
-	create_proc_read_entry("pos",0,proc_mca,get_mca_info,NULL);
-	create_proc_read_entry("machine",0,proc_mca,get_mca_machine_info,NULL);
+	node = create_proc_read_entry("pos",0,proc_mca,get_mca_info,NULL);
+	if (!node)
+		printk(KERN_WARNING "MCA: Unable to create mca /proc entry.\n");
+	node = create_proc_read_entry("machine",0,proc_mca,
+		get_mca_machine_info,NULL);
+	if (!node)
+		printk(KERN_WARNING 
+			"MCA: Unable to create machine /proc entry.\n");
 
 	/* Initialize /proc/mca entries for existing adapters */
 
@@ -211,7 +217,8 @@ void __init mca_do_proc_init(void)
 					      mca_read_proc, (void *)mca_dev);
 
 		if(node == NULL) {
-			printk("Failed to allocate memory for MCA proc-entries!");
+			printk(KERN_WARNING 
+				"Failed to allocate memory for MCA proc-entries!");
 			return;
 		}
 	}

--
