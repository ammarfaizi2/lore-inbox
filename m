Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbTLKBcl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264333AbTLKBbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:31:31 -0500
Received: from mail.kroah.org ([65.200.24.183]:62671 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264334AbTLKBaY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:30:24 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10711061451952@kroah.com>
Subject: Re: [PATCH] USB Fixes for 2.6.0-test11
In-Reply-To: <10711061453801@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 10 Dec 2003 17:29:05 -0800
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1517, 2003/12/08 13:28:46-08:00, david-b@pacbell.net

[PATCH] USB: fix remove device after set_configuration

If a device can't be configured, the current test9 code forgets
to clean it out of sysfs.  This resolves that issue, so the retry
in usb_new_device() stands a chance of working.

The enumeration code still doesn't handle such errors well, but
at least this way that hub port can be used for another device.


 drivers/usb/core/usb.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	Wed Dec 10 16:47:58 2003
+++ b/drivers/usb/core/usb.c	Wed Dec 10 16:47:58 2003
@@ -1120,6 +1120,7 @@
 	if (err) {
 		dev_err(&dev->dev, "can't set config #%d, error %d\n",
 			dev->config[0].desc.bConfigurationValue, err);
+		device_del(&dev->dev);
 		goto fail;
 	}
 

