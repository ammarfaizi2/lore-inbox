Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbVKQSEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbVKQSEn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVKQSEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:04:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:37794 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932497AbVKQSEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:04:24 -0500
Date: Thu, 17 Nov 2005 09:48:01 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       dsd@gentoo.org, mdharm-usb@one-eyed-alien.net, pfavr@how.dk
Subject: [patch 15/22] usb-storage: Fix detection of kodak flash readers in shuttle_usbat driver
Message-ID: <20051117174801.GT11174@kroah.com>
References: <20051117174227.007572000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-storage-fix-detection-of-kodak-flash-readers-in-shuttle_usbat-driver.patch"
In-Reply-To: <20051117174609.GA11174@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Drake <dsd@gentoo.org>

Peter Favrholdt reported that his Kodak flash device was getting
detected as a CDROM, and he helped me track this down to the fact that
the device takes a long time (approx 440ms!) to reset.

This patch increases the delay to 500ms, which solves the problem.

Signed-off-by: Daniel Drake <dsd@gentoo.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/usb/storage/shuttle_usbat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- usb-2.6.orig/drivers/usb/storage/shuttle_usbat.c
+++ usb-2.6/drivers/usb/storage/shuttle_usbat.c
@@ -853,7 +853,7 @@ static int usbat_identify_device(struct 
 	rc = usbat_device_reset(us);
 	if (rc != USB_STOR_TRANSPORT_GOOD)
 		return rc;
-	msleep(25);
+	msleep(500);
 
 	/*
 	 * In attempt to distinguish between HP CDRW's and Flash readers, we now

--
