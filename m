Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTI3Wr2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbTI3Wr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:47:28 -0400
Received: from mail.kroah.org ([65.200.24.183]:34779 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261820AbTI3WrV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:47:21 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10649613503520@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test6
In-Reply-To: <10649613502758@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Sep 2003 15:35:50 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1349, 2003/09/29 12:48:49-07:00, adobriyan@mail.ru

[PATCH] PCI: Remove setting TASK_RUNNING after schedule_timeout in /drivers/pci/


 drivers/pci/hotplug/cpqphp.h |    1 -
 drivers/pci/pool.c           |    1 -
 2 files changed, 2 deletions(-)


diff -Nru a/drivers/pci/hotplug/cpqphp.h b/drivers/pci/hotplug/cpqphp.h
--- a/drivers/pci/hotplug/cpqphp.h	Tue Sep 30 15:20:28 2003
+++ b/drivers/pci/hotplug/cpqphp.h	Tue Sep 30 15:20:28 2003
@@ -766,7 +766,6 @@
 	set_current_state(TASK_INTERRUPTIBLE);
 	/* Sleep for up to 1 second to wait for the LED to change. */
 	schedule_timeout(1*HZ);
-	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&ctrl->queue, &wait);
 	if (signal_pending(current))
 		retval =  -EINTR;
diff -Nru a/drivers/pci/pool.c b/drivers/pci/pool.c
--- a/drivers/pci/pool.c	Tue Sep 30 15:20:28 2003
+++ b/drivers/pci/pool.c	Tue Sep 30 15:20:28 2003
@@ -296,7 +296,6 @@
 
 			schedule_timeout (POOL_TIMEOUT_JIFFIES);
 
-			current->state = TASK_RUNNING;
 			remove_wait_queue (&pool->waitq, &wait);
 			goto restart;
 		}

