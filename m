Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267599AbUIAXVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267599AbUIAXVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268073AbUIAXSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:18:41 -0400
Received: from baikonur.stro.at ([213.239.196.228]:14046 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S268028AbUIAXQX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:16:23 -0400
Subject: [patch 08/14]  radio/miropcm20-rds: replace 	schedule_timeout() with msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Thu, 02 Sep 2004 01:16:22 +0200
Message-ID: <E1C2eL0-0002p7-SN@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list.

Thanks,
Nish



Description: Uses msleep() instead of schedule_timeout() so the task
is guaranteed to delay the desired time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/media/radio/miropcm20-rds.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/media/radio/miropcm20-rds.c~msleep-drivers_media_radio-miropcm20-rds drivers/media/radio/miropcm20-rds.c
--- linux-2.6.9-rc1-bk7/drivers/media/radio/miropcm20-rds.c~msleep-drivers_media_radio-miropcm20-rds	2004-09-01 19:35:12.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/media/radio/miropcm20-rds.c	2004-09-01 19:35:12.000000000 +0200
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/delay.h>
 #include <asm/uaccess.h>
 #include "miropcm20-rds-core.h"
 
@@ -60,8 +61,7 @@ static ssize_t rds_f_read(struct file *f
 	char c;
 	char bits[8];
 
-	current->state=TASK_UNINTERRUPTIBLE;
-	schedule_timeout(2*HZ);
+	msleep(2000);
 	aci_rds_cmd(RDS_STATUS, &c, 1);
 	print_matrix(&c, bits);
 	if (copy_to_user(buffer, bits, 8))

_
