Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbUDEVEr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbUDEVEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:04:47 -0400
Received: from gprs214-195.eurotel.cz ([160.218.214.195]:31872 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263195AbUDEVD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:03:57 -0400
Date: Mon, 5 Apr 2004 23:03:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Cleanup & (partly?) support swsusp for aic7xxx
Message-ID: <20040405210346.GA3520@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This kills checks for kernels older than 2.5.60, and marks threads as
needed for suspend (which they probably are).

								Pavel

--- tmp/linux/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-03-11 18:11:12.000000000 +0100
+++ linux/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-04-01 19:01:29.000000000 +0200
@@ -2581,17 +2581,8 @@
 	 * Complete thread creation.
 	 */
 	lock_kernel();
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,60)
-	/*
-	 * Don't care about any signals.
-	 */
-	siginitsetinv(&current->blocked, 0);
-
-	daemonize();
-	sprintf(current->comm, "ahd_dv_%d", ahd->unit);
-#else
 	daemonize("ahd_dv_%d", ahd->unit);
-#endif
+	current->flags |= PF_IOTHREAD;
 	unlock_kernel();
 
 	while (1) {
--- tmp/linux/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-03-11 18:11:12.000000000 +0100
+++ linux/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-04-01 19:01:08.000000000 +0200
@@ -2286,17 +2286,8 @@
 	 * Complete thread creation.
 	 */
 	lock_kernel();
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	/*
-	 * Don't care about any signals.
-	 */
-	siginitsetinv(&current->blocked, 0);
-
-	daemonize();
-	sprintf(current->comm, "ahc_dv_%d", ahc->unit);
-#else
 	daemonize("ahc_dv_%d", ahc->unit);
-#endif
+	current->flags |= PF_IOTHREAD;
 	unlock_kernel();
 
 	while (1) {

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
