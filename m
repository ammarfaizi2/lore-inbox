Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbULKPol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbULKPol (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 10:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbULKPol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 10:44:41 -0500
Received: from gprs215-225.eurotel.cz ([160.218.215.225]:387 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261952AbULKPof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 10:44:35 -0500
Date: Sat, 11 Dec 2004 16:44:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp bugfixes: fix memory leak
Message-ID: <20041211154422.GA1873@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes memory leak when we are low on memory during
suspend. Ouch and nr_needed_pages is only used twice, and only written
:-(. I guess that can wait for 2.6.10. Please apply,
							Pavel

--- clean/kernel/power/swsusp.c	28 Oct 2004 15:21:34 -0000	1.29
+++ linux/kernel/power/swsusp.c	10 Dec 2004 21:35:59 -0000
@@ -786,12 +768,13 @@
 
 int suspend_prepare_image(void)
 {
-	unsigned int nr_needed_pages = 0;
+	unsigned int nr_needed_pages;
 	int error;
 
 	pr_debug("swsusp: critical section: \n");
 	if (save_highmem()) {
 		printk(KERN_CRIT "Suspend machine: Not enough free pages for highmem\n");
+		restore_highmem();
 		return -ENOMEM;
 	}
 
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
