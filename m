Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbUKWQWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbUKWQWZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 11:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbUKWQWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 11:22:00 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:27263 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261334AbUKWQOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:14:21 -0500
Cc: openib-general@openib.org
In-Reply-To: <20041123814.p0AnYzTlx42JeVes@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 23 Nov 2004 08:14:14 -0800
Message-Id: <20041123814.rXLIXw020elfd6Da@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][RFC/v2][1/21] Add core InfiniBand support (public headers)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 16:14:19.0880 (UTC) FILETIME=[7CD40680:01C4D177]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add public headers for core InfiniBand support.  This can be thought
of as a midlayer that provides an abstraction between low-level
hardware drivers and upper level protocols (such as
IP-over-InfiniBand).

Signed-off-by: Roland Dreier <roland@topspin.com>


--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/include/ib_cache.h	2004-11-23 08:10:15.790234096 -0800
@@ -0,0 +1,49 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
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
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * $Id: ib_cache.h 1255 2004-11-17 17:20:41Z roland $
+ */
+
+#ifndef _IB_CACHE_H
+#define _IB_CACHE_H
+
+#include <ib_verbs.h>
+
+int ib_cached_gid_get(struct ib_device    *device,
+		      u8                   port,
+		      int                  index,
+		      union ib_gid        *gid);
+int ib_cached_pkey_get(struct ib_device    *device_handle,
+		       u8                   port,
+		       int                  index,
+		       u16                 *pkey);
+int ib_cached_pkey_find(struct ib_device    *device,
+			u8                   port,
+			u16                  pkey,
+			u16                 *index);
+
+#endif /* _IB_CACHE_H */
+
+/*
+  Local Variables:
+  c-file-style: "linux"
+  indent-tabs-mode: t
+  End:
+*/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/include/ib_fmr_pool.h	2004-11-23 08:10:15.847225692 -0800
@@ -0,0 +1,69 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
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
+ * Copyright (c) 2004 Topspin Corporation.  All rights reserved.
+ *
+ * $Id: ib_fmr_pool.h 696 2004-08-28 03:10:21Z roland $
+ */
+
+#if !defined(IB_FMR_POOL_H)
+#define IB_FMR_POOL_H
+
+#include <ib_verbs.h>
+
+struct ib_fmr_pool;
+
+struct ib_fmr_pool_param {
+	int                     max_pages_per_fmr;
+	enum ib_access_flags    access;
+	int                     pool_size;
+	int                     dirty_watermark;
+	void                  (*flush_function)(struct ib_fmr_pool *pool,
+						void *              arg);
+	void                   *flush_arg;
+	unsigned                cache:1;
+};
+
+struct ib_pool_fmr {
+	struct ib_fmr      *fmr;
+	struct ib_fmr_pool *pool;
+	struct list_head    list;
+	struct hlist_node   cache_node;
+	int                 ref_count;
+	int                 remap_count;
+	u64                 io_virtual_address;
+	int                 page_list_len;
+	u64                 page_list[0];
+};
+
+int ib_create_fmr_pool(struct ib_pd             *pd,
+		       struct ib_fmr_pool_param *params,
+		       struct ib_fmr_pool      **pool_handle);
+
+int ib_destroy_fmr_pool(struct ib_fmr_pool *pool);
+
+int ib_flush_fmr_pool(struct ib_fmr_pool *pool);
+
+struct ib_pool_fmr *ib_fmr_pool_map_phys(struct ib_fmr_pool *pool_handle,
+					 u64                *page_list,
+					 int                 list_len,
+					 u64                *io_virtual_address);
+
+int ib_fmr_pool_unmap(struct ib_pool_fmr *fmr);
+
+#endif /* IB_FMR_POOL_H */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/include/ib_pack.h	2004-11-23 08:10:15.909216552 -0800
@@ -0,0 +1,241 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
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
+ * Copyright (c) 2004 Topspin Corporation.  All rights reserved.
+ *
+ * $Id: ib_pack.h 1051 2004-10-25 02:47:17Z roland $
+ */
+
+#ifndef IB_PACK_H
+#define IB_PACK_H
+
+#include <ib_verbs.h>
+
+enum {
+	IB_LRH_BYTES  = 8,
+	IB_GRH_BYTES  = 40,
+	IB_BTH_BYTES  = 12,
+	IB_DETH_BYTES = 8
+};
+
+struct ib_field {
+	size_t struct_offset_bytes;
+	size_t struct_size_bytes;
+	int    offset_words;
+	int    offset_bits;
+	int    size_bits;
+	char  *field_name;
+};
+
+#define RESERVED \
+	.field_name          = "reserved"
+
+/*
+ * This macro cleans up the definitions of constants for BTH opcodes.
+ * It is used to define constants such as IB_OPCODE_UD_SEND_ONLY,
+ * which becomes IB_OPCODE_UD + IB_OPCODE_SEND_ONLY, and this gives
+ * the correct value.
+ *
+ * In short, user code should use the constants defined using the
+ * macro rather than worrying about adding together other constants.
+*/
+#define IB_OPCODE(transport, op) \
+	IB_OPCODE_ ## transport ## _ ## op = \
+		IB_OPCODE_ ## transport + IB_OPCODE_ ## op
+
+enum {
+	/* transport types -- just used to define real constants */
+	IB_OPCODE_RC                                = 0x00,
+	IB_OPCODE_UC                                = 0x20,
+	IB_OPCODE_RD                                = 0x40,
+	IB_OPCODE_UD                                = 0x60,
+
+	/* operations -- just used to define real constants */
+	IB_OPCODE_SEND_FIRST                        = 0x00,
+	IB_OPCODE_SEND_MIDDLE                       = 0x01,
+	IB_OPCODE_SEND_LAST                         = 0x02,
+	IB_OPCODE_SEND_LAST_WITH_IMMEDIATE          = 0x03,
+	IB_OPCODE_SEND_ONLY                         = 0x04,
+	IB_OPCODE_SEND_ONLY_WITH_IMMEDIATE          = 0x05,
+	IB_OPCODE_RDMA_WRITE_FIRST                  = 0x06,
+	IB_OPCODE_RDMA_WRITE_MIDDLE                 = 0x07,
+	IB_OPCODE_RDMA_WRITE_LAST                   = 0x08,
+	IB_OPCODE_RDMA_WRITE_LAST_WITH_IMMEDIATE    = 0x09,
+	IB_OPCODE_RDMA_WRITE_ONLY                   = 0x0a,
+	IB_OPCODE_RDMA_WRITE_ONLY_WITH_IMMEDIATE    = 0x0b,
+	IB_OPCODE_RDMA_READ_REQUEST                 = 0x0c,
+	IB_OPCODE_RDMA_READ_RESPONSE_FIRST          = 0x0d,
+	IB_OPCODE_RDMA_READ_RESPONSE_MIDDLE         = 0x0e,
+	IB_OPCODE_RDMA_READ_RESPONSE_LAST           = 0x0f,
+	IB_OPCODE_RDMA_READ_RESPONSE_ONLY           = 0x10,
+	IB_OPCODE_ACKNOWLEDGE                       = 0x11,
+	IB_OPCODE_ATOMIC_ACKNOWLEDGE                = 0x12,
+	IB_OPCODE_COMPARE_SWAP                      = 0x13,
+	IB_OPCODE_FETCH_ADD                         = 0x14,
+
+	/* real constants follow -- see comment about above IB_OPCODE()
+	   macro for more details */
+
+	/* RC */
+	IB_OPCODE(RC, SEND_FIRST),
+	IB_OPCODE(RC, SEND_MIDDLE),
+	IB_OPCODE(RC, SEND_LAST),
+	IB_OPCODE(RC, SEND_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(RC, SEND_ONLY),
+	IB_OPCODE(RC, SEND_ONLY_WITH_IMMEDIATE),
+	IB_OPCODE(RC, RDMA_WRITE_FIRST),
+	IB_OPCODE(RC, RDMA_WRITE_MIDDLE),
+	IB_OPCODE(RC, RDMA_WRITE_LAST),
+	IB_OPCODE(RC, RDMA_WRITE_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(RC, RDMA_WRITE_ONLY),
+	IB_OPCODE(RC, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
+	IB_OPCODE(RC, RDMA_READ_REQUEST),
+	IB_OPCODE(RC, RDMA_READ_RESPONSE_FIRST),
+	IB_OPCODE(RC, RDMA_READ_RESPONSE_MIDDLE),
+	IB_OPCODE(RC, RDMA_READ_RESPONSE_LAST),
+	IB_OPCODE(RC, RDMA_READ_RESPONSE_ONLY),
+	IB_OPCODE(RC, ACKNOWLEDGE),
+	IB_OPCODE(RC, ATOMIC_ACKNOWLEDGE),
+	IB_OPCODE(RC, COMPARE_SWAP),
+	IB_OPCODE(RC, FETCH_ADD),
+
+	/* UC */
+	IB_OPCODE(UC, SEND_FIRST),
+	IB_OPCODE(UC, SEND_MIDDLE),
+	IB_OPCODE(UC, SEND_LAST),
+	IB_OPCODE(UC, SEND_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(UC, SEND_ONLY),
+	IB_OPCODE(UC, SEND_ONLY_WITH_IMMEDIATE),
+	IB_OPCODE(UC, RDMA_WRITE_FIRST),
+	IB_OPCODE(UC, RDMA_WRITE_MIDDLE),
+	IB_OPCODE(UC, RDMA_WRITE_LAST),
+	IB_OPCODE(UC, RDMA_WRITE_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(UC, RDMA_WRITE_ONLY),
+	IB_OPCODE(UC, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
+
+	/* RD */
+	IB_OPCODE(RD, SEND_FIRST),
+	IB_OPCODE(RD, SEND_MIDDLE),
+	IB_OPCODE(RD, SEND_LAST),
+	IB_OPCODE(RD, SEND_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(RD, SEND_ONLY),
+	IB_OPCODE(RD, SEND_ONLY_WITH_IMMEDIATE),
+	IB_OPCODE(RD, RDMA_WRITE_FIRST),
+	IB_OPCODE(RD, RDMA_WRITE_MIDDLE),
+	IB_OPCODE(RD, RDMA_WRITE_LAST),
+	IB_OPCODE(RD, RDMA_WRITE_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(RD, RDMA_WRITE_ONLY),
+	IB_OPCODE(RD, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
+	IB_OPCODE(RD, RDMA_READ_REQUEST),
+	IB_OPCODE(RD, RDMA_READ_RESPONSE_FIRST),
+	IB_OPCODE(RD, RDMA_READ_RESPONSE_MIDDLE),
+	IB_OPCODE(RD, RDMA_READ_RESPONSE_LAST),
+	IB_OPCODE(RD, RDMA_READ_RESPONSE_ONLY),
+	IB_OPCODE(RD, ACKNOWLEDGE),
+	IB_OPCODE(RD, ATOMIC_ACKNOWLEDGE),
+	IB_OPCODE(RD, COMPARE_SWAP),
+	IB_OPCODE(RD, FETCH_ADD),
+
+	/* UD */
+	IB_OPCODE(UD, SEND_ONLY),
+	IB_OPCODE(UD, SEND_ONLY_WITH_IMMEDIATE)
+};
+
+enum {
+	IB_LNH_RAW        = 0,
+	IB_LNH_IP         = 1,
+	IB_LNH_IBA_LOCAL  = 2,
+	IB_LNH_IBA_GLOBAL = 3
+};
+
+struct ib_unpacked_lrh {
+	u8        virtual_lane;
+	u8        link_version;
+	u8        service_level;
+	u8        link_next_header;
+	__be16    destination_lid;
+	__be16    packet_length;
+	__be16    source_lid;
+};
+
+struct ib_unpacked_grh {
+	u8    	     ip_version;
+	u8    	     traffic_class;
+	__be32 	     flow_label;
+	__be16       payload_length;
+	u8    	     next_header;
+	u8    	     hop_limit;
+	union ib_gid source_gid;
+	union ib_gid destination_gid;
+};
+
+struct ib_unpacked_bth {
+	u8           opcode;
+	u8           solicited_event;
+	u8           mig_req;
+	u8           pad_count;
+	u8           transport_header_version;
+	__be16       pkey;
+	__be32       destination_qpn;
+	u8           ack_req;
+	__be32       psn;
+};
+
+struct ib_unpacked_deth {
+	__be32       qkey;
+	__be32       source_qpn;
+};
+
+struct ib_ud_header {
+	struct ib_unpacked_lrh  lrh;
+	int                     grh_present;
+	struct ib_unpacked_grh  grh;
+	struct ib_unpacked_bth  bth;
+	struct ib_unpacked_deth deth;
+	int            		immediate_present;
+	__be32         		immediate_data;
+};
+
+void ib_pack(const struct ib_field        *desc,
+	     int                           desc_len,
+	     void                         *structure,
+	     void                         *buf);
+
+void ib_unpack(const struct ib_field        *desc,
+	       int                           desc_len,
+	       void                         *buf,
+	       void                         *structure);
+
+void ib_ud_header_init(int     		   payload_bytes,
+		       int    		   grh_present,
+		       struct ib_ud_header *header);
+
+int ib_ud_header_pack(struct ib_ud_header *header,
+		      void                *buf);
+
+int ib_ud_header_unpack(void                *buf,
+			struct ib_ud_header *header);
+
+#endif /* IB_PACK_H */
+
+/*
+  Local Variables:
+  c-file-style: "linux"
+  indent-tabs-mode: t
+  End:
+*/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/include/ib_verbs.h	2004-11-23 08:10:15.974206969 -0800
@@ -0,0 +1,984 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
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
+ * Copyright (c) 2004 Mellanox Technologies Ltd.  All rights reserved.
+ * Copyright (c) 2004 Infinicon Corporation.  All rights reserved.
+ * Copyright (c) 2004 Intel Corporation.  All rights reserved.
+ * Copyright (c) 2004 Topspin Corporation.  All rights reserved.
+ * Copyright (c) 2004 Voltaire Corporation.  All rights reserved.
+ *
+ * $Id: ib_verbs.h 1226 2004-11-13 04:35:49Z roland $
+ */
+
+#if !defined(IB_VERBS_H)
+#define IB_VERBS_H
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <asm/atomic.h>
+
+union ib_gid {
+	u8	raw[16];
+	struct {
+		u64	subnet_prefix;
+		u64	interface_id;
+	} global;
+};
+
+enum ib_node_type {
+	IB_NODE_CA 	= 1,
+	IB_NODE_SWITCH,
+	IB_NODE_ROUTER
+};
+
+enum ib_device_cap_flags {
+	IB_DEVICE_RESIZE_MAX_WR		= 1, 
+	IB_DEVICE_BAD_PKEY_CNTR		= (1<<1), 
+	IB_DEVICE_BAD_QKEY_CNTR		= (1<<2),
+	IB_DEVICE_RAW_MULTI		= (1<<3), 
+	IB_DEVICE_AUTO_PATH_MIG		= (1<<4),
+	IB_DEVICE_CHANGE_PHY_PORT	= (1<<5),   
+	IB_DEVICE_UD_AV_PORT_ENFORCE	= (1<<6),
+	IB_DEVICE_CURR_QP_STATE_MOD	= (1<<7),
+	IB_DEVICE_SHUTDOWN_PORT		= (1<<8),
+	IB_DEVICE_INIT_TYPE		= (1<<9),
+	IB_DEVICE_PORT_ACTIVE_EVENT	= (1<<10),
+	IB_DEVICE_SYS_IMAGE_GUID	= (1<<11),
+	IB_DEVICE_RC_RNR_NAK_GEN	= (1<<12),
+	IB_DEVICE_SRQ_RESIZE		= (1<<13),
+	IB_DEVICE_N_NOTIFY_CQ		= (1<<14),
+	IB_DEVICE_RQ_SIG_TYPE		= (1<<15)
+};
+
+enum ib_atomic_cap {
+	IB_ATOMIC_NONE,
+	IB_ATOMIC_HCA,
+	IB_ATOMIC_GLOB
+};
+
+struct ib_device_attr {
+	u64			fw_ver;
+	u64			node_guid;
+	u64			sys_image_guid;
+	u64			max_mr_size;
+	u64			page_size_cap;
+	u32			vendor_id;
+	u32			vendor_part_id;
+	u32			hw_ver;
+	int			max_qp;
+	int			max_qp_wr;
+	int			device_cap_flags;
+	int			max_sge;
+	int			max_sge_rd;
+	int			max_cq;
+	int			max_cqe;
+	int			max_mr;
+	int			max_pd;
+	int			max_qp_rd_atom;
+	int			max_ee_rd_atom;
+	int			max_res_rd_atom;
+	int			max_qp_init_rd_atom;
+	int			max_ee_init_rd_atom;
+	enum ib_atomic_cap	atomic_cap;
+	int			max_ee;
+	int			max_rdd;
+	int			max_mw;
+	int			max_raw_ipv6_qp;
+	int			max_raw_ethy_qp;
+	int			max_mcast_grp;
+	int			max_mcast_qp_attach;
+	int			max_total_mcast_qp_attach;
+	int			max_ah;
+	int			max_fmr;
+	int			max_map_per_fmr;
+	int			max_srq;
+	int			max_srq_wr;
+	int			max_srq_sge;
+	u16			max_pkeys;
+	u8			local_ca_ack_delay;
+};
+
+enum ib_mtu {
+	IB_MTU_256  = 1,
+	IB_MTU_512  = 2,
+	IB_MTU_1024 = 3,
+	IB_MTU_2048 = 4,
+	IB_MTU_4096 = 5
+};
+
+static inline int ib_mtu_enum_to_int(enum ib_mtu mtu)
+{
+	switch (mtu) {
+	case IB_MTU_256:  return  256;
+	case IB_MTU_512:  return  512;
+	case IB_MTU_1024: return 1024;
+	case IB_MTU_2048: return 2048;
+	case IB_MTU_4096: return 4096;
+	default: 	  return -1;
+	}
+}
+
+enum ib_static_rate {
+	IB_STATIC_RATE_FULL		=  0,
+	IB_STATIC_RATE_12X_TO_4X	=  2,
+	IB_STATIC_RATE_4X_TO_1X		=  3,
+	IB_STATIC_RATE_12X_TO_1X	= 11
+};
+
+enum ib_port_state {
+	IB_PORT_NOP		= 0,
+	IB_PORT_DOWN		= 1,
+	IB_PORT_INIT		= 2,
+	IB_PORT_ARMED		= 3,
+	IB_PORT_ACTIVE		= 4,
+	IB_PORT_ACTIVE_DEFER	= 5
+};
+
+enum ib_port_cap_flags {
+	IB_PORT_SM				= (1<<31),
+	IB_PORT_NOTICE_SUP			= (1<<30),
+	IB_PORT_TRAP_SUP			= (1<<29),
+	IB_PORT_AUTO_MIGR_SUP			= (1<<27),
+	IB_PORT_SL_MAP_SUP			= (1<<26),
+	IB_PORT_MKEY_NVRAM			= (1<<25),
+	IB_PORT_PKEY_NVRAM			= (1<<24),
+	IB_PORT_LED_INFO_SUP			= (1<<23),
+	IB_PORT_SM_DISABLED			= (1<<22),
+	IB_PORT_SYS_IMAGE_GUID_SUP		= (1<<21),
+	IB_PORT_PKEY_SW_EXT_PORT_TRAP_SUP	= (1<<20),
+	IB_PORT_CM_SUP				= (1<<16),
+	IB_PORT_SNMP_TUNNEL_SUP			= (1<<15),
+	IB_PORT_REINIT_SUP			= (1<<14),
+	IB_PORT_DEVICE_MGMT_SUP			= (1<<13),
+	IB_PORT_VENDOR_CLASS_SUP		= (1<<12),
+	IB_PORT_DR_NOTICE_SUP			= (1<<11),
+	IB_PORT_PORT_NOTICE_SUP			= (1<<10),
+	IB_PORT_BOOT_MGMT_SUP			= (1<<9)
+};
+
+struct ib_port_attr {
+	enum ib_port_state	state;
+	enum ib_mtu		max_mtu;
+	enum ib_mtu		active_mtu;
+	int			gid_tbl_len;
+	u32			port_cap_flags;
+	u32			max_msg_sz;
+	u32			bad_pkey_cntr;
+	u32			qkey_viol_cntr;
+	u16			pkey_tbl_len;
+	u16			lid;
+	u16			sm_lid;
+	u8			lmc;
+	u8			max_vl_num;
+	u8			sm_sl;
+	u8			subnet_timeout;
+	u8			init_type_reply;
+}; 
+
+enum ib_device_modify_flags {
+	IB_DEVICE_MODIFY_SYS_IMAGE_GUID	= 1
+};
+
+struct ib_device_modify {
+	u64	sys_image_guid;
+};
+
+enum ib_port_modify_flags {
+	IB_PORT_SHUTDOWN		= 1,
+	IB_PORT_INIT_TYPE		= (1<<2),
+	IB_PORT_RESET_QKEY_CNTR		= (1<<3)
+};
+
+struct ib_port_modify {
+	u32	set_port_cap_mask;
+	u32	clr_port_cap_mask;
+	u8	init_type;
+};
+
+enum ib_event_type {
+	IB_EVENT_CQ_ERR,
+	IB_EVENT_QP_FATAL,
+	IB_EVENT_QP_REQ_ERR,
+	IB_EVENT_QP_ACCESS_ERR,
+	IB_EVENT_COMM_EST,
+	IB_EVENT_SQ_DRAINED,
+	IB_EVENT_PATH_MIG,
+	IB_EVENT_PATH_MIG_ERR,
+	IB_EVENT_DEVICE_FATAL,
+	IB_EVENT_PORT_ACTIVE,
+	IB_EVENT_PORT_ERR,
+	IB_EVENT_LID_CHANGE,
+	IB_EVENT_PKEY_CHANGE,
+	IB_EVENT_SM_CHANGE
+};
+
+struct ib_event {
+	struct ib_device	*device;
+	union {
+		struct ib_cq	*cq;
+		struct ib_qp	*qp;
+		u8		port_num;
+	} element;
+	enum ib_event_type	event;
+};
+
+struct ib_event_handler {
+	struct ib_device *device;
+	void            (*handler)(struct ib_event_handler *, struct ib_event *);
+	struct list_head  list;
+};
+
+#define INIT_IB_EVENT_HANDLER(_ptr, _device, _handler)		\
+	do {							\
+		(_ptr)->device  = _device;			\
+		(_ptr)->handler = _handler;			\
+		INIT_LIST_HEAD(&(_ptr)->list);			\
+	} while (0)
+
+struct ib_global_route {
+	union ib_gid	dgid;
+	u32		flow_label;
+	u8		sgid_index;
+	u8		hop_limit;
+	u8		traffic_class;
+};
+
+enum {
+	IB_MULTICAST_QPN = 0xffffff
+};
+
+enum ib_ah_flags {
+	IB_AH_GRH	= 1
+};
+
+struct ib_ah_attr {
+	struct ib_global_route	grh;
+	u16			dlid;
+	u8			sl;
+	u8			src_path_bits;
+	u8			static_rate;
+	u8			ah_flags;
+	u8			port_num;
+};
+
+enum ib_wc_status {
+	IB_WC_SUCCESS,
+	IB_WC_LOC_LEN_ERR,
+	IB_WC_LOC_QP_OP_ERR,
+	IB_WC_LOC_EEC_OP_ERR,
+	IB_WC_LOC_PROT_ERR,
+	IB_WC_WR_FLUSH_ERR,
+	IB_WC_MW_BIND_ERR,
+	IB_WC_BAD_RESP_ERR,
+	IB_WC_LOC_ACCESS_ERR,
+	IB_WC_REM_INV_REQ_ERR,
+	IB_WC_REM_ACCESS_ERR,
+	IB_WC_REM_OP_ERR,
+	IB_WC_RETRY_EXC_ERR,
+	IB_WC_RNR_RETRY_EXC_ERR,
+	IB_WC_LOC_RDD_VIOL_ERR,
+	IB_WC_REM_INV_RD_REQ_ERR,
+	IB_WC_REM_ABORT_ERR,
+	IB_WC_INV_EECN_ERR,
+	IB_WC_INV_EEC_STATE_ERR,
+	IB_WC_FATAL_ERR,
+	IB_WC_RESP_TIMEOUT_ERR,
+	IB_WC_GENERAL_ERR
+};
+
+enum ib_wc_opcode {
+	IB_WC_SEND,
+	IB_WC_RDMA_WRITE,
+	IB_WC_RDMA_READ,
+	IB_WC_COMP_SWAP,
+	IB_WC_FETCH_ADD,
+	IB_WC_BIND_MW,
+/*
+ * Set value of IB_WC_RECV so consumers can test if a completion is a
+ * receive by testing (opcode & IB_WC_RECV).
+ */
+	IB_WC_RECV			= 1 << 7,
+	IB_WC_RECV_RDMA_WITH_IMM
+};
+
+enum ib_wc_flags {
+	IB_WC_GRH		= 1,
+	IB_WC_WITH_IMM		= (1<<1)
+};
+
+struct ib_wc {
+	u64			wr_id;
+	enum ib_wc_status	status;
+	enum ib_wc_opcode	opcode;
+	u32			vendor_err;
+	u32			byte_len;
+	__be32			imm_data;
+	u32			src_qp;
+	int			wc_flags;
+	u16			pkey_index;
+	u16			slid;
+	u8			sl;
+	u8			dlid_path_bits;
+	u8			port_num;	/* valid only for DR SMPs on switches */
+};
+
+enum ib_cq_notify {
+	IB_CQ_SOLICITED,
+	IB_CQ_NEXT_COMP
+};
+
+struct ib_qp_cap {
+	u32	max_send_wr;
+	u32	max_recv_wr;
+	u32	max_send_sge;
+	u32	max_recv_sge;
+	u32	max_inline_data;
+};
+
+enum ib_sig_type {
+	IB_SIGNAL_ALL_WR,
+	IB_SIGNAL_REQ_WR
+};
+
+enum ib_qp_type {
+	/*
+	 * IB_QPT_SMI and IB_QPT_GSI have to be the first two entries
+	 * here (and in that order) since the MAD layer uses them as
+	 * indices into a 2-entry table.
+	 */
+	IB_QPT_SMI,
+	IB_QPT_GSI,
+
+	IB_QPT_RC,
+	IB_QPT_UC,
+	IB_QPT_UD,
+	IB_QPT_RAW_IPV6,
+	IB_QPT_RAW_ETY
+};
+
+struct ib_qp_init_attr {
+	void                  (*event_handler)(struct ib_event *, void *);
+	void		       *qp_context;
+	struct ib_cq	       *send_cq;
+	struct ib_cq	       *recv_cq;
+	struct ib_srq	       *srq;
+	struct ib_qp_cap	cap;
+	enum ib_sig_type	sq_sig_type;
+	enum ib_sig_type	rq_sig_type;
+	enum ib_qp_type		qp_type;
+	u8			port_num; /* special QP types only */
+};
+
+enum ib_rnr_timeout {
+	IB_RNR_TIMER_655_36 =  0,
+	IB_RNR_TIMER_000_01 =  1,
+	IB_RNR_TIMER_000_02 =  2,
+	IB_RNR_TIMER_000_03 =  3,
+	IB_RNR_TIMER_000_04 =  4,
+	IB_RNR_TIMER_000_06 =  5,
+	IB_RNR_TIMER_000_08 =  6,
+	IB_RNR_TIMER_000_12 =  7,
+	IB_RNR_TIMER_000_16 =  8,
+	IB_RNR_TIMER_000_24 =  9,
+	IB_RNR_TIMER_000_32 = 10,
+	IB_RNR_TIMER_000_48 = 11,
+	IB_RNR_TIMER_000_64 = 12,
+	IB_RNR_TIMER_000_96 = 13,
+	IB_RNR_TIMER_001_28 = 14,
+	IB_RNR_TIMER_001_92 = 15,
+	IB_RNR_TIMER_002_56 = 16,
+	IB_RNR_TIMER_003_84 = 17,
+	IB_RNR_TIMER_005_12 = 18,
+	IB_RNR_TIMER_007_68 = 19,
+	IB_RNR_TIMER_010_24 = 20,
+	IB_RNR_TIMER_015_36 = 21,
+	IB_RNR_TIMER_020_48 = 22,
+	IB_RNR_TIMER_030_72 = 23,
+	IB_RNR_TIMER_040_96 = 24,
+	IB_RNR_TIMER_061_44 = 25,
+	IB_RNR_TIMER_081_92 = 26,
+	IB_RNR_TIMER_122_88 = 27,
+	IB_RNR_TIMER_163_84 = 28,
+	IB_RNR_TIMER_245_76 = 29,
+	IB_RNR_TIMER_327_68 = 30,
+	IB_RNR_TIMER_491_52 = 31
+};
+
+enum ib_qp_attr_mask {
+	IB_QP_STATE			= 1,
+	IB_QP_CUR_STATE			= (1<<1),
+	IB_QP_EN_SQD_ASYNC_NOTIFY	= (1<<2),
+	IB_QP_ACCESS_FLAGS		= (1<<3),
+	IB_QP_PKEY_INDEX		= (1<<4),
+	IB_QP_PORT			= (1<<5),
+	IB_QP_QKEY			= (1<<6),
+	IB_QP_AV			= (1<<7),
+	IB_QP_PATH_MTU			= (1<<8),
+	IB_QP_TIMEOUT			= (1<<9),
+	IB_QP_RETRY_CNT			= (1<<10),
+	IB_QP_RNR_RETRY			= (1<<11),
+	IB_QP_RQ_PSN			= (1<<12),
+	IB_QP_MAX_QP_RD_ATOMIC		= (1<<13),
+	IB_QP_ALT_PATH			= (1<<14),
+	IB_QP_MIN_RNR_TIMER		= (1<<15),
+	IB_QP_SQ_PSN			= (1<<16),
+	IB_QP_MAX_DEST_RD_ATOMIC	= (1<<17),
+	IB_QP_PATH_MIG_STATE		= (1<<18),
+	IB_QP_CAP			= (1<<19),
+	IB_QP_DEST_QPN			= (1<<20)
+};
+
+enum ib_qp_state {
+	IB_QPS_RESET,
+	IB_QPS_INIT,
+	IB_QPS_RTR,
+	IB_QPS_RTS,
+	IB_QPS_SQD,
+	IB_QPS_SQE,
+	IB_QPS_ERR
+};
+
+enum ib_mig_state {
+	IB_MIG_MIGRATED,
+	IB_MIG_REARM,
+	IB_MIG_ARMED
+};
+
+struct ib_qp_attr {
+	enum ib_qp_state	qp_state;
+	enum ib_qp_state	cur_qp_state;
+	enum ib_mtu		path_mtu;
+	enum ib_mig_state	path_mig_state;
+	u32			qkey;
+	u32			rq_psn;
+	u32			sq_psn;
+	u32			dest_qp_num;
+	int			qp_access_flags;
+	struct ib_qp_cap	cap;
+	struct ib_ah_attr	ah_attr;
+	struct ib_ah_attr	alt_ah_attr;
+	u16			pkey_index;
+	u16			alt_pkey_index;
+	u8			en_sqd_async_notify;
+	u8			sq_draining;
+	u8			max_rd_atomic;
+	u8			max_dest_rd_atomic;
+	u8			min_rnr_timer;
+	u8			port_num;
+	u8			timeout;
+	u8			retry_cnt;
+	u8			rnr_retry;
+	u8			alt_port_num;
+	u8			alt_timeout;
+};
+
+enum ib_wr_opcode {
+	IB_WR_RDMA_WRITE,
+	IB_WR_RDMA_WRITE_WITH_IMM,
+	IB_WR_SEND,
+	IB_WR_SEND_WITH_IMM,
+	IB_WR_RDMA_READ,
+	IB_WR_ATOMIC_CMP_AND_SWP,
+	IB_WR_ATOMIC_FETCH_AND_ADD
+};
+
+enum ib_send_flags {
+	IB_SEND_FENCE		= 1,
+	IB_SEND_SIGNALED	= (1<<1),
+	IB_SEND_SOLICITED	= (1<<2),
+	IB_SEND_INLINE		= (1<<3)
+};
+
+enum ib_recv_flags {
+	IB_RECV_SIGNALED	= 1
+};
+
+struct ib_sge {
+	u64	addr;
+	u32	length;
+	u32	lkey;
+};
+
+struct ib_send_wr {
+	struct ib_send_wr      *next;
+	u64			wr_id;
+	struct ib_sge	       *sg_list;
+	int			num_sge;
+	enum ib_wr_opcode	opcode;
+	int			send_flags;
+	u32			imm_data;
+	union {
+		struct {
+			u64	remote_addr;
+			u32	rkey;
+		} rdma;
+		struct {
+			u64	remote_addr;
+			u64	compare_add;
+			u64	swap;
+			u32	rkey;
+		} atomic;
+		struct {
+			struct ib_ah *ah;
+			struct ib_mad_hdr *mad_hdr;
+			u32	remote_qpn;
+			u32	remote_qkey;
+			int	timeout_ms; /* valid for MADs only */
+			u16	pkey_index; /* valid for GSI only */
+			u8	port_num;   /* valid for DR SMPs on switch only */
+		} ud;
+	} wr;
+};
+
+struct ib_recv_wr {
+	struct ib_recv_wr      *next;
+	u64			wr_id;
+	struct ib_sge	       *sg_list;
+	int			num_sge;
+	int			recv_flags;
+};
+
+enum ib_access_flags {
+	IB_ACCESS_LOCAL_WRITE	= 1,
+	IB_ACCESS_REMOTE_WRITE	= (1<<1),
+	IB_ACCESS_REMOTE_READ	= (1<<2),
+	IB_ACCESS_REMOTE_ATOMIC	= (1<<3),
+	IB_ACCESS_MW_BIND	= (1<<4)
+};
+
+struct ib_phys_buf {
+	u64      addr;
+	u64      size;
+};
+
+struct ib_mr_attr {
+	struct ib_pd	*pd;
+	u64		device_virt_addr;
+	u64		size;
+	int		mr_access_flags;
+	u32		lkey;
+	u32		rkey;
+};
+
+enum ib_mr_rereg_flags {
+	IB_MR_REREG_TRANS	= 1,
+	IB_MR_REREG_PD		= (1<<1),
+	IB_MR_REREG_ACCESS	= (1<<2)
+};
+
+struct ib_mw_bind {
+	struct ib_mr   *mr;
+	u64		wr_id;
+	u64		addr;
+	u32		length;
+	int		send_flags;
+	int		mw_access_flags;
+};
+
+struct ib_fmr_attr {
+	int	max_pages;
+	int	max_maps;
+	u8	page_size;
+};
+
+struct ib_pd {
+	struct ib_device *device;
+	atomic_t          usecnt; /* count all resources */
+};
+
+struct ib_ah {
+	struct ib_device	*device;
+	struct ib_pd		*pd;
+};
+
+typedef void (*ib_comp_handler)(struct ib_cq *cq, void *cq_context);
+
+struct ib_cq {
+	struct ib_device *device;
+	ib_comp_handler   comp_handler;
+	void             (*event_handler)(struct ib_event *, void *);
+	void *            cq_context;
+	int               cqe;
+	atomic_t          usecnt; /* count number of work queues */
+};
+
+struct ib_srq {
+	struct ib_device	*device;
+	struct ib_pd		*pd;
+	void			*srq_context;
+	atomic_t		usecnt;
+};
+
+struct ib_qp {
+	struct ib_device       *device;
+	struct ib_pd	       *pd;
+	struct ib_cq	       *send_cq;
+	struct ib_cq	       *recv_cq;
+	struct ib_srq	       *srq;
+	void                  (*event_handler)(struct ib_event *, void *);
+	void		       *qp_context;
+	u32			qp_num;
+};
+
+struct ib_mr {
+	struct ib_device *device;
+	struct ib_pd     *pd;
+	u32		  lkey;
+	u32		  rkey;
+	atomic_t          usecnt; /* count number of MWs */
+};
+
+struct ib_mw {
+	struct ib_device	*device;
+	struct ib_pd		*pd;
+	u32			rkey;
+};
+
+struct ib_fmr {
+	struct ib_device	*device;
+	struct ib_pd		*pd;
+	struct list_head	list;
+	u32			lkey;
+	u32			rkey;
+};
+
+struct ib_mad;
+
+enum ib_process_mad_flags {
+	IB_MAD_IGNORE_MKEY	= 1
+};
+
+enum ib_mad_result {
+	IB_MAD_RESULT_FAILURE  = 0,      /* (!SUCCESS is the important flag) */
+	IB_MAD_RESULT_SUCCESS  = 1 << 0, /* MAD was successfully processed   */
+	IB_MAD_RESULT_REPLY    = 1 << 1, /* Reply packet needs to be sent    */
+	IB_MAD_RESULT_CONSUMED = 1 << 2  /* Packet consumed: stop processing */
+};
+
+#define IB_DEVICE_NAME_MAX 64
+
+struct ib_cache {
+	struct ib_event_handler event_handler;
+	struct ib_pkey_cache  **pkey_cache;
+	struct ib_gid_cache   **gid_cache;
+};
+
+struct ib_device {
+	struct device                *dma_device;
+
+	char                          name[IB_DEVICE_NAME_MAX];
+
+	struct list_head              event_handler_list;
+	spinlock_t                    event_handler_lock;
+
+	struct list_head              core_list;
+	struct list_head              client_data_list;
+	spinlock_t                    client_data_lock;
+
+	struct ib_cache               cache;
+
+	u32                           flags;
+
+	int		           (*query_device)(struct ib_device *device,
+						   struct ib_device_attr *device_attr);
+	int		           (*query_port)(struct ib_device *device, 
+						 u8 port_num,
+						 struct ib_port_attr *port_attr);
+	int		           (*query_gid)(struct ib_device *device,
+						u8 port_num, int index,
+						union ib_gid *gid);
+	int		           (*query_pkey)(struct ib_device *device,
+						 u8 port_num, u16 index, u16 *pkey);
+	int		           (*modify_device)(struct ib_device *device,
+						    int device_modify_mask,
+						    struct ib_device_modify *device_modify);
+	int		           (*modify_port)(struct ib_device *device,
+						  u8 port_num, int port_modify_mask,
+						  struct ib_port_modify *port_modify);
+	struct ib_pd *             (*alloc_pd)(struct ib_device *device);
+	int                        (*dealloc_pd)(struct ib_pd *pd);
+	struct ib_ah *             (*create_ah)(struct ib_pd *pd,
+						struct ib_ah_attr *ah_attr);
+	int                        (*modify_ah)(struct ib_ah *ah,
+						struct ib_ah_attr *ah_attr);
+	int                        (*query_ah)(struct ib_ah *ah,
+					       struct ib_ah_attr *ah_attr);
+	int                        (*destroy_ah)(struct ib_ah *ah);
+	struct ib_qp *             (*create_qp)(struct ib_pd *pd,
+						struct ib_qp_init_attr *qp_init_attr);
+	int                        (*modify_qp)(struct ib_qp *qp,
+						struct ib_qp_attr *qp_attr,
+						int qp_attr_mask);
+	int                        (*query_qp)(struct ib_qp *qp,
+					       struct ib_qp_attr *qp_attr,
+					       int qp_attr_mask,
+					       struct ib_qp_init_attr *qp_init_attr);
+	int                        (*destroy_qp)(struct ib_qp *qp);
+	int                        (*post_send)(struct ib_qp *qp,
+						struct ib_send_wr *send_wr,
+						struct ib_send_wr **bad_send_wr);
+	int                        (*post_recv)(struct ib_qp *qp,
+						struct ib_recv_wr *recv_wr,
+						struct ib_recv_wr **bad_recv_wr);
+	struct ib_cq *             (*create_cq)(struct ib_device *device,
+						int cqe);
+	int                        (*destroy_cq)(struct ib_cq *cq);
+	int                        (*resize_cq)(struct ib_cq *cq, int *cqe);
+	int                        (*poll_cq)(struct ib_cq *cq, int num_entries,
+					      struct ib_wc *wc);
+	int                        (*peek_cq)(struct ib_cq *cq, int wc_cnt);
+	int                        (*req_notify_cq)(struct ib_cq *cq,
+						    enum ib_cq_notify cq_notify);
+	int                        (*req_ncomp_notif)(struct ib_cq *cq,
+						      int wc_cnt);
+	struct ib_mr *             (*get_dma_mr)(struct ib_pd *pd,
+						 int mr_access_flags);
+	struct ib_mr *             (*reg_phys_mr)(struct ib_pd *pd,
+						  struct ib_phys_buf *phys_buf_array,
+						  int num_phys_buf,
+						  int mr_access_flags,
+						  u64 *iova_start);
+	int                        (*query_mr)(struct ib_mr *mr,
+					       struct ib_mr_attr *mr_attr);
+	int                        (*dereg_mr)(struct ib_mr *mr);
+	int                        (*rereg_phys_mr)(struct ib_mr *mr,
+						    int mr_rereg_mask,
+						    struct ib_pd *pd,
+						    struct ib_phys_buf *phys_buf_array,
+						    int num_phys_buf,
+						    int mr_access_flags,
+						    u64 *iova_start);
+	struct ib_mw *             (*alloc_mw)(struct ib_pd *pd);
+	int                        (*bind_mw)(struct ib_qp *qp,
+					      struct ib_mw *mw,
+					      struct ib_mw_bind *mw_bind);
+	int                        (*dealloc_mw)(struct ib_mw *mw);
+	struct ib_fmr *	           (*alloc_fmr)(struct ib_pd *pd,
+						int mr_access_flags,
+						struct ib_fmr_attr *fmr_attr);
+	int		           (*map_phys_fmr)(struct ib_fmr *fmr,
+						   u64 *page_list, int list_len,
+						   u64 iova);
+	int		           (*unmap_fmr)(struct list_head *fmr_list);
+	int		           (*dealloc_fmr)(struct ib_fmr *fmr);
+	int                        (*attach_mcast)(struct ib_qp *qp,
+						   union ib_gid *gid,
+						   u16 lid);
+	int                        (*detach_mcast)(struct ib_qp *qp,
+						   union ib_gid *gid,
+						   u16 lid);
+	int                        (*process_mad)(struct ib_device *device,
+						  int process_mad_flags,
+						  u8 port_num,
+						  u16 source_lid,
+						  struct ib_mad *in_mad,
+						  struct ib_mad *out_mad);
+
+	struct class_device          class_dev;
+	struct kobject               ports_parent;
+	struct list_head             port_list;
+
+	enum {
+		IB_DEV_UNINITIALIZED,
+		IB_DEV_REGISTERED,
+		IB_DEV_UNREGISTERED
+	}                            reg_state;
+
+	u8                           node_type;
+	u8                           phys_port_cnt;
+};
+
+struct ib_client {
+	char  *name;
+	void (*add)   (struct ib_device *);
+	void (*remove)(struct ib_device *);
+
+	struct list_head list;
+};
+
+struct ib_device *ib_alloc_device(size_t size);
+void ib_dealloc_device(struct ib_device *device);
+
+int ib_register_device   (struct ib_device *device);
+void ib_unregister_device(struct ib_device *device);
+
+int ib_register_client   (struct ib_client *client);
+void ib_unregister_client(struct ib_client *client);
+
+void *ib_get_client_data(struct ib_device *device, struct ib_client *client);
+void  ib_set_client_data(struct ib_device *device, struct ib_client *client,
+			 void *data);
+
+int ib_register_event_handler  (struct ib_event_handler *event_handler);
+int ib_unregister_event_handler(struct ib_event_handler *event_handler);
+void ib_dispatch_event(struct ib_event *event);
+
+int ib_query_device(struct ib_device *device,
+		    struct ib_device_attr *device_attr);
+
+int ib_query_port(struct ib_device *device, 
+		  u8 port_num, struct ib_port_attr *port_attr);
+
+int ib_query_gid(struct ib_device *device,
+		 u8 port_num, int index, union ib_gid *gid);
+
+int ib_query_pkey(struct ib_device *device,
+		  u8 port_num, u16 index, u16 *pkey);
+
+int ib_modify_device(struct ib_device *device,
+		     int device_modify_mask,
+		     struct ib_device_modify *device_modify);
+
+int ib_modify_port(struct ib_device *device,
+		   u8 port_num, int port_modify_mask,
+		   struct ib_port_modify *port_modify);
+
+struct ib_pd *ib_alloc_pd(struct ib_device *device);
+int ib_dealloc_pd(struct ib_pd *pd);
+
+struct ib_ah *ib_create_ah(struct ib_pd *pd, struct ib_ah_attr *ah_attr);
+int ib_modify_ah(struct ib_ah *ah, struct ib_ah_attr *ah_attr);
+int ib_query_ah(struct ib_ah *ah, struct ib_ah_attr *ah_attr);
+int ib_destroy_ah(struct ib_ah *ah);
+
+struct ib_qp *ib_create_qp(struct ib_pd *pd,
+			   struct ib_qp_init_attr *qp_init_attr);
+
+int ib_modify_qp(struct ib_qp *qp,
+		 struct ib_qp_attr *qp_attr,
+		 int qp_attr_mask);
+
+int ib_query_qp(struct ib_qp *qp,
+		struct ib_qp_attr *qp_attr,
+		int qp_attr_mask,
+		struct ib_qp_init_attr *qp_init_attr);
+
+int ib_destroy_qp(struct ib_qp *qp);
+
+static inline int ib_post_send(struct ib_qp *qp,
+			       struct ib_send_wr *send_wr,
+			       struct ib_send_wr **bad_send_wr)
+{
+	return qp->device->post_send(qp, send_wr, bad_send_wr);
+}
+
+static inline int ib_post_recv(struct ib_qp *qp,
+			       struct ib_recv_wr *recv_wr,
+			       struct ib_recv_wr **bad_recv_wr)
+{
+	return qp->device->post_recv(qp, recv_wr, bad_recv_wr);
+}
+
+struct ib_cq *ib_create_cq(struct ib_device *device,
+			   ib_comp_handler comp_handler,
+			   void (*event_handler)(struct ib_event *, void *),
+			   void *cq_context, int cqe);
+
+int ib_resize_cq(struct ib_cq *cq, int cqe);
+int ib_destroy_cq(struct ib_cq *cq);
+
+/**
+ * ib_poll_cq - poll a CQ for completion(s)
+ * @cq:the CQ being polled
+ * @num_entries:maximum number of completions to return
+ * @wc:array of at least @num_entries &struct ib_wc where completions
+ *   will be returned
+ *
+ * Poll a CQ for (possibly multiple) completions.  If the return value
+ * is < 0, an error occurred.  If the return value is >= 0, it is the
+ * number of completions returned.  If the return value is
+ * non-negative and < num_entries, then the CQ was emptied.
+ */
+static inline int ib_poll_cq(struct ib_cq *cq, int num_entries,
+			     struct ib_wc *wc)
+{
+	return cq->device->poll_cq(cq, num_entries, wc);
+}
+
+int ib_peek_cq(struct ib_cq *cq, int wc_cnt);
+
+/**
+ * ib_req_notify_cq - request completion notification
+ * @cq:the CQ to generate an event for
+ * @cq_notify:%IB_CQ_SOLICITED for next solicited event,
+ * %IB_CQ_NEXT_COMP for any completion.
+ */
+static inline int ib_req_notify_cq(struct ib_cq *cq,
+				   enum ib_cq_notify cq_notify)
+{
+	return cq->device->req_notify_cq(cq, cq_notify);
+}
+
+static inline int ib_req_ncomp_notif(struct ib_cq *cq, int wc_cnt)
+{
+	return cq->device->req_ncomp_notif ?
+		cq->device->req_ncomp_notif(cq, wc_cnt) :
+		-ENOSYS;
+}
+
+struct ib_mr *ib_get_dma_mr(struct ib_pd *pd, int mr_access_flags);
+
+struct ib_mr *ib_reg_phys_mr(struct ib_pd *pd,
+			     struct ib_phys_buf *phys_buf_array,
+			     int num_phys_buf,
+			     int mr_access_flags,
+			     u64 *iova_start);
+
+int ib_rereg_phys_mr(struct ib_mr *mr,
+		     int mr_rereg_mask,
+		     struct ib_pd *pd,
+		     struct ib_phys_buf *phys_buf_array,
+		     int num_phys_buf,
+		     int mr_access_flags,
+		     u64 *iova_start);
+
+int ib_query_mr(struct ib_mr *mr, struct ib_mr_attr *mr_attr);
+int ib_dereg_mr(struct ib_mr *mr);
+
+struct ib_mw *ib_alloc_mw(struct ib_pd *pd);
+
+static inline int ib_bind_mw(struct ib_qp *qp,
+			     struct ib_mw *mw,
+			     struct ib_mw_bind *mw_bind)
+{
+	/* XXX reference counting in corresponding MR? */
+	return mw->device->bind_mw ?
+		mw->device->bind_mw(qp, mw, mw_bind) :
+		-ENOSYS;
+}
+
+int ib_dealloc_mw(struct ib_mw *mw);
+
+struct ib_fmr *ib_alloc_fmr(struct ib_pd *pd,
+			    int mr_access_flags,
+			    struct ib_fmr_attr *fmr_attr);
+
+static inline int ib_map_phys_fmr(struct ib_fmr *fmr,
+				  u64 *page_list, int list_len,
+				  u64 iova)
+{
+	return fmr->device->map_phys_fmr(fmr, page_list, list_len, iova);
+}
+
+int ib_unmap_fmr(struct list_head *fmr_list);
+int ib_dealloc_fmr(struct ib_fmr *fmr);
+
+int ib_attach_mcast(struct ib_qp *qp, union ib_gid *gid, u16 lid);
+int ib_detach_mcast(struct ib_qp *qp, union ib_gid *gid, u16 lid);
+
+#endif /* IB_VERBS_H */

