Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbULLUFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbULLUFH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 15:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbULLUCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 15:02:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36882 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262102AbULLUB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 15:01:26 -0500
Date: Sun, 12 Dec 2004 21:01:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/sys.c: make some code static
Message-ID: <20041212200114.GP22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


diffstat output:
 kernel/signal.c |    2 --
 kernel/sys.c    |    4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

