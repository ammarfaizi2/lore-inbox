Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbUE1V0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUE1V0w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUE1V0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:26:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:18093 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261745AbUE1V0l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:26:41 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core fixes for 2.6.7-rc1
In-Reply-To: <10857795552653@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 28 May 2004 14:25:55 -0700
Message-Id: <10857795552130@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1717.7.6, 2004/05/28 10:05:31-07:00, greg@kroah.com

[PATCH] Report which device failed to suspend

Based on a patch from Nickolai Zeldovich <kolya@MIT.EDU> but put into the
proper place by me.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/power/suspend.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)


diff -Nru a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
--- a/drivers/base/power/suspend.c	Fri May 28 14:18:03 2004
+++ b/drivers/base/power/suspend.c	Fri May 28 14:18:03 2004
@@ -39,6 +39,8 @@
 {
 	int error = 0;
 
+	dev_dbg(dev, "suspending\n");
+
 	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
 		error = dev->bus->suspend(dev,state);
 
@@ -82,8 +84,11 @@
 		} else if (error == -EAGAIN) {
 			list_del(&dev->power.entry);
 			list_add(&dev->power.entry,&dpm_off_irq);
-		} else
+		} else {
+			printk(KERN_ERR "Could not suspend device %s: "
+				"error %d\n", kobject_name(&dev->kobj), error);
 			goto Error;
+		}
 	}
  Done:
 	up(&dpm_sem);

