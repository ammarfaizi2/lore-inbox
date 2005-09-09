Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbVIIWX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbVIIWX3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbVIIWX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:23:29 -0400
Received: from magic.adaptec.com ([216.52.22.17]:37101 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932584AbVIIWX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:23:27 -0400
Message-ID: <43220B58.1040407@adaptec.com>
Date: Fri, 09 Sep 2005 18:23:20 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [PATCH 2.6.13 15/14+1] sas-class: include files in include/scsi/sas/
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 22:23:25.0476 (UTC) FILETIME=[186D4E40:01C5B58D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Those files live in include/scsi/sas/ and were missed in the
previous patchset:

sas.h
sas_class.h
sas_discover.h
sas_expander.h
sas_frames.h
sas_frames_be.h
sas_frames_le.h
sas_task.h

Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>

diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/include/scsi/sas/sas.h linux-2.6.13/include/scsi/sas/sas.h
--- linux-2.6.13-orig/include/scsi/sas/sas.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/include/scsi/sas/sas.h	2005-09-09 11:13:28.000000000 -0400
@@ -0,0 +1,164 @@
+/*
+ * SAS structures and definitions header file
+ * 
+ * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+ * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+ *
+ * This file is licensed under GPLv2.
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
+ * USA
+ *
+ * $Id: //depot/sas-class/sas.h#23 $
+ */
+
+#ifndef _SAS_H_
+#define _SAS_H_
+
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+#define SAS_ADDR_SIZE        8
+#define HASHED_SAS_ADDR_SIZE 3
+#define SAS_ADDR(_sa)   (be64_to_cpu(*(__be64 *)(_sa)))
+
+enum sas_oob_mode {
+	OOB_NOT_CONNECTED,
+	SATA_OOB_MODE,
+	SAS_OOB_MODE
+};
+
+/* See sas_discover.c if you plan on changing these.
+ */
+enum sas_dev_type {
+	NO_DEVICE   = 0,	  /* protocol */
+	SAS_END_DEV = 1,	  /* protocol */
+	EDGE_DEV    = 2,	  /* protocol */
+	FANOUT_DEV  = 3,	  /* protocol */
+	SAS_HA      = 4,
+	SATA_DEV    = 5,
+	SATA_PM     = 7,
+	SATA_PM_PORT= 8,
+};
+
+enum sas_phy_linkrate {
+	PHY_LINKRATE_NONE = 0,
+	PHY_LINKRATE_UNKNOWN = 0,
+	PHY_DISABLED,
+	PHY_RESET_PROBLEM,
+	PHY_SPINUP_HOLD,
+	PHY_PORT_SELECTOR,
+        PHY_LINKRATE_1_5 = 0x08,
+	PHY_LINKRATE_G1  = PHY_LINKRATE_1_5,
+	PHY_LINKRATE_3   = 0x09,
+	PHY_LINKRATE_G2  = PHY_LINKRATE_3,
+	PHY_LINKRATE_6   = 0x0A,
+};
+
+/* Partly from IDENTIFY address frame. */
+enum sas_proto {
+	SATA_PROTO    = 1,
+	SAS_PROTO_SMP = 2,	  /* protocol */
+	SAS_PROTO_STP = 4,	  /* protocol */
+	SAS_PROTO_SSP = 8,	  /* protocol */
+	SAS_PROTO_ALL = 0xE,
+};
+
+/* From the spec; local phys only */
+enum phy_func {
+	PHY_FUNC_NOP,
+	PHY_FUNC_LINK_RESET,		  /* Enables the phy */
+	PHY_FUNC_HARD_RESET,
+	PHY_FUNC_DISABLE,
+	PHY_FUNC_CLEAR_ERROR_LOG = 5,
+	PHY_FUNC_CLEAR_AFFIL,
+	PHY_FUNC_TX_SATA_PS_SIGNAL,
+	PHY_FUNC_RELEASE_SPINUP_HOLD = 0x10, /* LOCAL PORT ONLY! */
+};
+
+#include <scsi/sas/sas_frames.h>
+
+/* SAS LLDD would need to report only _very_few_ of those, like BROADCAST.
+ * Most of those are here for completeness.
+ */
+enum sas_prim {
+	SAS_PRIM_AIP_NORMAL = 1,
+	SAS_PRIM_AIP_R0     = 2,
+	SAS_PRIM_AIP_R1     = 3,
+	SAS_PRIM_AIP_R2     = 4,
+	SAS_PRIM_AIP_WC     = 5,
+	SAS_PRIM_AIP_WD     = 6,
+	SAS_PRIM_AIP_WP     = 7,
+	SAS_PRIM_AIP_RWP    = 8,
+
+	SAS_PRIM_BC_CH      = 9,
+	SAS_PRIM_BC_RCH0    = 10,
+	SAS_PRIM_BC_RCH1    = 11,
+	SAS_PRIM_BC_R0      = 12,
+	SAS_PRIM_BC_R1      = 13,
+	SAS_PRIM_BC_R2      = 14,
+	SAS_PRIM_BC_R3      = 15,
+	SAS_PRIM_BC_R4      = 16,
+
+	SAS_PRIM_NOTIFY_ENSP= 17,
+	SAS_PRIM_NOTIFY_R0  = 18,
+	SAS_PRIM_NOTIFY_R1  = 19,
+	SAS_PRIM_NOTIFY_R2  = 20,
+
+	SAS_PRIM_CLOSE_CLAF = 21,
+	SAS_PRIM_CLOSE_NORM = 22,
+	SAS_PRIM_CLOSE_R0   = 23,
+	SAS_PRIM_CLOSE_R1   = 24,
+
+	SAS_PRIM_OPEN_RTRY  = 25,
+	SAS_PRIM_OPEN_RJCT  = 26,
+	SAS_PRIM_OPEN_ACPT  = 27,
+
+	SAS_PRIM_DONE       = 28,
+	SAS_PRIM_BREAK      = 29,
+
+	SATA_PRIM_DMAT      = 33,
+	SATA_PRIM_PMNAK     = 34,
+	SATA_PRIM_PMACK     = 35,
+	SATA_PRIM_PMREQ_S   = 36,
+	SATA_PRIM_PMREQ_P   = 37,
+	SATA_SATA_R_ERR     = 38,
+};
+
+enum sas_open_rej_reason {
+	/* Abandon open */
+	SAS_OREJ_UNKNOWN   = 0,
+	SAS_OREJ_BAD_DEST  = 1,
+	SAS_OREJ_CONN_RATE = 2,
+	SAS_OREJ_EPROTO    = 3,
+	SAS_OREJ_RESV_AB0  = 4,
+	SAS_OREJ_RESV_AB1  = 5,
+	SAS_OREJ_RESV_AB2  = 6,
+	SAS_OREJ_RESV_AB3  = 7,
+	SAS_OREJ_WRONG_DEST= 8,
+	SAS_OREJ_STP_NORES = 9,
+
+	/* Retry open */
+	SAS_OREJ_NO_DEST   = 10,
+	SAS_OREJ_PATH_BLOCKED = 11,
+	SAS_OREJ_RSVD_CONT0 = 12,
+	SAS_OREJ_RSVD_CONT1 = 13,
+	SAS_OREJ_RSVD_INIT0 = 14,
+	SAS_OREJ_RSVD_INIT1 = 15,
+	SAS_OREJ_RSVD_STOP0 = 16,
+	SAS_OREJ_RSVD_STOP1 = 17,
+	SAS_OREJ_RSVD_RETRY = 18,
+};
+#endif /* _SAS_H_ */
diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/include/scsi/sas/sas_class.h linux-2.6.13/include/scsi/sas/sas_class.h
--- linux-2.6.13-orig/include/scsi/sas/sas_class.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/include/scsi/sas/sas_class.h	2005-09-09 11:13:28.000000000 -0400
@@ -0,0 +1,300 @@
+/*
+ * Serial Attached SCSI (SAS) class header file
+ *
+ * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+ * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+ *
+ * This file is licensed under GPLv2.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
+ * USA
+ *
+ * $Id: //depot/sas-class/sas_class.h#65 $
+ */
+
+#ifndef _SAS_CLASS_H_
+#define _SAS_CLASS_H_
+
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <asm/semaphore.h>
+#include <scsi/sas/sas.h>
+
+enum sas_class {
+	SAS,
+	EXPANDER
+};
+
+enum sas_phy_role {
+	PHY_ROLE_NONE = 0,
+	PHY_ROLE_TARGET = 0x40,
+	PHY_ROLE_INITIATOR = 0x80,
+};
+
+enum sas_phy_type {
+        PHY_TYPE_PHYSICAL,
+        PHY_TYPE_VIRTUAL
+};
+
+/* The events are mnemonically described in sas_dump.c
+ * so when updating/adding events here, please also
+ * update the other file too.
+ */
+enum ha_event {
+	HAE_RESET = 0U,
+};
+#define HA_NUM_EVENTS 1
+
+enum port_event {
+	PORTE_BYTES_DMAED     = 0U,
+	PORTE_BROADCAST_RCVD  = 1,
+	PORTE_LINK_RESET_ERR  = 2,
+	PORTE_TIMER_EVENT     = 3,
+	PORTE_HARD_RESET      = 4,
+};
+#define PORT_NUM_EVENTS 5
+
+enum phy_event {
+	PHYE_LOSS_OF_SIGNAL   = 0U,
+	PHYE_OOB_DONE         = 1,
+	PHYE_OOB_ERROR        = 2,
+	PHYE_SPINUP_HOLD      = 3, /* hot plug SATA, no COMWAKE sent */
+};
+#define PHY_NUM_EVENTS 4
+
+enum discover_event {
+	DISCE_DISCOVER_DOMAIN   = 0U,
+	DISCE_REVALIDATE_DOMAIN = 1,
+	DISCE_PORT_GONE         = 2,
+};
+#define DISC_NUM_EVENTS 3
+
+struct sas_event {
+	int    event;
+	struct list_head el;
+};
+
+/* The phy pretty much is controlled by the LLDD.
+ * The class only reads those fields.
+ */
+struct sas_phy {
+/* private: */
+	struct kobject phy_kobj;
+
+	/* protected by ha->event_lock */
+	struct list_head   port_event_list;
+	struct list_head   phy_event_list;
+	struct sas_event   port_events[PORT_NUM_EVENTS];
+	struct sas_event   phy_events[PHY_NUM_EVENTS];
+
+	int error;
+
+/* public: */	
+	/* The following are class:RO, driver:R/W */
+	int            enabled;	  /* must be set */
+	
+	int            id;	  /* must be set */
+	enum sas_class class;
+	enum sas_proto iproto;
+	enum sas_proto tproto;
+	
+	enum sas_phy_type  type;
+	enum sas_phy_role  role;
+	enum sas_oob_mode  oob_mode;
+	enum sas_phy_linkrate linkrate;
+
+	u8   *sas_addr;		  /* must be set */
+	u8   attached_sas_addr[SAS_ADDR_SIZE]; /* class:RO, driver: R/W */
+
+	spinlock_t     frame_rcvd_lock;
+	u8             *frame_rcvd; /* must be set */
+	int            frame_rcvd_size;
+
+	spinlock_t     sas_prim_lock;
+	u32            sas_prim;
+
+	struct list_head port_phy_el; /* driver:RO */
+	struct sas_port      *port; /* Class:RW, driver: RO */
+
+	struct sas_ha_struct *ha; /* may be set; the class sets it anyway */
+
+	void *lldd_phy;		  /* not touched by the sas_class_code */
+};
+
+struct sas_port;
+
+struct sas_discovery {
+	spinlock_t disc_event_lock;
+	int        disc_thread_quit;
+	struct list_head disc_event_list;
+	struct sas_event disc_events[DISC_NUM_EVENTS];
+	struct task_struct *disc_thread;
+	struct semaphore  disc_sema;
+
+	u8     fanout_sas_addr[8];
+	u8     eeds_a[8];
+	u8     eeds_b[8];
+	int    max_level;
+};
+
+struct scsi_id_map {
+	int         max_ids;
+	spinlock_t  id_bitmap_lock;
+	int         id_bitmap_size;
+	void       *id_bitmap;
+};
+
+struct domain_device;
+
+/* The port struct is Class:RW, driver:RO */
+struct sas_port {
+/* private: */
+	struct kobject port_kobj;
+	struct kset    phy_kset;
+	struct kset    dev_kset;
+
+	struct completion port_gone_completion;
+
+	struct sas_discovery disc;
+	struct domain_device *port_dev;
+	struct list_head dev_list;
+	enum   sas_phy_linkrate linkrate;
+
+	struct scsi_id_map id_map;
+
+/* public: */	
+	int id;
+	
+	enum sas_class   class;
+	u8               sas_addr[SAS_ADDR_SIZE];
+	u8               attached_sas_addr[SAS_ADDR_SIZE];
+	enum sas_proto   iproto;
+	enum sas_proto   tproto;
+	
+	enum sas_oob_mode oob_mode;
+
+	spinlock_t       phy_list_lock;
+	struct list_head phy_list;
+	int              num_phys;
+	u32              phy_mask;
+
+	struct sas_ha_struct *ha;
+
+	void *lldd_port;	  /* not touched by the sas class code */
+};
+
+struct sas_task;
+
+struct scsi_core {
+	struct kobject scsi_core_obj;
+	
+	struct scsi_host_template *sht;
+	struct Scsi_Host *shost;
+
+	spinlock_t        task_queue_lock;
+	struct list_head  task_queue;
+	int               task_queue_size;
+
+	struct semaphore  queue_thread_sema;
+	int               queue_thread_kill;
+};
+
+struct sas_ha_struct {
+/* private: */
+	struct kset      ha_kset; /* "this" */
+	struct kset      phy_kset;
+	struct kset      port_kset;
+
+	struct semaphore event_sema;
+	int              event_thread_kill;
+
+	spinlock_t       event_lock;
+	struct list_head ha_event_list;
+	struct sas_event ha_events[HA_NUM_EVENTS];
+	u32              porte_mask; /* mask of phys for port events */
+	u32              phye_mask; /* mask of phys for phy events */
+
+	struct scsi_core core;
+	
+/* public: */
+	char *sas_ha_name;
+	struct pci_dev *pcidev;	  /* should be set */
+	struct module *lldd_module; /* should be set */
+
+	u8 *sas_addr;		  /* must be set */
+	u8 hashed_sas_addr[HASHED_SAS_ADDR_SIZE];
+
+	spinlock_t      phy_port_lock;
+	struct sas_phy  **sas_phy; /* array of valid pointers, must be set */
+	struct sas_port **sas_port; /* array of valid pointers, must be set */
+	int             num_phys; /* must be set, gt 0, static */
+
+	/* LLDD calls these to notify the class of an event. */
+	void (*notify_ha_event)(struct sas_ha_struct *, enum ha_event);
+	void (*notify_port_event)(struct sas_phy *, enum port_event);
+	void (*notify_phy_event)(struct sas_phy *, enum phy_event);
+
+	/* The class calls these to notify the LLDD of an event. */
+	void (*lldd_port_formed)(struct sas_phy *);
+	void (*lldd_port_deformed)(struct sas_phy *);
+
+	/* The class calls these when a device is found or gone. */
+	int  (*lldd_dev_found)(struct domain_device *);
+	void (*lldd_dev_gone)(struct domain_device *);
+
+	/* The class calls this to send a task for execution. */
+	int lldd_max_execute_num;
+	int lldd_queue_size;
+	int (*lldd_execute_task)(struct sas_task *, int num,
+				 unsigned long gfp_flags);
+
+	/* Task Management Functions. Must be called from process context. */
+	int (*lldd_abort_task)(struct sas_task *);
+	int (*lldd_abort_task_set)(struct domain_device *, u8 *lun);
+	int (*lldd_clear_aca)(struct domain_device *, u8 *lun);
+	int (*lldd_clear_task_set)(struct domain_device *, u8 *lun);
+	int (*lldd_I_T_nexus_reset)(struct domain_device *);
+	int (*lldd_lu_reset)(struct domain_device *, u8 *lun);
+	int (*lldd_query_task)(struct sas_task *);
+
+	/* Port and Adapter management */
+	int (*lldd_clear_nexus_port)(struct sas_port *);
+	int (*lldd_clear_nexus_ha)(struct sas_ha_struct *);
+
+	/* Phy management */
+	int (*lldd_control_phy)(struct sas_phy *, enum phy_func);
+
+	void *lldd_ha;		  /* not touched by sas class code */
+};
+
+#define SHOST_TO_SAS_HA(_shost) (*(struct sas_ha_struct **)(_shost)->hostdata)
+
+void sas_hash_addr(u8 *hashed, const u8 *sas_addr);
+
+/* Before calling a notify event, LLDD should use this function
+ * when the link is severed (possibly from its tasklet).
+ * The idea is that the Class only reads those, while the LLDD,
+ * can R/W these (thus avoiding a race).
+ */
+static inline void sas_phy_disconnected(struct sas_phy *phy)
+{
+	phy->oob_mode = OOB_NOT_CONNECTED;
+	phy->linkrate = PHY_LINKRATE_NONE;
+}
+
+int sas_register_ha(struct sas_ha_struct *sas_ha);
+int sas_unregister_ha(struct sas_ha_struct *sas_ha);
+
+#endif /* _SAS_CLASS_H_ */
diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/include/scsi/sas/sas_discover.h linux-2.6.13/include/scsi/sas/sas_discover.h
--- linux-2.6.13-orig/include/scsi/sas/sas_discover.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/include/scsi/sas/sas_discover.h	2005-09-09 11:13:28.000000000 -0400
@@ -0,0 +1,231 @@
+/*
+ * Serial Attached SCSI (SAS) Discover process header file
+ *
+ * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+ * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+ *
+ * This file is licensed under GPLv2.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * $Id: //depot/sas-class/sas_discover.h#40 $
+ */
+
+#ifndef _SAS_DISCOVER_H_
+#define _SAS_DISCOVER_H_
+
+#include <scsi/sas/sas_class.h>
+#include <scsi/sas/sas_frames.h>
+
+/* ---------- SMP ---------- */
+
+#define SMP_REPORT_GENERAL       0x00
+#define SMP_REPORT_MANUF_INFO    0x01
+#define SMP_READ_GPIO_REG        0x02
+#define SMP_DISCOVER             0x10
+#define SMP_REPORT_PHY_ERR_LOG   0x11
+#define SMP_REPORT_PHY_SATA      0x12
+#define SMP_REPORT_ROUTE_INFO    0x13
+#define SMP_WRITE_GPIO_REG       0x82
+#define SMP_CONF_ROUTE_INFO      0x90
+#define SMP_PHY_CONTROL          0x91
+#define SMP_PHY_TEST_FUNCTION    0x92
+
+#define SMP_RESP_FUNC_ACC        0x00
+#define SMP_RESP_FUNC_UNK        0x01
+#define SMP_RESP_FUNC_FAILED     0x02
+#define SMP_RESP_INV_FRM_LEN     0x03
+#define SMP_RESP_NO_PHY          0x10
+#define SMP_RESP_NO_INDEX        0x11
+#define SMP_RESP_PHY_NO_SATA     0x12
+#define SMP_RESP_PHY_UNK_OP      0x13
+#define SMP_RESP_PHY_UNK_TESTF   0x14
+#define SMP_RESP_PHY_TEST_INPROG 0x15
+#define SMP_RESP_PHY_VACANT      0x16
+
+/* ---------- Domain Devices ---------- */
+
+/* See sas_discover.c before changing these.
+ */
+
+/* ---------- SATA device ---------- */
+
+enum ata_command_set {
+	ATA_COMMAND_SET   = 0,
+	ATAPI_COMMAND_SET = 1,
+};
+
+struct domain_device;
+
+struct sata_device {
+	struct kset  pm_port_kset;
+	enum   ata_command_set command_set;
+	struct smp_resp        rps_resp; /* report_phy_sata_resp */
+	__le16 *identify_device;
+	__le16 *identify_packet_device;
+
+	u8     port_no;	       /* port number, if this is a PM (Port) */
+	struct list_head children; /* PM Ports if this is a PM */
+};
+
+/* ---------- SAS end device ---------- */
+
+#define SAS_INQUIRY_DATA_LEN 36
+
+struct scsi_core_mapping {
+	int  channel;
+	int  id;
+};
+
+enum task_management_type {
+	TASK_MANAGEMENT_NONE  = 0,
+	TASK_MANAGEMENT_FULL  = 1,
+	TASK_MANAGEMENT_BASIC = 2,
+};
+
+struct LU {
+	struct kobject   lu_obj;
+	struct list_head list;
+
+	struct domain_device *parent;
+	
+	u8     LUN[8];
+	int    inquiry_valid_data_len;
+	u8     inquiry_data[SAS_INQUIRY_DATA_LEN];
+	struct scsi_core_mapping map;
+
+	enum task_management_type tm_type;
+	
+	void  *uldd_dev;
+};
+
+struct end_device {
+	u8     ms_10:1;
+	u8     ready_led_meaning:1;
+	u8     rl_wlun:1;
+	u16    itnl_timeout; 	  /* 0 if you do not know it */
+	u16    iresp_timeout;
+
+	struct kset LU_kset;
+	struct list_head LU_list;
+};
+
+#include <scsi/sas/sas_expander.h>
+
+/* ---------- Domain device ---------- */
+
+struct domain_device {
+	struct kobject    dev_obj;
+	enum sas_dev_type dev_type;
+
+	enum sas_phy_linkrate linkrate;
+	enum sas_phy_linkrate min_linkrate;
+	enum sas_phy_linkrate max_linkrate;
+
+	int  pathways;
+
+	struct domain_device *parent;
+	struct list_head siblings; /* devices on the same level */
+	struct sas_port *port;	  /* shortcut to root of the tree */
+
+	struct list_head dev_list_node;
+
+	enum sas_proto    iproto;
+	enum sas_proto    tproto;
+
+	u8  sas_addr[SAS_ADDR_SIZE];
+	u8  hashed_sas_addr[HASHED_SAS_ADDR_SIZE];
+
+	u8  frame_rcvd[32];
+
+	union {
+		struct expander_device ex_dev;
+		struct end_device      end_dev;
+		struct sata_device     sata_dev; /* STP & directly attached */
+	};
+
+	void *lldd_dev;
+};
+
+#define list_for_each_entry_reverse_safe(pos, n, head, member)		\
+	for (pos = list_entry((head)->prev, typeof(*pos), member),	\
+		n = list_entry(pos->member.prev, typeof(*pos), member);	\
+	     &pos->member != (head); 					\
+	     pos = n, n = list_entry(n->member.prev, typeof(*n), member))
+
+
+static inline int sas_notify_lldd_dev_found(struct domain_device *dev)
+{
+	int res = 0;
+	struct sas_ha_struct *sas_ha = dev->port->ha;
+
+	if (!try_module_get(sas_ha->lldd_module))
+		return -ENOMEM;
+	if (sas_ha->lldd_dev_found) {
+		res = sas_ha->lldd_dev_found(dev);
+		if (res) {
+			printk("sas: driver on pcidev %s cannot handle "
+			       "device %llx, error:%d\n",
+			       pci_name(sas_ha->pcidev),
+			       SAS_ADDR(dev->sas_addr), res);
+		}
+	}
+	return res;
+}
+
+static inline void sas_notify_lldd_dev_gone(struct domain_device *dev)
+{
+	if (dev->port->ha->lldd_dev_gone)
+		dev->port->ha->lldd_dev_gone(dev);
+	module_put(dev->port->ha->lldd_module);
+}
+
+static inline void sas_init_dev(struct domain_device *dev)
+{
+	INIT_LIST_HEAD(&dev->siblings);
+	INIT_LIST_HEAD(&dev->dev_list_node);
+	switch (dev->dev_type) {
+	case SAS_END_DEV:
+		INIT_LIST_HEAD(&dev->end_dev.LU_list);
+		break;
+	case EDGE_DEV:
+	case FANOUT_DEV:
+		INIT_LIST_HEAD(&dev->ex_dev.children);
+		break;
+	case SATA_DEV:
+	case SATA_PM:
+	case SATA_PM_PORT:
+		INIT_LIST_HEAD(&dev->sata_dev.children);
+		break;
+	default:
+		break;
+	}
+}
+
+void sas_init_disc(struct sas_discovery *disc, struct sas_port *port);
+void sas_kill_disc_thread(struct sas_port *port);
+int  sas_discover_event(struct sas_port *sas_port, enum discover_event ev);
+
+int  sas_discover_sata(struct domain_device *dev);
+int  sas_discover_end_dev(struct domain_device *dev);
+
+void sas_unregister_dev(struct domain_device *dev);
+
+int  sas_register_with_scsi(struct LU *lu);
+void sas_unregister_with_scsi(struct LU *lu);
+
+void sas_unregister_devices(struct sas_ha_struct *sas_ha);
+
+#endif /* _SAS_DISCOVER_H_ */
diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/include/scsi/sas/sas_dump.h linux-2.6.13/include/scsi/sas/sas_dump.h
--- linux-2.6.13-orig/include/scsi/sas/sas_dump.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/include/scsi/sas/sas_dump.h	2005-09-09 11:13:28.000000000 -0400
@@ -0,0 +1,43 @@
+/*
+ * Serial Attached SCSI (SAS) Dump/Debugging routines header file
+ *
+ * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+ * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+ *
+ * This file is licensed under GPLv2.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * $Id: //depot/sas-class/sas_dump.h#2 $
+ */
+
+#include "sas_internal.h"
+
+#ifdef SAS_DEBUG
+
+void sas_dprint_porte(int phyid, enum port_event pe);
+void sas_dprint_phye(int phyid, enum phy_event pe);
+void sas_dprint_hae(struct sas_ha_struct *sas_ha, enum ha_event he);
+void sas_dump_port(struct sas_port *port);
+
+#else /* SAS_DEBUG */
+
+static inline void sas_dprint_porte(int phyid, enum port_event pe) { }
+static inline void sas_dprint_phye(int phyid, enum phy_event pe) { }
+static inline void sas_dprint_hae(struct sas_ha_struct *sas_ha,
+				  enum ha_event he) { }
+static inline void sas_dump_port(struct sas_port *port) { }
+
+#endif /* SAS_DEBUG */
diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/include/scsi/sas/sas_expander.h linux-2.6.13/include/scsi/sas/sas_expander.h
--- linux-2.6.13-orig/include/scsi/sas/sas_expander.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/include/scsi/sas/sas_expander.h	2005-09-09 11:13:28.000000000 -0400
@@ -0,0 +1,133 @@
+/*
+ * Serial Attached SCSI (SAS) Expander discovery and configuration
+ *
+ * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+ * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+ *
+ * This file is licensed under GPLv2.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * $Id: //depot/sas-class/sas_expander.h#18 $
+ */
+
+#ifndef _SAS_EXPANDER_H_
+#define _SAS_EXPANDER_H_
+
+#define ETASK 0xFA
+
+#define to_lu_device(_obj) container_of(_obj, struct LU, lu_obj)
+#define to_lu_attr(_attr) container_of(_attr, struct lu_dev_attribute, attr)
+#define to_dom_device(_obj) container_of(_obj, struct domain_device, dev_obj)
+#define to_dev_attr(_attr)  container_of(_attr, struct domain_dev_attribute,\
+                                         attr)
+
+/* ---------- Expander device ---------- */
+
+enum routing_attribute {
+	DIRECT_ROUTING,
+	SUBTRACTIVE_ROUTING,
+	TABLE_ROUTING,
+};
+
+enum ex_phy_state {
+	PHY_EMPTY,
+	PHY_VACANT,
+	PHY_NOT_PRESENT,
+	PHY_DEVICE_DISCOVERED
+};
+
+struct ex_phy {
+	int    phy_id;
+
+	enum ex_phy_state phy_state;
+
+	enum sas_dev_type attached_dev_type;
+	enum sas_phy_linkrate linkrate;
+
+	u8   attached_sata_host:1;
+	u8   attached_sata_dev:1;
+	u8   attached_sata_ps:1;
+	
+	enum sas_proto attached_tproto;
+	enum sas_proto attached_iproto;
+
+	u8   attached_sas_addr[SAS_ADDR_SIZE];
+	u8   attached_phy_id;
+
+	u8   phy_change_count;
+	enum routing_attribute routing_attr;
+	u8   virtual:1;
+
+	int  last_da_index;
+};
+
+struct expander_device {
+	struct list_head children;
+
+	int    level;
+
+	u16    ex_change_count;
+	u16    max_route_indexes;
+	u8     num_phys;
+	u8     configuring:1;
+	u8     conf_route_table:1;
+	u8     enclosure_logical_id[8];
+
+	char   vendor_id[8+1];
+	char   product_id[16+1];
+	char   product_rev[4+1];
+	char   component_vendor_id[8+1];
+	u16    component_id;
+	u8     component_revision_id;
+
+	struct ex_phy *ex_phy;
+
+	struct bin_attribute smp_bin_attr;
+	void *smp_req;
+	int   smp_req_size;
+	int   smp_portal_pid;
+	struct semaphore smp_sema;
+};
+
+/* ---------- Attributes and inlined ---------- */
+
+struct domain_dev_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct domain_device *dev, char *);
+	ssize_t (*store)(struct domain_device *dev, const char *, size_t);
+};
+
+void sas_kobj_set(struct domain_device *dev);
+
+extern struct kobj_type ex_dev_ktype;
+extern struct sysfs_ops dev_sysfs_ops;
+
+ssize_t dev_show_type(struct domain_device *dev, char *page);
+ssize_t dev_show_iproto(struct domain_device *dev, char *page);
+ssize_t dev_show_tproto(struct domain_device *dev, char *page);
+ssize_t dev_show_sas_addr(struct domain_device *dev, char *page);
+ssize_t dev_show_linkrate(struct domain_device *dev, char *page);
+ssize_t dev_show_min_linkrate(struct domain_device *dev, char *page);
+ssize_t dev_show_max_linkrate(struct domain_device *dev, char *page);
+ssize_t dev_show_pathways(struct domain_device *dev, char *page);
+
+int  sas_discover_root_expander(struct domain_device *dev);
+
+void sas_init_ex_attr(void);
+
+int  sas_ex_revalidate_domain(struct domain_device *port_dev);
+
+#endif /* _SAS_EXPANDER_H_ */
diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/include/scsi/sas/sas_frames.h linux-2.6.13/include/scsi/sas/sas_frames.h
--- linux-2.6.13-orig/include/scsi/sas/sas_frames.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/include/scsi/sas/sas_frames.h	2005-09-09 11:13:28.000000000 -0400
@@ -0,0 +1,97 @@
+/*
+ * SAS Frames
+ * 
+ * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+ * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+ *
+ * This file is licensed under GPLv2.
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
+ * USA
+ *
+ * $Id: //depot/sas-class/sas_frames.h#4 $
+ */
+
+#ifndef _SAS_FRAMES_
+#define _SAS_FRAMES_
+
+#define SMP_REQUEST             0x40
+#define SMP_RESPONSE            0x41
+
+#define SSP_DATA                0x01
+#define SSP_XFER_RDY            0x05
+#define SSP_COMMAND             0x06
+#define SSP_RESPONSE            0x07
+#define SSP_TASK                0x16
+
+struct  dev_to_host_fis {
+	u8     fis_type;	  /* 0x34 */
+	u8     flags;
+	u8     status;
+	u8     error;
+
+	u8     lbal;
+	union { u8 lbam; u8 byte_count_low; };
+	union { u8 lbah; u8 byte_count_high; };
+	u8     device;
+
+	u8     lbal_exp;
+	u8     lbam_exp;
+	u8     lbah_exp;
+	u8     _r_a;
+
+	union { u8  sector_count; u8 interrupt_reason; };
+	u8     sector_count_exp;
+	u8     _r_b;
+	u8     _r_c;
+
+	u32    _r_d;
+} __attribute__ ((packed));
+
+struct host_to_dev_fis {
+	u8     fis_type;	  /* 0x27 */
+	u8     flags;
+	u8     command;
+	u8     features;
+
+	u8     lbal;
+	union { u8 lbam; u8 byte_count_low; };
+	union { u8 lbah; u8 byte_count_high; };
+	u8     device;
+
+	u8     lbal_exp;
+	u8     lbam_exp;
+	u8     lbah_exp;
+	u8     features_exp;
+
+	union { u8  sector_count; u8 interrupt_reason; };
+	u8     sector_count_exp;
+	u8     _r_a;
+	u8     control;
+
+	u32    _r_b;
+} __attribute__ ((packed));
+
+/* Prefer to have code clarity over header file clarity.
+ */
+#ifdef __LITTLE_ENDIAN_BITFIELD
+#include <scsi/sas/sas_frames_le.h>
+#elif defined(__BIG_ENDIAN_BITFIELD)
+#include <scsi/sas/sas_frames_be.h>
+#else
+#error "Bitfield order not defined!"
+#endif
+
+#endif /* _SAS_FRAMES_ */
diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/include/scsi/sas/sas_frames_be.h linux-2.6.13/include/scsi/sas/sas_frames_be.h
--- linux-2.6.13-orig/include/scsi/sas/sas_frames_be.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/include/scsi/sas/sas_frames_be.h	2005-09-09 11:13:28.000000000 -0400
@@ -0,0 +1,222 @@
+/*
+ * SAS Frames Big endian bitfield order
+ * 
+ * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+ * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+ *
+ * This file is licensed under GPLv2.
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
+ * USA
+ *
+ * $Id: //depot/sas-class/sas_frames_be.h#9 $
+ */
+
+#ifndef _SAS_FRAMES_BE_H_
+#define _SAS_FRAMES_BE_H_
+
+#ifndef __BIG_ENDIAN_BITFIELD
+#error "Wrong header file included!"
+#endif
+
+struct sas_identify_frame {
+	/* Byte 0 */
+	u8  _un0:1;
+	u8  dev_type:3;
+	u8  frame_type:4;
+
+	/* Byte 1 */
+	u8  _un1;
+
+	/* Byte 2 */
+	union {
+		struct {
+			u8  _un247:4;
+			u8  ssp_iport:1;
+			u8  stp_iport:1;
+			u8  smp_iport:1;
+			u8  _un20:1;
+		};
+		u8 initiator_bits;		
+	};
+
+	/* Byte 3 */
+	union {
+		struct {
+			u8 _un347:4;
+			u8 ssp_tport:1;
+			u8 stp_tport:1;	
+			u8 smp_tport:1;
+			u8 _un30:1;
+		};
+		u8 target_bits;
+	};
+
+	/* Byte 4 - 11 */
+	u8 _un4_11[8];
+
+	/* Byte 12 - 19 */
+	u8 sas_addr[SAS_ADDR_SIZE];
+
+	/* Byte 20 */
+	u8 phy_id;
+
+	u8 _un21_27[7];
+
+	__be32 crc;
+} __attribute__ ((packed));
+
+struct ssp_frame_hdr {
+	u8     frame_type;
+	u8     hashed_dest_addr[HASHED_SAS_ADDR_SIZE];
+	u8     _r_a;
+	u8     hashed_src_addr[HASHED_SAS_ADDR_SIZE];
+	__be16 _r_b;
+
+	u8     _r_c:5;
+	u8     retry_data_frames:1;
+	u8     retransmit:1;
+	u8     changing_data_ptr:1;
+
+	u8     _r_d:6;
+	u8     num_fill_bytes:2;
+
+	u32    _r_e;
+	__be16 tag;
+	__be16 tptg;
+	__be32 data_offs;
+} __attribute__ ((packed));
+
+struct ssp_response_iu {
+	u8     _r_a[10];
+
+	u8     _r_b:6;
+	u8     datapres:2;
+
+	u8     status;
+
+	u32    _r_c;
+
+	__be32 sense_data_len;
+	__be32 response_data_len;
+
+	u8     resp_data[0];
+	u8     sense_data[0];	
+} __attribute__ ((packed));
+
+/* ---------- SMP ---------- */
+
+struct report_general_resp {
+	__be16  change_count;
+	__be16  route_indexes;
+	u8      _r_a;
+	u8      num_phys;
+
+	u8      _r_b:6;
+	u8      configuring:1;
+	u8      conf_route_table:1;
+
+	u8      _r_c;
+
+	u8      enclosure_logical_id[8];
+
+	u8      _r_d[12];	
+} __attribute__ ((packed));
+
+struct discover_resp {
+	u8    _r_a[5];
+
+	u8    phy_id;
+	__be16 _r_b;
+
+	u8    _r_d:1;
+	u8    attached_dev_type:3;
+	u8    _r_c:4;
+
+	u8    _r_e:4;
+	u8    linkrate:4;
+
+	u8    _r_f:4;
+	u8    iproto:3;
+	u8    attached_sata_host:1;
+
+	u8    attached_sata_ps:1;
+	u8    _r_g:3;
+	u8    tproto:3;
+	u8    attached_sata_dev:1;
+
+	u8    sas_addr[8];
+	u8    attached_sas_addr[8];
+	u8    attached_phy_id;
+
+	u8    _r_h[7];
+
+	u8    pmin_linkrate:4;
+	u8    hmin_linkrate:4;
+	u8    pmax_linkrate:4;
+	u8    hmax_linkrate:4;
+
+	u8    change_count;
+
+	u8    virtual:1;
+	u8    _r_i:3;
+	u8    pptv:4;
+
+	u8    _r_j:4;
+	u8    routing_attr:4;
+
+	u8    conn_type;
+	u8    conn_el_index;
+	u8    conn_phy_link;
+
+	u8    _r_k[8];
+} __attribute__ ((packed));
+
+struct report_phy_sata_resp {
+	u8    _r_a[5];
+
+	u8    phy_id;
+	u8    _r_b;
+
+	u8    _r_c:6;
+	u8    affil_supp:1;
+	u8    affil_valid:1;
+
+	u32   _r_d;
+
+	u8    stp_sas_addr[8];
+
+	struct dev_to_host_fis;
+
+	u32   _r_e;
+
+	u8    affil_stp_ini_addr[8];
+
+	__be32 crc;
+} __attribute__ ((packed));
+
+struct smp_resp {
+	u8 smp_frame_type;
+	u8 function;
+	u8 result;
+	u8 reserved;
+	union {
+		struct report_general_resp  rg;
+		struct discover_resp        disc;
+		struct report_phy_sata_resp rps;
+	};
+} __attribute__ ((packed));
+
+#endif /* _SAS_FRAMES_BE_H_ */
diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/include/scsi/sas/sas_frames_le.h linux-2.6.13/include/scsi/sas/sas_frames_le.h
--- linux-2.6.13-orig/include/scsi/sas/sas_frames_le.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/include/scsi/sas/sas_frames_le.h	2005-09-09 11:13:28.000000000 -0400
@@ -0,0 +1,223 @@
+/*
+ * SAS Frames Little endian bitfield order
+ * 
+ * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+ * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+ *
+ * This file is licensed under GPLv2.
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
+ * USA
+ *
+ * $Id: //depot/sas-class/sas_frames_le.h#9 $
+ */
+
+#ifndef _SAS_FRAMES_LE_H_
+#define _SAS_FRAMES_LE_H_
+
+#ifndef __LITTLE_ENDIAN_BITFIELD
+#error "Wrong header file included!"
+#endif
+
+struct sas_identify_frame {
+	/* Byte 0 */
+	u8  frame_type:4;
+	u8  dev_type:3;
+	u8  _un0:1;
+
+	/* Byte 1 */
+	u8  _un1;
+
+	/* Byte 2 */
+	union {
+		struct {
+			u8  _un20:1;
+			u8  smp_iport:1;
+			u8  stp_iport:1;
+			u8  ssp_iport:1;
+			u8  _un247:4;
+		};
+		u8 initiator_bits;
+	};
+
+	/* Byte 3 */
+	union {
+		struct {
+			u8  _un30:1;
+			u8 smp_tport:1;
+			u8 stp_tport:1;
+			u8 ssp_tport:1;
+			u8 _un347:4;
+		};
+		u8 target_bits;
+	};
+
+	/* Byte 4 - 11 */
+	u8 _un4_11[8];
+
+	/* Byte 12 - 19 */
+	u8 sas_addr[SAS_ADDR_SIZE];
+
+	/* Byte 20 */
+	u8 phy_id;
+
+	u8 _un21_27[7];
+
+	__be32 crc;
+} __attribute__ ((packed));
+
+struct ssp_frame_hdr {
+	u8     frame_type;
+	u8     hashed_dest_addr[HASHED_SAS_ADDR_SIZE];
+	u8     _r_a;
+	u8     hashed_src_addr[HASHED_SAS_ADDR_SIZE];
+	__be16 _r_b;
+
+	u8     changing_data_ptr:1;
+	u8     retransmit:1;
+	u8     retry_data_frames:1;
+	u8     _r_c:5;
+
+	u8     num_fill_bytes:2;
+	u8     _r_d:6;
+
+	u32    _r_e;
+	__be16 tag;
+	__be16 tptt;
+	__be32 data_offs;
+} __attribute__ ((packed));
+
+struct ssp_response_iu {
+	u8     _r_a[10];
+
+	u8     datapres:2;
+	u8     _r_b:6;
+
+	u8     status;
+
+	u32    _r_c;
+
+	__be32 sense_data_len;
+	__be32 response_data_len;
+
+	u8     resp_data[0];
+	u8     sense_data[0];	
+} __attribute__ ((packed));
+
+/* ---------- SMP ---------- */
+
+struct report_general_resp {
+	__be16  change_count;
+	__be16  route_indexes;
+	u8      _r_a;
+	u8      num_phys;
+
+	u8      conf_route_table:1;
+	u8      configuring:1;
+	u8      _r_b:6;
+
+	u8      _r_c;
+
+	u8      enclosure_logical_id[8];
+
+	u8      _r_d[12];	
+} __attribute__ ((packed));
+
+struct discover_resp {
+	u8    _r_a[5];
+
+	u8    phy_id;
+	__be16 _r_b;
+
+	u8    _r_c:4;
+	u8    attached_dev_type:3;
+	u8    _r_d:1;
+
+	u8    linkrate:4;
+	u8    _r_e:4;
+
+	u8    attached_sata_host:1;
+	u8    iproto:3;
+	u8    _r_f:4;
+
+	u8    attached_sata_dev:1;
+	u8    tproto:3;
+	u8    _r_g:3;
+	u8    attached_sata_ps:1;
+
+	u8    sas_addr[8];
+	u8    attached_sas_addr[8];
+	u8    attached_phy_id;
+
+	u8    _r_h[7];
+
+	u8    hmin_linkrate:4;
+	u8    pmin_linkrate:4;
+	u8    hmax_linkrate:4;
+	u8    pmax_linkrate:4;
+
+	u8    change_count;
+
+	u8    pptv:4;
+	u8    _r_i:3;
+	u8    virtual:1;
+
+	u8    routing_attr:4;
+	u8    _r_j:4;
+
+	u8    conn_type;
+	u8    conn_el_index;
+	u8    conn_phy_link;
+
+	u8    _r_k[8];
+} __attribute__ ((packed));
+
+struct report_phy_sata_resp {
+	u8    _r_a[5];
+
+	u8    phy_id;
+	u8    _r_b;
+
+	u8    affil_valid:1;
+	u8    affil_supp:1;
+	u8    _r_c:6;
+
+	u32    _r_d;
+
+	u8    stp_sas_addr[8];
+
+	struct dev_to_host_fis fis;
+
+	u32   _r_e;
+
+	u8    affil_stp_ini_addr[8];
+
+	__be32 crc;
+} __attribute__ ((packed));
+
+struct smp_resp {
+	u8    frame_type;
+	u8    function;
+	u8    result;
+	u8    reserved;
+	union {
+		struct report_general_resp  rg;
+		struct discover_resp        disc;
+		struct report_phy_sata_resp rps;
+	};
+} __attribute__ ((packed));
+
+#endif /* _SAS_FRAMES_LE_H_ */
+
diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/include/scsi/sas/sas_internal.h linux-2.6.13/include/scsi/sas/sas_internal.h
--- linux-2.6.13-orig/include/scsi/sas/sas_internal.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/include/scsi/sas/sas_internal.h	2005-09-09 11:13:28.000000000 -0400
@@ -0,0 +1,79 @@
+/*
+ * Serial Attached SCSI (SAS) class internal header file
+ *
+ * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+ * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+ *
+ * This file is licensed under GPLv2.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
+ * USA
+ *
+ * $Id: //depot/sas-class/sas_internal.h#35 $
+ */
+
+#ifndef _SAS_INTERNAL_H_
+#define _SAS_INTERNAL_H_
+
+#include <scsi/sas/sas_class.h>
+
+#define sas_printk(fmt, ...) printk(KERN_NOTICE "sas: " fmt, ## __VA_ARGS__)
+
+#ifdef SAS_DEBUG
+#define SAS_DPRINTK(fmt, ...) printk(KERN_NOTICE "sas: " fmt, ## __VA_ARGS__)
+#else
+#define SAS_DPRINTK(fmt, ...)
+#endif
+
+int sas_show_class(enum sas_class class, char *buf);
+int sas_show_proto(enum sas_proto proto, char *buf);
+int sas_show_linkrate(enum sas_phy_linkrate linkrate, char *buf);
+int sas_show_oob_mode(enum sas_oob_mode oob_mode, char *buf);
+
+int  sas_register_phys(struct sas_ha_struct *sas_ha);
+void sas_unregister_phys(struct sas_ha_struct *sas_ha);
+
+int  sas_register_ports(struct sas_ha_struct *sas_ha);
+void sas_unregister_ports(struct sas_ha_struct *sas_ha);
+
+int  sas_register_scsi_host(struct sas_ha_struct *sas_ha);
+void sas_unregister_scsi_host(struct sas_ha_struct *sas_ha);
+
+int  sas_start_event_thread(struct sas_ha_struct *sas_ha);
+void sas_kill_event_thread(struct sas_ha_struct *sas_ha);
+
+int  sas_init_queue(struct sas_ha_struct *sas_ha);
+void sas_shutdown_queue(struct sas_ha_struct *sas_ha);
+
+void sas_phye_loss_of_signal(struct sas_phy *phy);
+void sas_phye_oob_done(struct sas_phy *phy);
+void sas_phye_oob_error(struct sas_phy *phy);
+void sas_phye_spinup_hold(struct sas_phy *phy);
+
+void sas_deform_port(struct sas_phy *phy);
+
+void sas_porte_bytes_dmaed(struct sas_phy *phy);
+void sas_porte_broadcast_rcvd(struct sas_phy *phy);
+void sas_porte_link_reset_err(struct sas_phy *phy);
+void sas_porte_timer_event(struct sas_phy *phy);
+void sas_porte_hard_reset(struct sas_phy *phy);
+
+int  sas_reserve_free_id(struct sas_port *port);
+void sas_reserve_scsi_id(struct sas_port *port, int id);
+void sas_release_scsi_id(struct sas_port *port, int id);
+
+void sas_hae_reset(struct sas_ha_struct *sas_ha);
+
+#endif /* _SAS_INTERNAL_H_ */
diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/include/scsi/sas/sas_task.h linux-2.6.13/include/scsi/sas/sas_task.h
--- linux-2.6.13-orig/include/scsi/sas/sas_task.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/include/scsi/sas/sas_task.h	2005-09-09 11:13:28.000000000 -0400
@@ -0,0 +1,233 @@
+/*
+ * Serial Attached SCSI (SAS) Task interface
+ *
+ * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+ * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+ *
+ * This file is licensed under GPLv2.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * $Id: //depot/sas-class/sas_task.h#26 $
+ */
+
+#ifndef _SAS_TASK_H_
+#define _SAS_TASK_H_
+
+#include <linux/pci.h>
+#include <scsi/sas/sas_discover.h>
+
+/* SAM TMFs */
+#define TMF_ABORT_TASK      0x01
+#define TMF_ABORT_TASK_SET  0x02
+#define TMF_CLEAR_TASK_SET  0x04
+#define TMF_LU_RESET        0x08
+#define TMF_CLEAR_ACA       0x40
+#define TMF_QUERY_TASK      0x80
+
+/* SAS TMF responses */
+#define TMF_RESP_FUNC_COMPLETE   0x00
+#define TMF_RESP_INVALID_FRAME   0x02
+#define TMF_RESP_FUNC_ESUPP      0x04
+#define TMF_RESP_FUNC_FAILED     0x05
+#define TMF_RESP_FUNC_SUCC       0x08
+#define TMF_RESP_NO_LUN          0x09
+#define TMF_RESP_OVERLAPPED_TAG  0x0A
+
+/*
+      service_response |  SAS_TASK_COMPLETE  |  SAS_TASK_UNDELIVERED |
+  exec_status          |                     |                       |
+  ---------------------+---------------------+-----------------------+
+       SAM_...         |         X           |                       |
+       DEV_NO_RESPONSE |         X           |           X           |
+       INTERRUPTED     |         X           |                       |
+       QUEUE_FULL      |                     |           X           |
+       DEVICE_UNKNOWN  |                     |           X           |
+       SG_ERR          |                     |           X           |
+  ---------------------+---------------------+-----------------------+
+ */
+
+enum service_response {
+	SAS_TASK_COMPLETE,
+	SAS_TASK_UNDELIVERED = -1,
+};
+
+enum exec_status {
+	SAM_GOOD         = 0,
+	SAM_CHECK_COND   = 2,
+	SAM_COND_MET     = 4,
+	SAM_BUSY         = 8,
+	SAM_INTERMEDIATE = 0x10,
+	SAM_IM_COND_MET  = 0x12,
+	SAM_RESV_CONFLICT= 0x14,
+	SAM_TASK_SET_FULL= 0x28,
+	SAM_ACA_ACTIVE   = 0x30,
+	SAM_TASK_ABORTED = 0x40,
+
+	SAS_DEV_NO_RESPONSE = 0x80,
+	SAS_DATA_UNDERRUN,
+	SAS_DATA_OVERRUN,
+	SAS_INTERRUPTED,
+	SAS_QUEUE_FULL,
+	SAS_DEVICE_UNKNOWN,
+	SAS_SG_ERR,
+	SAS_OPEN_REJECT,
+	SAS_OPEN_TO,
+	SAS_PROTO_RESPONSE,
+	SAS_PHY_DOWN,
+	SAS_NAK_R_ERR,
+	SAS_PENDING,
+	SAS_ABORTED_TASK,
+};
+
+/* When a task finishes with a response, the LLDD examines the
+ * response:
+ * 	- For an ATA task task_status_struct::stat is set to
+ * SAS_PROTO_RESPONSE, and the task_status_struct::buf is set to the
+ * contents of struct ata_task_resp.
+ * 	- For SSP tasks, if no data is present or status/TMF response
+ * is valid, task_status_struct::stat is set.  If data is present
+ * (SENSE data), the LLDD copies up to SAS_STATUS_BUF_SIZE, sets
+ * task_status_struct::buf_valid_size, and task_status_struct::stat is
+ * set to SAM_CHECK_COND.
+ *
+ * "buf" has format SCSI Sense for SSP task, or struct ata_task_resp
+ * for ATA task.
+ *
+ * "frame_len" is the total frame length, which could be more or less
+ * than actually copied.
+ * 
+ * Tasks ending with response, always set the residual field.
+ */
+struct ata_task_resp {
+	u16  frame_len;
+	u8   ending_fis[24];	  /* dev to host or data-in */
+	u32  sstatus;
+	u32  serror;
+	u32  scontrol;
+	u32  sactive;
+};
+
+#define SAS_STATUS_BUF_SIZE 96
+
+struct task_status_struct {
+	enum service_response resp;
+	enum exec_status      stat;
+	int  buf_valid_size;
+
+	u8   buf[SAS_STATUS_BUF_SIZE];
+
+	u32  residual;
+	enum sas_open_rej_reason open_rej_reason;
+};
+
+/* ATA and ATAPI task queuable to a SAS LLDD.
+ */
+struct sas_ata_task {
+	struct host_to_dev_fis fis;
+	u8     atapi_packet[16];  /* 0 if not ATAPI task */
+
+	u8     retry_count;	  /* hardware retry, should be > 0 */
+	
+	u8     dma_xfer:1;	  /* PIO:0 or DMA:1 */
+	u8     use_ncq:1;
+	u8     set_affil_pol:1;
+	u8     stp_affil_pol:1;
+
+	u8     device_control_reg_update:1;
+};
+
+struct sas_smp_task {
+	struct scatterlist smp_req;
+	struct scatterlist smp_resp;
+};
+
+enum task_attribute {
+	TASK_ATTR_SIMPLE = 0,
+	TASK_ATTR_HOQ    = 1,
+	TASK_ATTR_ORDERED= 2,
+	TASK_ATTR_ACA    = 4,
+};
+
+struct sas_ssp_task {
+	u8     retry_count;	  /* hardware retry, should be > 0 */
+	
+	u8     LUN[8];
+	u8     enable_first_burst:1;
+	enum   task_attribute task_attr;
+	u8     task_prio;
+	u8     cdb[16];
+};
+
+#define SAS_TASK_STATE_PENDING  1
+#define SAS_TASK_STATE_DONE     2
+#define SAS_TASK_STATE_ABORTED  4
+
+struct sas_task {
+	struct domain_device *dev;
+	struct list_head      list;
+
+	spinlock_t   task_state_lock;
+	unsigned     task_state_flags;
+	
+	enum   sas_proto      task_proto;
+	
+	/* Used by the discovery code. */
+	struct timer_list     timer;
+	struct completion     completion;
+
+	union {
+		struct sas_ata_task ata_task;
+		struct sas_smp_task smp_task;
+		struct sas_ssp_task ssp_task;
+	};
+
+	struct scatterlist *scatter;
+	int    num_scatter;
+	u32    total_xfer_len;
+	u8     data_dir:2;	  /* Use PCI_DMA_... */
+
+	struct task_status_struct task_status;
+	void   (*task_done)(struct sas_task *task);
+
+	void   *lldd_task;	  /* for use by LLDDs */
+	void   *uldd_task;
+};
+
+static inline struct sas_task *sas_alloc_task(unsigned long flags)
+{
+	extern kmem_cache_t *sas_task_cache;
+	struct sas_task *task = kmem_cache_alloc(sas_task_cache, flags);
+
+	memset(task, 0, sizeof(*task));
+	INIT_LIST_HEAD(&task->list);
+	spin_lock_init(&task->task_state_lock);
+	task->task_state_flags = SAS_TASK_STATE_PENDING;
+	init_timer(&task->timer);
+	init_completion(&task->completion);
+
+	return task;
+}
+
+static inline void sas_free_task(struct sas_task *task)
+{
+	if (task) {
+		extern kmem_cache_t *sas_task_cache;
+		BUG_ON(!list_empty(&task->list));
+		kmem_cache_free(sas_task_cache, task);
+	}
+}
+
+#endif /* _SAS_TASK_H_ */
