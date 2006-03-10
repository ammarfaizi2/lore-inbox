Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWCJAgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWCJAgp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbWCJAgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:36:35 -0500
Received: from mx.pathscale.com ([64.160.42.68]:17550 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752154AbWCJAfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:35:50 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 18 of 20] ipath - kbuild infrastructure
X-Mercurial-Node: 867a396dd518ac63ab414ca4b266cc41f6bb2ae2
Message-Id: <867a396dd518ac63ab41.1141950948@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1141950930@eng-12.pathscale.com>
Date: Thu,  9 Mar 2006 16:35:48 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 1c88f73c2ac0 -r 867a396dd518 drivers/infiniband/hw/ipath/Kconfig
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/Kconfig	Thu Mar  9 16:17:00 2006 -0800
@@ -0,0 +1,18 @@
+config IPATH_CORE
+	tristate "PathScale InfiniPath Driver"
+	depends on 64BIT && (PCIEPORTBUS || X86_HT)
+	---help---
+	This is a low-level driver for PathScale InfiniPath host channel
+	adapters (HCAs) based on the HT-400 and PE-800 chips, including
+	the InfiniPath HT-460, the small form factor InfiniPath HT-460,
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
diff -r 1c88f73c2ac0 -r 867a396dd518 drivers/infiniband/hw/ipath/Makefile
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/Makefile	Thu Mar  9 16:17:00 2006 -0800
@@ -0,0 +1,42 @@
+EXTRA_CFLAGS += -O3
+
+_ipath_idstr:="PathScale $(shell date +%F)"
+EXTRA_CFLAGS += -DIPATH_IDSTR='$(_ipath_idstr)' -DIPATH_KERN_TYPE=0
+
+obj-$(CONFIG_IPATH_CORE) += ipath_core.o
+obj-$(CONFIG_INFINIBAND_IPATH) += ib_ipath.o
+obj-$(CONFIG_IPATH_ETHER) += ipath_ether.o
+
+ipath_core-y := \
+	ipath_copy.o \
+	ipath_diag.o \
+	ipath_driver.o \
+	ipath_eeprom.o \
+	ipath_file_ops.o \
+	ipath_ht400.o \
+	ipath_init_chip.o \
+	ipath_intr.o \
+	ipath_layer.o \
+	ipath_pe800.o \
+	ipath_sma.o \
+	ipath_stats.o \
+	ipath_sysfs.o \
+	ipath_user_pages.o
+
+ipath_core-$(CONFIG_X86_64) += ipath_wc_x86_64.o
+
+ib_ipath-y := \
+	ipath_cq.o \
+	ipath_keys.o \
+	ipath_mad.o \
+	ipath_mr.o \
+	ipath_qp.o \
+	ipath_rc.o \
+	ipath_ruc.o \
+	ipath_srq.o \
+	ipath_uc.o \
+	ipath_ud.o \
+	ipath_verbs.o \
+	ipath_verbs_mcast.o
+
+ipath_ether-y := ipath_eth.o
