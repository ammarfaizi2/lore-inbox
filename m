Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWFWGBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWFWGBp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 02:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWFWGBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 02:01:45 -0400
Received: from cantor2.suse.de ([195.135.220.15]:59287 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932361AbWFWGBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 02:01:44 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: linux-usb-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 1/2] [PATCH] USB: get USB suspend to work again
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 22 Jun 2006 22:58:34 -0700
Message-Id: <11510423151128-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <20060623055737.GA29631@kroah.com>
References: <20060623055737.GA29631@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Yeah, it's a hack, but it is only temporary until Alan's patches
reworking this area make it in.  We really should not care what devices
below us are doing, especially when we do not really know what type of
devices they are.  This patch relies on the fact that the endpoint
devices do not have a driver assigned to us.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/core/usb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 5153107..fb488c8 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -991,6 +991,8 @@ void usb_buffer_unmap_sg (struct usb_dev
 
 static int verify_suspended(struct device *dev, void *unused)
 {
+	if (dev->driver == NULL)
+		return 0;
 	return (dev->power.power_state.event == PM_EVENT_ON) ? -EBUSY : 0;
 }
 
-- 
1.4.0

