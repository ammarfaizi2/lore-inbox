Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbVKQSMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbVKQSMf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbVKQSMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:12:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:17826 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932499AbVKQSEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:04:08 -0500
Date: Thu, 17 Nov 2005 09:47:28 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       david-b@pacbell.net
Subject: [patch 11/22] USB: onetouch doesn't suspend yet
Message-ID: <20051117174728.GL11174@kroah.com>
References: <20051117174227.007572000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-onetouch-doesn-t-suspend-yet.patch"
In-Reply-To: <20051117174609.GA11174@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

The onetouch support doesn't suspend correctly (leaves an interrupt
URB posted, instead of unlinking it) so for now just disable it
when PM is in the air.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/storage/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- usb-2.6.orig/drivers/usb/storage/Kconfig
+++ usb-2.6/drivers/usb/storage/Kconfig
@@ -115,7 +115,7 @@ config USB_STORAGE_JUMPSHOT
 
 config USB_STORAGE_ONETOUCH
 	bool "Support OneTouch Button on Maxtor Hard Drives (EXPERIMENTAL)"
-	depends on USB_STORAGE && INPUT_EVDEV && EXPERIMENTAL
+	depends on USB_STORAGE && INPUT_EVDEV && EXPERIMENTAL && !PM
 	help
 	  Say Y here to include additional code to support the Maxtor OneTouch
 	  USB hard drive's onetouch button.

--
