Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270178AbUJSXW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270178AbUJSXW6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270206AbUJSXVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:21:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:21386 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270170AbUJSWql convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:41 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <1098225738411@kroah.com>
Date: Tue, 19 Oct 2004 15:42:18 -0700
Message-Id: <1098225738989@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.48, 2004/10/06 13:44:26-07:00, nacc@us.ibm.com

[PATCH] pci hotplug/shpchp: replace schedule_timeout() with msleep_interruptible()

Use msleep_interruptible() instead of schedule_timeout() to guarantee
the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/shpchp.h |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)


diff -Nru a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
--- a/drivers/pci/hotplug/shpchp.h	2004-10-19 15:23:17 -07:00
+++ b/drivers/pci/hotplug/shpchp.h	2004-10-19 15:23:17 -07:00
@@ -31,6 +31,7 @@
 
 #include <linux/types.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
 #include <asm/semaphore.h>
 #include <asm/io.h>		
 #include "pci_hotplug.h"
@@ -381,16 +382,14 @@
 	dbg("%s : start\n",__FUNCTION__);
 
 	add_wait_queue(&ctrl->queue, &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
 
 	if (!shpchp_poll_mode) {
 		/* Sleep for up to 1 second */
-		schedule_timeout(1*HZ);
+		msleep_interruptible(1000);
 	} else {
 		/* Sleep for up to 2 seconds */
-		schedule_timeout(2*HZ);
+		msleep_interruptible(2000);
 	}
-	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&ctrl->queue, &wait);
 	if (signal_pending(current))
 		retval =  -EINTR;

