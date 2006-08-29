Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965227AbWH2SKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbWH2SKp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWH2SKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:10:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57316 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965220AbWH2SGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:06:35 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 18/19] BLOCK: Make USB storage depend on SCSI rather than selecting it [try #6]
Date: Tue, 29 Aug 2006 19:06:31 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060829180631.32596.69574.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
References: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

This makes CONFIG_USB_STORAGE depend on CONFIG_SCSI rather than selecting it,
as selecting it makes CONFIG_USB_STORAGE override the dependencies of SCSI,
causing it to turn on even if they aren't all met.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 drivers/usb/storage/Kconfig |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/storage/Kconfig b/drivers/usb/storage/Kconfig
index be9eec2..5f720d7 100644
--- a/drivers/usb/storage/Kconfig
+++ b/drivers/usb/storage/Kconfig
@@ -8,8 +8,7 @@ comment "may also be needed; see USB_STO
 
 config USB_STORAGE
 	tristate "USB Mass Storage support"
-	depends on USB
-	select SCSI
+	depends on USB && SCSI
 	---help---
 	  Say Y here if you want to connect USB mass storage devices to your
 	  computer's USB port. This is the driver you need for USB
@@ -18,7 +17,7 @@ config USB_STORAGE
 	  similar devices. This driver may also be used for some cameras
 	  and card readers.
 
-	  This option 'selects' (turns on, enables) 'SCSI', but you
+	  This option depends on 'SCSI' support being enabled, but you
 	  probably also need 'SCSI device support: SCSI disk support'
 	  (BLK_DEV_SD) for most USB storage devices.
 
