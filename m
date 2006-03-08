Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWCHWkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWCHWkv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWCHWkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:40:51 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59405 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750808AbWCHWku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:40:50 -0500
Date: Wed, 8 Mar 2006 23:40:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jean Delvare <khali@linux-fr.org>, Jamey Hicks <jamey.hicks@hp.com>,
       Andrew Zabolotny <zap@homelink.ru>, LKML <linux-kernel@vger.kernel.org>
Subject: [2.6 patch] Fix error handling in backlight drivers
Message-ID: <20060308224048.GS4006@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

I have spotted the following problem in the way the backlight and lcd
drivers handle out-of-memory errors. This should probably be fixed for
2.6.16. Note that I don't have supported hardware so I couldn't
actually test the fix.


ERR_PTR() is supposed to be passed a negative value.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- 

This patch was sent by Jean Delvare on:
- 5 Mar 2006

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


