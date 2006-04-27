Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbWD0Ks1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbWD0Ks1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 06:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbWD0Ks1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 06:48:27 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:42257 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S965080AbWD0KsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 06:48:10 -0400
Message-ID: <4450A183.6030405@de.ibm.com>
Date: Thu, 27 Apr 2006 12:48:35 +0200
From: Heiko J Schick <schihei@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       schihei@de.ibm.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 06/16] ehca: common include files
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>


  ehca_iverbs.h |  183 +++++++++++++++++++++++++++
  ehca_kernel.h |  162 ++++++++++++++++++++++++
  ehca_tools.h  |  387 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  3 files changed, 732 insertions(+)



--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ehca_iverbs.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ehca_iverbs.h	2006-04-04 23:51:52.000000000 +0200
@@ -0,0 +1,183 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  Function definitions for internal functions
+ *
+ *  Authors: Heiko J Schick <schickhj@de.ibm.com>
+ *           Dietmar Decker <ddecker@de.ibm.com>
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
+ *  $Id: ehca_iverbs.h,v 1.8 2006/04/04 21:51:52 nguyen Exp $
+ */
+
+#ifndef __EHCA_IVERBS_H__
+#define __EHCA_IVERBS_H__
+
+#include "ehca_classes.h"
+
+int ehca_query_device(struct ib_device *ibdev, struct ib_device_attr *props);
+
+int ehca_query_port(struct ib_device *ibdev, u8 port,
+		    struct ib_port_attr *props);
+
+int ehca_query_pkey(struct ib_device *ibdev, u8 port, u16 index, u16 * pkey);
+
+int ehca_query_gid(struct ib_device *ibdev, u8 port, int index,
+		   union ib_gid *gid);
+
+int ehca_modify_port(struct ib_device *ibdev, u8 port, int port_modify_mask,
+		     struct ib_port_modify *props);
+
+struct ib_pd *ehca_alloc_pd(struct ib_device *device,
+			    struct ib_ucontext *context,
+			    struct ib_udata *udata);
+
+int ehca_dealloc_pd(struct ib_pd *pd);
+
+struct ib_ah *ehca_create_ah(struct ib_pd *pd, struct ib_ah_attr *ah_attr);
+
+int ehca_modify_ah(struct ib_ah *ah, struct ib_ah_attr *ah_attr);
+
+int ehca_query_ah(struct ib_ah *ah, struct ib_ah_attr *ah_attr);
+
+int ehca_destroy_ah(struct ib_ah *ah);
+
+struct ib_mr *ehca_get_dma_mr(struct ib_pd *pd, int mr_access_flags);
+
+struct ib_mr *ehca_reg_phys_mr(struct ib_pd *pd,
+			       struct ib_phys_buf *phys_buf_array,
+			       int num_phys_buf,
+			       int mr_access_flags, u64 *iova_start);
+
+struct ib_mr *ehca_reg_user_mr(struct ib_pd *pd,
+			       struct ib_umem *region,
+			       int mr_access_flags, struct ib_udata *udata);
+
+int ehca_rereg_phys_mr(struct ib_mr *mr,
+		       int mr_rereg_mask,
+		       struct ib_pd *pd,
+		       struct ib_phys_buf *phys_buf_array,
+		       int num_phys_buf, int mr_access_flags, u64 *iova_start);
+
+int ehca_query_mr(struct ib_mr *mr, struct ib_mr_attr *mr_attr);
+
+int ehca_dereg_mr(struct ib_mr *mr);
+
+struct ib_mw *ehca_alloc_mw(struct ib_pd *pd);
+
+int ehca_bind_mw(struct ib_qp *qp, struct ib_mw *mw,
+		 struct ib_mw_bind *mw_bind);
+
+int ehca_dealloc_mw(struct ib_mw *mw);
+
+struct ib_fmr *ehca_alloc_fmr(struct ib_pd *pd,
+			      int mr_access_flags,
+			      struct ib_fmr_attr *fmr_attr);
+
+int ehca_map_phys_fmr(struct ib_fmr *fmr,
+		      u64 *page_list, int list_len, u64 iova);
+
+int ehca_unmap_fmr(struct list_head *fmr_list);
+
+int ehca_dealloc_fmr(struct ib_fmr *fmr);
+
+enum ehca_eq_type {
+	EHCA_EQ = 0, /* Event Queue              */
+	EHCA_NEQ     /* Notification Event Queue */
+};
+
+int ehca_create_eq(struct ehca_shca *shca, struct ehca_eq *eq,
+		   enum ehca_eq_type type, const u32 length);
+
+int ehca_destroy_eq(struct ehca_shca *shca, struct ehca_eq *eq);
+
+void *ehca_poll_eq(struct ehca_shca *shca, struct ehca_eq *eq);
+
+
+struct ib_cq *ehca_create_cq(struct ib_device *device, int cqe,
+			     struct ib_ucontext *context,
+			     struct ib_udata *udata);
+
+int ehca_destroy_cq(struct ib_cq *cq);
+
+int ehca_resize_cq(struct ib_cq *cq, int cqe, struct ib_udata *udata);
+
+int ehca_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
+
+int ehca_peek_cq(struct ib_cq *cq, int wc_cnt);
+
+int ehca_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify cq_notify);
+
+struct ib_qp *ehca_create_qp(struct ib_pd *pd,
+			     struct ib_qp_init_attr *init_attr,
+			     struct ib_udata *udata);
+
+int ehca_destroy_qp(struct ib_qp *qp);
+
+int ehca_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask);
+
+int ehca_query_qp(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
+		  int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr);
+
+int ehca_post_send(struct ib_qp *qp, struct ib_send_wr *send_wr,
+		   struct ib_send_wr **bad_send_wr);
+
+int ehca_post_recv(struct ib_qp *qp, struct ib_recv_wr *recv_wr,
+		   struct ib_recv_wr **bad_recv_wr);
+
+u64 ehca_define_sqp(struct ehca_shca *shca, struct ehca_qp *ibqp,
+		    struct ib_qp_init_attr *qp_init_attr);
+
+int ehca_attach_mcast(struct ib_qp *qp, union ib_gid *gid, u16 lid);
+
+int ehca_detach_mcast(struct ib_qp *qp, union ib_gid *gid, u16 lid);
+
+struct ib_ucontext *ehca_alloc_ucontext(struct ib_device *device,
+					struct ib_udata *udata);
+
+int ehca_dealloc_ucontext(struct ib_ucontext *context);
+
+int ehca_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
+
+void ehca_poll_eqs(unsigned long data);
+
+int ehca_mmap_nopage(u64 foffset,u64 length,void **mapped,
+		     struct vm_area_struct **vma);
+
+int ehca_mmap_register(u64 physical,void **mapped,
+		       struct vm_area_struct **vma);
+
+int ehca_munmap(unsigned long addr, size_t len);
+
+#endif
--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ehca_kernel.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ehca_kernel.h	2006-04-03 08:40:54.000000000 +0200
@@ -0,0 +1,162 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  Generalized functions for code shared between kernel and userspace
+ *
+ *  Authors: Christoph Raisch <raisch@de.ibm.com>
+ *           Hoang-Nam Nguyen <hnguyen@de.ibm.com>
+ *           Khadija Souissi <souissik@de.ibm.com>
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
+ *  $Id: ehca_kernel.h,v 1.13 2006/04/03 06:40:54 schickhj Exp $
+ */
+
+#ifndef _EHCA_KERNEL_H_
+#define _EHCA_KERNEL_H_
+
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <linux/idr.h>
+#include <linux/kthread.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/vmalloc.h>
+#include <linux/version.h>
+
+#include <asm/abs_addr.h>
+#include <asm/ibmebus.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>
+
+/**
+ * ehca_adr_bad - Handle to be used for adress translation mechanisms,
+ * currently a placeholder.
+ */
+inline static int ehca_adr_bad(void *adr)
+{
+	return (adr == 0);
+};
+
+/* We will remove this lines in SVN when it is included in the Linux kernel.
+ * We don't want to introducte unnecessary dependencies to a patched kernel.
+ */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,17)
+#include <asm/hvcall.h>
+#define H_SUCCESS              0
+#define H_BUSY		       1
+#define H_CONSTRAINED	       4
+#define H_LONG_BUSY_ORDER_1_MSEC   9900
+#define H_LONG_BUSY_ORDER_10_MSEC  9901
+#define H_LONG_BUSY_ORDER_100_MSEC 9902
+#define H_LONG_BUSY_ORDER_1_SEC    9903
+#define H_LONG_BUSY_ORDER_10_SEC   9904
+#define H_LONG_BUSY_ORDER_100_SEC  9905
+
+#define H_IS_LONG_BUSY(x)  ((x >= H_LongBusyStartRange) && (x <= H_LongBusyEndRange))
+
+#define H_PARTIAL_STORE        16
+#define H_PAGE_REGISTERED      15
+#define H_IN_PROGRESS          14
+#define H_PARTIAL              5
+#define H_NOT_AVAILABLE        3
+#define H_Closed               2
+
+#define H_HARDWARE	       -1
+#define H_PARAMETER	       -4
+#define H_NO_MEM               -9
+#define H_RESOURCE             -16
+
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
+#define H_CB_ALIGNMENT         4096
+#endif /* LINUX_VERSION_CODE */
+
+#endif /* _EHCA_KERNEL_H_ */
--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ehca_tools.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ehca_tools.h	2006-03-30 14:36:54.000000000 +0200
@@ -0,0 +1,387 @@
+/*
+ *  IBM eServer eHCA Infiniband device driver for Linux on POWER
+ *
+ *  auxiliary functions
+ *
+ *  Authors: Christoph Raisch <raisch@de.ibm.com>
+ *           Hoang-Nam Nguyen <hnguyen@de.ibm.com>
+ *           Khadija Souissi <souissik@de.ibm.com>
+ *           Waleri Fomin <fomin@de.ibm.com>
+ *           Heiko J Schick <schickhj@de.ibm.com>
+ *
+ *  Copyright (c) 2005 IBM Corporation
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
+ *  $Id: ehca_tools.h,v 1.12 2006/03/30 12:36:54 schickhj Exp $
+ */
+
+
+#ifndef EHCA_TOOLS_H
+#define EHCA_TOOLS_H
+
+#define EHCA_EDEB_TRACE_MASK_SIZE 32
+extern u8 ehca_edeb_mask[EHCA_EDEB_TRACE_MASK_SIZE];
+#define EDEB_ID_TO_U32(str4) (str4[3] | (str4[2] << 8) | (str4[1] << 16) | \
+			      (str4[0] << 24))
+
+inline static u64 ehca_edeb_filter(const u32 level,
+				   const u32 id, const u32 line)
+{
+	u64 ret = 0;
+	u32 filenr = 0;
+	u32 filter_level = 9;
+	u32 dynamic_level = 0;
+
+	/* This is code written for the gcc -O2 optimizer which should colapse
+	 * to two single ints filter_level is the first level kicked out by
+	 * compiler means trace everythin below 6. */
+	if (id == EDEB_ID_TO_U32("ehav")) {
+		filenr = 0x01;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("clas")) {
+		filenr = 0x02;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("cqeq")) {
+		filenr = 0x03;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("shca")) {
+		filenr = 0x05;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("eirq")) {
+		filenr = 0x06;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("lMad")) {
+		filenr = 0x07;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("mcas")) {
+		filenr = 0x08;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("mrmw")) {
+		filenr = 0x09;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("vpd ")) {
+		filenr = 0x0a;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("e_qp")) {
+		filenr = 0x0b;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("uqes")) {
+		filenr = 0x0c;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("PHYP")) {
+		filenr = 0x0d;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("hcpi")) {
+		filenr = 0x0e;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("iptz")) {
+		filenr = 0x0f;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("spta")) {
+		filenr = 0x10;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("simp")) {
+		filenr = 0x11;
+		filter_level = 8;
+	}
+	if (id == EDEB_ID_TO_U32("reqs")) {
+		filenr = 0x12;
+		filter_level = 8;
+	}
+
+	if ((filenr - 1) > sizeof(ehca_edeb_mask)) {
+		filenr = 0;
+	}
+
+	if (filenr == 0) {
+		filter_level = 9;
+	} /* default */
+	ret = filenr * 0x10000 + line;
+	if (filter_level <= level) {
+		return (ret | 0x100000000L); /* this is the flag to not trace */
+	}
+	dynamic_level = ehca_edeb_mask[filenr];
+	if (likely(dynamic_level <= level)) {
+		ret = ret | 0x100000000L;
+	};
+	return ret;
+}
+
+#ifdef EHCA_USE_HCALL_KERNEL
+#ifdef CONFIG_PPC_PSERIES
+
+#include <asm/paca.h>
+
+/**
+ * IS_EDEB_ON - Checks if debug is on for the given level.
+ */
+#define IS_EDEB_ON(level) \
+    ((ehca_edeb_filter(level, EDEB_ID_TO_U32(DEB_PREFIX), __LINE__) & 0x100000000L)==0)
+
+#define EDEB_P_GENERIC(level,idstring,format,args...) \
+do { \
+	u64 ehca_edeb_filterresult =					\
+		ehca_edeb_filter(level, EDEB_ID_TO_U32(DEB_PREFIX), __LINE__);\
+	if ((ehca_edeb_filterresult & 0x100000000L) == 0)		\
+		printk("PU%04x %08x:%s " idstring " "format "\n",	\
+		       get_paca()->paca_index, (u32)(ehca_edeb_filterresult), \
+		       __func__,  ##args);				\
+} while (1==0)
+
+#elif REAL_HCALL
+
+#define EDEB_P_GENERIC(level,idstring,format,args...) \
+do { \
+	u64 ehca_edeb_filterresult =					\
+		ehca_edeb_filter(level, EDEB_ID_TO_U32(DEB_PREFIX), __LINE__); \
+	if ((ehca_edeb_filterresult & 0x100000000L) == 0)		\
+		printk("%08x:%s " idstring " "format "\n",	\
+			(u32)(ehca_edeb_filterresult), \
+			__func__,  ##args); \
+} while (1==0)
+
+#endif
+#else
+
+#define IS_EDEB_ON(level) (1)
+
+#define EDEB_P_GENERIC(level,idstring,format,args...) \
+do { \
+	printk("%s " idstring " "format "\n",	\
+	       __func__,  ##args);		\
+} while (1==0)
+
+#endif
+
+/**
+ * EDEB - Trace output macro.
+ * @level tracelevel
+ * @format optional format string, use "" if not desired
+ * @args printf like arguments for trace, use %Lx for u64, %x for u32
+ *       %p for pointer
+ */
+#define EDEB(level,format,args...) \
+	EDEB_P_GENERIC(level,"",format,##args)
+#define EDEB_ERR(level,format,args...) \
+	EDEB_P_GENERIC(level,"HCAD_ERROR ",format,##args)
+#define EDEB_EN(level,format,args...) \
+	EDEB_P_GENERIC(level,">>>",format,##args)
+#define EDEB_EX(level,format,args...) \
+	EDEB_P_GENERIC(level,"<<<",format,##args)
+
+/**
+ * EDEB macro to dump a memory block, whose length is n*8 bytes.
+ * Each line has the following layout:
+ * <format string> adr=X ofs=Y <8 bytes hex> <8 bytes hex>
+ */
+#define EDEB_DMP(level,adr,len,format,args...) \
+	do {				       \
+		unsigned int x;			      \
+		unsigned int l = (unsigned int)(len); \
+		unsigned char *deb = (unsigned char*)(adr);	\
+		for (x = 0; x < l; x += 16) { \
+		        EDEB(level, format " adr=%p ofs=%04x %016lx %016lx", \
+			     ##args, deb, x, *((u64 *)&deb[0]), *((u64 *)&deb[8])); \
+			deb += 16; \
+		} \
+	} while (0)
+
+/* define a bitmask, little endian version */
+#define EHCA_BMASK(pos,length) (((pos)<<16)+(length))
+/* define a bitmask, the ibm way... */
+#define EHCA_BMASK_IBM(from,to) (((63-to)<<16)+((to)-(from)+1))
+/* internal function, don't use */
+#define EHCA_BMASK_SHIFTPOS(mask) (((mask)>>16)&0xffff)
+/* internal function, don't use */
+#define EHCA_BMASK_MASK(mask) (0xffffffffffffffffULL >> ((64-(mask))&0xffff))
+/* return value shifted and masked by mask\n
+ * variable|=HCA_BMASK_SET(MY_MASK,0x4711) ORs the bits in variable\n
+ * variable&=~HCA_BMASK_SET(MY_MASK,-1) clears the bits from the mask
+ * in variable
+ */
+#define EHCA_BMASK_SET(mask,value) \
+	((EHCA_BMASK_MASK(mask) & ((u64)(value)))<<EHCA_BMASK_SHIFTPOS(mask))
+/* extract a parameter from value by mask\n
+ * param=EHCA_BMASK_GET(MY_MASK,value)
+ */
+#define EHCA_BMASK_GET(mask,value) \
+	( EHCA_BMASK_MASK(mask)& (((u64)(value))>>EHCA_BMASK_SHIFTPOS(mask)))
+
+#define PARANOIA_MODE
+#ifdef PARANOIA_MODE
+
+#define EHCA_CHECK_ADR_P(adr)					\
+	if (unlikely(adr==0)) {					\
+		EDEB_ERR(4, "adr=%p check failed line %i", adr,	\
+			 __LINE__);				\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_ADR(adr)					\
+	if (unlikely(adr==0)) {					\
+		EDEB_ERR(4, "adr=%p check failed line %i", adr,	\
+			 __LINE__);				\
+		return -EFAULT; }
+
+#define EHCA_CHECK_DEVICE_P(device)				\
+	if (unlikely(device==0)) {				\
+		EDEB_ERR(4, "device=%p check failed", device);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_DEVICE(device)				\
+	if (unlikely(device==0)) {				\
+		EDEB_ERR(4, "device=%p check failed", device);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_PD(pd)				\
+	if (unlikely(pd==0)) {				\
+		EDEB_ERR(4, "pd=%p check failed", pd);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_PD_P(pd)				\
+	if (unlikely(pd==0)) {				\
+		EDEB_ERR(4, "pd=%p check failed", pd);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_AV(av)				\
+	if (unlikely(av==0)) {				\
+		EDEB_ERR(4, "av=%p check failed", av);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_AV_P(av)				\
+	if (unlikely(av==0)) {				\
+		EDEB_ERR(4, "av=%p check failed", av);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_CQ(cq)				\
+	if (unlikely(cq==0)) {				\
+		EDEB_ERR(4, "cq=%p check failed", cq);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_CQ_P(cq)				\
+	if (unlikely(cq==0)) {				\
+		EDEB_ERR(4, "cq=%p check failed", cq);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_EQ(eq)				\
+	if (unlikely(eq==0)) {				\
+		EDEB_ERR(4, "eq=%p check failed", eq);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_EQ_P(eq)				\
+	if (unlikely(eq==0)) {				\
+		EDEB_ERR(4, "eq=%p check failed", eq);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_QP(qp)				\
+	if (unlikely(qp==0)) {				\
+		EDEB_ERR(4, "qp=%p check failed", qp);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_QP_P(qp)				\
+	if (unlikely(qp==0)) {				\
+		EDEB_ERR(4, "qp=%p check failed", qp);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_MR(mr)				\
+	if (unlikely(mr==0)) {				\
+		EDEB_ERR(4, "mr=%p check failed", mr);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_MR_P(mr)				\
+	if (unlikely(mr==0)) {				\
+		EDEB_ERR(4, "mr=%p check failed", mr);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_MW(mw)				\
+	if (unlikely(mw==0)) {				\
+		EDEB_ERR(4, "mw=%p check failed", mw);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_MW_P(mw)				\
+	if (unlikely(mw==0)) {				\
+		EDEB_ERR(4, "mw=%p check failed", mw);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_FMR(fmr)					\
+	if (unlikely(fmr==0)) {					\
+		EDEB_ERR(4, "fmr=%p check failed", fmr);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_FMR_P(fmr)					\
+	if (unlikely(fmr==0)) {					\
+		EDEB_ERR(4, "fmr=%p check failed", fmr);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_REGISTER_PD(device,pd)
+#define EHCA_REGISTER_AV(pd,av)
+#define EHCA_DEREGISTER_PD(PD)
+#define EHCA_DEREGISTER_AV(av)
+#else
+#define EHCA_CHECK_DEVICE_P(device)
+
+#define EHCA_CHECK_PD(pd)
+#define EHCA_REGISTER_PD(device,pd)
+#define EHCA_DEREGISTER_PD(PD)
+#endif
+
+/**
+ * ehca2ib_return_code - Returns ib return code corresponding to the given
+ * ehca return code.
+ */
+static inline int ehca2ib_return_code(u64 ehca_rc)
+{
+	switch (ehca_rc) {
+	case H_SUCCESS:
+		return 0;
+	case H_BUSY:
+		return -EBUSY;
+	case H_NO_MEM:
+		return -ENOMEM;
+	default:
+		return -EINVAL;
+	}
+}
+
+#endif /* EHCA_TOOLS_H */



