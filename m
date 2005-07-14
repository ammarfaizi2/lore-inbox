Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVGNWUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVGNWUW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVGNWUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:20:14 -0400
Received: from coderock.org ([193.77.147.115]:25761 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261412AbVGNWT2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 18:19:28 -0400
Message-Id: <20050714221923.543951000@homer>
Date: Fri, 15 Jul 2005 00:19:23 +0200
From: domen@coderock.org
To: spyro@f2s.com
Cc: linux-kernel@vger.kernel.org, Christophe Lucas <clucas@rotomalug.org>,
       domen@coderock.org
Subject: [patch 1/1] Audit return code of create_proc_*
Content-Disposition: inline; filename=return_code-arch_arm26_kernel_ecard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Lucas <clucas@rotomalug.org>


Audit return of create_proc_* functions.

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 ecard.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

Index: quilt/arch/arm26/kernel/ecard.c
===================================================================
--- quilt.orig/arch/arm26/kernel/ecard.c
+++ quilt/arch/arm26/kernel/ecard.c
@@ -522,9 +522,16 @@ static struct proc_dir_entry *proc_bus_e
 
 static void ecard_proc_init(void)
 {
+	struct proc_dir_entry *proc_entry;
 	proc_bus_ecard_dir = proc_mkdir("ecard", proc_bus);
-	create_proc_info_entry("devices", 0, proc_bus_ecard_dir,
-		get_ecard_dev_info);
+	if (!proc_bus_ecard_dir)
+		printk(KERN_WARNING "Unable to create proc dir entry.\n");
+	else {
+		proc_entry = create_proc_info_entry("devices", 0,
+			proc_bus_ecard_dir, get_ecard_dev_info);
+		if (!proc_entry)
+			printk(KERN_WARNING "ecard: Unable to create proc entry\n");
+	}
 }
 
 #define ec_set_resource(ec,nr,st,sz,flg)			\

--
