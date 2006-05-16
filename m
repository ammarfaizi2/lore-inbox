Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWEPVnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWEPVnM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWEPVnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:43:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:31918 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932181AbWEPVkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:40:42 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 04/10] SPI: spi bounce buffer has a minimum length
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 16 May 2006 14:38:32 -0700
Message-Id: <1147815518897-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.3.2
In-Reply-To: <11478155181381-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

Make sure that spi_write_then_read() can always handle at least 32 bytes
of transfer (total, both directions), minimizing one portability issue.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/spi/spi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

a9948b6194b46e489aa3b4d111d6dfd786c39c4b
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 94f5e8e..1168ef0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -522,7 +522,8 @@ int spi_sync(struct spi_device *spi, str
 }
 EXPORT_SYMBOL_GPL(spi_sync);
 
-#define	SPI_BUFSIZ	(SMP_CACHE_BYTES)
+/* portable code must never pass more than 32 bytes */
+#define	SPI_BUFSIZ	max(32,SMP_CACHE_BYTES)
 
 static u8	*buf;
 
-- 
1.3.2

