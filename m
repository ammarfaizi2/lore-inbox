Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267274AbTHKQ25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTHKQBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:01:41 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:13350 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272756AbTHKP7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:59:41 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [PATCH] Missing spin_unlock_irqrestore from rrunner driver.
Message-Id: <E19mF4Z-0005Ep-00@tetrachloride>
Date: Mon, 11 Aug 2003 16:59:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/rrunner.c linux-2.5/drivers/net/rrunner.c
--- bk-linus/drivers/net/rrunner.c	2003-08-04 01:00:27.000000000 +0100
+++ linux-2.5/drivers/net/rrunner.c	2003-08-06 18:59:37.000000000 +0100
@@ -1645,6 +1645,7 @@ static int rr_ioctl(struct net_device *d
 			printk(KERN_ERR "%s: Error reading EEPROM\n",
 			       dev->name);
 			error = -EFAULT;
+			spin_unlock_irqrestore(&rrpriv->lock, flags);
 			goto gf_out;
 		}
 		spin_unlock_irqrestore(&rrpriv->lock, flags);
