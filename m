Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVCYWUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVCYWUD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVCYWRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:17:47 -0500
Received: from mail.dif.dk ([193.138.115.101]:18872 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261830AbVCYWQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:16:23 -0500
Date: Fri, 25 Mar 2005 23:18:16 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Axis Communications AB <jffs-dev@axis.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] get rid of redundant checks for NULL before kfree() in
 fs/jffs/
Message-ID: <Pine.LNX.4.62.0503252315480.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's no need to check for NULL before calling kfree().

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm3-orig/fs/jffs/intrep.c	2005-03-21 23:12:41.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/jffs/intrep.c	2005-03-25 22:47:29.000000000 +0100
@@ -1693,9 +1693,7 @@ jffs_find_child(struct jffs_file *dir, c
 		}
 		printk("jffs_find_child(): Didn't find the file \"%s\".\n",
 		       (copy ? copy : ""));
-		if (copy) {
-			kfree(copy);
-		}
+		kfree(copy);
 	});
 
 	return f;


