Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131594AbQKNXQf>; Tue, 14 Nov 2000 18:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131610AbQKNXQ3>; Tue, 14 Nov 2000 18:16:29 -0500
Received: from [213.8.185.152] ([213.8.185.152]:6665 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S131594AbQKNXQH>;
	Tue, 14 Nov 2000 18:16:07 -0500
Date: Wed, 15 Nov 2000 00:45:36 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: test11-pre5
In-Reply-To: <Pine.LNX.4.10.10011141346480.15149-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0011150030030.26513-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


against: test11-pre5
summery: dev_3c501.name shouldn't be NULL, or we get oops
reason: Correct me if I'm wrong, but 3c501.c:init_module() calls
net_init.c:register_netdev(&dev_3c501), which calls strchr(),
{and might also,which might} dereference dev_3c501.name.

--- linux/drivers/net/3c501.c	Wed Nov 15 00:30:40 2000
+++ linux/drivers/net/3c501.c	Wed Nov 15 00:31:44 2000
@@ -915,6 +915,7 @@
 #ifdef MODULE
 
 static struct net_device dev_3c501 = {
+	name:		"",
 	init:		el1_probe,
 	base_addr:	0x280,
 	irq:		5,


-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
