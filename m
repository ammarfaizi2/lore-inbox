Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbUBVR5X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 12:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbUBVR5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 12:57:22 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:6411 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261715AbUBVR5N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 12:57:13 -0500
Date: Sun, 22 Feb 2004 18:57:11 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] Incorrect SCx200 dependency
Message-Id: <20040222185711.76e72e65.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

It looks like there is a dependency problem for CONFIG_SCx200_I2C in
Linux 2.4.25. It should depend on CONFIG_SCx200_GPIO, not just on
CONFIG_SCx200. One of my previous patches was supposed to fix that
already, but it looks like I forgot about it then.

Patch follows, please apply.
Thanks


--- linux-2.4.25/drivers/i2c/Config.in.orig	Sun Feb 22 10:11:14 2004
+++ linux-2.4.25/drivers/i2c/Config.in	Sun Feb 22 18:46:19 2004
@@ -12,7 +12,7 @@
       dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_PHILIPSPAR $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
       dep_tristate '  ELV adapter' CONFIG_I2C_ELV $CONFIG_I2C_ALGOBIT
       dep_tristate '  Velleman K8000 adapter' CONFIG_I2C_VELLEMAN $CONFIG_I2C_ALGOBIT
-      dep_tristate '  NatSemi SCx200 I2C using GPIO pins' CONFIG_SCx200_I2C $CONFIG_SCx200 $CONFIG_I2C_ALGOBIT
+      dep_tristate '  NatSemi SCx200 I2C using GPIO pins' CONFIG_SCx200_I2C $CONFIG_SCx200_GPIO $CONFIG_I2C_ALGOBIT
       if [ "$CONFIG_SCx200_I2C" != "n" ]; then
          int  '    GPIO pin used for SCL' CONFIG_SCx200_I2C_SCL 12
          int  '    GPIO pin used for SDA' CONFIG_SCx200_I2C_SDA 13

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
