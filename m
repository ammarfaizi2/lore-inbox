Return-Path: <linux-kernel-owner+w=401wt.eu-S1945994AbWLVHWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945994AbWLVHWw (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 02:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946002AbWLVHW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 02:22:29 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:9094 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945994AbWLVHVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 02:21:52 -0500
From: Divy Le Ray <None@chelsio.com>
Subject: [PATCH 10/10] cxgb3 - build files and versioning
Date: Thu, 21 Dec 2006 23:21:44 -0800
To: jeff@garzik.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       swise@opengridcomputing.com
Message-Id: <20061222072144.12412.55748.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Divy Le Ray <divy@chelsio.com>

This patch implements build files and versioning for the 
Chelsio T3 network adapter's driver.

Signed-off-by: Divy Le Ray <divy@chelsio.com>
---

 drivers/net/Kconfig         |   18 ++++++++++++++++++
 drivers/net/Makefile        |    1 +
 drivers/net/cxgb3/Makefile  |    8 ++++++++
 drivers/net/cxgb3/version.h |   24 ++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 8aa8dd0..f8742f1 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2392,6 +2392,24 @@ config CHELSIO_T1_NAPI
 	  NAPI is a driver API designed to reduce CPU and interrupt load
 	  when the driver is receiving lots of packets from the card.
 
+config CHELSIO_T3
+        tristate "Chelsio Communications T3 10Gb Ethernet support"
+        depends on PCI
+        help
+          This driver supports Chelsio T3-based gigabit and 10Gb Ethernet
+          adapters.
+
+          For general information about Chelsio and our products, visit
+          our website at <http://www.chelsio.com>.
+
+          For customer support, please visit our customer support page at
+          <http://www.chelsio.com/support.htm>.
+
+          Please send feedback to <linux-bugs@chelsio.com>.
+
+          To compile this driver as a module, choose M here: the module
+          will be called cxgb3.
+
 config EHEA
 	tristate "eHEA Ethernet support"
 	depends on IBMEBUS
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 4c0d4e5..5c66643 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_E1000) += e1000/
 obj-$(CONFIG_IBM_EMAC) += ibm_emac/
 obj-$(CONFIG_IXGB) += ixgb/
 obj-$(CONFIG_CHELSIO_T1) += chelsio/
+obj-$(CONFIG_CHELSIO_T3) += cxgb3/
 obj-$(CONFIG_EHEA) += ehea/
 obj-$(CONFIG_BONDING) += bonding/
 obj-$(CONFIG_GIANFAR) += gianfar_driver.o
diff --git a/drivers/net/cxgb3/Makefile b/drivers/net/cxgb3/Makefile
new file mode 100755
index 0000000..3434679
--- /dev/null
+++ b/drivers/net/cxgb3/Makefile
@@ -0,0 +1,8 @@
+#
+# Chelsio T3 driver
+#
+
+obj-$(CONFIG_CHELSIO_T3) += cxgb3.o
+
+cxgb3-objs := cxgb3_main.o ael1002.o vsc8211.o t3_hw.o mc5.o \
+	      xgmac.o sge.o l2t.o cxgb3_offload.o
diff --git a/drivers/net/cxgb3/version.h b/drivers/net/cxgb3/version.h
new file mode 100755
index 0000000..1413ea3
--- /dev/null
+++ b/drivers/net/cxgb3/version.h
@@ -0,0 +1,24 @@
+/*****************************************************************************
+ *                                                                           *
+ * File:                                                                     *
+ *  version.h                                                                *
+ *                                                                           *
+ * Description:                                                              *
+ *  Chelsio driver version defines.                                          *
+ *                                                                           *
+ * Copyright (c) 2003 - 2006 Chelsio Communications, Inc.                    *
+ * All rights reserved.                                                      *
+ *                                                                           *
+ * Maintainers: maintainers@chelsio.com                                      *
+ *                                                                           *
+ * http://www.chelsio.com                                                    *
+ *                                                                           *
+ ****************************************************************************/
+/* $Date: 2006/10/31 18:57:51 $ $RCSfile: version.h,v $ $Revision: 1.3 $ */
+#ifndef __CHELSIO_VERSION_H
+#define __CHELSIO_VERSION_H
+#define DRV_DESC "Chelsio T3 Network Driver"
+#define DRV_NAME "cxgb3"
+/* Driver version */
+#define DRV_VERSION "1.0"
+#endif				/* __CHELSIO_VERSION_H */
