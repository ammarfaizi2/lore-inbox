Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVJAHNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVJAHNi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 03:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVJAHNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 03:13:38 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:41924 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750761AbVJAHNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 03:13:37 -0400
Date: Sat, 1 Oct 2005 00:13:40 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [drivers/firmware] kmalloc + memset -> kzalloc conversion
Message-ID: <20051001071340.GI25424@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Deepak Saxena <dsaxena@plexity.net>


diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -715,7 +715,6 @@ edd_device_register(struct edd_device *e
 
 	if (!edev)
 		return 1;
-	memset(edev, 0, sizeof (*edev));
 	edd_dev_set_info(edev, i);
 	kobject_set_name(&edev->kobj, "int13_dev%02x",
 			 0x80 + i);
@@ -756,7 +755,7 @@ edd_init(void)
 		return rc;
 
 	for (i = 0; i < edd_num_devices() && !rc; i++) {
-		edev = kmalloc(sizeof (*edev), GFP_KERNEL);
+		edev = kzalloc(sizeof (*edev), GFP_KERNEL);
 		if (!edev)
 			return -ENOMEM;
 
diff --git a/drivers/firmware/efivars.c b/drivers/firmware/efivars.c
--- a/drivers/firmware/efivars.c
+++ b/drivers/firmware/efivars.c
@@ -614,16 +614,14 @@ efivar_create_sysfs_entry(unsigned long 
 	char *short_name;
 	struct efivar_entry *new_efivar;
 
-	short_name = kmalloc(short_name_size + 1, GFP_KERNEL);
-	new_efivar = kmalloc(sizeof(struct efivar_entry), GFP_KERNEL);
+	short_name = kzalloc(short_name_size + 1, GFP_KERNEL);
+	new_efivar = kzalloc(sizeof(struct efivar_entry), GFP_KERNEL);
 
 	if (!short_name || !new_efivar)  {
 		kfree(short_name);
 		kfree(new_efivar);
 		return 1;
 	}
-	memset(short_name, 0, short_name_size+1);
-	memset(new_efivar, 0, sizeof(struct efivar_entry));
 
 	memcpy(new_efivar->var.VariableName, variable_name,
 		variable_name_size);
@@ -674,14 +672,12 @@ efivars_init(void)
 	if (!efi_enabled)
 		return -ENODEV;
 
-	variable_name = kmalloc(variable_name_size, GFP_KERNEL);
+	variable_name = kzalloc(variable_name_size, GFP_KERNEL);
 	if (!variable_name) {
 		printk(KERN_ERR "efivars: Memory allocation failed.\n");
 		return -ENOMEM;
 	}
 
-	memset(variable_name, 0, variable_name_size);
-
 	printk(KERN_INFO "EFI Variables Facility v%s %s\n", EFIVARS_VERSION,
 	       EFIVARS_DATE);
 
-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
