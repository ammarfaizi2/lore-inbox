Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWIUHpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWIUHpq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 03:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWIUHpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 03:45:46 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:38323 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750955AbWIUHpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 03:45:46 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Alessandro Zummo <a.zummo@towertech.it>
Subject: [RTC] Remove superfluous call to call to cdev_del()
Date: Thu, 21 Sep 2006 09:46:06 +0200
User-Agent: KMail/1.9.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609210946.06924.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If cdev_add() fails there is no good reason to call cdev_del().

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

---
commit 7d8c15d5af591c6039a4bba6ab20e4952ed11c1f
tree 8849441bf17c6c8145f09123a320c34572746c7c
parent 10e3d9d489c71aaf7ff86c81178ae5aeefe1ad6f
author Rolf Eike Beer <eike-kernel@sf-tec.de> Thu, 21 Sep 2006 09:42:49 +0200
committer Rolf Eike Beer <eike-kernel@sf-tec.de> Thu, 21 Sep 2006 09:42:49 +0200

 drivers/rtc/rtc-dev.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-dev.c b/drivers/rtc/rtc-dev.c
index 61a5825..062c0ab 100644
--- a/drivers/rtc/rtc-dev.c
+++ b/drivers/rtc/rtc-dev.c
@@ -406,7 +406,6 @@ #endif
 	rtc->char_dev.owner = rtc->owner;
 
 	if (cdev_add(&rtc->char_dev, MKDEV(MAJOR(rtc_devt), rtc->id), 1)) {
-		cdev_del(&rtc->char_dev);
 		dev_err(class_dev->dev,
 			"failed to add char device %d:%d\n",
 			MAJOR(rtc_devt), rtc->id);
