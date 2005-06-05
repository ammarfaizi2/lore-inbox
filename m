Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVFEGM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVFEGM3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 02:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVFEGM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 02:12:28 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:16371 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261469AbVFEF5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 01:57:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=WsQR/TY0GKwzRPRNlo3PRHpAwdj6MhEoe7DE/EK87ZHOzrl5wqBzkp3J130RWJrS4qSQEcuhJhUZpM0pYlI9pmPzMkDImFis2kSRYGhs/hybiYCz3ONepi2wgTfygG91HV+EKrfKO5EE0x1qCjTqf0km4J+qaqiF/8nl627Q8oI=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050605055337.6301E65A@htj.dyndns.org>
In-Reply-To: <20050605055337.6301E65A@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc5-mm2 07/09] blk: update libata to use the new blk_ordered.
Message-ID: <20050605055337.13444DD8@htj.dyndns.org>
Date: Sun,  5 Jun 2005 14:57:40 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

07_blk_update_libata_to_use_new_ordered.patch

	Reflect changes in SCSI midlayer and updated to use the new
	ordered request implementation.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/ahci.c         |    1 -
 drivers/scsi/ata_piix.c     |    1 -
 drivers/scsi/libata-core.c  |   14 +++++++++-----
 drivers/scsi/libata-scsi.c  |   22 +++++++++++++++++++++-
 drivers/scsi/sata_nv.c      |    1 -
 drivers/scsi/sata_promise.c |    1 -
 drivers/scsi/sata_sil.c     |    1 -
 drivers/scsi/sata_sis.c     |    1 -
 drivers/scsi/sata_svw.c     |    1 -
 drivers/scsi/sata_sx4.c     |    1 -
 drivers/scsi/sata_uli.c     |    1 -
 drivers/scsi/sata_via.c     |    1 -
 drivers/scsi/sata_vsc.c     |    1 -
 include/linux/ata.h         |    4 +++-
 include/linux/libata.h      |    1 +
 15 files changed, 34 insertions(+), 18 deletions(-)

Index: blk-fixes/drivers/scsi/ahci.c
===================================================================
--- blk-fixes.orig/drivers/scsi/ahci.c	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/drivers/scsi/ahci.c	2005-06-05 14:53:35.000000000 +0900
@@ -203,7 +203,6 @@ static Scsi_Host_Template ahci_sht = {
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations ahci_ops = {
Index: blk-fixes/drivers/scsi/ata_piix.c
===================================================================
--- blk-fixes.orig/drivers/scsi/ata_piix.c	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/drivers/scsi/ata_piix.c	2005-06-05 14:53:35.000000000 +0900
@@ -123,7 +123,6 @@ static Scsi_Host_Template piix_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations piix_pata_ops = {
Index: blk-fixes/drivers/scsi/sata_nv.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_nv.c	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_nv.c	2005-06-05 14:53:35.000000000 +0900
@@ -206,7 +206,6 @@ static Scsi_Host_Template nv_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations nv_ops = {
Index: blk-fixes/drivers/scsi/sata_promise.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_promise.c	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_promise.c	2005-06-05 14:53:35.000000000 +0900
@@ -104,7 +104,6 @@ static Scsi_Host_Template pdc_ata_sht = 
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations pdc_ata_ops = {
Index: blk-fixes/drivers/scsi/sata_sil.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_sil.c	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_sil.c	2005-06-05 14:53:35.000000000 +0900
@@ -135,7 +135,6 @@ static Scsi_Host_Template sil_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations sil_ops = {
Index: blk-fixes/drivers/scsi/sata_sis.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_sis.c	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_sis.c	2005-06-05 14:53:35.000000000 +0900
@@ -90,7 +90,6 @@ static Scsi_Host_Template sis_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations sis_ops = {
Index: blk-fixes/drivers/scsi/sata_svw.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_svw.c	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_svw.c	2005-06-05 14:53:35.000000000 +0900
@@ -288,7 +288,6 @@ static Scsi_Host_Template k2_sata_sht = 
 	.proc_info		= k2_sata_proc_info,
 #endif
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 
Index: blk-fixes/drivers/scsi/sata_sx4.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_sx4.c	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_sx4.c	2005-06-05 14:53:35.000000000 +0900
@@ -188,7 +188,6 @@ static Scsi_Host_Template pdc_sata_sht =
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations pdc_20621_ops = {
Index: blk-fixes/drivers/scsi/sata_uli.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_uli.c	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_uli.c	2005-06-05 14:53:35.000000000 +0900
@@ -82,7 +82,6 @@ static Scsi_Host_Template uli_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations uli_ops = {
Index: blk-fixes/drivers/scsi/sata_via.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_via.c	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_via.c	2005-06-05 14:53:35.000000000 +0900
@@ -102,7 +102,6 @@ static Scsi_Host_Template svia_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations svia_sata_ops = {
Index: blk-fixes/drivers/scsi/sata_vsc.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_vsc.c	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_vsc.c	2005-06-05 14:53:35.000000000 +0900
@@ -206,7 +206,6 @@ static Scsi_Host_Template vsc_sata_sht =
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 
Index: blk-fixes/drivers/scsi/libata-core.c
===================================================================
--- blk-fixes.orig/drivers/scsi/libata-core.c	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/drivers/scsi/libata-core.c	2005-06-05 14:53:35.000000000 +0900
@@ -510,19 +510,21 @@ void ata_tf_from_fis(u8 *fis, struct ata
 }
 
 /**
- *	ata_prot_to_cmd - determine which read/write opcodes to use
+ *	ata_prot_to_cmd - determine which read/write/fua-write opcodes to use
  *	@protocol: ATA_PROT_xxx taskfile protocol
  *	@lba48: true is lba48 is present
  *
- *	Given necessary input, determine which read/write commands
- *	to use to transfer data.
+ *	Given necessary input, determine which read/write/fua-write
+ *	commands to use to transfer data.  Note that we only support
+ *	fua-writes on DMA LBA48 protocol.  In other cases, we simply
+ *	return 0 which is NOP.
  *
  *	LOCKING:
  *	None.
  */
 static int ata_prot_to_cmd(int protocol, int lba48)
 {
-	int rcmd = 0, wcmd = 0;
+	int rcmd = 0, wcmd = 0, wfua = 0;
 
 	switch (protocol) {
 	case ATA_PROT_PIO:
@@ -539,6 +541,7 @@ static int ata_prot_to_cmd(int protocol,
 		if (lba48) {
 			rcmd = ATA_CMD_READ_EXT;
 			wcmd = ATA_CMD_WRITE_EXT;
+			wfua = ATA_CMD_WRITE_FUA_EXT;
 		} else {
 			rcmd = ATA_CMD_READ;
 			wcmd = ATA_CMD_WRITE;
@@ -549,7 +552,7 @@ static int ata_prot_to_cmd(int protocol,
 		return -1;
 	}
 
-	return rcmd | (wcmd << 8);
+	return rcmd | (wcmd << 8) | (wfua << 16);
 }
 
 /**
@@ -582,6 +585,7 @@ static void ata_dev_set_protocol(struct 
 
 	dev->read_cmd = cmd & 0xff;
 	dev->write_cmd = (cmd >> 8) & 0xff;
+	dev->write_fua_cmd = (cmd >> 16) & 0xff;
 }
 
 static const char * xfer_mode_str[] = {
Index: blk-fixes/drivers/scsi/libata-scsi.c
===================================================================
--- blk-fixes.orig/drivers/scsi/libata-scsi.c	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/drivers/scsi/libata-scsi.c	2005-06-05 14:53:35.000000000 +0900
@@ -569,6 +569,7 @@ static unsigned int ata_scsi_rw_xlat(str
 	struct ata_device *dev = qc->dev;
 	unsigned int lba   = tf->flags & ATA_TFLAG_LBA;
 	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
+	int fua = scsicmd[1] & 0x8;
 	u64 block = 0;
 	u32 n_block = 0;
 
@@ -577,9 +578,26 @@ static unsigned int ata_scsi_rw_xlat(str
 
 	if (scsicmd[0] == READ_10 || scsicmd[0] == READ_6 ||
 	    scsicmd[0] == READ_16) {
+		if (fua) {
+			printk(KERN_WARNING
+			       "ata%u(%u): WARNING: FUA READ unsupported\n",
+			       qc->ap->id, qc->dev->devno);
+			return 1;
+		}
 		tf->command = qc->dev->read_cmd;
 	} else {
-		tf->command = qc->dev->write_cmd;
+		if (fua) {
+			if (qc->dev->write_fua_cmd == 0 || !lba48) {
+				printk(KERN_WARNING
+				       "ata%u(%u): WARNING: FUA WRITE "
+				       "unsupported with the current "
+				       "protocol/addressing\n",
+				       qc->ap->id, qc->dev->devno);
+				return 1;
+			}
+			tf->command = qc->dev->write_fua_cmd;
+		} else
+			tf->command = qc->dev->write_cmd;
 		tf->flags |= ATA_TFLAG_WRITE;
 	}
 
@@ -1205,10 +1223,12 @@ unsigned int ata_scsiop_mode_sense(struc
 	if (six_byte) {
 		output_len--;
 		rbuf[0] = output_len;
+		rbuf[2] |= ata_id_has_fua(args->id) ? 0x10 : 0;
 	} else {
 		output_len -= 2;
 		rbuf[0] = output_len >> 8;
 		rbuf[1] = output_len;
+		rbuf[3] |= ata_id_has_fua(args->id) ? 0x10 : 0;
 	}
 
 	return 0;
Index: blk-fixes/include/linux/ata.h
===================================================================
--- blk-fixes.orig/include/linux/ata.h	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/include/linux/ata.h	2005-06-05 14:53:35.000000000 +0900
@@ -117,6 +117,7 @@ enum {
 	ATA_CMD_READ_EXT	= 0x25,
 	ATA_CMD_WRITE		= 0xCA,
 	ATA_CMD_WRITE_EXT	= 0x35,
+	ATA_CMD_WRITE_FUA_EXT	= 0x3D,
 	ATA_CMD_PIO_READ	= 0x20,
 	ATA_CMD_PIO_READ_EXT	= 0x24,
 	ATA_CMD_PIO_WRITE	= 0x30,
@@ -229,7 +230,8 @@ struct ata_taskfile {
 #define ata_id_is_sata(id)	((id)[93] == 0)
 #define ata_id_rahead_enabled(id) ((id)[85] & (1 << 6))
 #define ata_id_wcache_enabled(id) ((id)[85] & (1 << 5))
-#define ata_id_has_flush(id) ((id)[83] & (1 << 12))
+#define ata_id_has_fua(id)	((id)[84] & (1 << 6))
+#define ata_id_has_flush(id)	((id)[83] & (1 << 12))
 #define ata_id_has_flush_ext(id) ((id)[83] & (1 << 13))
 #define ata_id_has_lba48(id)	((id)[83] & (1 << 10))
 #define ata_id_has_wcache(id)	((id)[82] & (1 << 5))
Index: blk-fixes/include/linux/libata.h
===================================================================
--- blk-fixes.orig/include/linux/libata.h	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/include/linux/libata.h	2005-06-05 14:53:35.000000000 +0900
@@ -280,6 +280,7 @@ struct ata_device {
 	u8			xfer_protocol;	/* taskfile xfer protocol */
 	u8			read_cmd;	/* opcode to use on read */
 	u8			write_cmd;	/* opcode to use on write */
+	u8			write_fua_cmd;	/* opcode to use on FUA write */
 
 	/* for CHS addressing */
 	u16			cylinders;	/* Number of cylinders */

