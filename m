Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264101AbUE1WIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264101AbUE1WIi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbUE1WH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:07:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:35262 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264101AbUE1WBb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 18:01:31 -0400
Subject: Re: [PATCH] I2C update for 2.6.7-rc1
In-Reply-To: <1085781643100@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 28 May 2004 15:00:43 -0700
Message-Id: <10857816433297@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1717.6.24, 2004/05/19 00:25:14-07:00, khali@linux-fr.org

[PATCH] I2C: Incomplete AT24RF08 corruption prevention in i2c eeprom

The AT24RF08 corruption prevention trick that is found in the i2c eeprom
driver is not correct. The prevention is activated only conditionally,
while it should be done all the time.


 drivers/i2c/chips/eeprom.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	Fri May 28 14:52:32 2004
+++ b/drivers/i2c/chips/eeprom.c	Fri May 28 14:52:32 2004
@@ -203,11 +203,12 @@
 	new_client->driver = &eeprom_driver;
 	new_client->flags = 0;
 
+	/* prevent 24RF08 corruption */
+	i2c_smbus_write_quick(new_client, 0);
+
 	/* Now, we do the remaining detection. It is not there, unless you force
 	   the checksum to work out. */
 	if (checksum) {
-		/* prevent 24RF08 corruption */
-		i2c_smbus_write_quick(new_client, 0);
 		cs = 0;
 		for (i = 0; i <= 0x3e; i++)
 			cs += i2c_smbus_read_byte_data(new_client, i);

