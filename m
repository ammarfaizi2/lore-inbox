Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVLPTKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVLPTKQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVLPTJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:09:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:65430 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932345AbVLPTJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:09:44 -0500
Date: Fri, 16 Dec 2005 11:08:43 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, mgreer@mvista.com,
       khali@linux-fr.org
Subject: [patch 1/4] i2c: Fix i2c-mv64xxx compilation error
Message-ID: <20051216190843.GB4594@kroah.com>
References: <20051216185442.633779000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="i2c-mv64xxx-compilation-error-fix.patch"
In-Reply-To: <20051216190828.GA4594@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mark A. Greer" <mgreer@mvista.com>

The busses/i2c-mv64xxx.c driver doesn't currently compile because of an
incorrect argument to dev_err().  This patch fixes that.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/i2c/busses/i2c-mv64xxx.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- gregkh-2.6.orig/drivers/i2c/busses/i2c-mv64xxx.c
+++ gregkh-2.6/drivers/i2c/busses/i2c-mv64xxx.c
@@ -529,14 +529,15 @@ mv64xxx_i2c_probe(struct platform_device
 	i2c_set_adapdata(&drv_data->adapter, drv_data);
 
 	if (request_irq(drv_data->irq, mv64xxx_i2c_intr, 0,
-		MV64XXX_I2C_CTLR_NAME, drv_data)) {
-
-		dev_err(dev, "mv64xxx: Can't register intr handler "
-			"irq: %d\n", drv_data->irq);
+			MV64XXX_I2C_CTLR_NAME, drv_data)) {
+		dev_err(&drv_data->adapter.dev,
+			"mv64xxx: Can't register intr handler irq: %d\n",
+			drv_data->irq);
 		rc = -EINVAL;
 		goto exit_unmap_regs;
 	} else if ((rc = i2c_add_adapter(&drv_data->adapter)) != 0) {
-		dev_err(dev, "mv64xxx: Can't add i2c adapter, rc: %d\n", -rc);
+		dev_err(&drv_data->adapter.dev,
+			"mv64xxx: Can't add i2c adapter, rc: %d\n", -rc);
 		goto exit_free_irq;
 	}
 

--
