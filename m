Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263330AbVCKOU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbVCKOU6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 09:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbVCKOUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 09:20:52 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53485 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263330AbVCKOU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 09:20:29 -0500
Date: Fri, 11 Mar 2005 15:20:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: do not provoke emergency disk shutdowns
Message-ID: <20050311142012.GA1584@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan <seife@suse.de>

In platform swsusp mode, we were forgetting to spin disks down,
leading to ugly emergency shutdown. This synchronizes platform method
with other methods and actually helps. Please apply,

								Pavel

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- linux/kernel/power/disk.c-orig	2005-03-01 09:50:51.000000000 +0100
+++ linux/kernel/power/disk.c	2005-03-01 09:57:29.000000000 +0100
@@ -56,7 +56,7 @@ static void power_down(suspend_disk_meth
 	local_irq_save(flags);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
- 		device_power_down(PMSG_SUSPEND);
+ 		device_shutdown();
 		error = pm_ops->enter(PM_SUSPEND_DISK);
 		break;
 	case PM_DISK_SHUTDOWN:


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
