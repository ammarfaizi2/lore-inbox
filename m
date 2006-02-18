Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945905AbWBRBBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945905AbWBRBBU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbWBRA6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:58:24 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:34083 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1751846AbWBRA6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:58:08 -0500
X-IronPort-AV: i="4.02,125,1139212800"; 
   d="scan'208"; a="256299687:sNHT33322728"
From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 22/22] ehca Makefile/Kconfig changes
Date: Fri, 17 Feb 2006 16:58:02 -0800
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org
Cc: SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Message-Id: <20060218005801.13620.38625.stgit@localhost.localdomain>
In-Reply-To: <20060218005532.13620.79663.stgit@localhost.localdomain>
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
X-OriginalArrivalTime: 18 Feb 2006 00:58:02.0062 (UTC) FILETIME=[5E35BEE0:01C63426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>


---

 drivers/infiniband/Kconfig         |    2 ++
 drivers/infiniband/Makefile        |    1 +
 drivers/infiniband/hw/ehca/Kbuild  |    8 ++++++++
 drivers/infiniband/hw/ehca/Kconfig |    6 ++++++
 4 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index bdf0891..2b3ad03 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -31,6 +31,8 @@ config INFINIBAND_USER_ACCESS
 
 source "drivers/infiniband/hw/mthca/Kconfig"
 
+source "drivers/infiniband/hw/ehca/Kconfig"
+
 source "drivers/infiniband/ulp/ipoib/Kconfig"
 
 source "drivers/infiniband/ulp/srp/Kconfig"
diff --git a/drivers/infiniband/Makefile b/drivers/infiniband/Makefile
index a43fb34..eb7788f 100644
--- a/drivers/infiniband/Makefile
+++ b/drivers/infiniband/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_INFINIBAND)		+= core/
 obj-$(CONFIG_INFINIBAND_MTHCA)		+= hw/mthca/
+obj-$(CONFIG_INFINIBAND_EHCA)		+= hw/ehca/
 obj-$(CONFIG_INFINIBAND_IPOIB)		+= ulp/ipoib/
 obj-$(CONFIG_INFINIBAND_SRP)		+= ulp/srp/
diff --git a/drivers/infiniband/hw/ehca/Kbuild b/drivers/infiniband/hw/ehca/Kbuild
new file mode 100644
index 0000000..7b610b1
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/Kbuild
@@ -0,0 +1,8 @@
+obj-$(CONFIG_INFINIBAND_EHCA) += hcad_mod.o 
+
+hcad_mod-objs = ehca_main.o ehca_hca.o ipz_pt_fn.o ehca_classes.o ehca_av.o \
+	ehca_pd.o ehca_mrmw.o ehca_cq.o ehca_sqp.o ehca_qp.o hcp_sense.o \
+	ehca_eq.o ehca_irq.o hcp_phyp.o ehca_mcast.o ehca_reqs.o \
+	ehca_uverbs.o
+
+CFLAGS +=-DP_SERIES -DEHCA_USE_HCALL -DEHCA_USE_HCALL_KERNEL
diff --git a/drivers/infiniband/hw/ehca/Kconfig b/drivers/infiniband/hw/ehca/Kconfig
new file mode 100644
index 0000000..b875649
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/Kconfig
@@ -0,0 +1,6 @@
+config INFINIBAND_EHCA
+       tristate "eHCA support"
+       depends on IBMEBUS && INFINIBAND
+       ---help---
+       This is a low level device driver for the IBM
+       GX based Host channel adapters (HCAs)
\ No newline at end of file
