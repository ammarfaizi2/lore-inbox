Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWHQUP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWHQUP2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 16:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWHQULT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 16:11:19 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:52308 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1030256AbWHQULE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 16:11:04 -0400
X-IronPort-AV: i="4.08,139,1154934000"; 
   d="scan'208"; a="336821744:sNHT55895004"
Cc: schihei@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Subject: [PATCH 02/13] IB/ehca: includes
In-Reply-To: <20068171311.qHSUlh5t6lpV4BeW@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 17 Aug 2006 13:11:00 -0700
Message-Id: <20068171311.X1v1Q4Gk1v3wd7qJ@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: openib-general@openib.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 17 Aug 2006 20:11:01.0154 (UTC) FILETIME=[42847820:01C6C239]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rolandd@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 drivers/infiniband/hw/ehca/ehca_iverbs.h |  181 +++++++++++++
 drivers/infiniband/hw/ehca/ehca_tools.h  |  417 ++++++++++++++++++++++++++++++
 2 files changed, 598 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_iverbs.h b/drivers/infiniband/hw/ehca/ehca_iverbs.h
new file mode 100644
index 0000000..bbdc437
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_iverbs.h
@@ -0,0 +1,181 @@
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
diff --git a/drivers/infiniband/hw/ehca/ehca_tools.h b/drivers/infiniband/hw/ehca/ehca_tools.h
new file mode 100644
index 0000000..783fbb3
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/ehca_tools.h
@@ -0,0 +1,417 @@
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
+ */
+
+
+#ifndef EHCA_TOOLS_H
+#define EHCA_TOOLS_H
+
+#include <linux/kernel.h>
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
+#include <linux/notifier.h>
+#include <linux/cpu.h>
+
+#include <asm/abs_addr.h>
+#include <asm/ibmebus.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>
+
+#define EHCA_EDEB_TRACE_MASK_SIZE 32
+extern u8 ehca_edeb_mask[EHCA_EDEB_TRACE_MASK_SIZE];
+#define EDEB_ID_TO_U32(str4) (str4[3] | (str4[2] << 8) | (str4[1] << 16) | \
+			      (str4[0] << 24))
+
+static inline u64 ehca_edeb_filter(const u32 level,
+				   const u32 id, const u32 line)
+{
+	u64 ret = 0;
+	u32 filenr = 0;
+	u32 filter_level = 9;
+	u32 dynamic_level = 0;
+
+	/*
+	 * This is code written for the gcc -O2 optimizer
+	 * which should collapse  to two single ints.
+	 * Filter_level is the first level kicked out by
+	 * compiler and  means trace everything below 6.
+	 */
+
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
+		return ret | 0x100000000L; /* this is the flag to not trace */
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
+/*
+ * IS_EDEB_ON - Checks if debug is on for the given level.
+ */
+#define IS_EDEB_ON(level) \
+((ehca_edeb_filter(level, EDEB_ID_TO_U32(DEB_PREFIX), __LINE__) & \
+  0x100000000L) == 0)
+
+#define EDEB_P_GENERIC(level,idstring,format,args...) \
+do { \
+	u64 ehca_edeb_filterresult =					\
+		ehca_edeb_filter(level, EDEB_ID_TO_U32(DEB_PREFIX), __LINE__);\
+	if ((ehca_edeb_filterresult & 0x100000000L) == 0)		\
+		printk("PU%04x %08x:%s " idstring " "format "\n",	\
+		       get_paca()->paca_index, (u32)(ehca_edeb_filterresult), \
+		       __func__,  ##args);				\
+} while (1 == 0)
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
+} while (1 == 0)
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
+} while (1 == 0)
+
+#endif
+
+/**
+ * EDEB - Trace output macro.
+ * @level: tracelevel
+ * @format: optional format string, use "" if not desired
+ * @args: printf like arguments for trace
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
+ * EDEB_DMP - macro to dump a memory block, whose length is n*8 bytes.
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
+			     ##args, deb, x, \
+			     *((u64 *)&deb[0]), *((u64 *)&deb[8])); \
+			deb += 16; \
+		} \
+	} while (0)
+
+/* define a bitmask, little endian version */
+#define EHCA_BMASK(pos,length) (((pos)<<16)+(length))
+
+/* define a bitmask, the ibm way... */
+#define EHCA_BMASK_IBM(from,to) (((63-to)<<16)+((to)-(from)+1))
+
+/* internal function, don't use */
+#define EHCA_BMASK_SHIFTPOS(mask) (((mask)>>16)&0xffff)
+
+/* internal function, don't use */
+#define EHCA_BMASK_MASK(mask) (0xffffffffffffffffULL >> ((64-(mask))&0xffff))
+
+/**
+ * EHCA_BMASK_SET - return value shifted and masked by mask
+ * variable|=EHCA_BMASK_SET(MY_MASK,0x4711) ORs the bits in variable
+ * variable&=~EHCA_BMASK_SET(MY_MASK,-1) clears the bits from the mask
+ * in variable
+ */
+#define EHCA_BMASK_SET(mask,value) \
+	((EHCA_BMASK_MASK(mask) & ((u64)(value)))<<EHCA_BMASK_SHIFTPOS(mask))
+
+/**
+ * EHCA_BMASK_GET - extract a parameter from value by mask
+ */
+#define EHCA_BMASK_GET(mask,value) \
+	( EHCA_BMASK_MASK(mask)& (((u64)(value))>>EHCA_BMASK_SHIFTPOS(mask)))
+
+#define PARANOIA_MODE
+#ifdef PARANOIA_MODE
+
+#define EHCA_CHECK_ADR_P(adr)					\
+	if (unlikely(adr == 0)) {				\
+		EDEB_ERR(4, "adr=%p check failed line %i", adr,	\
+			 __LINE__);				\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_ADR(adr)					\
+	if (unlikely(adr == 0)) {				\
+		EDEB_ERR(4, "adr=%p check failed line %i", adr,	\
+			 __LINE__);				\
+		return -EFAULT; }
+
+#define EHCA_CHECK_DEVICE_P(device)				\
+	if (unlikely(device == 0)) {				\
+		EDEB_ERR(4, "device=%p check failed", device);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_DEVICE(device)				\
+	if (unlikely(device == 0)) {				\
+		EDEB_ERR(4, "device=%p check failed", device);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_PD(pd)				\
+	if (unlikely(pd == 0)) {			\
+		EDEB_ERR(4, "pd=%p check failed", pd);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_PD_P(pd)				\
+	if (unlikely(pd == 0)) {			\
+		EDEB_ERR(4, "pd=%p check failed", pd);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_AV(av)				\
+	if (unlikely(av == 0)) {			\
+		EDEB_ERR(4, "av=%p check failed", av);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_AV_P(av)				\
+	if (unlikely(av == 0)) {			\
+		EDEB_ERR(4, "av=%p check failed", av);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_CQ(cq)				\
+	if (unlikely(cq == 0)) {			\
+		EDEB_ERR(4, "cq=%p check failed", cq);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_CQ_P(cq)				\
+	if (unlikely(cq == 0)) {			\
+		EDEB_ERR(4, "cq=%p check failed", cq);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_EQ(eq)				\
+	if (unlikely(eq == 0)) {			\
+		EDEB_ERR(4, "eq=%p check failed", eq);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_EQ_P(eq)				\
+	if (unlikely(eq == 0)) {			\
+		EDEB_ERR(4, "eq=%p check failed", eq);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_QP(qp)				\
+	if (unlikely(qp == 0)) {			\
+		EDEB_ERR(4, "qp=%p check failed", qp);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_QP_P(qp)				\
+	if (unlikely(qp == 0)) {			\
+		EDEB_ERR(4, "qp=%p check failed", qp);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_MR(mr)				\
+	if (unlikely(mr == 0)) {			\
+		EDEB_ERR(4, "mr=%p check failed", mr);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_MR_P(mr)				\
+	if (unlikely(mr == 0)) {			\
+		EDEB_ERR(4, "mr=%p check failed", mr);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_MW(mw)				\
+	if (unlikely(mw == 0)) {			\
+		EDEB_ERR(4, "mw=%p check failed", mw);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_MW_P(mw)				\
+	if (unlikely(mw == 0)) {			\
+		EDEB_ERR(4, "mw=%p check failed", mw);	\
+		return ERR_PTR(-EFAULT); }
+
+#define EHCA_CHECK_FMR(fmr)					\
+	if (unlikely(fmr == 0)) {				\
+		EDEB_ERR(4, "fmr=%p check failed", fmr);	\
+		return -EFAULT; }
+
+#define EHCA_CHECK_FMR_P(fmr)					\
+	if (unlikely(fmr == 0)) {				\
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
+static inline int ehca_adr_bad(void *adr)
+{
+	return !adr;
+}
+
+/* Converts ehca to ib return code */
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
-- 
1.4.1

