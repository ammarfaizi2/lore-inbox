Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263124AbUENXIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUENXIa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbUENXIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:08:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:50652 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263124AbUENXIA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:08:00 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.6
In-Reply-To: <1084576043923@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 14 May 2004 16:07:23 -0700
Message-Id: <10845760433731@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.5.28, 2004/05/14 12:12:11-07:00, masbock@us.ibm.com

[PATCH] add ibmasm driver warning message

[note, I changed this a bit to be nicer on the system log, greg k-h]


 drivers/misc/Kconfig         |    8 +++++++-
 drivers/misc/ibmasm/module.c |    7 +++++++
 2 files changed, 14 insertions(+), 1 deletion(-)


diff -Nru a/drivers/misc/Kconfig b/drivers/misc/Kconfig
--- a/drivers/misc/Kconfig	Fri May 14 15:55:56 2004
+++ b/drivers/misc/Kconfig	Fri May 14 15:55:56 2004
@@ -6,7 +6,7 @@
 
 config IBM_ASM
 	tristate "Device driver for IBM RSA service processor"
-	depends on X86
+	depends on X86 && EXPERIMENTAL
 	default n
 	---help---
 	  This option enables device driver support for in-band access to the
@@ -20,6 +20,12 @@
 	  this feature serial driver support (CONFIG_SERIAL_8250) must be
 	  enabled.
 	  
+	  WARNING: This software may not be supported or function
+	  correctly on your IBM server. Please consult the IBM ServerProven
+	  website http://www.pc.ibm/ww/eserver/xseries/serverproven for
+	  information on the specific driver level and support statement
+	  for your IBM server.
+
 
 	  If unsure, say N.
 
diff -Nru a/drivers/misc/ibmasm/module.c b/drivers/misc/ibmasm/module.c
--- a/drivers/misc/ibmasm/module.c	Fri May 14 15:55:56 2004
+++ b/drivers/misc/ibmasm/module.c	Fri May 14 15:55:56 2004
@@ -126,6 +126,13 @@
 
 	ibmasm_register_uart(sp);
 
+	dev_printk(KERN_DEBUG, &pdev->dev, "WARNING: This software may not be supported or function\n");
+	dev_printk(KERN_DEBUG, &pdev->dev, "correctly on your IBM server. Please consult the IBM\n");
+	dev_printk(KERN_DEBUG, &pdev->dev, "ServerProven website\n");
+	dev_printk(KERN_DEBUG, &pdev->dev, "http://www.pc.ibm.com/ww/eserver/xseries/serverproven\n");
+	dev_printk(KERN_DEBUG, &pdev->dev, "for information on the specific driver level and support\n");
+	dev_printk(KERN_DEBUG, &pdev->dev, "statement for your IBM server.\n");
+
 	return 0;
 
 error_send_message:

