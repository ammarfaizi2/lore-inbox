Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266753AbUIXCJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266753AbUIXCJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266741AbUIWUk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:40:28 -0400
Received: from baikonur.stro.at ([213.239.196.228]:51613 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266578AbUIWUZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:15 -0400
Subject: [patch 08/26]  char/ip2main: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:15 +0200
Message-ID: <E1CAa9U-000837-56@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. 

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/ip2main.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/char/ip2main.c~msleep_interruptible-drivers_char_ip2main drivers/char/ip2main.c
--- linux-2.6.9-rc2-bk7/drivers/char/ip2main.c~msleep_interruptible-drivers_char_ip2main	2004-09-21 21:08:08.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/ip2main.c	2004-09-21 21:08:08.000000000 +0200
@@ -1632,8 +1632,7 @@ ip2_close( PTTY tty, struct file *pFile 
 
 	if (pCh->wopen) {
 		if (pCh->ClosingDelay) {
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(pCh->ClosingDelay);
+			msleep_interruptible(jiffies_to_msecs(pCh->ClosingDelay));
 		}
 		wake_up_interruptible(&pCh->open_wait);
 	}
_
