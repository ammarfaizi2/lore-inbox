Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbTDQFyE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 01:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbTDQFv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 01:51:57 -0400
Received: from granite.he.net ([216.218.226.66]:52496 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263077AbTDQFu5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 01:50:57 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10505595042978@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.67
In-Reply-To: <10505595042504@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 16 Apr 2003 23:05:04 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1057, 2003/04/14 10:18:56-07:00, greg@kroah.com

[PATCH] USB: add better check to prevent oops in hcd_unlink_urb()


diff -Nru a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	Wed Apr 16 10:49:27 2003
+++ b/drivers/usb/core/hcd.c	Wed Apr 16 10:49:27 2003
@@ -1229,7 +1229,7 @@
 	spin_unlock (&hcd_data_lock);
 	spin_unlock_irqrestore (&urb->lock, flags);
 bye:
-	if (retval && sys)
+	if (retval && sys && sys->driver)
 		dev_dbg (sys, "hcd_unlink_urb %p fail %d\n", urb, retval);
 	return retval;
 }

