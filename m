Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbTL3WMw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbTL3WK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:10:29 -0500
Received: from mail.kroah.org ([65.200.24.183]:59329 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265831AbTL3WGm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:06:42 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.0
In-Reply-To: <10728219692713@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Dec 2003 14:06:10 -0800
Message-Id: <10728219701447@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496.20.1, 2003/12/17 15:44:31-08:00, khali@linux-fr.org

[PATCH] I2C: fix i2c-amd8111 driver.

This patch fixes i2c_smbus_write_byte() being broken for i2c-amd8111.
This causes trouble when that module is used together with eeprom (which
is also in 2.6). We have had no report so far, but the problem is
similar to the one addressed by a recent patch to i2c-nforce2.

Credits go to Hans-Frieder Vogt for finding and fixing the problem. Mark
D. Studebaker found and fixed the original problem in i2c-nforce2.

This is a serious bug fix, and I believe you shouldn't wait too long
before applying it.


 drivers/i2c/busses/i2c-amd8111.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	Tue Dec 30 12:31:03 2003
+++ b/drivers/i2c/busses/i2c-amd8111.c	Tue Dec 30 12:31:03 2003
@@ -192,7 +192,7 @@
 
 		case I2C_SMBUS_BYTE:
 			if (read_write == I2C_SMBUS_WRITE)
-				amd_ec_write(smbus, AMD_SMB_DATA, data->byte);
+				amd_ec_write(smbus, AMD_SMB_CMD, command);
 			protocol |= AMD_SMB_PRTCL_BYTE;
 			break;
 

