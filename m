Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTLDWaE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 17:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTLDWaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 17:30:04 -0500
Received: from mail.kroah.org ([65.200.24.183]:59095 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263620AbTLDW37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 17:29:59 -0500
Date: Thu, 4 Dec 2003 14:28:26 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [PATCH] i2c driver fix for 2.6.0-test11
Message-ID: <20031204222826.GB2541@kroah.com>
References: <20031204222752.GA2541@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031204222752.GA2541@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1505, 2003/12/04 14:14:33-08:00, khali@linux-fr.org

[PATCH] I2C: fix i2c_smbus_write_byte() for i2c-nforce2

This patch fixes i2c_smbus_write_byte() being broken for i2c-nforce2.
This causes trouble when that module is used together with eeprom (which
is also in 2.6). We have had three user reports about the problem.

Credits go to Mark D. Studebaker for finding and fixing the problem.


 drivers/i2c/busses/i2c-nforce2.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	Thu Dec  4 14:22:52 2003
+++ b/drivers/i2c/busses/i2c-nforce2.c	Thu Dec  4 14:22:52 2003
@@ -147,7 +147,7 @@
 
 		case I2C_SMBUS_BYTE:
 			if (read_write == I2C_SMBUS_WRITE)
-				outb_p(data->byte, NVIDIA_SMB_DATA);
+				outb_p(command, NVIDIA_SMB_CMD);
 			protocol |= NVIDIA_SMB_PRTCL_BYTE;
 			break;
 
