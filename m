Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUKIFyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUKIFyt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbUKIFxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:53:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:6303 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261394AbUKIFZD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:25:03 -0500
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
In-Reply-To: <10999778552805@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 8 Nov 2004 21:24:15 -0800
Message-Id: <10999778551027@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2014.1.6, 2004/11/05 13:41:16-08:00, johnpol@2ka.mipt.ru

[PATCH] w1/w1_int: replace schedule_timeout() with msleep_interruptible()

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1_int.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)


diff -Nru a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c	2004-11-08 18:55:59 -08:00
+++ b/drivers/w1/w1_int.c	2004-11-08 18:55:59 -08:00
@@ -184,10 +184,8 @@
 	while (atomic_read(&dev->refcnt)) {
 		printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
 				dev->name, atomic_read(&dev->refcnt));
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ);
 
-		if (signal_pending(current))
+		if (msleep_interruptible(1000))
 			flush_signals(current);
 	}
 

