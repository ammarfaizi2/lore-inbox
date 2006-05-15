Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbWEORn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWEORn6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWEORnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:43:14 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:12862 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S965015AbWEORnE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:43:04 -0400
Message-ID: <4468BDBF.6060703@de.ibm.com>
Date: Mon, 15 May 2006 19:43:27 +0200
From: Heiko J Schick <schihei@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       schihei@de.ibm.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 16/16] ehca: integration in Linux kernel build system
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>


  drivers/infiniband/hw/ehca/Kconfig  |    6 ++++++
  drivers/infiniband/hw/ehca/Makefile |   16 ++++++++++++++++
  2 files changed, 22 insertions(+)



--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/Kconfig	2006-04-28 13:32:08.000000000 +0200
@@ -0,0 +1,6 @@
+config INFINIBAND_EHCA
+       tristate "eHCA support"
+       depends on IBMEBUS && INFINIBAND
+       ---help---
+       This is a low level device driver for the IBM
+       GX based Host channel adapters (HCAs)
--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/Makefile	2006-04-28 13:31:25.000000000 +0200
@@ -0,0 +1,16 @@
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
+hcad_mod-objs = ehca_main.o ehca_hca.o ehca_mcast.o ehca_pd.o ehca_av.o ehca_eq.o \
+		ehca_cq.o ehca_qp.o ehca_sqp.o ehca_mrmw.o ehca_reqs.o ehca_irq.o \
+		ehca_uverbs.o hcp_if.o hcp_phyp.o ipz_pt_fn.o
+
+CFLAGS += -DEHCA_USE_HCALL -DEHCA_USE_HCALL_KERNEL



