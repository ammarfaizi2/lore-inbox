Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUAWUGz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 15:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266697AbUAWUFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 15:05:34 -0500
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:53522 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S266695AbUAWUFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 15:05:18 -0500
Date: Fri, 23 Jan 2004 21:05:20 +0100
From: Jean Delvare <khali@linux-fr.org>
To: linux1394-devel@lists.sourceforge.net
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Message about PCILynx in kernel config
Message-Id: <20040123210520.08108f9f.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a proposed patch to alter the conditions under which the PCILynx
message is displayed while configuring Linux 2.6. The way it is now, a
user with PCI and I2C both disabled will see a message stating that
"PCILynx requires I2C". If the user goes to the I2C section and selects
I2C, then comes back to the IEEE 1394 section, the message will have
disappeared (because I2C isn't missing anymore) but the PCILynx option
will not show (because PCI is still not selected).

I think it might be confusing, so I suggest that the message shouldn't
be displayed at all if PCI isn't selected. And here's a simple patch
that does just this. Built against and tested on Linux 2.6.2-rc1.

Thanks for your attention.

--- linux-2.6.2-rc1/drivers/ieee1394/Kconfig.orig	2004-01-22 10:37:43 +0100
+++ linux-2.6.2-rc1/drivers/ieee1394/Kconfig	2004-01-22 10:43:10 +0100
@@ -52,7 +52,7 @@
 	depends on IEEE1394
 
 comment "Texas Instruments PCILynx requires I2C"
-	depends on IEEE1394 && I2C=n
+	depends on PCI && IEEE1394 && I2C=n
 
 config IEEE1394_PCILYNX
 	tristate "Texas Instruments PCILynx support"


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
