Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936304AbWLAKte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936304AbWLAKte (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 05:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936295AbWLAKte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 05:49:34 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:15583 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S936304AbWLAKtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 05:49:33 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] PM: Fix swsusp debug mode testproc
Date: Fri, 1 Dec 2006 11:45:12 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       stable@kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011145.12787.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 'testproc' swsusp debug mode thaws tasks twice in a row, which is _very_
confusing.  Fix that.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/disk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.19-rc6-mm2/kernel/power/disk.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/kernel/power/disk.c	2006-11-28 22:48:35.000000000 +0100
+++ linux-2.6.19-rc6-mm2/kernel/power/disk.c	2006-11-29 23:46:33.000000000 +0100
@@ -153,7 +153,7 @@ int pm_suspend_disk(void)
 		return error;
 
 	if (pm_disk_mode == PM_DISK_TESTPROC)
-		goto Thaw;
+		return 0;
 
 	suspend_console();
 	error = device_suspend(PMSG_FREEZE);
