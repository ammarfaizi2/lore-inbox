Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbWD0KpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbWD0KpV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 06:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWD0KpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 06:45:21 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:41948 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S965087AbWD0KpU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 06:45:20 -0400
Message-ID: <4450B384.4020601@de.ibm.com>
Date: Thu, 27 Apr 2006 14:05:24 +0200
From: Heiko J Schick <schihei@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, openib-general@openib.org,
       linuxppc-dev@ozlabs.org, Marcus Eder <MEDER@de.ibm.com>,
       Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, schickhj@de.ibm.com
Subject: [PATCH 01/16] ehca: integration in Linux kernel	build system
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>


  Kconfig  |    6 ++++++
  Makefile |   29 +++++++++++++++++++++++++++++
  2 files changed, 35 insertions(+)



--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/Kconfig	2006-01-04 16:29:05.000000000 +0100
@@ -0,0 +1,6 @@
+config INFINIBAND_EHCA
+       tristate "eHCA support"
+       depends on IBMEBUS && INFINIBAND
+       ---help---
+       This is a low level device driver for the IBM
+       GX based Host channel adapters (HCAs)
\ No newline at end of file
--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/Makefile	2006-03-06 12:26:36.000000000 +0100
@@ -0,0 +1,29 @@
+#  Authors: Heiko J Schick <schickhj@de.ibm.com>
+#           Christoph Raisch <raisch@de.ibm.com>
+#
+#  Copyright (c) 2005 IBM Corporation
+#
+#  All rights reserved.
+#
+#  This source code is distributed under a dual license of GPL v2.0 and OpenIB BSD.
+
+obj-$(CONFIG_INFINIBAND_EHCA) += hcad_mod.o
+
+hcad_mod-objs = ehca_main.o   \
+		ehca_hca.o    \
+		ehca_mcast.o  \
+		ehca_pd.o     \
+		ehca_av.o     \
+		ehca_eq.o     \
+		ehca_cq.o     \
+		ehca_qp.o     \
+		ehca_sqp.o    \
+		ehca_mrmw.o   \
+		ehca_reqs.o   \
+		ehca_irq.o    \
+		ehca_uverbs.o \
+		hcp_if.o      \
+		hcp_phyp.o    \
+		ipz_pt_fn.o
+
+CFLAGS += -DEHCA_USE_HCALL -DEHCA_USE_HCALL_KERNEL



