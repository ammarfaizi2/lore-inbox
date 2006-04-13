Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWDMXR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWDMXR3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWDMXRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:17:10 -0400
Received: from cantor.suse.de ([195.135.220.2]:28101 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932477AbWDMXIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:08:15 -0400
Date: Thu, 13 Apr 2006 16:07:14 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 04/22] isd200: limit to BLK_DEV_IDE
Message-ID: <20060413230714.GE5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="isd200-limit-to-blk_dev_ide.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Randy Dunlap <rdunlap@xenotime.net>

Limit USB_STORAGE_ISD200 to whatever BLK_DEV_IDE and USB_STORAGE
are set to (y, m) since isd200 calls ide_fix_driveid() in the
BLK_DEV_IDE code.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/storage/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.16.5.orig/drivers/usb/storage/Kconfig
+++ linux-2.6.16.5/drivers/usb/storage/Kconfig
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
