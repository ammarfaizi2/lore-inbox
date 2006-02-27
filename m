Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbWB0GZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWB0GZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 01:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWB0GZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 01:25:49 -0500
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:63455 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S1751553AbWB0GY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 01:24:59 -0500
Date: Mon, 27 Feb 2006 07:23:11 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>
Subject: [PATCH 7/7] isdn4linux: Siemens Gigaset drivers - Kconfigs and Makefiles
Message-ID: <gigaset307x.2006.02.27.001.7@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.02.27.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.02.27.001.1@hjlipp.my-fqdn.de> <gigaset307x.2006.02.27.001.2@hjlipp.my-fqdn.de> <gigaset307x.2006.02.27.001.3@hjlipp.my-fqdn.de> <gigaset307x.2006.02.27.001.4@hjlipp.my-fqdn.de> <gigaset307x.2006.02.27.001.5@hjlipp.my-fqdn.de> <gigaset307x.2006.02.27.001.6@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.02.27.001.6@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>

This patch prepares the kernel build infrastructure for addition of the
Gigaset ISDN drivers. It creates a Makefile and Kconfig file for the
Gigaset driver and hooks them into those of the isdn4linux subsystem.
It also adds a MAINTAINERS entry for the driver.

This patch depends on patches 1 to 6 of the present set, as without the
actual source files, activating the options added here will cause the
kernel build to fail.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 MAINTAINERS                   |    9 +++++++++
 drivers/isdn/Makefile         |    1 +
 drivers/isdn/gigaset/Kconfig  |   41 +++++++++++++++++++++++++++++++++++++++++
 drivers/isdn/gigaset/Makefile |    6 ++++++
 drivers/isdn/i4l/Kconfig      |    1 +
 5 files changed, 58 insertions(+)

--- linux-2.6.16-rc4.orig/MAINTAINERS	2006-02-20 17:18:00.000000000 +0100
+++ linux-2.6.16-rc4-mm2/MAINTAINERS	2006-02-26 17:25:16.000000000 +0100
@@ -1028,6 +1028,15 @@
 W:	http://www.kernel.org/pub/linux/utils/net/hdlc/
 S:	Maintained
 
+GIGASET ISDN DRIVERS
+P:	Hansjoerg Lipp
+M:	hjlipp@web.de
+P:	Tilman Schmidt
+M:	tilman@imap.cc
+L:	gigaset307x-common@lists.sourceforge.net
+W:	http://gigaset307x.sourceforge.net/
+S:	Maintained
+
 HARDWARE MONITORING
 P:	Jean Delvare
 M:	khali@linux-fr.org
--- linux-2.6.16-rc4.orig/drivers/isdn/Makefile	2005-07-16 20:04:00.000000000 +0200
+++ linux-2.6.16-rc4-mm2/drivers/isdn/Makefile	2006-02-26 14:36:44.000000000 +0100
@@ -13,3 +13,4 @@
 obj-$(CONFIG_ISDN_DRV_LOOP)		+= isdnloop/
 obj-$(CONFIG_ISDN_DRV_ACT2000)		+= act2000/
 obj-$(CONFIG_HYSDN)			+= hysdn/
+obj-$(CONFIG_ISDN_DRV_GIGASET)		+= gigaset/
--- linux-2.6.16-rc4.orig/drivers/isdn/i4l/Kconfig	2005-07-16 20:04:00.000000000 +0200
+++ linux-2.6.16-rc4-mm2/drivers/isdn/i4l/Kconfig	2006-02-26 14:36:44.000000000 +0100
@@ -139,3 +139,4 @@
 
 endmenu
 
+source "drivers/isdn/gigaset/Kconfig"
--- linux-2.6.16-rc4.orig/drivers/isdn/gigaset/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-rc4-mm2/drivers/isdn/gigaset/Kconfig	2006-02-20 18:39:08.000000000 +0100
@@ -0,0 +1,41 @@
+menu "Siemens Gigaset"
+	depends on ISDN_I4L
+
+config ISDN_DRV_GIGASET
+	tristate "Siemens Gigaset support (isdn)"
+	depends on ISDN_I4L && CRC_CCITT
+	help
+	  Say m here if you have a Gigaset or Sinus isdn device.
+
+if ISDN_DRV_GIGASET!=n
+
+config GIGASET_BASE
+	tristate "Gigaset base station support"
+	depends on ISDN_DRV_GIGASET && USB
+	help
+	  Say m here if you need to communicate with the base
+	  directly via USB.
+
+config GIGASET_M105
+	tristate "Gigaset M105 support"
+	depends on ISDN_DRV_GIGASET && USB
+	help
+	  Say m here if you need the driver for the Gigaset M105 device.
+
+config GIGASET_DEBUG
+	bool "Gigaset debugging"
+	help
+	  This enables debugging code in the Gigaset drivers.
+	  If in doubt, say yes.
+
+config GIGASET_UNDOCREQ
+	bool "Support for undocumented USB requests"
+	help
+	  This enables support for USB requests we only know from
+	  reverse engineering (currently M105 only). If you need
+	  features like configuration mode of M105, say yes. If you
+	  care about your device, say no.
+
+endif
+
+endmenu
--- linux-2.6.16-rc4.orig/drivers/isdn/gigaset/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-rc4-mm2/drivers/isdn/gigaset/Makefile	2005-12-10 17:40:47.000000000 +0100
@@ -0,0 +1,6 @@
+gigaset-y := common.o interface.o proc.o ev-layer.o i4l.o
+usb_gigaset-y := usb-gigaset.o asyncdata.o
+bas_gigaset-y := bas-gigaset.o isocdata.o
+
+obj-$(CONFIG_GIGASET_M105) += usb_gigaset.o gigaset.o
+obj-$(CONFIG_GIGASET_BASE) += bas_gigaset.o gigaset.o
