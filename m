Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265893AbUG1WXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265893AbUG1WXe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266284AbUG1WXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:23:33 -0400
Received: from gprs214-195.eurotel.cz ([160.218.214.195]:1664 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265893AbUG1WXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:23:16 -0400
Date: Thu, 29 Jul 2004 00:23:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: -mm swsusp: fix highmem handling
Message-ID: <20040728222300.GA16671@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Swsusp was not restoring highmem properly. I did not find a nice place
where to restore it, through, so it went to swsusp_free.

I'm not sure why you are saving state before
save_processor_state. swsusp_arch_resume will overwrite this,
anyway. Is it to make something balanced?
								Pavel

--- clean-mm/kernel/power/swsusp.c	2004-07-28 23:39:49.000000000 +0200
+++ linux-mm/kernel/power/swsusp.c	2004-07-28 23:30:33.000000000 +0200
@@ -656,6 +652,10 @@
 			free_suspend_pagedir_zone(zone, p);
 	}
 	free_pages(p, pagedir_order);
+#ifdef CONFIG_HIGHMEM
+	printk( "Restoring highmem\n" );
+	restore_highmem();
+#endif
 }
 
 
@@ -890,7 +890,6 @@
 {
 	int error;
 	local_irq_disable();
-	save_processor_state();
 	error = swsusp_arch_resume();
 	restore_processor_state();
 	local_irq_enable();

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
