Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbVAPN6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVAPN6t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 08:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVAPN5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 08:57:34 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:6374 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S262507AbVAPNwv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:52:51 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050116135250.30109.31739.53624@localhost.localdomain>
In-Reply-To: <20050116135223.30109.26479.55757@localhost.localdomain>
References: <20050116135223.30109.26479.55757@localhost.localdomain>
Subject: [PATCH 4/13] ftape: remove cli()/sti() in drivers/char/ftape/lowlevel/ftape-io.c
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [209.158.220.243] at Sun, 16 Jan 2005 07:52:50 -0600
Date: Sun, 16 Jan 2005 07:52:50 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.11-rc1-mm1-original/drivers/char/ftape/lowlevel/ftape-io.c linux-2.6.11-rc1-mm1/drivers/char/ftape/lowlevel/ftape-io.c
--- linux-2.6.11-rc1-mm1-original/drivers/char/ftape/lowlevel/ftape-io.c	2005-01-16 07:17:19.000000000 -0500
+++ linux-2.6.11-rc1-mm1/drivers/char/ftape/lowlevel/ftape-io.c	2005-01-16 07:32:19.293557207 -0500
@@ -95,15 +95,15 @@
 
 		TRACE(ft_t_any, "%d msec, %d ticks", time/1000, ticks);
 		timeout = ticks;
-		save_flags(flags);
-		sti();
+		local_save_flags(flags);
+		local_irq_enable();
 		msleep_interruptible(jiffies_to_msecs(timeout));
 		/*  Mmm. Isn't current->blocked == 0xffffffff ?
 		 */
 		if (signal_pending(current)) {
 			TRACE(ft_t_err, "awoken by non-blocked signal :-(");
 		}
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 	TRACE_EXIT;
 }
