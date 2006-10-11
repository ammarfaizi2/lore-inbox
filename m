Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWJKMmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWJKMmW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 08:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWJKMmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 08:42:22 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:48108 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751240AbWJKMmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 08:42:21 -0400
Subject: [PATCH] drivers/mmc/mmc.c: Replacing yield() with a better
	alternative
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: kernel Janitors <kernel-janitors@lists.osdl.org>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 18:15:43 +0530
Message-Id: <1160570743.19143.307.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6, the semantics of calling yield() changed from "sleep for a
bit" to "I really don't want to run for a while".  This matches POSIX
better, but there's a lot of drivers still using yield() when they mean
cond_resched(), schedule() or even schedule_timeout().

For this driver cond_resched() seems to be a better
alternative

Tested compile only

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/drivers/mmc/mmc.c linux-2.6.19-rc1/drivers/mmc/mmc.c
--- linux-2.6.19-rc1-orig/drivers/mmc/mmc.c	2006-10-05 14:00:46.000000000 +0530
+++ linux-2.6.19-rc1/drivers/mmc/mmc.c	2006-10-11 17:57:02.000000000 +0530
@@ -454,7 +454,7 @@ static void mmc_deselect_cards(struct mm
 static inline void mmc_delay(unsigned int ms)
 {
 	if (ms < HZ / 1000) {
-		yield();
+		cond_resched();
 		mdelay(ms);
 	} else {
 		msleep_interruptible (ms);


