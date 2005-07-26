Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVGZHS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVGZHS4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 03:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVGZHS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 03:18:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49797 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261832AbVGZHSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 03:18:55 -0400
Date: Tue, 26 Jul 2005 09:18:45 +0200
From: Pavel Machek <pavel@suse.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk
Subject: [patch] ucb1x00: driver model fixes
Message-ID: <20050726071845.GJ8684@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes u32 vs. pm_message_t confusion and uses cleaner
try_to_freeze() [fixing compilation as a side-effect on newer
kernels.]

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- linux-rmk.clean//drivers/misc/mcp.h	2005-07-26 09:15:05.000000000 +0200
+++ linux-rmk/drivers/misc/mcp.h	2005-07-26 08:46:03.000000000 +0200
@@ -45,7 +45,7 @@
 	struct device_driver drv;
 	int (*probe)(struct mcp *);
 	void (*remove)(struct mcp *);
-	int (*suspend)(struct mcp *, u32);
+	int (*suspend)(struct mcp *, pm_message_t);
 	int (*resume)(struct mcp *);
 };
 
--- linux-rmk.clean//drivers/misc/ucb1x00-ts.c	2005-07-26 09:15:19.000000000 +0200
+++ linux-rmk/drivers/misc/ucb1x00-ts.c	2005-07-26 08:46:56.000000000 +0200
@@ -253,8 +253,7 @@
 			timeout = HZ / 100;
 		}
 
-		if (tsk->flags & PF_FREEZE)
-			refrigerator();
+		try_to_freeze();
 
 		schedule_timeout(timeout);
 		if (signal_pending(tsk))

-- 
teflon -- maybe it is a trademark, but it should not be.
