Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267455AbUHWTWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267455AbUHWTWM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267451AbUHWTVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:21:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:1476 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267219AbUHWSgr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:47 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286083974@kroah.com>
Date: Mon, 23 Aug 2004 11:34:43 -0700
Message-Id: <1093286083943@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1790.2.13, 2004/08/02 16:28:17-07:00, nacc@us.ibm.com

[PATCH] PCI: replace schedule_timeout() with msleep()

Use msleep() instead of schedule_timeout() to guarantee
the task delays for the desired time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)


diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	2004-08-23 11:06:51 -07:00
+++ b/drivers/pci/pci.c	2004-08-23 11:06:51 -07:00
@@ -291,10 +291,7 @@
 	/* Mandatory power management transition delays */
 	/* see PCI PM 1.1 5.6.1 table 18 */
 	if(state == 3 || dev->current_state == 3)
-	{
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(HZ/100);
-	}
+		msleep(10);
 	else if(state == 2 || dev->current_state == 2)
 		udelay(200);
 	dev->current_state = state;

