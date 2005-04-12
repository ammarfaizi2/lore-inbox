Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVDLFSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVDLFSw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVDLFSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:18:52 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:61304 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262009AbVDLDY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 23:24:26 -0400
Message-ID: <425B3F58.2040000@yahoo.com>
Date: Mon, 11 Apr 2005 20:24:08 -0700
From: Alex Aizman <itn780@yahoo.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE 2/6] Linux-iSCSI High-Performance Initiator
Content-Type: multipart/mixed;
 boundary="------------000803060708070905060203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000803060708070905060203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

               Common header files:
               - iscsi_ifev.h (user/kernel events).
               - iscsi_if.h (user/kernel #defines);
               - iscsi_iftrans.h (iscsi transport interface);
               - iscsi_proto.h (RFC3720 #defines and types).

               Signed-off-by: Alex Aizman <itn780@yahoo.com>
               Signed-off-by: Dmitry Yusupov <dmitry_yus@yahoo.com>














--------------000803060708070905060203
Content-Type: text/plain;
 name="linux-iscsi-headers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-iscsi-headers.patch"

diff -Nru linux-2.6.12-rc2.orig/include/scsi/iscsi_ifev.h linux-2.6.12-rc2.dima/include/scsi/iscsi_ifev.h
--- linux-2.6.12-rc2.orig/include/scsi/iscsi_ifev.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12-rc2.dima/include/scsi/iscsi_ifev.h	2005-04-11 18:13:12.000000000 -0700
@@ -0,0 +1,118 @@
+/*
+ * iSCSI Kernel/User Interface Events
+ *
+ * Copyright (C) 2005 Dmitry Yusupov, Alex Aizman
+ * maintained by open-iscsi@googlegroups.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * See the file COPYING included with this distribution for more details.
+ */
+
+#ifndef ISCSI_IFEV_H
+#define ISCSI_IFEV_H
+
+enum iscsi_uevent_e {
+	ISCSI_UEVENT_UNKNOWN		= 0,
+
+	/* down events */
+	ISCSI_UEVENT_CREATE_SESSION	= UEVENT_BASE + 1,
+	ISCSI_UEVENT_DESTROY_SESSION	= UEVENT_BASE + 2,
+	ISCSI_UEVENT_CREATE_CNX		= UEVENT_BASE + 3,
+	ISCSI_UEVENT_DESTROY_CNX	= UEVENT_BASE + 4,
+	ISCSI_UEVENT_BIND_CNX		= UEVENT_BASE + 5,
+	ISCSI_UEVENT_SET_PARAM		= UEVENT_BASE + 6,
+	ISCSI_UEVENT_START_CNX		= UEVENT_BASE + 7,
+	ISCSI_UEVENT_STOP_CNX		= UEVENT_BASE + 8,
+	ISCSI_UEVENT_SEND_PDU		= UEVENT_BASE + 9,
+	ISCSI_UEVENT_TRANS_LIST		= UEVENT_BASE + 10,
+
+	/* up events */
+	ISCSI_KEVENT_RECV_PDU		= KEVENT_BASE + 1,
+	ISCSI_KEVENT_CNX_ERROR		= KEVENT_BASE + 2,
+	ISCSI_KEVENT_IF_ERROR		= KEVENT_BASE + 3,
+};
+
+struct iscsi_uevent {
+	uint32_t type; /* k/u events type */
+	uint32_t iferror; /* carries interface or resource errors */
+	uint64_t transport_handle;
+
+	union {
+		/* messages u -> k */
+		struct msg_create_session {
+			uint64_t	session_handle;
+			uint32_t	initial_cmdsn;
+		} c_session;
+		struct msg_destroy_session {
+			uint64_t	session_handle;
+			uint32_t	sid;
+		} d_session;
+		struct msg_create_cnx {
+			uint64_t	session_handle;
+			uint64_t	cnx_handle;
+			uint32_t	cid;
+			uint32_t	sid;
+		} c_cnx;
+		struct msg_bind_cnx {
+			uint64_t	session_handle;
+			uint64_t	cnx_handle;
+			uint32_t	transport_fd;
+			uint32_t	is_leading;
+		} b_cnx;
+		struct msg_destroy_cnx {
+			uint64_t	cnx_handle;
+			uint32_t	cid;
+		} d_cnx;
+		struct msg_send_pdu {
+			uint32_t	hdr_size;
+			uint32_t	data_size;
+			uint64_t	cnx_handle;
+		} send_pdu;
+		struct msg_set_param {
+			uint64_t	cnx_handle;
+			uint32_t	param; /* enum iscsi_param */
+			uint32_t	value;
+		} set_param;
+		struct msg_start_cnx {
+			uint64_t	cnx_handle;
+		} start_cnx;
+		struct msg_stop_cnx {
+			uint64_t	cnx_handle;
+			uint32_t	flag;
+		} stop_cnx;
+	} u;
+	union {
+		/* messages k -> u */
+		uint64_t		handle;
+		int			retcode;
+		struct msg_create_session_ret {
+			uint64_t	handle;
+			uint32_t	sid;
+		} c_session_ret;
+		struct msg_recv_req {
+			uint64_t	recv_handle;
+			uint64_t	cnx_handle;
+		} recv_req;
+		struct msg_cnx_error {
+			uint64_t	cnx_handle;
+			uint32_t	error; /* enum iscsi_err */
+		} cnxerror;
+		struct msg_trans_list {
+			struct {
+				uint64_t handle;
+				char name[ISCSI_TRANSPORT_NAME_MAXLEN];
+			} elements[ISCSI_TRANSPORT_MAX];
+		} t_list;
+	} r;
+};
+
+#endif /* ISCSI_IFEV_H */
diff -Nru linux-2.6.12-rc2.orig/include/scsi/iscsi_if.h linux-2.6.12-rc2.dima/include/scsi/iscsi_if.h
--- linux-2.6.12-rc2.orig/include/scsi/iscsi_if.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12-rc2.dima/include/scsi/iscsi_if.h	2005-04-11 18:13:12.000000000 -0700
@@ -0,0 +1,103 @@
+/*
+ * iSCSI User/Kernel Shares (Defines, Constants, Protocol definitions, etc)
+ *
+ * Copyright (C) 2005 Dmitry Yusupov, Alex Aizman
+ * maintained by open-iscsi@googlegroups.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * See the file COPYING included with this distribution for more details.
+ */
+
+#ifndef ISCSI_IF_H
+#define ISCSI_IF_H
+
+#include <scsi/iscsi_proto.h>
+
+#define ISCSI_TRANSPORT_NAME_MAXLEN	16
+#define ISCSI_TRANSPORT_MAX		1
+#define UEVENT_BASE			10
+#define KEVENT_BASE			100
+#define ISCSI_ERR_BASE			1000
+
+/*
+ * Common error codes
+ */
+enum iscsi_err {
+	ISCSI_OK			= 0,
+
+	ISCSI_ERR_DATASN		= ISCSI_ERR_BASE + 1,
+	ISCSI_ERR_DATA_OFFSET		= ISCSI_ERR_BASE + 2,
+	ISCSI_ERR_MAX_CMDSN		= ISCSI_ERR_BASE + 3,
+	ISCSI_ERR_EXP_CMDSN		= ISCSI_ERR_BASE + 4,
+	ISCSI_ERR_BAD_OPCODE		= ISCSI_ERR_BASE + 5,
+	ISCSI_ERR_DATALEN		= ISCSI_ERR_BASE + 6,
+	ISCSI_ERR_AHSLEN		= ISCSI_ERR_BASE + 7,
+	ISCSI_ERR_PROTO			= ISCSI_ERR_BASE + 8,
+	ISCSI_ERR_LUN			= ISCSI_ERR_BASE + 9,
+	ISCSI_ERR_BAD_ITT		= ISCSI_ERR_BASE + 10,
+	ISCSI_ERR_CNX_FAILED		= ISCSI_ERR_BASE + 11,
+	ISCSI_ERR_R2TSN			= ISCSI_ERR_BASE + 12,
+	ISCSI_ERR_SNX_FAILED		= ISCSI_ERR_BASE + 13,
+	ISCSI_ERR_HDR_DGST		= ISCSI_ERR_BASE + 14,
+	ISCSI_ERR_DATA_DGST		= ISCSI_ERR_BASE + 15,
+	ISCSI_ERR_PDU_GATHER_FAILED	= ISCSI_ERR_BASE + 16,
+	ISCSI_ERR_PARAM_NOT_FOUND	= ISCSI_ERR_BASE + 17
+};
+
+/*
+ * iSCSI Parameters (RFC3720)
+ */
+enum iscsi_param {
+	ISCSI_PARAM_MAX_RECV_DLENGTH	= 0,
+	ISCSI_PARAM_MAX_XMIT_DLENGTH	= 1,
+	ISCSI_PARAM_HDRDGST_EN		= 2,
+	ISCSI_PARAM_DATADGST_EN		= 3,
+	ISCSI_PARAM_INITIAL_R2T_EN	= 4,
+	ISCSI_PARAM_MAX_R2T		= 5,
+	ISCSI_PARAM_IMM_DATA_EN		= 6,
+	ISCSI_PARAM_FIRST_BURST		= 7,
+	ISCSI_PARAM_MAX_BURST		= 8,
+	ISCSI_PARAM_PDU_INORDER_EN	= 9,
+	ISCSI_PARAM_DATASEQ_INORDER_EN	= 10,
+	ISCSI_PARAM_ERL			= 11,
+	ISCSI_PARAM_IFMARKER_EN		= 12,
+	ISCSI_PARAM_OFMARKER_EN		= 13,
+};
+#define ISCSI_PARAM_MAX			14
+
+typedef uint64_t iscsi_snx_t;		/* iSCSI Data-Path session handle */
+typedef uint64_t iscsi_cnx_t;		/* iSCSI Data-Path connection handle */
+
+#define iscsi_ptr(_handle) ((void*)(unsigned long)_handle)
+#define iscsi_handle(_ptr) ((uint64_t)(unsigned long)_ptr)
+#define iscsi_hostdata(_hostdata) ((void*)_hostdata + sizeof(unsigned long))
+
+/*
+ * These flags presents iSCSI Data-Path capabilities.
+ */
+#define CAP_RECOVERY_L0		0x1
+#define CAP_RECOVERY_L1		0x2
+#define CAP_RECOVERY_L2		0x4
+#define CAP_MULTI_R2T		0x8
+#define CAP_HDRDGST		0x10
+#define CAP_DATADGST		0x20
+#define CAP_MULTI_CNX		0x40
+#define CAP_TEXT_NEGO		0x80
+
+/*
+ * These flags describes reason of stop_cnx() call
+ */
+#define STOP_CNX_TERM		0x1
+#define STOP_CNX_SUSPEND	0x2
+#define STOP_CNX_RECOVER	0x3
+
+#endif
diff -Nru linux-2.6.12-rc2.orig/include/scsi/iscsi_iftrans.h linux-2.6.12-rc2.dima/include/scsi/iscsi_iftrans.h
--- linux-2.6.12-rc2.orig/include/scsi/iscsi_iftrans.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12-rc2.dima/include/scsi/iscsi_iftrans.h	2005-04-11 18:13:12.000000000 -0700
@@ -0,0 +1,83 @@
+/*
+ * iSCSI Transport Interface
+ *
+ * Copyright (C) 2005 Dmitry Yusupov, Alex Aizman
+ * maintained by open-iscsi@googlegroups.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * See the file COPYING included with this distribution for more details.
+ */
+
+#ifndef ISCSI_IFTRANS_H
+#define ISCSI_IFTRANS_H
+
+#include <scsi/iscsi_if.h>
+
+/**
+ * struct iscsi_transport - down calls
+ *
+ * @name: transport name
+ * @caps: iSCSI Data-Path capabilities
+ * @create_snx: create new iSCSI session object
+ * @destroy_snx: destroy existing iSCSI session object
+ * @create_cnx: create new iSCSI connection
+ * @bind_cnx: associate this connection with existing iSCSI session and
+ *            specified transport descriptor
+ * @destroy_cnx: destroy inactive iSCSI connection
+ * @set_param: set iSCSI Data-Path operational parameter
+ * @start_cnx: set connection to be operational
+ * @stop_cnx: suspend connection
+ * @send_pdu: send iSCSI PDU, Login, Logout, NOP-Out, Reject, Text.
+ *
+ * API provided by iSCSI Initiator Data Path module
+ */
+struct iscsi_transport {
+	struct module *owner;
+	char *name;
+	unsigned int caps;
+	struct scsi_host_template *host_template;
+	int hostdata_size;
+	int max_lun;
+	unsigned int max_cnx;
+	unsigned int max_cmd_len;
+	iscsi_snx_t (*create_session) (iscsi_snx_t cp_snx,
+			uint32_t initial_cmdsn, struct Scsi_Host *shost);
+	void (*destroy_session) (iscsi_snx_t dp_snx);
+	iscsi_cnx_t (*create_cnx) (iscsi_snx_t dp_snx, iscsi_cnx_t cp_cnx,
+			uint32_t cid);
+	int (*bind_cnx) (iscsi_snx_t dp_snx, iscsi_cnx_t dp_cnx,
+			uint32_t transport_fd, int is_leading);
+	int (*start_cnx) (iscsi_cnx_t dp_cnx);
+	void (*stop_cnx) (iscsi_cnx_t dp_cnx, int flag);
+	void (*destroy_cnx) (iscsi_cnx_t dp_cnx);
+	int (*set_param) (iscsi_cnx_t dp_cnx, enum iscsi_param param,
+			  uint32_t value);
+	int (*get_param) (iscsi_cnx_t dp_cnx, enum iscsi_param param,
+			  uint32_t *value);
+	int (*send_pdu) (iscsi_cnx_t dp_cnx, struct iscsi_hdr *hdr,
+			 char *data, uint32_t data_size);
+};
+
+/*
+ * transport registration upcalls
+ */
+extern int iscsi_register_transport(struct iscsi_transport *t);
+extern int iscsi_unregister_transport(struct iscsi_transport *t);
+
+/*
+ * control plane "up" calls
+ */
+extern void iscsi_cnx_error(iscsi_cnx_t cp_cnx, enum iscsi_err error);
+extern int iscsi_recv_pdu(iscsi_cnx_t cp_cnx, struct iscsi_hdr *hdr,
+				char *data, uint32_t data_size);
+
+#endif /* ISCSI_IFTRANS_H */
diff -Nru linux-2.6.12-rc2.orig/include/scsi/iscsi_proto.h linux-2.6.12-rc2.dima/include/scsi/iscsi_proto.h
--- linux-2.6.12-rc2.orig/include/scsi/iscsi_proto.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12-rc2.dima/include/scsi/iscsi_proto.h	2005-04-11 18:13:12.000000000 -0700
@@ -0,0 +1,565 @@
+/*
+ * RFC 3720 (iSCSI) protocol data types
+ *
+ * Copyright (C) 2005 Dmitry Yusupov, Alex Aizman
+ * maintained by open-iscsi@googlegroups.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * See the file COPYING included with this distribution for more details.
+ */
+
+#ifndef ISCSI_PROTO_H
+#define ISCSI_PROTO_H
+
+#define ISCSI_VERSION_STR	"0.2"
+#define ISCSI_DATE_STR		"15-Mar-2005"
+#define ISCSI_DRAFT20_VERSION	0x00
+
+/* default iSCSI listen port for incoming connections */
+#define ISCSI_LISTEN_PORT	3260
+
+/* Padding word length */
+#define PAD_WORD_LEN		4
+
+/*
+ * useful common(control and data pathes) macro
+ */
+#define ntoh24(p) (((p)[0] << 16) | ((p)[1] << 8) | ((p)[2]))
+#define hton24(p, v) { \
+        p[0] = (((v) >> 16) & 0xFF); \
+        p[1] = (((v) >> 8) & 0xFF); \
+        p[2] = ((v) & 0xFF); \
+}
+#define zero_data(p) {p[0]=0;p[1]=0;p[2]=0;}
+
+/*
+ * iSCSI Template Message Header
+ */
+struct iscsi_hdr {
+	uint8_t		opcode;
+	uint8_t		flags;		/* Final bit */
+	uint8_t		rsvd2[2];
+	uint8_t		hlength;	/* AHSs total length */
+	uint8_t		dlength[3];	/* Data length */
+	uint8_t		lun[8];
+	uint32_t	itt;		/* Initiator Task Tag */
+	uint32_t	ttt;		/* Target Task Tag */
+	uint32_t	statsn;
+	uint32_t	exp_statsn;
+	uint8_t		other[16];
+};
+
+/************************* RFC 3720 Begin *****************************/
+
+#define ISCSI_RESERVED_TAG		0xffffffff
+
+/* Opcode encoding bits */
+#define ISCSI_OP_RETRY			0x80
+#define ISCSI_OP_IMMEDIATE		0x40
+#define ISCSI_OPCODE_MASK		0x3F
+
+/* Initiator Opcode values */
+#define ISCSI_OP_NOOP_OUT		0x00
+#define ISCSI_OP_SCSI_CMD		0x01
+#define ISCSI_OP_SCSI_TMFUNC		0x02
+#define ISCSI_OP_LOGIN			0x03
+#define ISCSI_OP_TEXT			0x04
+#define ISCSI_OP_SCSI_DATA_OUT		0x05
+#define ISCSI_OP_LOGOUT			0x06
+#define ISCSI_OP_SNACK			0x10
+
+/* Target Opcode values */
+#define ISCSI_OP_NOOP_IN		0x20
+#define ISCSI_OP_SCSI_CMD_RSP		0x21
+#define ISCSI_OP_SCSI_TMFUNC_RSP	0x22
+#define ISCSI_OP_LOGIN_RSP		0x23
+#define ISCSI_OP_TEXT_RSP		0x24
+#define ISCSI_OP_SCSI_DATA_IN		0x25
+#define ISCSI_OP_LOGOUT_RSP		0x26
+#define ISCSI_OP_R2T			0x31
+#define ISCSI_OP_ASYNC_EVENT		0x32
+#define ISCSI_OP_REJECT			0x3f
+
+/* SCSI Command Header */
+struct iscsi_cmd {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd2;
+	uint8_t cmdrn;
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t lun[8];
+	uint32_t itt;	/* Initiator Task Tag */
+	uint32_t data_length;
+	uint32_t cmdsn;
+	uint32_t exp_statsn;
+	uint8_t cdb[16];	/* SCSI Command Block */
+	/* Additional Data (Command Dependent) */
+};
+
+/* Command PDU flags */
+#define ISCSI_FLAG_CMD_FINAL		0x80
+#define ISCSI_FLAG_CMD_READ		0x40
+#define ISCSI_FLAG_CMD_WRITE		0x20
+#define ISCSI_FLAG_CMD_ATTR_MASK	0x07	/* 3 bits */
+
+/* SCSI Command Attribute values */
+#define ISCSI_ATTR_UNTAGGED		0
+#define ISCSI_ATTR_SIMPLE		1
+#define ISCSI_ATTR_ORDERED		2
+#define ISCSI_ATTR_HEAD_OF_QUEUE	3
+#define ISCSI_ATTR_ACA			4
+
+/* SCSI Response Header */
+struct iscsi_cmd_rsp {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t response;
+	uint8_t cmd_status;
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t rsvd[8];
+	uint32_t itt;	/* Initiator Task Tag */
+	uint32_t rsvd1;
+	uint32_t statsn;
+	uint32_t exp_cmdsn;
+	uint32_t max_cmdsn;
+	uint32_t exp_datasn;
+	uint32_t bi_residual_count;
+	uint32_t residual_count;
+	/* Response or Sense Data (optional) */
+};
+
+/* Command Response PDU flags */
+#define ISCSI_FLAG_CMD_BIDI_OVERFLOW	0x10
+#define ISCSI_FLAG_CMD_BIDI_UNDERFLOW	0x08
+#define ISCSI_FLAG_CMD_OVERFLOW		0x04
+#define ISCSI_FLAG_CMD_UNDERFLOW	0x02
+
+/* iSCSI Status values. Valid if Rsp Selector bit is not set */
+#define ISCSI_STATUS_CMD_COMPLETED	0
+#define ISCSI_STATUS_TARGET_FAILURE	1
+#define ISCSI_STATUS_SUBSYS_FAILURE	2
+
+/* Asynchronous Event Header */
+struct iscsi_async {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd2[2];
+	uint8_t rsvd3;
+	uint8_t dlength[3];
+	uint8_t lun[8];
+	uint8_t rsvd4[8];
+	uint32_t statsn;
+	uint32_t exp_cmdsn;
+	uint32_t max_cmdsn;
+	uint8_t async_event;
+	uint8_t async_vcode;
+	uint16_t param1;
+	uint16_t param2;
+	uint16_t param3;
+	uint8_t rsvd5[4];
+};
+
+/* iSCSI Event Codes */
+#define ISCSI_ASYNC_MSG_SCSI_EVENT			0
+#define ISCSI_ASYNC_MSG_REQUEST_LOGOUT			1
+#define ISCSI_ASYNC_MSG_DROPPING_CONNECTION		2
+#define ISCSI_ASYNC_MSG_DROPPING_ALL_CONNECTIONS	3
+#define ISCSI_ASYNC_MSG_PARAM_NEGOTIATION		4
+#define ISCSI_ASYNC_MSG_VENDOR_SPECIFIC			255
+
+/* NOP-Out Message */
+struct iscsi_nopout {
+	uint8_t opcode;
+	uint8_t flags;
+	uint16_t rsvd2;
+	uint8_t rsvd3;
+	uint8_t dlength[3];
+	uint8_t lun[8];
+	uint32_t itt;	/* Initiator Task Tag */
+	uint32_t ttt;	/* Target Transfer Tag */
+	uint32_t cmdsn;
+	uint32_t exp_statsn;
+	uint8_t rsvd4[16];
+};
+
+/* NOP-In Message */
+struct iscsi_nopin {
+	uint8_t opcode;
+	uint8_t flags;
+	uint16_t rsvd2;
+	uint8_t rsvd3;
+	uint8_t dlength[3];
+	uint8_t lun[8];
+	uint32_t itt;	/* Initiator Task Tag */
+	uint32_t ttt;	/* Target Transfer Tag */
+	uint32_t statsn;
+	uint32_t exp_cmdsn;
+	uint32_t max_cmdsn;
+	uint8_t rsvd4[12];
+};
+
+/* SCSI Task Management Message Header */
+struct iscsi_tm {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd1[2];
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t lun[8];
+	uint32_t itt;	/* Initiator Task Tag */
+	uint32_t rtt;	/* Reference Task Tag */
+	uint32_t cmdsn;
+	uint32_t exp_statsn;
+	uint32_t refcmdsn;
+	uint32_t exp_datasn;
+	uint8_t rsvd2[8];
+};
+
+#define ISCSI_FLAG_TASK_MGMT_FUNCTION_MASK	0x7F
+
+/* Function values */
+#define ISCSI_TM_FUNC_ABORT_TASK		1
+#define ISCSI_TM_FUNC_ABORT_TASK_SET		2
+#define ISCSI_TM_FUNC_CLEAR_ACA			3
+#define ISCSI_TM_FUNC_CLEAR_TASK_SET		4
+#define ISCSI_TM_FUNC_LOGICAL_UNIT_RESET	5
+#define ISCSI_TM_FUNC_TARGET_WARM_RESET		6
+#define ISCSI_TM_FUNC_TARGET_COLD_RESET		7
+#define ISCSI_TM_FUNC_TASK_REASSIGN		8
+
+/* SCSI Task Management Response Header */
+struct iscsi_tm_rsp {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t response;	/* see Response values below */
+	uint8_t qualifier;
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t rsvd2[8];
+	uint32_t itt;	/* Initiator Task Tag */
+	uint32_t rtt;	/* Reference Task Tag */
+	uint32_t statsn;
+	uint32_t exp_cmdsn;
+	uint32_t max_cmdsn;
+	uint8_t rsvd3[12];
+};
+
+/* Response values */
+#define SCSI_TCP_TM_RESP_COMPLETE	0x00
+#define SCSI_TCP_TM_RESP_NO_TASK	0x01
+#define SCSI_TCP_TM_RESP_NO_LUN		0x02
+#define SCSI_TCP_TM_RESP_TASK_ALLEGIANT	0x03
+#define SCSI_TCP_TM_RESP_NO_FAILOVER	0x04
+#define SCSI_TCP_TM_RESP_NOT_SUPPORTED	0x05
+#define SCSI_TCP_TM_RESP_AUTH_FAILED	0x06
+#define SCSI_TCP_TM_RESP_REJECTED	0xff
+
+/* Ready To Transfer Header */
+struct iscsi_r2t_rsp {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd2[2];
+	uint8_t	hlength;
+	uint8_t	dlength[3];
+	uint8_t lun[8];
+	uint32_t itt;	/* Initiator Task Tag */
+	uint32_t ttt;	/* Target Transfer Tag */
+	uint32_t statsn;
+	uint32_t exp_cmdsn;
+	uint32_t max_cmdsn;
+	uint32_t r2tsn;
+	uint32_t data_offset;
+	uint32_t data_length;
+};
+
+/* SCSI Data Hdr */
+struct iscsi_data {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd2[2];
+	uint8_t rsvd3;
+	uint8_t dlength[3];
+	uint8_t lun[8];
+	uint32_t itt;
+	uint32_t ttt;
+	uint32_t rsvd4;
+	uint32_t exp_statsn;
+	uint32_t rsvd5;
+	uint32_t datasn;
+	uint32_t offset;
+	uint32_t rsvd6;
+	/* Payload */
+};
+
+/* SCSI Data Response Hdr */
+struct iscsi_data_rsp {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd2;
+	uint8_t cmd_status;
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t lun[8];
+	uint32_t itt;
+	uint32_t ttt;
+	uint32_t statsn;
+	uint32_t exp_cmdsn;
+	uint32_t max_cmdsn;
+	uint32_t datasn;
+	uint32_t offset;
+	uint32_t residual_count;
+};
+
+/* Data Response PDU flags */
+#define ISCSI_FLAG_DATA_ACK		0x40
+#define ISCSI_FLAG_DATA_OVERFLOW	0x04
+#define ISCSI_FLAG_DATA_UNDERFLOW	0x02
+#define ISCSI_FLAG_DATA_STATUS		0x01
+
+/* Text Header */
+struct iscsi_text {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd2[2];
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t rsvd4[8];
+	uint32_t itt;
+	uint32_t ttt;
+	uint32_t cmdsn;
+	uint32_t exp_statsn;
+	uint8_t rsvd5[16];
+	/* Text - key=value pairs */
+};
+
+#define ISCSI_FLAG_TEXT_CONTINUE	0x40
+
+/* Text Response Header */
+struct iscsi_text_rsp {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd2[2];
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t rsvd4[8];
+	uint32_t itt;
+	uint32_t ttt;
+	uint32_t statsn;
+	uint32_t exp_cmdsn;
+	uint32_t max_cmdsn;
+	uint8_t rsvd5[12];
+	/* Text Response - key:value pairs */
+};
+
+/* Login Header */
+struct iscsi_login {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t max_version;	/* Max. version supported */
+	uint8_t min_version;	/* Min. version supported */
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t isid[6];	/* Initiator Session ID */
+	uint16_t tsih;	/* Target Session Handle */
+	uint32_t itt;	/* Initiator Task Tag */
+	uint16_t cid;
+	uint16_t rsvd3;
+	uint32_t cmdsn;
+	uint32_t exp_statsn;
+	uint8_t rsvd5[16];
+};
+
+/* Login PDU flags */
+#define ISCSI_FLAG_LOGIN_TRANSIT		0x80
+#define ISCSI_FLAG_LOGIN_CONTINUE		0x40
+#define ISCSI_FLAG_LOGIN_CURRENT_STAGE_MASK	0x0C	/* 2 bits */
+#define ISCSI_FLAG_LOGIN_NEXT_STAGE_MASK	0x03	/* 2 bits */
+
+#define ISCSI_LOGIN_CURRENT_STAGE(flags) \
+	((flags & ISCSI_FLAG_LOGIN_CURRENT_STAGE_MASK) >> 2)
+#define ISCSI_LOGIN_NEXT_STAGE(flags) \
+	(flags & ISCSI_FLAG_LOGIN_NEXT_STAGE_MASK)
+
+/* Login Response Header */
+struct iscsi_login_rsp {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t max_version;	/* Max. version supported */
+	uint8_t active_version;	/* Active version */
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t isid[6];	/* Initiator Session ID */
+	uint16_t tsih;	/* Target Session Handle */
+	uint32_t itt;	/* Initiator Task Tag */
+	uint32_t rsvd3;
+	uint32_t statsn;
+	uint32_t exp_cmdsn;
+	uint32_t max_cmdsn;
+	uint8_t status_class;	/* see Login RSP ststus classes below */
+	uint8_t status_detail;	/* see Login RSP Status details below */
+	uint8_t rsvd4[10];
+};
+
+/* Login stage (phase) codes for CSG, NSG */
+#define ISCSI_INITIAL_LOGIN_STAGE		-1
+#define ISCSI_SECURITY_NEGOTIATION_STAGE	0
+#define ISCSI_OP_PARMS_NEGOTIATION_STAGE	1
+#define ISCSI_FULL_FEATURE_PHASE		3
+
+/* Login Status response classes */
+#define ISCSI_STATUS_CLS_SUCCESS		0x00
+#define ISCSI_STATUS_CLS_REDIRECT		0x01
+#define ISCSI_STATUS_CLS_INITIATOR_ERR		0x02
+#define ISCSI_STATUS_CLS_TARGET_ERR		0x03
+
+/* Login Status response detail codes */
+/* Class-0 (Success) */
+#define ISCSI_LOGIN_STATUS_ACCEPT		0x00
+
+/* Class-1 (Redirection) */
+#define ISCSI_LOGIN_STATUS_TGT_MOVED_TEMP	0x01
+#define ISCSI_LOGIN_STATUS_TGT_MOVED_PERM	0x02
+
+/* Class-2 (Initiator Error) */
+#define ISCSI_LOGIN_STATUS_INIT_ERR		0x00
+#define ISCSI_LOGIN_STATUS_AUTH_FAILED		0x01
+#define ISCSI_LOGIN_STATUS_TGT_FORBIDDEN	0x02
+#define ISCSI_LOGIN_STATUS_TGT_NOT_FOUND	0x03
+#define ISCSI_LOGIN_STATUS_TGT_REMOVED		0x04
+#define ISCSI_LOGIN_STATUS_NO_VERSION		0x05
+#define ISCSI_LOGIN_STATUS_ISID_ERROR		0x06
+#define ISCSI_LOGIN_STATUS_MISSING_FIELDS	0x07
+#define ISCSI_LOGIN_STATUS_CONN_ADD_FAILED	0x08
+#define ISCSI_LOGIN_STATUS_NO_SESSION_TYPE	0x09
+#define ISCSI_LOGIN_STATUS_NO_SESSION		0x0a
+#define ISCSI_LOGIN_STATUS_INVALID_REQUEST	0x0b
+
+/* Class-3 (Target Error) */
+#define ISCSI_LOGIN_STATUS_TARGET_ERROR		0x00
+#define ISCSI_LOGIN_STATUS_SVC_UNAVAILABLE	0x01
+#define ISCSI_LOGIN_STATUS_NO_RESOURCES		0x02
+
+/* Logout Header */
+struct iscsi_logout {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd1[2];
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t rsvd2[8];
+	uint32_t itt;	/* Initiator Task Tag */
+	uint16_t cid;
+	uint8_t rsvd3[2];
+	uint32_t cmdsn;
+	uint32_t exp_statsn;
+	uint8_t rsvd4[16];
+};
+
+/* Logout PDU flags */
+#define ISCSI_FLAG_LOGOUT_REASON_MASK	0x7F
+
+/* logout reason_code values */
+
+#define ISCSI_LOGOUT_REASON_CLOSE_SESSION	0
+#define ISCSI_LOGOUT_REASON_CLOSE_CONNECTION	1
+#define ISCSI_LOGOUT_REASON_RECOVERY		2
+#define ISCSI_LOGOUT_REASON_AEN_REQUEST		3
+
+/* Logout Response Header */
+struct iscsi_logout_rsp {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t response;	/* see Logout response values below */
+	uint8_t rsvd2;
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t rsvd3[8];
+	uint32_t itt;	/* Initiator Task Tag */
+	uint32_t rsvd4;
+	uint32_t statsn;
+	uint32_t exp_cmdsn;
+	uint32_t max_cmdsn;
+	uint32_t rsvd5;
+	uint16_t t2wait;
+	uint16_t t2retain;
+	uint32_t rsvd6;
+};
+
+/* logout response status values */
+
+#define ISCSI_LOGOUT_SUCCESS			0
+#define ISCSI_LOGOUT_CID_NOT_FOUND		1
+#define ISCSI_LOGOUT_RECOVERY_UNSUPPORTED	2
+#define ISCSI_LOGOUT_CLEANUP_FAILED		3
+
+/* SNACK Header */
+struct iscsi_snack {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd2[14];
+	uint32_t itt;
+	uint32_t begrun;
+	uint32_t runlength;
+	uint32_t exp_statsn;
+	uint32_t rsvd3;
+	uint32_t exp_datasn;
+	uint8_t rsvd6[8];
+};
+
+/* SNACK PDU flags */
+#define ISCSI_FLAG_SNACK_TYPE_MASK	0x0F	/* 4 bits */
+
+/* Reject Message Header */
+struct iscsi_reject {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t reason;
+	uint8_t rsvd2;
+	uint8_t rsvd3;
+	uint8_t dlength[3];
+	uint8_t rsvd4[16];
+	uint32_t statsn;
+	uint32_t exp_cmdsn;
+	uint32_t max_cmdsn;
+	uint32_t datasn;
+	uint8_t rsvd5[8];
+	/* Text - Rejected hdr */
+};
+
+/* Reason for Reject */
+#define CMD_BEFORE_LOGIN	1
+#define DATA_DIGEST_ERROR	2
+#define DATA_SNACK_REJECT	3
+#define ISCSI_PROTOCOL_ERROR	4
+#define CMD_NOT_SUPPORTED	5
+#define IMM_CMD_REJECT		6
+#define TASK_IN_PROGRESS	7
+#define INVALID_SNACK		8
+#define BOOKMARK_REJECTED	9
+#define BOOKMARK_NO_RESOURCES	10
+#define NEGOTIATION_RESET	11
+
+/* Max. number of Key=Value pairs in a text message */
+#define MAX_KEY_VALUE_PAIRS	8192
+
+/* maximum length for text keys/values */
+#define KEY_MAXLEN		64
+#define VALUE_MAXLEN		255
+#define TARGET_NAME_MAXLEN	VALUE_MAXLEN
+
+#define DEFAULT_MAX_RECV_DATA_SEGMENT_LENGTH	8192
+
+/************************* RFC 3720 End *****************************/
+
+#endif /* ISCSI_PROTO_H */





--------------000803060708070905060203--
