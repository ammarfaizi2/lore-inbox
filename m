Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVCaXln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVCaXln (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVCaXkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:40:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:38624 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262116AbVCaXYL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:11 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Fix Vaio EEPROM detection
In-Reply-To: <111231139374@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:13 -0800
Message-Id: <1112311393634@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2339, 2005/03/31 14:29:23-08:00, khali@linux-fr.org

[PATCH] I2C: Fix Vaio EEPROM detection

This fixes a bug in the eeprom driver, which made all EEPROMs at
location 0x57 be erroneously treated as Vaio EEPROMs. I have to say I'm
quite ashamed that I introduced the bug in the first place, as this was
a really stupid one.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/eeprom.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	2005-03-31 15:17:18 -08:00
+++ b/drivers/i2c/chips/eeprom.c	2005-03-31 15:17:18 -08:00
@@ -210,10 +210,11 @@
 		if (i2c_smbus_read_byte_data(new_client, 0x80) == 'P'
 		 && i2c_smbus_read_byte(new_client) == 'C'
 		 && i2c_smbus_read_byte(new_client) == 'G'
-		 && i2c_smbus_read_byte(new_client) == '-')
+		 && i2c_smbus_read_byte(new_client) == '-') {
 			dev_info(&new_client->dev, "Vaio EEPROM detected, "
 				"enabling password protection\n");
 			data->nature = VAIO;
+		}
 	}
 
 	/* create the sysfs eeprom file */

