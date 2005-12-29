Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbVL2Ajl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbVL2Ajl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbVL2Ajh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:39:37 -0500
Received: from mx.pathscale.com ([64.160.42.68]:53736 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964942AbVL2AjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:39:10 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 19 of 20] ipath - kbuild infrastructure
X-Mercurial-Node: 07bf9f34e2218a4b26e33a8385ca98b785928b5a
Message-Id: <07bf9f34e2218a4b26e3.1135816298@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1135816279@eng-12.pathscale.com>
Date: Wed, 28 Dec 2005 16:31:38 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r e7cabc7a2e78 -r 07bf9f34e221 drivers/infiniband/hw/ipath/Kconfig
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/Kconfig	Wed Dec 28 14:19:43 2005 -0800
@@ -0,0 +1,18 @@
+config IPATH_CORE
+	tristate "PathScale InfiniPath Driver"
+	depends on PCI_MSI
+	---help---
+	This is a low-level driver for PathScale InfiniPath host
+	channel adapters (HCAs) based on the HT-400 chip, including the
+	InfiniPath HT-460, the small form factor InfiniPath HT-460,
+	the InfiniPath HT-470 and the Linux Networx LS/X.
+
+config INFINIBAND_IPATH
+	tristate "PathScale InfiniPath Verbs Driver"
+	depends on IPATH_CORE && INFINIBAND
+	---help---
+	This is a driver that provides InfiniBand verbs support for
+	PathScale InfiniPath host channel adapters (HCAs).  This
+	allows these devices to be used with both kernel upper level
+	protocols such as IP-over-InfiniBand as well as with userspace
+	applications (in conjunction with InfiniBand userspace access).
diff -r e7cabc7a2e78 -r 07bf9f34e221 drivers/infiniband/hw/ipath/Makefile
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/Makefile	Wed Dec 28 14:19:43 2005 -0800
@@ -0,0 +1,7 @@
+obj-$(CONFIG_IPATH_CORE) += ipath_core.o
+obj-$(CONFIG_INFINIBAND_IPATH) += ib_ipath.o
+
+ipath_core-y := ipath_copy.o ipath_driver.o ipath_ht400.o ipath_i2c.o \
+	ipath_layer.o ipath_lib.o ipath_upages.o
+
+ib_ipath-y := ipath_mad.o ipath_verbs.o
