Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264968AbUD2Uas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264968AbUD2Uas (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbUD2U2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:28:43 -0400
Received: from [213.133.118.2] ([213.133.118.2]:23697 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S264962AbUD2U2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:28:03 -0400
Message-ID: <4091662A.5040907@shadowconnect.com>
Date: Thu, 29 Apr 2004 22:31:38 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] I2O subsystem fixing and cleanup for 2.6 - i2o-makefile-cleanup.patch
Content-Type: multipart/mixed;
 boundary="------------020300000501060605030305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020300000501060605030305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------020300000501060605030305
Content-Type: text/plain;
 name="i2o-makefile-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o-makefile-cleanup.patch"

--- a/drivers/message/i2o/Kconfig	2004-04-04 05:36:15.000000000 +0200
+++ b/drivers/message/i2o/Kconfig	2004-04-27 10:05:52.000000000 +0200
@@ -3,7 +3,7 @@
 
 config I2O
 	tristate "I2O support"
-	depends on PCI && !64BIT
+	depends on PCI
 	---help---
 	  The Intelligent Input/Output (I2O) architecture allows hardware
 	  drivers to be split into two parts: an operating system specific
@@ -20,19 +20,20 @@
 	  drivers and OSM's with the following questions.
 
 	  To compile this support as a module, choose M here: the
-	  modules will be called i2o_core and i2o_config.
+	  modules will be called i2o_core.
 
 	  If unsure, say N.
 
-config I2O_PCI
-	tristate "I2O PCI support"
+config I2O_CONFIG
+	tristate "I2O Configuration support"
 	depends on PCI && I2O
 	help
-	  Say Y for support of PCI bus I2O interface adapters. Currently this
-	  is the only variety supported, so you should say Y.
+	  Say Y for support of the configuration interface for the I2O adapters.
+	  If you have a RAID controller from Adaptec and you want to use the
+	  raidutils to manage your RAID array, you have to say Y here.
 
 	  To compile this support as a module, choose M here: the
-	  module will be called i2o_pci.
+	  module will be called i2o_config.
 
 config I2O_BLOCK
 	tristate "I2O Block OSM"
--- a/drivers/message/i2o/Makefile	2004-04-04 05:37:37.000000000 +0200
+++ b/drivers/message/i2o/Makefile	2004-04-27 10:06:09.000000000 +0200
@@ -5,7 +5,8 @@
 # In the future, some of these should be built conditionally.
 #
 
-obj-$(CONFIG_I2O)	+= i2o_core.o i2o_config.o
+obj-$(CONFIG_I2O)	+= i2o_core.o
+obj-$(CONFIG_I2O_CONFIG)+= i2o_config.o
 obj-$(CONFIG_I2O_BLOCK)	+= i2o_block.o
 obj-$(CONFIG_I2O_SCSI)	+= i2o_scsi.o
 obj-$(CONFIG_I2O_PROC)	+= i2o_proc.o

--------------020300000501060605030305--
