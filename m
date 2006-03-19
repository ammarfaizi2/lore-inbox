Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWCSLUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWCSLUr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 06:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWCSLUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 06:20:46 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:44254 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751473AbWCSLUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 06:20:46 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 1/3] swsusp: let userland tools switch console on suspend
Date: Sun, 19 Mar 2006 12:05:18 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <200603191158.26275.rjw@sisk.pl>
In-Reply-To: <200603191158.26275.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603191205.18704.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Rafael J. Wysocki" <rjw@sisk.pl>

Remove the console-switching code from the suspend part of the swsusp
userland interface and let the userland tools switch the console.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
---
 kernel/power/user.c |    3 ---
 1 files changed, 3 deletions(-)

Index: linux-2.6.16-rc6-mm2/kernel/power/user.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/kernel/power/user.c
+++ linux-2.6.16-rc6-mm2/kernel/power/user.c
@@ -138,12 +138,10 @@ static int snapshot_ioctl(struct inode *
 		if (data->frozen)
 			break;
 		down(&pm_sem);
-		pm_prepare_console();
 		disable_nonboot_cpus();
 		if (freeze_processes()) {
 			thaw_processes();
 			enable_nonboot_cpus();
-			pm_restore_console();
 			error = -EBUSY;
 		}
 		up(&pm_sem);
@@ -157,7 +155,6 @@ static int snapshot_ioctl(struct inode *
 		down(&pm_sem);
 		thaw_processes();
 		enable_nonboot_cpus();
-		pm_restore_console();
 		up(&pm_sem);
 		data->frozen = 0;
 		break;

