Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWJDUZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWJDUZG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWJDUZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:25:05 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:35538 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751098AbWJDUZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:25:03 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -fix] swsusp: Make userland suspend work on SMP again
Date: Wed, 4 Oct 2006 22:26:42 +0200
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610042226.43833.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately one of the recent changes in swsusp has broken the userland
suspend on SMP.  Fix it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
---
 kernel/power/user.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-mm3/kernel/power/user.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/power/user.c
+++ linux-2.6.18-mm3/kernel/power/user.c
@@ -149,10 +149,10 @@ static int snapshot_ioctl(struct inode *
 			error = freeze_processes();
 			if (error) {
 				thaw_processes();
+				enable_nonboot_cpus();
 				error = -EBUSY;
 			}
 		}
-		enable_nonboot_cpus();
 		up(&pm_sem);
 		if (!error)
 			data->frozen = 1;
