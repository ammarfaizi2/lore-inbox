Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVAGBls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVAGBls (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 20:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVAGBkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 20:40:31 -0500
Received: from mail.dif.dk ([193.138.115.101]:60351 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261252AbVAGBHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 20:07:31 -0500
Date: Fri, 7 Jan 2005 02:18:55 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][4/4] let's kill verify_area - convert kernel/printk.c to
 access_ok()
Message-ID: <Pine.LNX.4.61.0501070207460.3430@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a patch to convert verify_area to access_ok in kernel/printk.c


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-bk9-orig/kernel/printk.c linux-2.6.10-bk9/kernel/printk.c
--- linux-2.6.10-bk9-orig/kernel/printk.c	2004-12-24 22:35:40.000000000 +0100
+++ linux-2.6.10-bk9/kernel/printk.c	2005-01-07 02:11:16.000000000 +0100
@@ -269,8 +269,8 @@ int do_syslog(int type, char __user * bu
 		error = 0;
 		if (!len)
 			goto out;
-		error = verify_area(VERIFY_WRITE,buf,len);
-		if (error)
+		error = access_ok(VERIFY_WRITE,buf,len);
+		if (!error)
 			goto out;
 		error = wait_event_interruptible(log_wait, (log_start - log_end));
 		if (error)
@@ -300,8 +300,8 @@ int do_syslog(int type, char __user * bu
 		error = 0;
 		if (!len)
 			goto out;
-		error = verify_area(VERIFY_WRITE,buf,len);
-		if (error)
+		error = access_ok(VERIFY_WRITE,buf,len);
+		if (!error)
 			goto out;
 		count = len;
 		if (count > log_buf_len)



