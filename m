Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWIDUrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWIDUrz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 16:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWIDUrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 16:47:55 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:49793 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751389AbWIDUry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 16:47:54 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] PM: Remove sleeping from suspend_console
Date: Mon, 4 Sep 2006 22:50:40 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Stefan Seyfried <seife@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609042250.41592.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ssleep() from suspend_console().

Stefan thinks it is unnecessary and will slow down the suspend too much.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
---
 kernel/printk.c |    5 -----
 1 file changed, 5 deletions(-)

Index: linux-2.6.18-rc5-mm1/kernel/printk.c
===================================================================
--- linux-2.6.18-rc5-mm1.orig/kernel/printk.c
+++ linux-2.6.18-rc5-mm1/kernel/printk.c
@@ -713,11 +713,6 @@ void suspend_console(void)
 	printk("Suspending console(s)\n");
 	acquire_console_sem();
 	console_suspended = 1;
-	/* This is needed so that all of the messages that have already been
-	 * written to all consoles can be actually transmitted (eg. over a
-	 * network) before we try to suspend the consoles' devices.
-	 */
-	ssleep(2);
 }
 
 void resume_console(void)
