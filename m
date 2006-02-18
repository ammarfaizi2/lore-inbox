Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWBRA5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWBRA5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWBRA5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:57:12 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:38258 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751810AbWBRA5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:57:11 -0500
From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 01/22] Add powerpc-specific clear_cacheline(), which just compiles to "dcbz".
Date: Fri, 17 Feb 2006 16:57:04 -0800
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org
Cc: SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Message-Id: <20060218005704.13620.88286.stgit@localhost.localdomain>
In-Reply-To: <20060218005532.13620.79663.stgit@localhost.localdomain>
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
X-OriginalArrivalTime: 18 Feb 2006 00:57:05.0117 (UTC) FILETIME=[3C44A0D0:01C63426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>

This is horribly non-portable.  How much of a performance difference
does it make?  How does it do on ppc64 systems where the cacheline
size is not 32?
---

 drivers/infiniband/hw/ehca/ehca_asm.h |   58 +++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_asm.h b/drivers/infiniband/hw/ehca/ehca_asm.h
new file mode 100644
index 0000000..6a09ac5
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_asm.h
@@ -0,0 +1,58 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  Some helper macros with assembler instructions
+ *
+ *  Authors: Khadija Souissi <souissik@de.ibm.com>
+ *           Christoph Raisch <raisch@de.ibm.com>
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
+ *  $Id: ehca_asm.h,v 1.7 2006/02/06 10:17:34 schickhj Exp $
+ */
+
+
+#ifndef __EHCA_ASM_H__
+#define __EHCA_ASM_H__
+
+#if defined(CONFIG_PPC_PSERIES) || defined (__PPC64__) || defined (__PPC__)
+
+#define clear_cacheline(adr) __asm__ __volatile("dcbz 0,%0"::"r"(adr))
+
+#elif defined(CONFIG_ARCH_S390)
+#error "unsupported yet"
+#else
+#error "invalid platform"
+#endif
+
+#endif /* __EHCA_ASM_H__ */
