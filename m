Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUG1W3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUG1W3h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUG1W3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:29:37 -0400
Received: from gprs214-195.eurotel.cz ([160.218.214.195]:3200 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266531AbUG1W0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:26:01 -0400
Date: Thu, 29 Jul 2004 00:25:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: -mm swsusp: make sure we do not return to userspace where image is on disk
Message-ID: <20040728222547.GA18951@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When image is already on the disk, returning back to user is
dangerous. Please apply,
							Pavel

--- clean-mm/kernel/power/disk.c	2004-07-28 23:39:49.000000000 +0200
+++ linux-mm/kernel/power/disk.c	2004-07-28 23:33:46.000000000 +0200
@@ -63,8 +63,10 @@
 		break;
 	}
 	machine_halt();
-	device_power_up();
-	local_irq_restore(flags);
+	/* Valid image is on the disk, if we continue we risk serious data corruption
+	   after resume. */
+	printk("Please power me down manually\n");
+	while(1);
 	return 0;
 }
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
