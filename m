Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbULAASY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbULAASY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbULAAR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:17:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:48868 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261254AbULAAOY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:14:24 -0500
Subject: [PATCH] I2C fixes for 2.6.10-rc2
In-Reply-To: <20041201001245.GA27535@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Nov 2004 16:13:38 -0800
Message-Id: <11018600181498@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2223.2.1, 2004/11/24 14:24:06-08:00, khali@linux-fr.org

[PATCH] I2C: More verbose w83l785ts driver

This simple patch increases the verbosity of the w83l785ts hardware
monitoring driver. I wrote it months ago in the hope it would help solve
a reported problem [1]. Not sure whether it did (no news from user since
July), but the extra debug info may help in the future and doesn't hurt
otherwise, so let's have this in for every user (not that many AFAIK),
just in case.


[1] http://bugzilla.kernel.org/show_bug.cgi?id=2899

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/w83l785ts.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/w83l785ts.c b/drivers/i2c/chips/w83l785ts.c
--- a/drivers/i2c/chips/w83l785ts.c	2004-11-30 16:01:27 -08:00
+++ b/drivers/i2c/chips/w83l785ts.c	2004-11-30 16:01:27 -08:00
@@ -280,14 +280,17 @@
 	 * default value requested by the caller. */
 	for (i = 1; i <= MAX_RETRIES; i++) {
 		value = i2c_smbus_read_byte_data(client, reg);
-		if (value >= 0)
+		if (value >= 0) {
+			dev_dbg(&client->dev, "Read 0x%02x from register "
+				"0x%02x.\n", value, reg);
 			return value;
+		}
 		dev_dbg(&client->dev, "Read failed, will retry in %d.\n", i);
 		msleep(i);
 	}
 
-	dev_err(&client->dev, "Couldn't read value from register. "
-		"Please report.\n");
+	dev_err(&client->dev, "Couldn't read value from register 0x%02x. "
+		"Please report.\n", reg);
 	return defval;
 }
 

