Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263846AbUCZABk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263812AbUCYX7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 18:59:21 -0500
Received: from waste.org ([209.173.204.2]:48281 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263816AbUCYX6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:58:00 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <13.524465763@selenic.com>
Message-Id: <14.524465763@selenic.com>
Subject: [PATCH 13/22] /dev/random: kill extract_timer_state
Date: Thu, 25 Mar 2004 17:57:44 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/random  kill extract_timer_state

Remove unused extract_timer_state struct. It was formerly used to
feedback zero-entropy timing samples while extracting entropy, but
that had a tendency to overwhelm the batch processing queue and
prevent storing real samples.


 tiny-mpm/drivers/char/random.c |    3 ---
 1 files changed, 3 deletions(-)

diff -puN drivers/char/random.c~kill-extract-state drivers/char/random.c
--- tiny/drivers/char/random.c~kill-extract-state	2004-03-20 13:38:30.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:38:30.000000000 -0600
@@ -749,7 +749,6 @@ struct timer_rand_state {
 
 static struct timer_rand_state keyboard_timer_state;
 static struct timer_rand_state mouse_timer_state;
-static struct timer_rand_state extract_timer_state;
 static struct timer_rand_state *irq_timer_state[NR_IRQS];
 
 /*
@@ -1490,8 +1489,6 @@ static int __init rand_initialize(void)
 		irq_timer_state[i] = NULL;
 	memset(&keyboard_timer_state, 0, sizeof(struct timer_rand_state));
 	memset(&mouse_timer_state, 0, sizeof(struct timer_rand_state));
-	memset(&extract_timer_state, 0, sizeof(struct timer_rand_state));
-	extract_timer_state.dont_count_entropy = 1;
 	return 0;
 }
 module_init(rand_initialize);

_
