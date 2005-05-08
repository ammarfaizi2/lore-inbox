Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262976AbVEHWL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbVEHWL0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 18:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbVEHWL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 18:11:26 -0400
Received: from mail.dif.dk ([193.138.115.101]:47327 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262976AbVEHWLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 18:11:24 -0400
Date: Mon, 9 May 2005 00:15:12 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: Matt_Domsch@dell.com, matthew.e.tolentino@intel.com, akpm@osdl.org
Subject: [PATCH] kfree cleanups for drivers/firmware/
Message-ID: <Pine.LNX.4.62.0505090009540.2440@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch with kfree() cleanups for drivers/firmware/efivars.c
Patch removes redundant NULL checks before kfree and also makes a small 
whitespace cleanup - moves two statements on same line to sepperate lines.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/firmware/efivars.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

--- linux-2.6.12-rc3-mm3-orig/drivers/firmware/efivars.c	2005-05-06 23:21:08.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/firmware/efivars.c	2005-05-09 00:08:51.000000000 +0200
@@ -618,8 +618,8 @@ efivar_create_sysfs_entry(unsigned long 
 	new_efivar = kmalloc(sizeof(struct efivar_entry), GFP_KERNEL);
 
 	if (!short_name || !new_efivar)  {
-		if (short_name)        kfree(short_name);
-		if (new_efivar)        kfree(new_efivar);
+		kfree(short_name);
+		kfree(new_efivar);
 		return 1;
 	}
 	memset(short_name, 0, short_name_size+1);
@@ -644,7 +644,8 @@ efivar_create_sysfs_entry(unsigned long 
 	kobj_set_kset_s(new_efivar, vars_subsys);
 	kobject_register(&new_efivar->kobj);
 
-	kfree(short_name); short_name = NULL;
+	kfree(short_name);
+	short_name = NULL;
 
 	spin_lock(&efivars_lock);
 	list_add(&new_efivar->list, &efivar_list);


