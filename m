Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTDXXlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264497AbTDXXiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:38:16 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:3751 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264498AbTDXXeG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:34:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512280511698@kroah.com>
Subject: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <20030424234614.GA29734@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:31 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1110.2.1, 2003/04/18 16:11:42-07:00, david-b@pacbell.net

[PATCH] USB: fix for deadlock in v2.5.67

The patch below should resolve the keyboard problem -- just reorders two
lines so the lock isn't held after the device's records get deleted, so
the order is what it should always have been.


 drivers/usb/core/hcd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	Thu Apr 24 16:29:16 2003
+++ b/drivers/usb/core/hcd.c	Thu Apr 24 16:29:16 2003
@@ -961,8 +961,8 @@
 	spin_lock_irqsave (&hcd_data_lock, flags);
 	list_del_init (&urb->urb_list);
 	dev = urb->dev;
-	usb_put_dev (dev);
 	spin_unlock_irqrestore (&hcd_data_lock, flags);
+	usb_put_dev (dev);
 }
 
 

