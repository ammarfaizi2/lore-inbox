Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTECNdP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 09:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263314AbTECNdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 09:33:14 -0400
Received: from [203.145.184.221] ([203.145.184.221]:60433 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263311AbTECNdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 09:33:13 -0400
Subject: [PATCH 2.{4,5}.x] mod_timer conversions for mptctl.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: davej@codemonkey.org.uk
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 May 2003 19:20:24 +0530
Message-Id: <1051969824.1243.101.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Trivial {del,add}_timer to mod_timer conversions.

vinay

--- linux-2.5.68/drivers/message/fusion/mptctl.c	2003-03-25 10:07:57.000000000 +0530
+++ linux-2.5.68-nvk/drivers/message/fusion/mptctl.c	2003-05-03 15:50:42.000000000 +0530
@@ -269,11 +269,8 @@
 			 */
 			iocStatus = reply->u.reply.IOCStatus & MPI_IOCSTATUS_MASK;
 			if (iocStatus == MPI_IOCSTATUS_SCSI_TASK_MGMT_FAILED) {
-				if (ioc->ioctl->status & MPT_IOCTL_STATUS_TIMER_ACTIVE) {
-					del_timer (&ioc->ioctl->timer);
-					ioc->ioctl->timer.expires = jiffies + HZ;
-					add_timer(&ioc->ioctl->timer);
-				}
+				if (ioc->ioctl->status & MPT_IOCTL_STATUS_TIMER_ACTIVE)
+					mod_timer(&ioc->ioctl->timer, jiffies + HZ);
 			}
 			ioc->ioctl->tmPtr = NULL;
 



