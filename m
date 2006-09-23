Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWIWA3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWIWA3f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 20:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWIWA3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 20:29:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:14735 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964970AbWIWA3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 20:29:34 -0400
Date: Sat, 23 Sep 2006 01:29:34 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: gregkh@ftp.linux.org.uk
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] fallout from hcd-core patch
Message-ID: <20060923002934.GD29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

missing le16_to_cpu()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/input/hid-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
index a2c56b2..3305fb6 100644
--- a/drivers/usb/input/hid-core.c
+++ b/drivers/usb/input/hid-core.c
@@ -1818,7 +1818,7 @@ static struct hid_device *usb_hid_config
 	int n, len, insize = 0;
 
         /* Ignore all Wacom devices */
-        if (dev->descriptor.idVendor == USB_VENDOR_ID_WACOM)
+        if (le16_to_cpu(dev->descriptor.idVendor) == USB_VENDOR_ID_WACOM)
                 return NULL;
 
 	for (n = 0; hid_blacklist[n].idVendor; n++)
-- 
1.4.2.GIT
