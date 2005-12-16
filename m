Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbVLPXxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbVLPXxL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbVLPXtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:49:41 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:44306 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S964831AbVLPXt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:49:26 -0500
Subject: [PATCH 13/13]  [RFC] ipath Kconfig and Makefile
In-Reply-To: <200512161548.MdcxE8ZQTy1yj4v1@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 16 Dec 2005 15:48:55 -0800
Message-Id: <200512161548.lokgvLraSGi0enUH@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 16 Dec 2005 23:48:57.0682 (UTC) FILETIME=[47F14B20:01C6029B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig and Makefile for ipath driver.  (Leaving out changes to base
drivers/infiniband/{Kconfig,Makefile} to hook these new files into
kernel build)

---

 drivers/infiniband/hw/ipath/Kconfig  |   18 ++++++++++++++++++
 drivers/infiniband/hw/ipath/Makefile |   15 +++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)
 create mode 100644 drivers/infiniband/hw/ipath/Kconfig
 create mode 100644 drivers/infiniband/hw/ipath/Makefile

8748441795d589631fc58cbf477f485ff6716348
diff --git a/drivers/infiniband/hw/ipath/Kconfig b/drivers/infiniband/hw/ipath/Kconfig
new file mode 100644
index 0000000..092faa6
--- /dev/null
+++ b/drivers/infiniband/hw/ipath/Kconfig
@@ -0,0 +1,18 @@
+config IPATH_CORE
+	tristate "PathScale InfiniPath Driver"
+	depends on PCI_MSI && X86_64
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
diff --git a/drivers/infiniband/hw/ipath/Makefile b/drivers/infiniband/hw/ipath/Makefile
new file mode 100644
index 0000000..dbe2557
--- /dev/null
+++ b/drivers/infiniband/hw/ipath/Makefile
@@ -0,0 +1,15 @@
+EXTRA_CFLAGS += -Idrivers/infiniband/include
+
+EXTRA_CFLAGS += -Wall -O3 -g3
+
+_ipath_idstr:="$$""Id: kernel.org InfiniPath Release 1.1 $$"" $$""Date: $(shell date +%F-%R)"" $$"
+EXTRA_CFLAGS += -D_IPATH_IDSTR='$(_ipath_idstr)' -DIPATH_KERN_TYPE=0
+
+obj-$(CONFIG_IPATH_CORE) += ipath_core.o
+obj-$(CONFIG_INFINIBAND_IPATH) += ib_ipath.o
+
+ipath_core-objs := ipath_copy.o ipath_driver.o \
+	ipath_dwordcpy.o ipath_ht400.o ipath_i2c.o ipath_layer.o \
+	ipath_lib.o ipath_mlock.o
+
+ib_ipath-objs := ipath_mad.o ipath_verbs.o
-- 
0.99.9n
