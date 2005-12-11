Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVLKS1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVLKS1c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 13:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVLKS1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 13:27:20 -0500
Received: from mail.gmx.de ([213.165.64.21]:47082 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750777AbVLKSZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 13:25:22 -0500
X-Authenticated: #20799612
Date: Sun, 11 Dec 2005 19:20:37 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>
Subject: [PATCH 1/9] isdn4linux: Siemens Gigaset drivers - Kconfigs and Makefiles
Message-ID: <gigaset307x.2005.12.11.001.1@hjlipp.my-fqdn.de>
References: <gigaset307x.2005.12.11.001.0@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2005.12.11.001.0@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.9i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>

This patch prepares the kernel build infrastructure for addition of the
Gigaset ISDN drivers. It creates a Makefile and Kconfig file for the
Gigaset driver and hooks them into those of the isdn4linux subsystem.
It also adds a MAINTAINERS entry for the driver.

This patch depends on patches 2 to 9 of the present set, as without the
actual source files, activating the options added here will cause the
kernel build to fail.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 MAINTAINERS                   |    9 +++++++++
 drivers/isdn/Makefile         |    1 +
 drivers/isdn/gigaset/Kconfig  |   42 ++++++++++++++++++++++++++++++++++++++++++
 drivers/isdn/gigaset/Makefile |    6 ++++++
 drivers/isdn/i4l/Kconfig      |    1 +
 5 files changed, 59 insertions(+)

--- linux-2.6.14/MAINTAINERS	2005-11-01 17:41:36.000000000 +0100
+++ linux-2.6.14-gig/MAINTAINERS	2005-11-22 19:33:08.000000000 +0100
@@ -976,6 +976,15 @@
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
--- linux-2.6.14/drivers/isdn/Makefile	2005-07-16 20:04:00.000000000 +0200
+++ linux-2.6.14-gig/drivers/isdn/Makefile	2005-11-13 17:54:13.000000000 +0100
@@ -13,3 +13,4 @@
 obj-$(CONFIG_ISDN_DRV_LOOP)		+= isdnloop/
 obj-$(CONFIG_ISDN_DRV_ACT2000)		+= act2000/
 obj-$(CONFIG_HYSDN)			+= hysdn/
+obj-$(CONFIG_ISDN_DRV_GIGASET)		+= gigaset/
--- linux-2.6.14/drivers/isdn/i4l/Kconfig	2005-07-16 20:04:00.000000000 +0200
+++ linux-2.6.14-gig/drivers/isdn/i4l/Kconfig	2005-11-13 17:53:47.000000000 +0100
@@ -139,3 +139,4 @@
 
 endmenu
 
+source "drivers/isdn/gigaset/Kconfig"
--- linux-2.6.14/drivers/isdn/gigaset/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-gig/drivers/isdn/gigaset/Kconfig	2005-12-11 13:20:50.000000000 +0100
@@ -0,0 +1,42 @@
+menu "Siemens Gigaset"
+	depends on ISDN_I4L
+
+config ISDN_DRV_GIGASET
+	tristate "Siemens Gigaset support (isdn)"
+	depends on ISDN_I4L && m
+#	depends on ISDN_I4L && MODULES
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
--- linux-2.6.14/drivers/isdn/gigaset/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-gig/drivers/isdn/gigaset/Makefile	2005-12-11 13:20:54.000000000 +0100
@@ -0,0 +1,6 @@
+gigaset-y := common.o interface.o proc.o ev-layer.o i4l.o
+usb_gigaset-y := usb-gigaset.o asyncdata.o
+bas_gigaset-y := bas-gigaset.o isocdata.o
+
+obj-$(CONFIG_GIGASET_M105) += usb_gigaset.o gigaset.o
+obj-$(CONFIG_GIGASET_BASE) += bas_gigaset.o gigaset.o
