Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269898AbUJSXHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269898AbUJSXHT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269819AbUJSXHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:07:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:63625 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270086AbUJSWqX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:23 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257383944@kroah.com>
Date: Tue, 19 Oct 2004 15:42:18 -0700
Message-Id: <1098225738124@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.50, 2004/10/06 13:45:22-07:00, nacc@us.ibm.com

[PATCH] pci hotplug/cpqphp: replace schedule_timeout() with msleep_interruptible()

Use msleep_interruptible() instead of schedule_timeout() to guarantee
the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/cpqphp.h |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/pci/hotplug/cpqphp.h b/drivers/pci/hotplug/cpqphp.h
--- a/drivers/pci/hotplug/cpqphp.h	2004-10-19 15:23:06 -07:00
+++ b/drivers/pci/hotplug/cpqphp.h	2004-10-19 15:23:06 -07:00
@@ -707,9 +707,8 @@
 
 	dbg("%s - start\n", __FUNCTION__);
 	add_wait_queue(&ctrl->queue, &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
 	/* Sleep for up to 1 second to wait for the LED to change. */
-	schedule_timeout(1*HZ);
+	msleep_interruptible(1000);
 	remove_wait_queue(&ctrl->queue, &wait);
 	if (signal_pending(current))
 		retval =  -EINTR;

