Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267510AbUHWTsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267510AbUHWTsB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267526AbUHWTqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:46:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:52163 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266864AbUHWSg0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:26 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286083943@kroah.com>
Date: Mon, 23 Aug 2004 11:34:43 -0700
Message-Id: <1093286083141@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.54.1, 2004/08/02 16:05:14-07:00, nacc@us.ibm.com

[PATCH] I2C: i2c-keywest: replace schedule_timeout() with msleep()

Uses msleep() instead of schedule_timeout() to guarantee
the task delays at least the desired time amount.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-keywest.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-keywest.c b/drivers/i2c/busses/i2c-keywest.c
--- a/drivers/i2c/busses/i2c-keywest.c	2004-08-23 11:07:42 -07:00
+++ b/drivers/i2c/busses/i2c-keywest.c	2004-08-23 11:07:42 -07:00
@@ -662,8 +662,7 @@
 	spin_lock_irq(&iface->lock);
 	while (iface->state != state_idle) {
 		spin_unlock_irq(&iface->lock);
-		set_task_state(current,TASK_UNINTERRUPTIBLE);
-		schedule_timeout(HZ/10);
+		msleep(100);
 		spin_lock_irq(&iface->lock);
 	}
 #endif /* POLLED_MODE */

