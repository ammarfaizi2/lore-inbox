Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272780AbTHKQOJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbTHKQBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:01:49 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:13862 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272773AbTHKP7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:59:42 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missing copy_from_user check in comx-proto-fr driver
Message-Id: <E19mF4Z-0005F4-00@tetrachloride>
Date: Mon, 11 Aug 2003 16:59:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/wan/comx-proto-fr.c linux-2.5/drivers/net/wan/comx-proto-fr.c
--- bk-linus/drivers/net/wan/comx-proto-fr.c	2003-05-20 18:41:21.000000000 +0100
+++ linux-2.5/drivers/net/wan/comx-proto-fr.c	2003-07-13 06:04:34.000000000 +0100
@@ -657,7 +657,10 @@ static int fr_write_proc(struct file *fi
 		return -ENOMEM;
 	}
 
-	copy_from_user(page, buffer, count);
+	if (copy_from_user(page, buffer, count)) {
+		free_page((unsigned long)page);
+		return -EFAULT;
+	}
 	if (*(page + count - 1) == '\n') {
 		*(page + count - 1) = 0;
 	}
