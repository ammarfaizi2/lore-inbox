Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVAOAwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVAOAwB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVAOAup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:50:45 -0500
Received: from waste.org ([216.27.176.166]:10465 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262072AbVAOAtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:49:16 -0500
Date: Fri, 14 Jan 2005 18:49:07 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6.563253706@selenic.com>
Message-Id: <7.563253706@selenic.com>
Subject: [PATCH 6/10] random pt2: kill memsets of static data
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant memsets of BSS data

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-12 21:28:03.909017586 -0800
+++ rnd/drivers/char/random.c	2005-01-12 21:28:04.834899546 -0800
@@ -1499,8 +1499,6 @@
 
 static int __init rand_initialize(void)
 {
-	int i;
-
 	if (create_entropy_store(DEFAULT_POOL_SIZE, "primary", &random_state))
 		goto err;
 	if (batch_entropy_init(BATCH_ENTROPY_SIZE, random_state))
@@ -1517,10 +1515,6 @@
 #ifdef CONFIG_SYSCTL
 	sysctl_init_random(random_state);
 #endif
-	for (i = 0; i < NR_IRQS; i++)
-		irq_timer_state[i] = NULL;
-	memset(&input_timer_state, 0, sizeof(struct timer_rand_state));
-	memset(&extract_timer_state, 0, sizeof(struct timer_rand_state));
 	extract_timer_state.dont_count_entropy = 1;
 	return 0;
 err:
