Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265845AbTL3WQj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265849AbTL3WPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:15:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:55745 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265845AbTL3WGi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:06:38 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.0
In-Reply-To: <10728219701447@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Dec 2003 14:06:10 -0800
Message-Id: <1072821970466@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496.20.2, 2003/12/19 10:47:09-08:00, mds@paradyne.com

[PATCH] I2C: fix amd756 byte writes

This fixes byte writes (used by the eeprom driver) in the i2c-amd756
driver.  It is similar to recent fixes for the i2c-amd8111 and
i2c-nforce2 drivers.

Tested by me.


 drivers/i2c/busses/i2c-amd756.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	Tue Dec 30 12:29:49 2003
+++ b/drivers/i2c/busses/i2c-amd756.c	Tue Dec 30 12:29:49 2003
@@ -213,9 +213,8 @@
 	case I2C_SMBUS_BYTE:
 		outw_p(((addr & 0x7f) << 1) | (read_write & 0x01),
 		       SMB_HOST_ADDRESS);
-		/* TODO: Why only during write? */
 		if (read_write == I2C_SMBUS_WRITE)
-			outb_p(command, SMB_HOST_COMMAND);
+			outb_p(command, SMB_HOST_DATA);
 		size = AMD756_BYTE;
 		break;
 	case I2C_SMBUS_BYTE_DATA:

