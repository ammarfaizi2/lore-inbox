Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161243AbWALUeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161243AbWALUeX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161245AbWALUeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:34:23 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:34056 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1161243AbWALUeW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:34:22 -0500
Date: Thu, 12 Jan 2006 21:34:37 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Subject: [PATCH] Fix zoran_card compilation warning
Message-Id: <20060112213437.3eb3f370.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ronald, all,

Fix the following warning which was introduced in 2.6.15-git8 by
commit 7408187d223f63d46a13b6a35b8f96b032c2f623:

  CC [M]  drivers/media/video/zoran_card.o
drivers/media/video/zoran_card.c: In function `zr36057_init':
drivers/media/video/zoran_card.c:1053: warning: assignment makes integer from pointer without a cast

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/media/video/zoran_card.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.15-git.orig/drivers/media/video/zoran_card.c	2006-01-12 20:34:54.000000000 +0100
+++ linux-2.6.15-git/drivers/media/video/zoran_card.c	2006-01-12 20:47:26.000000000 +0100
@@ -995,7 +995,7 @@
 static int __devinit
 zr36057_init (struct zoran *zr)
 {
-	unsigned long mem;
+	u32 *mem;
 	void *vdev;
 	unsigned mem_needed;
 	int j;
@@ -1058,10 +1058,10 @@
 			"%s: zr36057_init() - kmalloc (STAT_COM) failed\n",
 			ZR_DEVNAME(zr));
 		kfree(vdev);
-		kfree((void *)mem);
+		kfree(mem);
 		return -ENOMEM;
 	}
-	zr->stat_com = (u32 *) mem;
+	zr->stat_com = mem;
 	for (j = 0; j < BUZ_NUM_STAT_COM; j++) {
 		zr->stat_com[j] = 1;	/* mark as unavailable to zr36057 */
 	}


-- 
Jean Delvare
