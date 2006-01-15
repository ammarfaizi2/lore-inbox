Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWAOU0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWAOU0H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWAOU0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:26:06 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:31245 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932080AbWAOU0E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:26:04 -0500
Date: Sun, 15 Jan 2006 21:26:37 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: LKML <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com,
       Russell King <rmk+kernel@arm.linux.org.uk>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] Fix warning in dvb-btxx driver
Message-Id: <20060115212637.23fda216.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro, all,

Fix the following warning I am seeing in 2.6.15-git11, which seems
to have been introduced by commit 348290a4ae143a692124330942b464ccdb0d0365:

  CC [M]  drivers/media/dvb/bt8xx/dvb-bt8xx.o
drivers/media/dvb/bt8xx/dvb-bt8xx.c:923: warning: initialization from incompatible pointer type

It would have also been possible to keep "void" as the return type and
change the function itself instead, but given that the driver core's
.remove method returns an int, my guess is that we want the same here.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/media/video/bttv.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15-git.orig/drivers/media/video/bttv.h	2006-01-15 10:49:37.000000000 +0100
+++ linux-2.6.15-git/drivers/media/video/bttv.h	2006-01-15 20:47:24.000000000 +0100
@@ -366,7 +366,7 @@
 	struct device_driver   drv;
 	char                   wanted[BUS_ID_SIZE];
 	int                    (*probe)(struct bttv_sub_device *sub);
-	void                   (*remove)(struct bttv_sub_device *sub);
+	int                    (*remove)(struct bttv_sub_device *sub);
 	void                   (*gpio_irq)(struct bttv_sub_device *sub);
 };
 #define to_bttv_sub_drv(x) container_of((x), struct bttv_sub_driver, drv)


-- 
Jean Delvare
