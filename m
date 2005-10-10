Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVJJVdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVJJVdt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 17:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbVJJVdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 17:33:49 -0400
Received: from [139.30.44.2] ([139.30.44.2]:61444 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1751267AbVJJVds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 17:33:48 -0400
Date: Mon, 10 Oct 2005 23:33:47 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch]Fix copy-and-paste error in BSD accounting
Message-ID: <Pine.LNX.4.61.0510102330570.24774@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Schmielau <tim@physik3.uni-rostock.de>

Fix copy and paste error in jiffies_to_AHZ conversion which leads
to wrong BSD accounting information on alpha and ia64 when
CONFIG_BSD_PROCESS_ACCT_V3 is turned on.

Also update comment to match reorganised header files.

Signed-off-by: Tim Schmielau <tim@physik3.uni-rostock.de>

--- linux-2.6.14-rc3/include/linux/acct.h	2005-08-29 01:41:01 +0200
+++ linux-2.6.14-rc3-ahz/include/linux/acct.h	2005-10-10 23:06:26 +0200
@@ -162,13 +162,13 @@ typedef struct acct acct_t;
 #ifdef __KERNEL__
 /*
  * Yet another set of HZ to *HZ helper functions.
- * See <linux/times.h> for the original.
+ * See <linux/jiffies.h> for the original.
  */
 
 static inline u32 jiffies_to_AHZ(unsigned long x)
 {
 #if (TICK_NSEC % (NSEC_PER_SEC / AHZ)) == 0
-	return x / (HZ / USER_HZ);
+	return x / (HZ / AHZ);
 #else
         u64 tmp = (u64)x * TICK_NSEC;
         do_div(tmp, (NSEC_PER_SEC / AHZ));
