Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266910AbUHWTai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266910AbUHWTai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUHWT1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:27:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:59587 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266910AbUHWSgi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:38 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860823806@kroah.com>
Date: Mon, 23 Aug 2004 11:34:42 -0700
Message-Id: <1093286082426@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1790.2.10, 2004/08/02 15:36:27-07:00, nacc@us.ibm.com

[PATCH] PCI Hotplug: shpchp_hpc: replace schedule_timeout() with msleep()

Uses msleep() instead of schedule_timeout() to guarantee
the task delays the desired time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/shpchp_hpc.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
--- a/drivers/pci/hotplug/shpchp_hpc.c	2004-08-23 11:07:59 -07:00
+++ b/drivers/pci/hotplug/shpchp_hpc.c	2004-08-23 11:07:59 -07:00
@@ -300,8 +300,7 @@
 		if (!(cmd_status & 0x1))
 			break;
 		/*  Check every 0.1 sec for a total of 1 sec*/
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ/10);
+		msleep(100);
 	}
 
 	cmd_status = readw(php_ctlr->creg + CMD_STATUS);

