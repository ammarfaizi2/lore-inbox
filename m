Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbTHKQOK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267274AbTHKQBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:01:45 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:13606 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272765AbTHKP7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:59:41 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missing copy_from_user check in munich driver
Message-Id: <E19mF4Z-0005F1-00@tetrachloride>
Date: Mon, 11 Aug 2003 16:59:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/wan/comx-hw-munich.c linux-2.5/drivers/net/wan/comx-hw-munich.c
--- bk-linus/drivers/net/wan/comx-hw-munich.c	2003-05-23 12:11:56.000000000 +0100
+++ linux-2.5/drivers/net/wan/comx-hw-munich.c	2003-07-13 06:04:34.000000000 +0100
@@ -2414,7 +2414,10 @@ static int munich_write_proc(struct file
 	return -ENOMEM;
 
     /* Copy user data and cut trailing \n */
-    copy_from_user(page, buffer, count = min(count, PAGE_SIZE));
+    if (copy_from_user(page, buffer, count = min(count, PAGE_SIZE))) {
+	    free_page((unsigned long)page);
+	    return -EFAULT;
+    }
     if (*(page + count - 1) == '\n')
 	*(page + count - 1) = 0;
     *(page + PAGE_SIZE - 1) = 0;
