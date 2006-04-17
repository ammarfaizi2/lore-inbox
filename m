Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWDQVfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWDQVfi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 17:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWDQVe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 17:34:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:60129 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751326AbWDQVe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 17:34:57 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@xenotime.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 1/5] isd200: limit to BLK_DEV_IDE
Reply-To: Greg KH <greg@kroah.com>
Date: Mon, 17 Apr 2006 14:33:35 -0700
Message-Id: <11453096194144-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.3.0.rc4.ge6bf
In-Reply-To: <20060417212946.GA3118@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Limit USB_STORAGE_ISD200 to whatever BLK_DEV_IDE and USB_STORAGE
are set to (y, m) since isd200 calls ide_fix_driveid() in the
BLK_DEV_IDE code.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/usb/storage/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

66e0a9888b774af625ce544f7c6597c7506d07db
diff --git a/drivers/usb/storage/Kconfig b/drivers/usb/storage/Kconfig
index 92be101..be9eec2 100644
--- a/drivers/usb/storage/Kconfig
+++ b/drivers/usb/storage/Kconfig
@@ -48,7 +48,8 @@ config USB_STORAGE_FREECOM
 
 config USB_STORAGE_ISD200
 	bool "ISD-200 USB/ATA Bridge support"
-	depends on USB_STORAGE && BLK_DEV_IDE
+	depends on USB_STORAGE
+	depends on BLK_DEV_IDE=y || BLK_DEV_IDE=USB_STORAGE
 	---help---
 	  Say Y here if you want to use USB Mass Store devices based
 	  on the In-Systems Design ISD-200 USB/ATA bridge.
-- 
1.2.6

