Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVAXRUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVAXRUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVAXRUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:20:05 -0500
Received: from gprs213-136.eurotel.cz ([160.218.213.136]:3201 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261480AbVAXRT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:19:59 -0500
Date: Mon, 24 Jan 2005 18:19:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: arpanet@post.cz, Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Enable swsusp on SMP machines
Message-ID: <20050124171943.GA2499@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This enables swsusp on SMP machines. It should be working in 2.6.10,
already (but you may need noapic in 2.6.10). Please apply,

								Pavel

--- /data/l/READ-ONLY/linux/kernel/power/main.c	2005-01-16 23:10:29.000000000 +0100
+++ linux/kernel/power/main.c	2005-01-24 17:59:14.000000000 +0100
@@ -141,14 +141,14 @@
 	if (down_trylock(&pm_sem))
 		return -EBUSY;
 
-	/* Suspend is hard to get right on SMP. */
-	if (num_online_cpus() != 1) {
-		error = -EPERM;
+	if (state == PM_SUSPEND_DISK) {
+		error = pm_suspend_disk();
 		goto Unlock;
 	}
 
-	if (state == PM_SUSPEND_DISK) {
-		error = pm_suspend_disk();
+	/* Suspend is hard to get right on SMP. */
+	if (num_online_cpus() != 1) {
+		error = -EPERM;
 		goto Unlock;
 	}
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
