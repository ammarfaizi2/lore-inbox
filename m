Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267493AbUHWTjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267493AbUHWTjS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266876AbUHWTiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:38:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:52675 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266871AbUHWSg2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:28 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286084674@kroah.com>
Date: Mon, 23 Aug 2004 11:34:44 -0700
Message-Id: <1093286084472@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.54.7, 2004/08/02 16:11:06-07:00, nacc@us.ibm.com

[PATCH] I2C: i2c-nforce2: replace schedule_timeout() with msleep()

Uses msleep() instead of schedule_timeout() to guarantee
the task delays at least the desired time amount.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-nforce2.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	2004-08-23 11:07:08 -07:00
+++ b/drivers/i2c/busses/i2c-nforce2.c	2004-08-23 11:07:08 -07:00
@@ -244,8 +244,7 @@
 		temp = inb_p(NVIDIA_SMB_STS);
 	}
 	if (~temp & NVIDIA_SMB_STS_DONE) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(HZ/100);
+		msleep(10);
 		temp = inb_p(NVIDIA_SMB_STS);
 	}
 

