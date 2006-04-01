Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWDANPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWDANPl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 08:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWDANPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 08:15:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:65042 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751444AbWDANPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 08:15:40 -0500
Date: Sat, 1 Apr 2006 15:15:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] the scheduled unexport of panic_timeout
Message-ID: <20060401131539.GH28310@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the scheduled unexport of panic_timeout.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

@Andrew:
Since this was announced and gave compile warnings for one year, it 
should go into 2.6.17.

 Documentation/feature-removal-schedule.txt |    8 --------
 include/linux/kernel.h                     |    2 +-
 kernel/panic.c                             |    1 -
 3 files changed, 1 insertion(+), 10 deletions(-)

--- linux-2.6.16-mm2-full/Documentation/feature-removal-schedule.txt.old	2006-04-01 12:44:08.000000000 +0200
+++ linux-2.6.16-mm2-full/Documentation/feature-removal-schedule.txt	2006-04-01 12:44:34.000000000 +0200
@@ -72,14 +72,6 @@
 
 ---------------------------
 
-What:	remove EXPORT_SYMBOL(panic_timeout)
-When:	April 2006
-Files:	kernel/panic.c
-Why:	No modular usage in the kernel.
-Who:	Adrian Bunk <bunk@stusta.de>
-
----------------------------
-
 What:	remove EXPORT_SYMBOL(insert_resource)
 When:	April 2006
 Files:	kernel/resource.c
--- linux-2.6.16-mm2-full/include/linux/kernel.h.old	2006-04-01 12:43:48.000000000 +0200
+++ linux-2.6.16-mm2-full/include/linux/kernel.h	2006-04-01 12:43:59.000000000 +0200
@@ -176,7 +176,7 @@
 
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
-extern __deprecated_for_modules int panic_timeout;
+extern int panic_timeout;
 extern int panic_on_oops;
 extern int tainted;
 extern const char *print_tainted(void);
--- linux-2.6.16-mm2-full/kernel/panic.c.old	2006-04-01 12:44:43.000000000 +0200
+++ linux-2.6.16-mm2-full/kernel/panic.c	2006-04-01 12:44:47.000000000 +0200
@@ -27,7 +27,6 @@
 static DEFINE_SPINLOCK(pause_on_oops_lock);
 
 int panic_timeout;
-EXPORT_SYMBOL(panic_timeout);
 
 ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
 

