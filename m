Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVIDXgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVIDXgP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVIDXes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:34:48 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:57729 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932146AbVIDXbI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:31:08 -0400
Message-Id: <20050904232336.944205000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:52 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Philipp Hahn <pmhahn@titan.lahn.de>
Content-Disposition: inline; filename=dvb-saa7146-i2c-sysfs-fix.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 53/54] saa7146: i2c vs. sysfs fix
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>

Integrate saa7146_i2c adapter into device model:
Moves entries from /sys/device/platform to /sys/device/pci*.

Signed-off-by: Philipp Hahn <pmhahn@titan.lahn.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/common/saa7146_i2c.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.13-git4.orig/drivers/media/common/saa7146_i2c.c	2005-09-04 22:27:49.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/common/saa7146_i2c.c	2005-09-04 22:31:04.000000000 +0200
@@ -405,6 +405,7 @@ int saa7146_i2c_adapter_prepare(struct s
 	if( NULL != i2c_adapter ) {
 		BUG_ON(!i2c_adapter->class);
 		i2c_set_adapdata(i2c_adapter,dev);
+		i2c_adapter->dev.parent    = &dev->pci->dev;
 		i2c_adapter->algo	   = &saa7146_algo;
 		i2c_adapter->algo_data     = NULL;
 		i2c_adapter->id		   = I2C_ALGO_SAA7146;

--

