Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263083AbVCDWMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263083AbVCDWMI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbVCDWL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:11:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:55457 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263144AbVCDUyY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:24 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] Add class definition to the elektor bus driver
In-Reply-To: <110996859785@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:37 -0800
Message-Id: <11099685973185@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2111, 2005/03/02 15:03:15-08:00, khali@linux-fr.org

[PATCH] Add class definition to the elektor bus driver

Hi Frank, all,

> > Which bus driver are you using? It obviously lacks class declaration,
> > so the correct fix is to add the class there.
>
> The modules that are loading are (in reverse order):
>      adm1031
>      ad5321
>      mic184
>      pca9540
>      i2c_sensor
>      i2c_elektor
>      i2c_algo_pcf
>      i2c_core
>
> So I believe what you are asking for is the i2c_elektor driver for the
> PCF8584 ISA to I2C chip.

Correct, I just checked and this one actually lacks its class. Patch
follows.

This patch adds a class definition to the elektor i2c bus driver.
Without this definition, hardware monitoring chips located on such
busses cannot possibly be driven.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/busses/i2c-elektor.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
--- a/drivers/i2c/busses/i2c-elektor.c	2005-03-04 12:23:13 -08:00
+++ b/drivers/i2c/busses/i2c-elektor.c	2005-03-04 12:23:13 -08:00
@@ -183,6 +183,7 @@
 
 static struct i2c_adapter pcf_isa_ops = {
 	.owner		= THIS_MODULE,
+	.class		= I2C_CLASS_HWMON,
 	.id		= I2C_HW_P_ELEK,
 	.algo_data	= &pcf_isa_data,
 	.name		= "PCF8584 ISA adapter",

