Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbTJGRpj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 13:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTJGRpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 13:45:39 -0400
Received: from smtp12.eresmas.com ([62.81.235.112]:27288 "EHLO
	smtp12.eresmas.com") by vger.kernel.org with ESMTP id S262539AbTJGRpg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 13:45:36 -0400
Message-ID: <3F82FB91.20207@wanadoo.es>
Date: Tue, 07 Oct 2003 19:44:49 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: syn uw <syn_uw@hotmail.com>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com.br, atulm@lsil.com,
       linux-megaraid-devel@dell.com
Subject: Re: Megaraid does not work with 2.4.22
References: <Pine.LNX.4.44.0310011307300.3451-100000@dmt.cyclades>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070709010501020309000307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070709010501020309000307
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:

> Fine. I agree on adding in to mainline 2.4.x.

Here go some trivial fixes(add menu entry, list all compatibles
boards in help and put tab instead spaces) for megaraid2.

-thanks-
-- 
If it wasn't for the presence of Lara Croft and Xena Warrior Princess,
techies around the world would have posters of Torvalds on their walls.


--------------070709010501020309000307
Content-Type: text/plain;
 name="megaraid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="megaraid.patch"

diff -Nuar old/Documentation/Configure.help new/Documentation/Configure.help
--- old/Documentation/Configure.help	Tue Oct  7 19:11:27 2003
+++ new/Documentation/Configure.help	Tue Oct  7 19:30:00 2003
@@ -9051,9 +9051,11 @@
 
 AMI MegaRAID support (old driver)
 CONFIG_SCSI_MEGARAID
-  This driver supports the AMI MegaRAID 418, 428, 438, 466, 762, 490
-  and 467 SCSI host adapters. This is the old and very heavily tested
-  driver but lacks features like clustering.
+  This driver supports the AMI MegaRAID 418, 428, 438, 466, 762, 490,
+  467, 471 and 493 SCSI host adapters. 
+
+  This is the old and very heavily tested driver but lacks features
+  like clustering.
 
   If you want to compile this driver as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -9062,14 +9064,15 @@
 
 AMI MegaRAID support (new driver)
 CONFIG_SCSI_MEGARAID2
-This driver supports the AMI MegaRAID 418, 428, 438, 466, 762, 490
-and 467 SCSI host adapters. This is the newer less tested but more
-featureful driver.
-
-If you want to compile this driver as a module ( = code which can be
-inserted in and removed from the running kernel whenever you want),
-say M here and read <file:Documentation/modules.txt>.  The module
-will be called megaraid2.o.
+  This driver supports the AMI MegaRAID 418, 428, 438, 466, 762, 490,
+  467, 471, 493 and new Ultra320(518, 520, 531, 532) SCSI host adapters.
+
+  This is the newer less tested but more featureful driver.
+
+  If you want to compile this driver as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want),
+  say M here and read <file:Documentation/modules.txt>.  The module
+  will be called megaraid2.o.
 
 Intel/ICP (former GDT SCSI Disk Array) RAID Controller support
 CONFIG_SCSI_GDTH
diff -Nuar old/drivers/scsi/Config.in new/drivers/scsi/Config.in
--- old/drivers/scsi/Config.in	Tue Oct  7 19:10:54 2003
+++ new/drivers/scsi/Config.in	Tue Oct  7 19:21:28 2003
@@ -67,6 +67,7 @@
 dep_tristate 'Always IN2000 SCSI support' CONFIG_SCSI_IN2000 $CONFIG_SCSI
 dep_tristate 'AM53/79C974 PCI SCSI support' CONFIG_SCSI_AM53C974 $CONFIG_SCSI $CONFIG_PCI
 dep_tristate 'AMI MegaRAID support' CONFIG_SCSI_MEGARAID $CONFIG_SCSI
+dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI
 
 dep_tristate 'BusLogic SCSI support' CONFIG_SCSI_BUSLOGIC $CONFIG_SCSI
 if [ "$CONFIG_SCSI_BUSLOGIC" != "n" ]; then
diff -Nuar old/drivers/scsi/Makefile new/drivers/scsi/Makefile
--- old/drivers/scsi/Makefile	Tue Oct  7 19:10:49 2003
+++ new/drivers/scsi/Makefile	Tue Oct  7 19:21:41 2003
@@ -110,7 +110,7 @@
 obj-$(CONFIG_SCSI_DC390T)	+= tmscsim.o
 obj-$(CONFIG_SCSI_AM53C974)	+= AM53C974.o
 obj-$(CONFIG_SCSI_MEGARAID)	+= megaraid.o
-obj-$(CONFIG_SCSI_MEGARAID2)   += megaraid2.o
+obj-$(CONFIG_SCSI_MEGARAID2)	+= megaraid2.o
 obj-$(CONFIG_SCSI_ACARD)	+= atp870u.o
 obj-$(CONFIG_SCSI_SUNESP)	+= esp.o
 obj-$(CONFIG_SCSI_GDTH)		+= gdth.o


--------------070709010501020309000307--

