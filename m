Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUCZABl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263816AbUCYX70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 18:59:26 -0500
Received: from waste.org ([209.173.204.2]:48793 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263817AbUCYX6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:58:00 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8.524465763@selenic.com>
Message-Id: <9.524465763@selenic.com>
Subject: [PATCH 8/22] /dev/random: BUG on premature random users
Date: Thu, 25 Mar 2004 17:57:43 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/random  BUG on premature random users

Generate a fatal error if we try to use the get_random_bytes before
we're initialized.


 tiny-mpm/drivers/char/random.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff -puN drivers/char/random.c~bug-on-grb drivers/char/random.c
--- tiny/drivers/char/random.c~bug-on-grb	2004-03-20 13:38:22.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:38:22.000000000 -0600
@@ -1412,13 +1412,8 @@ static ssize_t extract_entropy(struct en
  */
 void get_random_bytes(void *buf, int nbytes)
 {
-	if (blocking_pool)
-		extract_entropy(blocking_pool, buf, nbytes, 0);
-	else if (input_pool)
-		extract_entropy(input_pool, buf, nbytes, 0);
-	else
-		printk(KERN_NOTICE "get_random_bytes called before "
-				   "random driver initialization\n");
+	BUG_ON(!blocking_pool);
+	extract_entropy(blocking_pool, buf, nbytes, 0);
 }
 
 EXPORT_SYMBOL(get_random_bytes);

_
