Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbTIWPUm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 11:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbTIWPUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 11:20:42 -0400
Received: from verein.lst.de ([212.34.189.10]:437 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261386AbTIWPUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 11:20:34 -0400
Date: Tue, 23 Sep 2003 17:20:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] drivers/Kconfig
Message-ID: <20030923152032.GA16599@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3 () PATCH_UNIFIED_DIFF,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What do people think about creating a common drivers/Kconfig
that includes the drivers/*/Kconfig files?  This saves quite
a few superflous Kconfig lines and is a natural way to avoid
the architectyures going out of sync.  Yes, this requires
every driver having proper bus-depencies but we should be
almost there already.

Sample patch (for ppc, i386 and x86_64) attached.  


--- 1.76/arch/i386/Kconfig	Wed Sep 10 08:41:39 2003
+++ edited/arch/i386/Kconfig	Tue Sep 23 11:42:49 2003
@@ -1175,61 +1175,14 @@
 
 endmenu
 
-source "drivers/base/Kconfig"
-
-source "drivers/mtd/Kconfig"
-
-source "drivers/parport/Kconfig"
-
-source "drivers/pnp/Kconfig"
-
-source "drivers/block/Kconfig"
-
-source "drivers/ide/Kconfig"
-
-source "drivers/scsi/Kconfig"
-
-source "drivers/cdrom/Kconfig"
-
-source "drivers/md/Kconfig"
-
-source "drivers/message/fusion/Kconfig"
-
-source "drivers/ieee1394/Kconfig"
-
-source "drivers/message/i2o/Kconfig"
-
 source "net/Kconfig"
-
 source "net/ax25/Kconfig"
-
 source "net/irda/Kconfig"
-
-source "drivers/isdn/Kconfig"
-
-source "drivers/telephony/Kconfig"
-
-#
-# input before char - char/joystick depends on it. As does USB.
-#
-source "drivers/input/Kconfig"
-
-source "drivers/char/Kconfig"
-
-#source drivers/misc/Config.in
-source "drivers/media/Kconfig"
-
-source "fs/Kconfig"
-
-source "drivers/video/Kconfig"
-
-source "sound/Kconfig"
-
-source "drivers/usb/Kconfig"
-
 source "net/bluetooth/Kconfig"
-
+source "fs/Kconfig"
 source "arch/i386/oprofile/Kconfig"
+source "drivers/Kconfig"
+source "sound/Kconfig"
 
 
 menu "Kernel hacking"
--- 1.42/arch/ppc/Kconfig	Wed Sep 17 22:31:25 2003
+++ edited/arch/ppc/Kconfig	Tue Sep 23 11:46:48 2003
@@ -1021,8 +1021,6 @@
 
 source "drivers/pcmcia/Kconfig"
 
-source "drivers/parport/Kconfig"
-
 endmenu
 
 menu "Advanced setup"
@@ -1120,39 +1118,13 @@
 	depends on ADVANCED_OPTIONS && 8xx
 endmenu
 
-source "drivers/base/Kconfig"
-
-source "drivers/mtd/Kconfig"
-
-source "drivers/pnp/Kconfig"
-
-source "drivers/block/Kconfig"
-
-source "drivers/md/Kconfig"
-
-source "drivers/ide/Kconfig"
-
-source "drivers/scsi/Kconfig"
-
-source "drivers/message/fusion/Kconfig"
-
-source "drivers/ieee1394/Kconfig"
-
-source "drivers/message/i2o/Kconfig"
-
 source "net/Kconfig"
 
 source "net/ax25/Kconfig"
 
 source "net/irda/Kconfig"
 
-source "drivers/isdn/Kconfig"
-
-source "drivers/video/Kconfig"
-
-source "drivers/cdrom/Kconfig"
-
-source "drivers/input/Kconfig"
+source "drivers/Kconfig"
 
 
 menu "Macintosh device drivers"
@@ -1289,9 +1261,6 @@
 
 endmenu
 
-source "drivers/char/Kconfig"
-
-source "drivers/media/Kconfig"
 
 source "fs/Kconfig"
 
@@ -1320,8 +1289,6 @@
 	default y
 
 endmenu
-
-source "drivers/usb/Kconfig"
 
 source "net/bluetooth/Kconfig"
 
--- 1.30/arch/x86_64/Kconfig	Mon Sep  8 03:44:40 2003
+++ edited/arch/x86_64/Kconfig	Tue Sep 23 11:50:44 2003
@@ -395,55 +395,11 @@
 
 endmenu
 
-source "drivers/base/Kconfig"
-
-source "drivers/mtd/Kconfig"
-
-source "drivers/parport/Kconfig"
-
-source "drivers/block/Kconfig"
-
-source "drivers/ide/Kconfig"
-
-source "drivers/scsi/Kconfig"
-
-source "drivers/md/Kconfig"
-
-source "drivers/telephony/Kconfig"
-
-source "drivers/message/fusion/Kconfig"
-
-source "drivers/ieee1394/Kconfig"
-
-#Currently not 64-bit safe
-#source drivers/message/i2o/Config.in
-source "net/Kconfig"
-
-source "net/ax25/Kconfig"
-
-source "net/irda/Kconfig"
-
-source "drivers/isdn/Kconfig"
-
-# no support for non IDE/SCSI cdroms as they were all ISA only
-#
-# input before char - char/joystick depends on it. As does USB.
-#
-source "drivers/input/Kconfig"
-
-source "drivers/char/Kconfig"
-
-source "drivers/misc/Kconfig"
-
-source "drivers/media/Kconfig"
+source "drivers/Kconfig"
 
 source "fs/Kconfig"
 
-source "drivers/video/Kconfig"
-
 source "sound/Kconfig"
-
-source "drivers/usb/Kconfig"
 
 source "net/bluetooth/Kconfig"
 
--- 1.4/drivers/message/i2o/Kconfig	Thu Mar 20 19:44:46 2003
+++ edited/drivers/message/i2o/Kconfig	Tue Sep 23 11:52:11 2003
@@ -1,5 +1,6 @@
-
+# Currently not 64-bit safe
 menu "I2O device support"
+	depends on !X86_64
 
 config I2O
 	tristate "I2O support"
@@ -78,4 +79,3 @@
 	  here and read <file:Documentation/modules.txt>.
 
 endmenu
-
