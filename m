Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268981AbUJTS0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268981AbUJTS0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 14:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268980AbUJTSWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:22:32 -0400
Received: from gprs214-236.eurotel.cz ([160.218.214.236]:23171 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268981AbUJTSQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:16:43 -0400
Date: Wed, 20 Oct 2004 20:16:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: power/disk.c: small fixups
Message-ID: <20041020181617.GA29435@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

power_down may never ever fail, so it does not really need to return
anything. Kill obsolete code and fixup old comments. Please apply,

								Pavel

--- foo/kernel/power/disk.c	19 Oct 2004 05:52:31 -0000	1.8
+++ foo/kernel/power/disk.c	20 Oct 2004 17:53:42 -0000
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2003 Patrick Mochel
  * Copyright (c) 2003 Open Source Development Lab
+ * Copyright (c) 2004 Pavel Machek <pavel@suse.cz>
  *
  * This file is released under the GPLv2.
  *
@@ -41,7 +43,7 @@
  *	there ain't no turning back.
  */
 
-static int power_down(u32 mode)
+static void power_down(u32 mode)
 {
 	unsigned long flags;
 	int error = 0;
@@ -67,7 +69,6 @@
 	   after resume. */
 	printk(KERN_CRIT "Please power me down manually\n");
 	while(1);
-	return 0;
 }
 
 
@@ -162,7 +163,7 @@
  *
  *	If we're going through the firmware, then get it over with quickly.
  *
- *	If not, then call pmdis to do it's thing, then figure out how
+ *	If not, then call swsusp to do it's thing, then figure out how
  *	to power down the system.
  */
 
@@ -184,18 +185,9 @@
 
 	if (in_suspend) {
 		pr_debug("PM: writing image.\n");
-
-		/*
-		 * FIXME: Leftover from swsusp. Are they necessary?
-		 */
-		mb();
-		barrier();
-
 		error = swsusp_write();
-		if (!error) {
-			error = power_down(pm_disk_mode);
-			pr_debug("PM: Power down failed.\n");
-		}
+		if (!error)
+			power_down(pm_disk_mode);
 	} else
 		pr_debug("PM: Image restored successfully.\n");
 	swsusp_free();

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
