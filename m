Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262595AbVCaXyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbVCaXyx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbVCaXyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:54:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:47584 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262545AbVCaXYP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:15 -0500
Cc: mgreer@mvista.com
Subject: [PATCH] i2c: i2c-mv64xxx - set adapter owner and class fields
In-Reply-To: <1112311396681@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:16 -0800
Message-Id: <11123113962602@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2351, 2005/03/31 14:33:14-08:00, mgreer@mvista.com

[PATCH] i2c: i2c-mv64xxx - set adapter owner and class fields

This patch adds the correct values for the 'owner' and 'class' fields of
the adapter structure in the mv64xxx i2c bus driver.  The missing class
field caused some i2c chip drivers to refuse to attempt a probe on the
mv64xxx i2c bus.

Signed-off-by: Chris Elston <chris.elston@radstone.co.uk>
Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/busses/i2c-mv64xxx.c |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
--- a/drivers/i2c/busses/i2c-mv64xxx.c	2005-03-31 15:15:49 -08:00
+++ b/drivers/i2c/busses/i2c-mv64xxx.c	2005-03-31 15:15:49 -08:00
@@ -525,6 +525,8 @@
 	drv_data->irq = platform_get_irq(pd, 0);
 	drv_data->adapter.id = I2C_ALGO_MV64XXX | I2C_HW_MV64XXX;
 	drv_data->adapter.algo = &mv64xxx_i2c_algo;
+	drv_data->adapter.owner = THIS_MODULE;
+	drv_data->adapter.class = I2C_CLASS_HWMON;
 	drv_data->adapter.timeout = pdata->timeout;
 	drv_data->adapter.retries = pdata->retries;
 	dev_set_drvdata(dev, drv_data);

