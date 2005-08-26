Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVHZJlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVHZJlZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 05:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVHZJlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 05:41:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56268 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932283AbVHZJlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 05:41:24 -0400
Date: Fri, 26 Aug 2005 11:41:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] Cleanup /sys/power/disk
Message-ID: <20050826094114.GA1903@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean code up a bit, and only show suspend to disk as available when
it is configured in.

--- linux-mm/kernel/power/main.c	2005-08-24 20:21:55.000000000 +0200
+++ linux/kernel/power/main.c	2005-07-13 23:58:57.000000000 +0200
@@ -143,11 +143,12 @@
 
 
 
-static char * pm_states[] = {
+static char * pm_states[PM_SUSPEND_MAX] = {
 	[PM_SUSPEND_STANDBY]	= "standby",
 	[PM_SUSPEND_MEM]	= "mem",
+#ifdef CONFIG_SOFTWARE_SUSPEND
 	[PM_SUSPEND_DISK]	= "disk",
-	NULL,
+#endif
 };
 
 

-- 
if you have sharp zaurus hardware you don't need... you know my address
