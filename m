Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVAOBDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVAOBDS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVAOAth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:49:37 -0500
Received: from waste.org ([216.27.176.166]:9185 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262069AbVAOAtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:49:12 -0500
Date: Fri, 14 Jan 2005 18:49:06 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3.563253706@selenic.com>
Message-Id: <4.563253706@selenic.com>
Subject: [PATCH 3/10] random pt2: combine legacy ioctls
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ZAPENTCNT is now effectively identical to RNDCLEARPOOL, fall through

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-12 21:28:00.196490892 -0800
+++ rnd/drivers/char/random.c	2005-01-12 21:28:01.110374382 -0800
@@ -1748,10 +1748,6 @@
 			wake_up_interruptible(&random_read_wait);
 		return 0;
 	case RNDZAPENTCNT:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
-		random_state->entropy_count = 0;
-		return 0;
 	case RNDCLEARPOOL:
 		/* Clear the entropy pool counters. */
 		if (!capable(CAP_SYS_ADMIN))
