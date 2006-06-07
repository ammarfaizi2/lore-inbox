Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWFGS0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWFGS0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 14:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWFGS0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 14:26:19 -0400
Received: from mail.sanpeople.com ([196.41.13.122]:35848 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP
	id S1750824AbWFGS0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 14:26:18 -0400
Subject: [PATCH] RTC: Ensure that time being passed to set_alarm() is valid.
From: Andrew Victor <andrew@sanpeople.com>
To: linux-kernel@vger.kernel.org
Cc: alessandro.zummo@towertech.it, akpm@osdl.org
Content-Type: text/plain
Organization: SAN People (Pty) Ltd
Message-Id: <1149704455.20386.90.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Jun 2006 20:20:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RTC: Ensure that the time being passed to set_alarm() is valid.


Signed-off-by: Andrew Victor <andrew@sanpeople.com>
Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>


diff -urN -x CVS linux-2.6.17-rc6/drivers/rtc/interface.c
linux-2.6.17-rc/drivers/rtc/interface.c
--- linux-2.6.17-rc6/drivers/rtc/interface.c	Tue Jun  6 10:28:05 2006
+++ linux-2.6.17-rc/drivers/rtc/interface.c	Wed Jun  7 11:46:28 2006
@@ -129,6 +129,10 @@
 	int err;
 	struct rtc_device *rtc = to_rtc_device(class_dev);
 
+	err = rtc_valid_tm(&alarm->time);
+	if (err != 0)
+		return err;
+
 	err = mutex_lock_interruptible(&rtc->ops_lock);
 	if (err)
 		return -EBUSY;



