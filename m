Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVAOBDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVAOBDT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVAOAtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:49:46 -0500
Received: from waste.org ([216.27.176.166]:9441 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262067AbVAOAtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:49:12 -0500
Date: Fri, 14 Jan 2005 18:49:07 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7.563253706@selenic.com>
Message-Id: <8.563253706@selenic.com>
Subject: [PATCH 7/10] random pt2: kill dead extract_state struct
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused extract_timer_state struct. It was formerly used to
feedback zero-entropy timing samples while extracting entropy, but
that had a tendency to overwhelm the batch processing queue and
prevent storing real samples.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-12 21:28:04.834899546 -0800
+++ rnd/drivers/char/random.c	2005-01-12 21:28:05.741783928 -0800
@@ -777,7 +777,6 @@
 };
 
 static struct timer_rand_state input_timer_state;
-static struct timer_rand_state extract_timer_state;
 static struct timer_rand_state *irq_timer_state[NR_IRQS];
 
 /*
@@ -1515,7 +1514,6 @@
 #ifdef CONFIG_SYSCTL
 	sysctl_init_random(random_state);
 #endif
-	extract_timer_state.dont_count_entropy = 1;
 	return 0;
 err:
 	return -1;
