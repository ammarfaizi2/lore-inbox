Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263327AbTECOeP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 10:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263328AbTECOeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 10:34:15 -0400
Received: from [203.145.184.221] ([203.145.184.221]:12818 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263327AbTECOeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 10:34:14 -0400
Subject: [PATCH 2.{4,5}.x] mod_timer fix for sdla_x25.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: eis@baty.hanse.de
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 May 2003 20:21:16 +0530
Message-Id: <1051973476.1243.167.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sdla_x25.c: trivial {del,add}_timer to mod_timer conversion.

--- linux-2.5.68/drivers/net/wan/sdla_x25.c	2003-03-25 10:07:27.000000000 +0530
+++ linux-2.5.68-nvk/drivers/net/wan/sdla_x25.c	2003-05-03 16:02:35.000000000 +0530
@@ -1224,9 +1224,7 @@
 			connect(card);
 			S508_S514_unlock(card, &smp_flags);
 
-			del_timer(&card->u.x.x25_timer);
-			card->u.x.x25_timer.expires=jiffies+HZ;
-			add_timer(&card->u.x.x25_timer);
+			mod_timer(&card->u.x.x25_timer, jiffies + HZ);
 		}
 	}
 	/* Device is not up until the we are in connected state */



