Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272767AbTHKQED (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272756AbTHKQCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:02:31 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:15910 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272781AbTHKP7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:59:42 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missing copy_from_user check in mixcom driver.
Message-Id: <E19mF4Z-0005Ey-00@tetrachloride>
Date: Mon, 11 Aug 2003 16:59:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/wan/comx-hw-mixcom.c linux-2.5/drivers/net/wan/comx-hw-mixcom.c
--- bk-linus/drivers/net/wan/comx-hw-mixcom.c	2003-05-20 18:41:21.000000000 +0100
+++ linux-2.5/drivers/net/wan/comx-hw-mixcom.c	2003-07-13 06:04:34.000000000 +0100
@@ -763,7 +763,10 @@ static int mixcom_write_proc(struct file
 		return -ENOMEM;
 	}
 
-	copy_from_user(page, buffer, count = min_t(unsigned long, count, PAGE_SIZE));
+	if (copy_from_user(page, buffer, count = min_t(unsigned long, count, PAGE_SIZE))) {
+		free_page((unsigned long)page);
+		return -EFAULT;
+	}
 	if (*(page + count - 1) == '\n') {
 		*(page + count - 1) = 0;
 	}
