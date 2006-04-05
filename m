Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWDETBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWDETBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 15:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWDETBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 15:01:33 -0400
Received: from xenotime.net ([66.160.160.81]:53433 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751122AbWDETBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 15:01:33 -0400
Date: Wed, 5 Apr 2006 12:03:45 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: stable@kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] isd200: limit to BLK_DEV_IDE
Message-Id: <20060405120345.6ad380de.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Randy Dunlap <rdunlap@xenotime.net>

Limit USB_STORAGE_ISD200 to whatever BLK_DEV_IDE and USB_STORAGE
are set to (y, m) since isd200 calls ide_fix_driveid() in the
BLK_DEV_IDE code.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/usb/storage/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2616-z.orig/drivers/usb/storage/Kconfig
+++ linux-2616-z/drivers/usb/storage/Kconfig
@@ -48,7 +48,8 @@ config USB_STORAGE_FREECOM

 config USB_STORAGE_ISD200
 	bool "ISD-200 USB/ATA Bridge support"
-	depends on USB_STORAGE && BLK_DEV_IDE
+	depends on USB_STORAGE
+	depends on BLK_DEV_IDE=y || BLK_DEV_IDE=USB_STORAGE
 	---help---
 	  Say Y here if you want to use USB Mass Store devices based
 	  on the In-Systems Design ISD-200 USB/ATA bridge.


---
