Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751815AbWBRBEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbWBRBEx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWBRA5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:57:43 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:51030 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1751815AbWBRA5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:57:25 -0500
From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 07/22] Hypercall definitions
Date: Fri, 17 Feb 2006 16:57:21 -0800
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org
Cc: SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Message-Id: <20060218005721.13620.84990.stgit@localhost.localdomain>
In-Reply-To: <20060218005532.13620.79663.stgit@localhost.localdomain>
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
X-OriginalArrivalTime: 18 Feb 2006 00:57:21.0523 (UTC) FILETIME=[460BFC30:01C63426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>

Do these defines belong in the ehca driver, or should they be put
somewhere in generic hypercall support?
---

 drivers/infiniband/hw/ehca/ehca_common.h |  115 ++++++++++++++++++++++++++++++
 1 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_common.h b/drivers/infiniband/hw/ehca/ehca_common.h
new file mode 100644
index 0000000..922f010
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_common.h
@@ -0,0 +1,115 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  hcad local defines
+ *
+ *  Authors:  Christoph Raisch <raisch@de.ibm.com>
+ *
+ *  Copyright (c) 2005 IBM Corporation
+ *
+ *  All rights reserved.
+ *
+ *  This source code is distributed under a dual license of GPL v2.0 and OpenIB
+ *  BSD.
+ *
+ * OpenIB BSD License
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ * Redistributions of source code must retain the above copyright notice, this
+ * list of conditions and the following disclaimer.
+ *
+ * Redistributions in binary form must reproduce the above copyright notice,
+ * this list of conditions and the following disclaimer in the documentation
+ * and/or other materials
+ * provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
+ * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  $Id: ehca_common.h,v 1.15 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+#ifndef __EHCA_COMMON_H__
+#define __EHCA_COMMON_H__
+
+#ifdef CONFIG_PPC64
+#include <asm/hvcall.h>
+
+#define H_PARTIAL_STORE   16
+#define H_PAGE_REGISTERED 15
+#define H_IN_PROGRESS     14
+#define H_PARTIAL          5
+#define H_NOT_AVAILABLE    3
+#define H_Closed           2
+#define H_ADAPTER_PARM         -17
+#define H_RH_PARM              -18
+#define H_RCQ_PARM             -19
+#define H_SCQ_PARM             -20
+#define H_EQ_PARM              -21
+#define H_RT_PARM              -22
+#define H_ST_PARM              -23
+#define H_SIGT_PARM            -24
+#define H_TOKEN_PARM           -25
+#define H_MLENGTH_PARM         -27
+#define H_MEM_PARM             -28
+#define H_MEM_ACCESS_PARM      -29
+#define H_ATTR_PARM            -30
+#define H_PORT_PARM            -31
+#define H_MCG_PARM             -32
+#define H_VL_PARM              -33
+#define H_TSIZE_PARM           -34
+#define H_TRACE_PARM           -35
+
+#define H_MASK_PARM            -37
+#define H_MCG_FULL             -38
+#define H_ALIAS_EXIST          -39
+#define H_P_COUNTER            -40
+#define H_TABLE_FULL           -41
+#define H_ALT_TABLE            -42
+#define H_MR_CONDITION         -43
+#define H_NOT_ENOUGH_RESOURCES -44
+#define H_R_STATE              -45
+#define H_RESCINDEND           -46
+
+/* H call defines to be moved to kernel */
+#define H_RESET_EVENTS         0x15C
+#define H_ALLOC_RESOURCE       0x160
+#define H_FREE_RESOURCE        0x164
+#define H_MODIFY_QP            0x168
+#define H_QUERY_QP             0x16C
+#define H_REREGISTER_PMR       0x170
+#define H_REGISTER_SMR         0x174
+#define H_QUERY_MR             0x178
+#define H_QUERY_MW             0x17C
+#define H_QUERY_HCA            0x180
+#define H_QUERY_PORT           0x184
+#define H_MODIFY_PORT          0x188
+#define H_DEFINE_AQP1          0x18C
+#define H_GET_TRACE_BUFFER     0x190
+#define H_DEFINE_AQP0          0x194
+#define H_RESIZE_MR            0x198
+#define H_ATTACH_MCQP          0x19C
+#define H_DETACH_MCQP          0x1A0
+#define H_CREATE_RPT           0x1A4
+#define H_REMOVE_RPT           0x1A8
+#define H_REGISTER_RPAGES      0x1AC
+#define H_DISABLE_AND_GETC     0x1B0
+#define H_ERROR_DATA           0x1B4
+#define H_GET_HCA_INFO         0x1B8
+#define H_GET_PERF_COUNT       0x1BC
+#define H_MANAGE_TRACE         0x1C0
+#define H_QUERY_INT_STATE      0x1E4
+#endif
+
+#endif /* __EHCA_COMMON_H__ */
