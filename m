Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVCaXck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVCaXck (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVCaXcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:32:01 -0500
Received: from mail.kroah.org ([69.55.234.183]:27872 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262071AbVCaXYG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:06 -0500
Cc: mgreer@mvista.com
Subject: [PATCH] I2C: Fix breakage in m41t00 i2c rtc driver
In-Reply-To: <11123113922923@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:12 -0800
Message-Id: <11123113924150@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2334, 2005/03/31 14:09:00-08:00, mgreer@mvista.com

[PATCH] I2C: Fix breakage in m41t00 i2c rtc driver

Remove setting of deleted i2c_client structure member.

The latest include/linux/i2c.h:i2c_client structure no longer has an
'id' member.  This patch removes the setting of that no longer existing
member.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/m41t00.c |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/drivers/i2c/chips/m41t00.c b/drivers/i2c/chips/m41t00.c
--- a/drivers/i2c/chips/m41t00.c	2005-03-31 15:17:53 -08:00
+++ b/drivers/i2c/chips/m41t00.c	2005-03-31 15:17:53 -08:00
@@ -184,7 +184,6 @@
 
 	memset(client, 0, sizeof(struct i2c_client));
 	strncpy(client->name, M41T00_DRV_NAME, I2C_NAME_SIZE);
-	client->id = m41t00_driver.id;
 	client->flags = I2C_DF_NOTIFY;
 	client->addr = addr;
 	client->adapter = adap;

