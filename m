Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266054AbTHKQBh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTHKQBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:01:36 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:14118 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272752AbTHKP7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:59:41 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Missing copy_from_user check in comx driver
Message-Id: <E19mF4Z-0005Ev-00@tetrachloride>
Date: Mon, 11 Aug 2003 16:59:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/wan/comx-hw-locomx.c linux-2.5/drivers/net/wan/comx-hw-locomx.c
--- bk-linus/drivers/net/wan/comx-hw-locomx.c	2003-05-20 18:41:21.000000000 +0100
+++ linux-2.5/drivers/net/wan/comx-hw-locomx.c	2003-07-13 06:04:34.000000000 +0100
@@ -339,7 +339,10 @@ static int locomx_write_proc(struct file
 		return -ENOMEM;
 	}
 
-	copy_from_user(page, buffer, count = min_t(unsigned long, count, PAGE_SIZE));
+	if (copy_from_user(page, buffer, count = min_t(unsigned long, count, PAGE_SIZE))) {
+		free_page((unsigned long)page);
+		return -EBADF;
+	}
 	if (*(page + count - 1) == '\n') {
 		*(page + count - 1) = 0;
 	}
