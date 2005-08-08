Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVHHWfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVHHWfx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbVHHWf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:35:28 -0400
Received: from coderock.org ([193.77.147.115]:39555 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S932309AbVHHWbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:31:08 -0400
Message-Id: <20050808223035.187646000@homer>
References: <20050808222936.090422000@homer>
Date: Tue, 09 Aug 2005 00:29:48 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Maximilian Attems <janitor@sternwelten.at>, domen@coderock.org
Subject: [patch 12/16] ide/ide-cs: replace schedule_timeout() with msleep()
Content-Disposition: inline; filename=msleep-drivers_ide_ide-cs.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Uses msleep() in place of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 ide-cs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: quilt/drivers/ide/legacy/ide-cs.c
===================================================================
--- quilt.orig/drivers/ide/legacy/ide-cs.c
+++ quilt/drivers/ide/legacy/ide-cs.c
@@ -43,6 +43,7 @@
 #include <linux/ide.h>
 #include <linux/hdreg.h>
 #include <linux/major.h>
+#include <linux/delay.h>
 #include <asm/io.h>
 #include <asm/system.h>
 
@@ -340,8 +341,7 @@ static void ide_config(dev_link_t *link)
 		break;
 	    }
 	}
-	__set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ/10);
+	msleep(100);
     }
 
     if (hd < 0) {

--
