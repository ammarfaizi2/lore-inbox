Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270107AbUJSXWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270107AbUJSXWz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270209AbUJSXVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:21:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:20362 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270168AbUJSWql convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:41 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <1098225738124@kroah.com>
Date: Tue, 19 Oct 2004 15:42:18 -0700
Message-Id: <10982257383185@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.51, 2004/10/06 13:45:48-07:00, nacc@us.ibm.com

[PATCH] pci hotplug/cpqphp_ctrl: replace schedule_timeout() with msleep_interruptible()

Use msleep_interruptible() instead of schedule_timeout() to guarantee
the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/cpqphp_ctrl.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)


diff -Nru a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
--- a/drivers/pci/hotplug/cpqphp_ctrl.c	2004-10-19 15:23:01 -07:00
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c	2004-10-19 15:23:01 -07:00
@@ -69,10 +69,8 @@
 	init_waitqueue_head(&delay_wait);
 
 	add_wait_queue(&delay_wait, &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(delay);
+	msleep_interruptible(jiffies_to_msecs(delay));
 	remove_wait_queue(&delay_wait, &wait);
-	set_current_state(TASK_RUNNING);
 	
 	up(&delay_sem);
 }

