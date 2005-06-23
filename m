Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVFWGOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVFWGOP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVFWGMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:12:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:134 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262224AbVFWGKg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:10:36 -0400
Cc: stelian@popies.net
Subject: [PATCH] USB: fix hid core to return proper error code from probe
In-Reply-To: <20050623060933.GA11578@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 22 Jun 2005 23:10:30 -0700
Message-Id: <11195070302202@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] USB: fix hid core to return proper error code from probe

Drivers need to return -ENODEV when they can't bind to a device.
Anything else stops the "bind a device to a driver" search.

From: Stelian Pop <stelian@popies.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 479f6ea85e513551510ad52f37e69e1c596ad356
tree 60eadfd85297f42be75be8863cacbc0ea9d82f3b
parent b7c84c6ada2be942eca6722edb2cfaad412cd5de
author Stelian Pop <stelian@popies.net> Wed, 22 Jun 2005 17:53:28 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 22 Jun 2005 23:01:09 -0700

 drivers/usb/input/hid-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c
+++ b/drivers/usb/input/hid-core.c
@@ -1762,7 +1762,7 @@ static int hid_probe(struct usb_interfac
 			intf->altsetting->desc.bInterfaceNumber);
 
 	if (!(hid = usb_hid_configure(intf)))
-		return -EIO;
+		return -ENODEV;
 
 	hid_init_reports(hid);
 	hid_dump_device(hid);
@@ -1777,7 +1777,7 @@ static int hid_probe(struct usb_interfac
 	if (!hid->claimed) {
 		printk ("HID device not claimed by input or hiddev\n");
 		hid_disconnect(intf);
-		return -EIO;
+		return -ENODEV;
 	}
 
 	printk(KERN_INFO);

