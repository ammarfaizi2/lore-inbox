Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936601AbWLBWvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936601AbWLBWvs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 17:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936595AbWLBWvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 17:51:32 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:33689 "EHLO
	smtp.opengridcomputing.com") by vger.kernel.org with ESMTP
	id S936589AbWLBWv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 17:51:29 -0500
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH  v2 13/13] Kconfig/Makefile
Date: Sat, 02 Dec 2006 16:51:29 -0600
To: rdreier@cisco.com
Cc: netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Message-Id: <20061202225129.27014.42302.stgit@dell3.ogc.int>
In-Reply-To: <20061202224917.27014.15424.stgit@dell3.ogc.int>
References: <20061202224917.27014.15424.stgit@dell3.ogc.int>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Steve Wise <swise@opengridcomputing.com>
---

 drivers/infiniband/Kconfig              |    1 +
 drivers/infiniband/Makefile             |    1 +
 drivers/infiniband/hw/cxgb3/Kconfig     |   27 +++++++++++++++++++++++++++
 drivers/infiniband/hw/cxgb3/Makefile    |   12 ++++++++++++
 drivers/infiniband/hw/cxgb3/locking.txt |   25 +++++++++++++++++++++++++
 5 files changed, 66 insertions(+), 0 deletions(-)

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
index 0000000..84f0f6e
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
+          For general information about Chelsio and our products, visit
+          our website at <http://www.chelsio.com>.
+
+          For customer support, please visit our customer support page at
+          <http://www.chelsio.com/support.htm>.
+
+          Please send feedback to <linux-bugs@chelsio.com>.
+
+          To compile this driver as a module, choose M here: the module
+          will be called iw_cxgb3.
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
index 0000000..0df2b3d
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
+EXTRA_CFLAGS += -DDEBUG -O1 -g 
+iw_cxgb3-y += core/cxio_dbg.o
+endif
diff --git a/drivers/infiniband/hw/cxgb3/locking.txt b/drivers/infiniband/hw/cxgb3/locking.txt
new file mode 100644
index 0000000..e5e9991
--- /dev/null
+++ b/drivers/infiniband/hw/cxgb3/locking.txt
@@ -0,0 +1,25 @@
+cq lock:
+	- spin lock
+	- used to synchronize the t3_cq
+
+qp lock:
+	- spin lock
+	- used to synchronize updates to the qp state, attrs, and the t3_wq.
+	- touched on interrupt and process context
+	
+rnicp lock:
+	- spin lock
+	- touched on interrupt and process context
+	- used around lookup tables mapping CQID and QPID to a structure.
+	- used also to bump the refcnt atomically with the lookup.
+
+poll:
+	lock+disable on cq lock
+		lock qp lock for each cqe that is polled around the call
+		to cxio_poll_cq().
+	
+post: 
+	lock+disable qp lock
+
+global mutex iwch_mutex:
+	used to maintain global device list.
