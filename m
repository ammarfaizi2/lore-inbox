Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbTHKQOI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbTHKQBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:01:53 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:14374 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272767AbTHKP7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:59:42 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [PATCH] missing copy_to_user check in tun driver.
Message-Id: <E19mF4Z-0005Es-00@tetrachloride>
Date: Mon, 11 Aug 2003 16:59:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/tun.c linux-2.5/drivers/net/tun.c
--- bk-linus/drivers/net/tun.c	2003-06-17 00:23:21.000000000 +0100
+++ linux-2.5/drivers/net/tun.c	2003-06-25 12:26:54.000000000 +0100
@@ -459,7 +459,8 @@ static int tun_chr_ioctl(struct inode *i
 		if (err)
 			return err;
 
-		copy_to_user((void *)arg, &ifr, sizeof(ifr));
+		if (copy_to_user((void *)arg, &ifr, sizeof(ifr)))
+			return -EFAULT;
 		return 0;
 	}
 
