Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262944AbVAKXYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbVAKXYL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262899AbVAKXWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:22:37 -0500
Received: from coderock.org ([193.77.147.115]:13509 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262917AbVAKXRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:17:48 -0500
Subject: [patch 2/3] ide/ide-cs: replace schedule_timeout() with msleep()
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       domen@coderock.org, nacc@us.ibm.com, janitor@sternwelten.at
From: domen@coderock.org
Date: Wed, 12 Jan 2005 00:17:40 +0100
Message-Id: <20050111231740.738FE1F226@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Uses msleep() in place of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/ide/legacy/ide-cs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/ide/legacy/ide-cs.c~msleep-drivers_ide_ide-cs drivers/ide/legacy/ide-cs.c
--- kj/drivers/ide/legacy/ide-cs.c~msleep-drivers_ide_ide-cs	2005-01-10 17:59:50.000000000 +0100
+++ kj-domen/drivers/ide/legacy/ide-cs.c	2005-01-10 17:59:50.000000000 +0100
@@ -43,6 +43,7 @@
 #include <linux/ide.h>
 #include <linux/hdreg.h>
 #include <linux/major.h>
+#include <linux/delay.h>
 #include <asm/io.h>
 #include <asm/system.h>
 
@@ -357,8 +358,7 @@ void ide_config(dev_link_t *link)
 		break;
 	    }
 	}
-	__set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ/10);
+	msleep(100);
     }
 
     if (hd < 0) {
_
