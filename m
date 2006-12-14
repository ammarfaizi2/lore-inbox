Return-Path: <linux-kernel-owner+w=401wt.eu-S932770AbWLNOXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770AbWLNOXE (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932768AbWLNOWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:22:40 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:46405 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932744AbWLNOTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:19:31 -0500
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH  v4 13/13] Kconfig/Makefile
Date: Thu, 14 Dec 2006 07:59:08 -0600
To: rdreier@cisco.com
Cc: netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Message-Id: <20061214135908.21159.80049.stgit@dell3.ogc.int>
In-Reply-To: <20061214135233.21159.78613.stgit@dell3.ogc.int>
References: <20061214135233.21159.78613.stgit@dell3.ogc.int>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Steve Wise <swise@opengridcomputing.com>
---

 drivers/infiniband/Kconfig           |    1 +
 drivers/infiniband/Makefile          |    1 +
 drivers/infiniband/hw/cxgb3/Kconfig  |   27 +++++++++++++++++++++++++++
 drivers/infiniband/hw/cxgb3/Makefile |   12 ++++++++++++
 4 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 59b3932..06453ab 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -38,6 +38,7 @@ source "drivers/infiniband/hw/mthca/Kcon
 source "drivers/infiniband/hw/ipath/Kconfig"
 source "drivers/infiniband/hw/ehca/Kconfig"
 source "drivers/infiniband/hw/amso1100/Kconfig"
+source "drivers/infiniband/hw/cxgb3/Kconfig"
 
 source "drivers/infiniband/ulp/ipoib/Kconfig"
 
diff --git a/drivers/infiniband/Makefile b/drivers/infiniband/Makefile
index 570b30a..69bdd55 100644
--- a/drivers/infiniband/Makefile
+++ b/drivers/infiniband/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_INFINIBAND_MTHCA)		+= hw/mt
 obj-$(CONFIG_INFINIBAND_IPATH)		+= hw/ipath/
 obj-$(CONFIG_INFINIBAND_EHCA)		+= hw/ehca/
 obj-$(CONFIG_INFINIBAND_AMSO1100)	+= hw/amso1100/
+obj-$(CONFIG_INFINIBAND_CXGB3)		+= hw/cxgb3/
 obj-$(CONFIG_INFINIBAND_IPOIB)		+= ulp/ipoib/
 obj-$(CONFIG_INFINIBAND_SRP)		+= ulp/srp/
 obj-$(CONFIG_INFINIBAND_ISER)		+= ulp/iser/
diff --git a/drivers/infiniband/hw/cxgb3/Kconfig b/drivers/infiniband/hw/cxgb3/Kconfig
new file mode 100644
index 0000000..d3db264
--- /dev/null
+++ b/drivers/infiniband/hw/cxgb3/Kconfig
@@ -0,0 +1,27 @@
+config INFINIBAND_CXGB3
+	tristate "Chelsio RDMA Driver"
+	depends on CHELSIO_T3 && INFINIBAND
+	select GENERIC_ALLOCATOR
+	---help---
+	  This is an iWARP/RDMA driver for the Chelsio T3 1GbE and
+	  10GbE adapters.
+
+	  For general information about Chelsio and our products, visit
+	  our website at <http://www.chelsio.com>.
+
+	  For customer support, please visit our customer support page at
+	  <http://www.chelsio.com/support.htm>.
+
+	  Please send feedback to <linux-bugs@chelsio.com>.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called iw_cxgb3.
+
+config INFINIBAND_CXGB3_DEBUG
+	bool "Verbose debugging output"
+	depends on INFINIBAND_CXGB3
+	default n
+	---help---
+	  This option causes the Chelsio RDMA driver to produce copious
+	  amounts of debug messages.  Select this if you are developing
+	  the driver or trying to diagnose a problem.
diff --git a/drivers/infiniband/hw/cxgb3/Makefile b/drivers/infiniband/hw/cxgb3/Makefile
new file mode 100644
index 0000000..7a89f6d
--- /dev/null
+++ b/drivers/infiniband/hw/cxgb3/Makefile
@@ -0,0 +1,12 @@
+EXTRA_CFLAGS += -I$(TOPDIR)/drivers/net/cxgb3 \
+		-I$(TOPDIR)/drivers/infiniband/hw/cxgb3/core 
+
+obj-$(CONFIG_INFINIBAND_CXGB3) += iw_cxgb3.o
+
+iw_cxgb3-y :=  iwch_cm.o iwch_ev.o iwch_cq.o iwch_qp.o iwch_mem.o \
+	       iwch_provider.o iwch.o core/cxio_hal.o core/cxio_resource.o
+
+ifdef CONFIG_INFINIBAND_CXGB3_DEBUG
+EXTRA_CFLAGS += -DDEBUG -g 
+iw_cxgb3-y += core/cxio_dbg.o
+endif
