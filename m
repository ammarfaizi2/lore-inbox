Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbWASHFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWASHFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 02:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbWASHF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 02:05:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:62935 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161109AbWASHF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 02:05:29 -0500
Date: Thu, 19 Jan 2006 00:58:21 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Andrew Morton <akpm@osdl.org>, <wim@iguana.be>
cc: linux-kernel@vger.kernel.org, <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] powerpc: remove useless spinlock from mpc83xx watchdog
Message-ID: <Pine.LNX.4.44.0601190057130.8484-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since we can only open the watchdog once having a spinlock to protect
multiple access is pointless.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 8852c088c0624f5534b08a769b5887c42a211694
tree 04ad05af51efb90604ff86af48197b6b7b45f77a
parent 1161d00ace361999d5b98bbe3082da4c8d457ba3
author Kumar Gala <galak@kernel.crashing.org> Thu, 19 Jan 2006 01:03:09 -0600
committer Kumar Gala <galak@kernel.crashing.org> Thu, 19 Jan 2006 01:03:09 -0600

 drivers/char/watchdog/mpc83xx_wdt.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/char/watchdog/mpc83xx_wdt.c b/drivers/char/watchdog/mpc83xx_wdt.c
index 5d6f506..b310144 100644
--- a/drivers/char/watchdog/mpc83xx_wdt.c
+++ b/drivers/char/watchdog/mpc83xx_wdt.c
@@ -57,15 +57,12 @@ static int prescale = 1;
 static unsigned int timeout_sec;
 
 static unsigned long wdt_is_open;
-static spinlock_t wdt_spinlock;
 
 static void mpc83xx_wdt_keepalive(void)
 {
 	/* Ping the WDT */
-	spin_lock(&wdt_spinlock);
 	out_be16(&wd_base->swsrr, 0x556c);
 	out_be16(&wd_base->swsrr, 0xaa39);
-	spin_unlock(&wdt_spinlock);
 }
 
 static ssize_t mpc83xx_wdt_write(struct file *file, const char __user *buf,
@@ -184,8 +181,6 @@ static int __devinit mpc83xx_wdt_probe(s
 		"mode:%s timeout=%d (%d seconds)\n",
 		reset ? "reset":"interrupt", timeout, timeout_sec);
 
-	spin_lock_init(&wdt_spinlock);
-
 	return 0;
 
 err_unmap:

