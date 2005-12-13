Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbVLMC2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVLMC2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 21:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbVLMC2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 21:28:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56069 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932366AbVLMC23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 21:28:29 -0500
Date: Tue, 13 Dec 2005 03:28:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: andrew.vasquez@qlogic.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/qla2xxx/: possible cleanups
Message-ID: <20051213022829.GZ23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 the following unused global functions:
  - qla_sup.c: qla24xx_get_flash_manufacturer
  - qla_sup.c: qla24xx_write_flash_data


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 20 Nov 2005

 drivers/scsi/qla2xxx/qla_os.c  |   14 +++++++-------
 drivers/scsi/qla2xxx/qla_sup.c |    8 ++++++--
 2 files changed, 13 insertions(+), 9 deletions(-)

--- linux-2.6.15-rc1-mm2-full/drivers/scsi/qla2xxx/qla_os.c.old	2005-11-20 19:56:43.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/scsi/qla2xxx/qla_os.c	2005-11-20 20:04:14.000000000 +0100
@@ -54,7 +54,7 @@
 MODULE_PARM_DESC(ql2xloginretrycount,
 		"Specify an alternate value for the NVRAM login retry count.");
 
-int ql2xfwloadbin=1;
+static int ql2xfwloadbin=1;
 module_param(ql2xfwloadbin, int, S_IRUGO|S_IRUSR);
 MODULE_PARM_DESC(ql2xfwloadbin,
 		"Load ISP2xxx firmware image via hotplug.");
@@ -266,7 +266,7 @@
 	return str;
 }
 
-char *
+static char *
 qla2x00_fw_version_str(struct scsi_qla_host *ha, char *str)
 {
 	char un_str[10];
@@ -304,7 +304,7 @@
 	return (str);
 }
 
-char *
+static char *
 qla24xx_fw_version_str(struct scsi_qla_host *ha, char *str)
 {
 	sprintf(str, "%d.%02d.%02d ", ha->fw_major_version,
@@ -580,7 +580,7 @@
 *
 * Note:
 **************************************************************************/
-int
+static int
 qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 {
 	scsi_qla_host_t *ha = to_qla_host(cmd->device->host);
@@ -714,7 +714,7 @@
 *    SUCCESS/FAILURE (defined as macro in scsi.h).
 *
 **************************************************************************/
-int
+static int
 qla2xxx_eh_device_reset(struct scsi_cmnd *cmd)
 {
 	scsi_qla_host_t *ha = to_qla_host(cmd->device->host);
@@ -845,7 +845,7 @@
 *    SUCCESS/FAILURE (defined as macro in scsi.h).
 *
 **************************************************************************/
-int
+static int
 qla2xxx_eh_bus_reset(struct scsi_cmnd *cmd)
 {
 	scsi_qla_host_t *ha = to_qla_host(cmd->device->host);
@@ -906,7 +906,7 @@
 *
 * Note:
 **************************************************************************/
-int
+static int
 qla2xxx_eh_host_reset(struct scsi_cmnd *cmd)
 {
 	scsi_qla_host_t *ha = to_qla_host(cmd->device->host);
--- linux-2.6.15-rc1-mm2-full/drivers/scsi/qla2xxx/qla_sup.c.old	2005-11-20 19:58:00.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/scsi/qla2xxx/qla_sup.c	2005-11-20 20:00:10.000000000 +0100
@@ -428,7 +428,7 @@
 	return FARX_ACCESS_NVRAM_DATA | naddr;
 }
 
-uint32_t
+static uint32_t
 qla24xx_read_flash_dword(scsi_qla_host_t *ha, uint32_t addr)
 {
 	int rval;
@@ -469,7 +469,7 @@
 	return dwptr;
 }
 
-int
+static int
 qla24xx_write_flash_dword(scsi_qla_host_t *ha, uint32_t addr, uint32_t data)
 {
 	int rval;
@@ -491,6 +491,8 @@
 	return rval;
 }
 
+#if 0
+
 void
 qla24xx_get_flash_manufacturer(scsi_qla_host_t *ha, uint8_t *man_id,
     uint8_t *flash_id)
@@ -581,6 +583,8 @@
 	return ret;
 }
 
+#endif  /*  0  */
+
 uint8_t *
 qla2x00_read_nvram_data(scsi_qla_host_t *ha, uint8_t *buf, uint32_t naddr,
     uint32_t bytes)

