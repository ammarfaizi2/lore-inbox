Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbTLKBcm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbTLKBbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:31:19 -0500
Received: from mail.kroah.org ([65.200.24.183]:61391 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264332AbTLKBaV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:30:21 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10711061451940@kroah.com>
Subject: Re: [PATCH] USB Fixes for 2.6.0-test11
In-Reply-To: <10711061451952@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 10 Dec 2003 17:29:05 -0800
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1518, 2003/12/08 13:58:14-08:00, greg@kroah.com

[PATCH] USB: fix race with hub devices disconnecting while stuff is still happening to them.


 drivers/usb/core/hub.c |    3 +++
 1 files changed, 3 insertions(+)


diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c	Wed Dec 10 16:47:50 2003
+++ b/drivers/usb/core/hub.c	Wed Dec 10 16:47:50 2003
@@ -692,6 +692,9 @@
 	struct usb_hub *hub = usb_get_intfdata(dev->actconfig->interface[0]);
 	int ret;
 
+	if (!hub)
+		return -ENODEV;
+
 	ret = get_port_status(dev, port + 1, &hub->status->port);
 	if (ret < 0)
 		dev_err (hubdev (dev),

