Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWDLQ6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWDLQ6X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 12:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWDLQ6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 12:58:23 -0400
Received: from smtp.ocgnet.org ([68.93.27.132]:27102 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S932208AbWDLQ6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 12:58:22 -0400
From: "amatus@ocgnet.org" <amatus@ocgnet.org>
Date: Wed, 12 Apr 2006 11:58:21 -0500
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] m41t00: fix bitmasks when writing to chip
Message-ID: <20060412165821.GA3025@login.ocgnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Barksdale <amatus@ocgnet.org>

This patch fixes the bitmasks used when writing to the M41T00 registers.
The origional code used a mask of 0x7f when writing to each register,
this is incorrect and probably the result of a copy-paste error. As a
result years from 1980 to 1999 will be read back as 2000 to 2019.

Signed-off-by: David Barksdale <amatus@ocgnet.org>

---

The following patch is against the 2.6.16.4 linux kernel

--- linux-2.6.16.4/drivers/i2c/chips/m41t00.c.orig	2006-04-12 11:28:04.740793700 -0500
+++ linux-2.6.16.4/drivers/i2c/chips/m41t00.c	2006-04-12 11:29:58.093959100 -0500
@@ -129,13 +129,13 @@ m41t00_set_tlet(ulong arg)
 	if ((i2c_smbus_write_byte_data(save_client, 0, tm.tm_sec & 0x7f) < 0)
 		|| (i2c_smbus_write_byte_data(save_client, 1, tm.tm_min & 0x7f)
 			< 0)
-		|| (i2c_smbus_write_byte_data(save_client, 2, tm.tm_hour & 0x7f)
+		|| (i2c_smbus_write_byte_data(save_client, 2, tm.tm_hour & 0x3f)
 			< 0)
-		|| (i2c_smbus_write_byte_data(save_client, 4, tm.tm_mday & 0x7f)
+		|| (i2c_smbus_write_byte_data(save_client, 4, tm.tm_mday & 0x3f)
 			< 0)
-		|| (i2c_smbus_write_byte_data(save_client, 5, tm.tm_mon & 0x7f)
+		|| (i2c_smbus_write_byte_data(save_client, 5, tm.tm_mon & 0x1f)
 			< 0)
-		|| (i2c_smbus_write_byte_data(save_client, 6, tm.tm_year & 0x7f)
+		|| (i2c_smbus_write_byte_data(save_client, 6, tm.tm_year & 0xff)
 			< 0))
 
 		dev_warn(&save_client->dev,"m41t00: can't write to rtc chip\n");
