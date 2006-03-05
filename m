Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWCESHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWCESHk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 13:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWCESHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 13:07:40 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:3852 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750770AbWCESHj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 13:07:39 -0500
Date: Sun, 5 Mar 2006 19:08:49 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Jamey Hicks <jamey.hicks@hp.com>, Andrew Zabolotny <zap@homelink.ru>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix error handling in backlight drivers
Message-Id: <20060305190849.03877211.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jamey, Andrew,

I have spotted the following problem in the way the backlight and lcd
drivers handle out-of-memory errors. This should probably be fixed for
2.6.16. Note that I don't have supported hardware so I couldn't
actually test the fix.

* * * * *

ERR_PTR() is supposed to be passed a negative value.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/video/backlight/backlight.c |    2 +-
 drivers/video/backlight/lcd.c       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16-rc5.orig/drivers/video/backlight/backlight.c	2006-02-13 19:22:18.000000000 +0100
+++ linux-2.6.16-rc5/drivers/video/backlight/backlight.c	2006-03-05 18:39:58.000000000 +0100
@@ -172,7 +172,7 @@
 
 	new_bd = kmalloc(sizeof(struct backlight_device), GFP_KERNEL);
 	if (unlikely(!new_bd))
-		return ERR_PTR(ENOMEM);
+		return ERR_PTR(-ENOMEM);
 
 	init_MUTEX(&new_bd->sem);
 	new_bd->props = bp;
--- linux-2.6.16-rc5.orig/drivers/video/backlight/lcd.c	2006-02-13 19:22:18.000000000 +0100
+++ linux-2.6.16-rc5/drivers/video/backlight/lcd.c	2006-03-05 18:39:54.000000000 +0100
@@ -171,7 +171,7 @@
 
 	new_ld = kmalloc(sizeof(struct lcd_device), GFP_KERNEL);
 	if (unlikely(!new_ld))
-		return ERR_PTR(ENOMEM);
+		return ERR_PTR(-ENOMEM);
 
 	init_MUTEX(&new_ld->sem);
 	new_ld->props = lp;


-- 
Jean Delvare
