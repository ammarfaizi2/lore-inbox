Return-Path: <linux-kernel-owner+w=401wt.eu-S1030303AbWLTTYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbWLTTYa (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030310AbWLTTYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:24:30 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:40894 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030303AbWLTTY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:24:28 -0500
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH  v5 13/13] iw_cxgb3 Kconfig/Makefile
Date: Wed, 20 Dec 2006 13:24:26 -0600
To: rdreier@cisco.com
Cc: netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org, jeff@garzik.org
Message-Id: <20061220192426.19316.34290.stgit@dell3.ogc.int>
In-Reply-To: <20061220191754.19316.4914.stgit@dell3.ogc.int>
References: <20061220191754.19316.4914.stgit@dell3.ogc.int>
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
