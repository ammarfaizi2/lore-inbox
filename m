Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVAGB2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVAGB2J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 20:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVAGBIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 20:08:36 -0500
Received: from mail.dif.dk ([193.138.115.101]:57023 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261237AbVAGBHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 20:07:11 -0500
Date: Fri, 7 Jan 2005 02:18:34 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2/4] let's kill verify_area - convert kernel/signal.c to
 access_ok()
Message-ID: <Pine.LNX.4.61.0501070151100.3430@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a patch to convert verify_area to access_ok in kernel/signal.c


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-bk9-orig/kernel/signal.c linux-2.6.10-bk9/kernel/signal.c
--- linux-2.6.10-bk9-orig/kernel/signal.c	2005-01-06 22:19:19.000000000 +0100
+++ linux-2.6.10-bk9/kernel/signal.c	2005-01-07 02:02:55.000000000 +0100
@@ -2435,7 +2435,7 @@ do_sigaltstack (const stack_t __user *us
 		int ss_flags;
 
 		error = -EFAULT;
-		if (verify_area(VERIFY_READ, uss, sizeof(*uss))
+		if (!access_ok(VERIFY_READ, uss, sizeof(*uss))
 		    || __get_user(ss_sp, &uss->ss_sp)
 		    || __get_user(ss_flags, &uss->ss_flags)
 		    || __get_user(ss_size, &uss->ss_size))






