Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVAYHvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVAYHvF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVAYHvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:51:05 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21255 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261863AbVAYHtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:49:20 -0500
Date: Tue, 25 Jan 2005 08:49:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/sys.c: make some code static
Message-ID: <20050125074917.GH3515@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 kernel/signal.c |    2 --
 kernel/sys.c    |    4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

This patch was already sent on:
- 12 Dec 2004

--- linux-2.6.10-rc2-mm4-full/kernel/sys.c.old	2004-12-12 03:18:40.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/sys.c	2004-12-12 03:19:19.000000000 +0100
@@ -90,7 +90,7 @@
  */
 
 static struct notifier_block *reboot_notifier_list;
-DEFINE_RWLOCK(notifier_lock);
+static DEFINE_RWLOCK(notifier_lock);
 
 /**
  *	notifier_chain_register	- Add notifier to a notifier chain
@@ -1544,7 +1544,7 @@
  * given child after it's reaped, or none so this sample is before reaping.
  */
 
-void k_getrusage(struct task_struct *p, int who, struct rusage *r)
+static void k_getrusage(struct task_struct *p, int who, struct rusage *r)
 {
 	struct task_struct *t;
 	unsigned long flags;
--- linux-2.6.10-rc2-mm4-full/kernel/signal.c.old	2004-12-12 03:18:25.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/signal.c	2004-12-12 03:18:32.000000000 +0100
@@ -27,8 +27,6 @@
 #include <asm/unistd.h>
 #include <asm/siginfo.h>
 
-extern void k_getrusage(struct task_struct *, int, struct rusage *);
-
 /*
  * SLAB caches for signal bits.
  */

