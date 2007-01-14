Return-Path: <linux-kernel-owner+w=401wt.eu-S1751262AbXANNpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbXANNpv (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 08:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbXANNpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 08:45:51 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2458 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751262AbXANNpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 08:45:50 -0500
Date: Sun, 14 Jan 2007 14:45:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ravi Anand <ravi.anand@qlogic.com>,
       David Somayajulu <david.somayajulu@qlogic.com>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] drivers/scsi/qla4xxx/: possible cleanups
Message-ID: <20070114134554.GW7469@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 unused functions

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/qla4xxx/ql4_dbg.c  |    4 ++++
 drivers/scsi/qla4xxx/ql4_glbl.h |    9 ---------
 drivers/scsi/qla4xxx/ql4_init.c |   18 +++++++++---------
 drivers/scsi/qla4xxx/ql4_iocb.c |   18 +++++++++---------
 drivers/scsi/qla4xxx/ql4_mbx.c  |   19 ++++++++++++++-----
 drivers/scsi/qla4xxx/ql4_os.c   |    9 ++++-----
 6 files changed, 40 insertions(+), 37 deletions(-)

--- linux-2.6.20-rc4-mm1/drivers/scsi/qla4xxx/ql4_dbg.c.old	2007-01-14 10:21:51.000000000 +0100
+++ linux-2.6.20-rc4-mm1/drivers/scsi/qla4xxx/ql4_dbg.c	2007-01-14 14:11:11.000000000 +0100
@@ -8,6 +8,8 @@
 #include "ql4_def.h"
 #include <scsi/scsi_dbg.h>
 
+#if 0
+
 static void qla4xxx_print_srb_info(struct srb * srb)
 {
 	printk("%s: srb = 0x%p, flags=0x%02x\n", __func__, srb, srb->flags);
@@ -195,3 +197,5 @@
 	if (cnt % 16)
 		printk(KERN_DEBUG "\n");
 }
+
+#endif  /*  0  */
--- linux-2.6.20-rc4-mm1/drivers/scsi/qla4xxx/ql4_glbl.h.old	2007-01-14 10:25:16.000000000 +0100
+++ linux-2.6.20-rc4-mm1/drivers/scsi/qla4xxx/ql4_glbl.h	2007-01-14 14:10:38.000000000 +0100
@@ -43,8 +43,6 @@
 			    uint16_t *tcp_source_port_num,
 			    uint16_t *connection_id);
 
-struct ddb_entry * qla4xxx_alloc_ddb(struct scsi_qla_host * ha,
-				     uint32_t fw_ddb_index);
 int qla4xxx_set_ddb_entry(struct scsi_qla_host * ha, uint16_t fw_ddb_index,
 			  dma_addr_t fw_ddb_entry_dma);
 
@@ -55,18 +53,11 @@
 struct ddb_entry *qla4xxx_alloc_sess(struct scsi_qla_host *ha);
 int qla4xxx_add_sess(struct ddb_entry *);
 void qla4xxx_destroy_sess(struct ddb_entry *ddb_entry);
-int qla4xxx_conn_close_sess_logout(struct scsi_qla_host * ha,
-				   uint16_t fw_ddb_index,
-				   uint16_t connection_id,
-				   uint16_t option);
-int qla4xxx_clear_database_entry(struct scsi_qla_host * ha,
-				 uint16_t fw_ddb_index);
 int qla4xxx_is_nvram_configuration_valid(struct scsi_qla_host * ha);
 int qla4xxx_get_fw_version(struct scsi_qla_host * ha);
 void qla4xxx_interrupt_service_routine(struct scsi_qla_host * ha,
 				       uint32_t intr_status);
 int qla4xxx_init_rings(struct scsi_qla_host * ha);
-void qla4xxx_dump_buffer(void *b, uint32_t size);
 struct srb * qla4xxx_del_from_active_array(struct scsi_qla_host *ha, uint32_t index);
 void qla4xxx_srb_compl(struct scsi_qla_host *ha, struct srb *srb);
 int qla4xxx_reinitialize_ddb_list(struct scsi_qla_host * ha);
--- linux-2.6.20-rc4-mm1/drivers/scsi/qla4xxx/ql4_init.c.old	2007-01-14 10:25:31.000000000 +0100
+++ linux-2.6.20-rc4-mm1/drivers/scsi/qla4xxx/ql4_init.c	2007-01-14 10:27:40.000000000 +0100
@@ -7,9 +7,8 @@
 
 #include "ql4_def.h"
 
-/*
- * QLogic ISP4xxx Hardware Support Function Prototypes.
- */
+static struct ddb_entry * qla4xxx_alloc_ddb(struct scsi_qla_host *ha,
+					    uint32_t fw_ddb_index);
 
 static void ql4xxx_set_mac_number(struct scsi_qla_host *ha)
 {
@@ -48,7 +47,8 @@
  * This routine deallocates and unlinks the specified ddb_entry from the
  * adapter's
  **/
-void qla4xxx_free_ddb(struct scsi_qla_host *ha, struct ddb_entry *ddb_entry)
+static void qla4xxx_free_ddb(struct scsi_qla_host *ha,
+			     struct ddb_entry *ddb_entry)
 {
 	/* Remove device entry from list */
 	list_del_init(&ddb_entry->list);
@@ -370,9 +370,9 @@
  * must be initialized prior to	calling this routine
  *
  **/
-int qla4xxx_update_ddb_entry(struct scsi_qla_host *ha,
-			     struct ddb_entry *ddb_entry,
-			     uint32_t fw_ddb_index)
+static int qla4xxx_update_ddb_entry(struct scsi_qla_host *ha,
+				    struct ddb_entry *ddb_entry,
+				    uint32_t fw_ddb_index)
 {
 	struct dev_db_entry *fw_ddb_entry = NULL;
 	dma_addr_t fw_ddb_entry_dma;
@@ -450,8 +450,8 @@
  * This routine allocates a ddb_entry, ititializes some values, and
  * inserts it into the ddb list.
  **/
-struct ddb_entry * qla4xxx_alloc_ddb(struct scsi_qla_host *ha,
-				     uint32_t fw_ddb_index)
+static struct ddb_entry * qla4xxx_alloc_ddb(struct scsi_qla_host *ha,
+					    uint32_t fw_ddb_index)
 {
 	struct ddb_entry *ddb_entry;
 
--- linux-2.6.20-rc4-mm1/drivers/scsi/qla4xxx/ql4_iocb.c.old	2007-01-14 10:29:58.000000000 +0100
+++ linux-2.6.20-rc4-mm1/drivers/scsi/qla4xxx/ql4_iocb.c	2007-01-14 10:34:46.000000000 +0100
@@ -19,8 +19,8 @@
  *	- advances the request_in pointer
  *	- checks for queue full
  **/
-int qla4xxx_get_req_pkt(struct scsi_qla_host *ha,
-			struct queue_entry **queue_entry)
+static int qla4xxx_get_req_pkt(struct scsi_qla_host *ha,
+			       struct queue_entry **queue_entry)
 {
 	uint16_t request_in;
 	uint8_t status = QLA_SUCCESS;
@@ -62,8 +62,8 @@
  *
  * This routine issues a marker IOCB.
  **/
-int qla4xxx_send_marker_iocb(struct scsi_qla_host *ha,
-			     struct ddb_entry *ddb_entry, int lun)
+static int qla4xxx_send_marker_iocb(struct scsi_qla_host *ha,
+				    struct ddb_entry *ddb_entry, int lun)
 {
 	struct marker_entry *marker_entry;
 	unsigned long flags = 0;
@@ -96,7 +96,7 @@
 	return status;
 }
 
-struct continuation_t1_entry* qla4xxx_alloc_cont_entry(
+static struct continuation_t1_entry* qla4xxx_alloc_cont_entry(
 	struct scsi_qla_host *ha)
 {
 	struct continuation_t1_entry *cont_entry;
@@ -120,7 +120,7 @@
 	return cont_entry;
 }
 
-uint16_t qla4xxx_calc_request_entries(uint16_t dsds)
+static uint16_t qla4xxx_calc_request_entries(uint16_t dsds)
 {
 	uint16_t iocbs;
 
@@ -133,9 +133,9 @@
 	return iocbs;
 }
 
-void qla4xxx_build_scsi_iocbs(struct srb *srb,
-			      struct command_t3_entry *cmd_entry,
-			      uint16_t tot_dsds)
+static void qla4xxx_build_scsi_iocbs(struct srb *srb,
+				     struct command_t3_entry *cmd_entry,
+				     uint16_t tot_dsds)
 {
 	struct scsi_qla_host *ha;
 	uint16_t avail_dsds;
--- linux-2.6.20-rc4-mm1/drivers/scsi/qla4xxx/ql4_mbx.c.old	2007-01-14 11:53:44.000000000 +0100
+++ linux-2.6.20-rc4-mm1/drivers/scsi/qla4xxx/ql4_mbx.c	2007-01-14 14:03:04.000000000 +0100
@@ -20,9 +20,9 @@
  * If outCount is 0, this routine completes successfully WITHOUT waiting
  * for the mailbox command to complete.
  **/
-int qla4xxx_mailbox_command(struct scsi_qla_host *ha, uint8_t inCount,
-			    uint8_t outCount, uint32_t *mbx_cmd,
-			    uint32_t *mbx_sts)
+static int qla4xxx_mailbox_command(struct scsi_qla_host *ha, uint8_t inCount,
+				   uint8_t outCount, uint32_t *mbx_cmd,
+				   uint32_t *mbx_sts)
 {
 	int status = QLA_ERROR;
 	uint8_t i;
@@ -163,6 +163,8 @@
 }
 
 
+#if 0
+
 /**
  * qla4xxx_issue_iocb - issue mailbox iocb command
  * @ha: adapter state pointer.
@@ -236,6 +238,8 @@
 	return QLA_SUCCESS;
 }
 
+#endif  /*  0  */
+
 /**
  * qla4xxx_initialize_fw_cb - initializes firmware control block.
  * @ha: Pointer to host adapter structure.
@@ -563,6 +567,7 @@
 	return qla4xxx_mailbox_command(ha, 4, 1, &mbox_cmd[0], &mbox_sts[0]);
 }
 
+#if 0
 int qla4xxx_conn_open_session_login(struct scsi_qla_host * ha,
 				    uint16_t fw_ddb_index)
 {
@@ -587,6 +592,7 @@
 
 		return status;
 }
+#endif  /*  0  */
 
 /**
  * qla4xxx_get_crash_record - retrieves crash record.
@@ -642,6 +648,7 @@
 				  crash_record, crash_record_dma);
 }
 
+#if 0
 /**
  * qla4xxx_get_conn_event_log - retrieves connection event log
  * @ha: Pointer to host adapter structure.
@@ -731,6 +738,7 @@
 		dma_free_coherent(&ha->pdev->dev, event_log_size, event_log,
 				  event_log_dma);
 }
+#endif  /*  0  */
 
 /**
  * qla4xxx_reset_lun - issues LUN Reset
@@ -827,7 +835,8 @@
 	return QLA_SUCCESS;
 }
 
-int qla4xxx_get_default_ddb(struct scsi_qla_host *ha, dma_addr_t dma_addr)
+static int qla4xxx_get_default_ddb(struct scsi_qla_host *ha,
+				   dma_addr_t dma_addr)
 {
 	uint32_t mbox_cmd[MBOX_REG_COUNT];
 	uint32_t mbox_sts[MBOX_REG_COUNT];
@@ -848,7 +857,7 @@
 	return QLA_SUCCESS;
 }
 
-int qla4xxx_req_ddb_entry(struct scsi_qla_host *ha, uint32_t *ddb_index)
+static int qla4xxx_req_ddb_entry(struct scsi_qla_host *ha, uint32_t *ddb_index)
 {
 	uint32_t mbox_cmd[MBOX_REG_COUNT];
 	uint32_t mbox_sts[MBOX_REG_COUNT];
--- linux-2.6.20-rc4-mm1/drivers/scsi/qla4xxx/ql4_os.c.old	2007-01-14 14:03:35.000000000 +0100
+++ linux-2.6.20-rc4-mm1/drivers/scsi/qla4xxx/ql4_os.c	2007-01-14 14:04:27.000000000 +0100
@@ -14,7 +14,7 @@
 /*
  * Driver version
  */
-char qla4xxx_version_str[40];
+static char qla4xxx_version_str[40];
 
 /*
  * SRB allocation cache
@@ -43,8 +43,7 @@
 /*
  * SCSI host template entry points
  */
-
-void qla4xxx_config_dma_addressing(struct scsi_qla_host *ha);
+static void qla4xxx_config_dma_addressing(struct scsi_qla_host *ha);
 
 /*
  * iSCSI template entry points
@@ -1339,7 +1338,7 @@
  * At exit, the @ha's flags.enable_64bit_addressing set to indicated
  * supported addressing method.
  */
-void qla4xxx_config_dma_addressing(struct scsi_qla_host *ha)
+static void qla4xxx_config_dma_addressing(struct scsi_qla_host *ha)
 {
 	int retval;
 
@@ -1614,7 +1613,7 @@
 };
 MODULE_DEVICE_TABLE(pci, qla4xxx_pci_tbl);
 
-struct pci_driver qla4xxx_pci_driver = {
+static struct pci_driver qla4xxx_pci_driver = {
 	.name		= DRIVER_NAME,
 	.id_table	= qla4xxx_pci_tbl,
 	.probe		= qla4xxx_probe_adapter,

