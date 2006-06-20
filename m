Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWFTNco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWFTNco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 09:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWFTNco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 09:32:44 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:18104
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1750815AbWFTNcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 09:32:43 -0400
Message-ID: <4497F8F9.3070904@ed-soft.at>
Date: Tue, 20 Jun 2006 15:32:41 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] Mouse emulation support on x86 boxes
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------000107000906030105000204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000107000906030105000204
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Since the Intel Macs the mouse emulation support
not longer belongs to PPC only.

Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>

--------------000107000906030105000204
Content-Type: text/x-patch;
 name="mouseemu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mouseemu.patch"

diff -uNr linux-2.6.16.1/drivers/Makefile linux-2.6.16.1-imac/drivers/Makefile
--- linux-2.6.16.1/drivers/Makefile	2006-03-20 05:53:29.000000000 +0000
+++ linux-2.6.16.1-imac/drivers/Makefile	2006-04-01 23:51:38.000000000 +0000
@@ -33,7 +33,7 @@
 obj-y				+= base/ block/ misc/ mfd/ net/ media/
 obj-$(CONFIG_NUBUS)		+= nubus/
 obj-$(CONFIG_ATM)		+= atm/
-obj-$(CONFIG_PPC_PMAC)		+= macintosh/
+obj-y				+= macintosh/
 obj-$(CONFIG_IDE)		+= ide/
 obj-$(CONFIG_FC4)		+= fc4/
 obj-$(CONFIG_SCSI)		+= scsi/
diff -uNr linux-2.6.16.1/drivers/macintosh/Kconfig linux-2.6.16.1-imac/drivers/macintosh/Kconfig
--- linux-2.6.16.1/drivers/macintosh/Kconfig	2006-03-20 05:53:29.000000000 +0000
+++ linux-2.6.16.1-imac/drivers/macintosh/Kconfig	2006-04-01 23:51:38.000000000 +0000
@@ -1,6 +1,6 @@
 
 menu "Macintosh device drivers"
-	depends on PPC || MAC
+	depends on PPC || MAC || X86
 
 config ADB
 	bool "Apple Desktop Bus (ADB) support"
@@ -135,7 +135,7 @@
 
 config MAC_EMUMOUSEBTN
 	bool "Support for mouse button 2+3 emulation"
-	depends on INPUT_ADBHID
+#	depends on INPUT_ADBHID
 	help
 	  This provides generic support for emulating the 2nd and 3rd mouse
 	  button with keypresses.  If you say Y here, the emulation is still
--- linux-2.6.16.1/drivers/macintosh/Kconfig	2006-06-19 09:31:24.000000000 +0200
+++ linux-2.6.16.1-imac/drivers/macintosh/Kconfig	2006-06-19 09:31:10.000000000 +0200
@@ -171,6 +171,7 @@
 
 config WINDFARM
 	tristate "New PowerMac thermal control infrastructure"
+	depends on (PPC_PMAC64 || PPC_PMAC)
 
 config WINDFARM_PM81
 	tristate "Support for thermal management on iMac G5"

--------------000107000906030105000204--
