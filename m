Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbVKBQYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbVKBQYd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 11:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbVKBQYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 11:24:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56848 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965122AbVKBQYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 11:24:32 -0500
Date: Wed, 2 Nov 2005 17:24:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] EDAC: remove proc_ent from struct mem_ctl_info
Message-ID: <20051102162421.GJ8009@stusta.de>
References: <20051024014838.0dd491bb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024014838.0dd491bb.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While fixing a compile error with CONFIG_PROC_FS=n in the EDAC code, I 
discovered that the proc_ent member of struct mem_ctl_info is only used 
in a debug printk.

Is this patch to remove proc_ent OK?


Signed-off-by: Adrian Bunk <bunk@stusta.de>

 drivers/edac/edac_mc.c |    8 ++------
 drivers/edac/edac_mc.h |    3 ---
 2 files changed, 2 insertions(+), 9 deletions(-)

--- linux-2.6.14-rc5-mm1-modular-2.95/drivers/edac/edac_mc.h.old	2005-11-02 02:38:08.000000000 +0100
+++ linux-2.6.14-rc5-mm1-modular-2.95/drivers/edac/edac_mc.h	2005-11-02 02:38:19.000000000 +0100
@@ -313,9 +313,6 @@
 	const char *mod_ver;
 	const char *ctl_name;
 	char proc_name[MC_PROC_NAME_MAX_LEN + 1];
-#ifdef CONFIG_PROC_FS
-	struct proc_dir_entry *proc_ent;
-#endif
 	void *pvt_info;
 	u32 ue_noinfo_count;	/* Uncorrectable Errors w/o info */
 	u32 ce_noinfo_count;	/* Correctable Errors w/o info */
--- linux-2.6.14-rc5-mm1-modular-2.95/drivers/edac/edac_mc.c.old	2005-11-02 02:38:30.000000000 +0100
+++ linux-2.6.14-rc5-mm1-modular-2.95/drivers/edac/edac_mc.c	2005-11-02 02:39:44.000000000 +0100
@@ -362,8 +362,6 @@
 	printk(KERN_INFO "\tpdev = %p\n", mci->pdev);
 	printk(KERN_INFO "\tmod_name:ctl_name = %s:%s\n",
 	       mci->mod_name, mci->ctl_name);
-	printk(KERN_INFO "\tproc_name = %s, proc_ent = %p\n",
-	       mci->proc_name, mci->proc_ent);
 	printk(KERN_INFO "\tpvt_info = %p\n\n", mci->pvt_info);
 }
 
@@ -575,10 +573,8 @@
 		goto finish;
 	}
 
-	mci->proc_ent = create_proc_read_entry(mci->proc_name, 0, proc_mc,
-					       mc_read_proc, (void *) mci);
-
-	if (mci->proc_ent == NULL) {
+	if(create_proc_read_entry(mci->proc_name, 0, proc_mc,
+	                          mc_read_proc, (void *) mci) == NULL) {
 		printk(KERN_WARNING
 		       "MC%d: failed to create proc entry for controller\n",
 		       mci->mc_idx);

