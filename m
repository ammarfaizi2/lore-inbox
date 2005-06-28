Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVF2C1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVF2C1X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 22:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbVF1Xjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:39:40 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:41396 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S262224AbVF1XDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:03:52 -0400
X-IronPort-AV: i="3.93,240,1115017200"; 
   d="scan'208"; a="195037098:sNHT29453048"
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 08/16] IB uverbs: add mthca ABI header
In-Reply-To: <2005628163.3Q9FD2m0Zd9kmlVn@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 28 Jun 2005 16:03:43 -0700
Message-Id: <2005628163.kTUk6BiHHfEXJhoz@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mthca_user.h header file, which defines the device-specific
ABI used by the mthca low-level driver for kernel/user communication.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_user.h |   81 +++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+)



--- /dev/null	2005-06-23 14:14:38.423479552 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_user.h	2005-06-28 15:20:10.937544281 -0700
@@ -0,0 +1,81 @@
+/*
+ * Copyright (c) 2005 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Cisco Systems.  All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ */
+
+#ifndef MTHCA_USER_H
+#define MTHCA_USER_H
+
+#include <linux/types.h>
+
+/*
+ * Make sure that all structs defined in this file remain laid out so
+ * that they pack the same way on 32-bit and 64-bit architectures (to
+ * avoid incompatibility between 32-bit userspace and 64-bit kernels).
+ * In particular do not use pointer types -- pass pointers in __u64
+ * instead.
+ */
+
+struct mthca_alloc_ucontext_resp {
+	__u32 qp_tab_size;
+	__u32 uarc_size;
+};
+
+struct mthca_alloc_pd_resp {
+	__u32 pdn;
+	__u32 reserved;
+};
+
+struct mthca_create_cq {
+	__u32 lkey;
+	__u32 pdn;
+	__u64 arm_db_page;
+	__u64 set_db_page;
+	__u32 arm_db_index;
+	__u32 set_db_index;
+};
+
+struct mthca_create_cq_resp {
+	__u32 cqn;
+	__u32 reserved;
+};
+
+struct mthca_create_qp {
+	__u32 lkey;
+	__u32 reserved;
+	__u64 sq_db_page;
+	__u64 rq_db_page;
+	__u32 sq_db_index;
+	__u32 rq_db_index;
+};
+
+#endif /* MTHCA_USER_H */
