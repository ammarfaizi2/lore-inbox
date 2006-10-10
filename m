Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWJJNTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWJJNTz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWJJNTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:19:54 -0400
Received: from havoc.gtf.org ([69.61.125.42]:51093 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750729AbWJJNTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:19:53 -0400
Date: Tue, 10 Oct 2006 09:19:49 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Matt_Domsch@dell.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] firmware/efivars: handle error
Message-ID: <20061010131949.GA9064@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/firmware/efivars.c      |    7 ++++++-

diff --git a/drivers/firmware/efivars.c b/drivers/firmware/efivars.c
index 8ebce1c..5ab5e39 100644
--- a/drivers/firmware/efivars.c
+++ b/drivers/firmware/efivars.c
@@ -639,7 +639,12 @@ efivar_create_sysfs_entry(unsigned long 
 
 	kobject_set_name(&new_efivar->kobj, "%s", short_name);
 	kobj_set_kset_s(new_efivar, vars_subsys);
-	kobject_register(&new_efivar->kobj);
+	i = kobject_register(&new_efivar->kobj);
+	if (i) {
+		kfree(short_name);
+		kfree(new_efivar);
+		return 1;
+	}
 
 	kfree(short_name);
 	short_name = NULL;
