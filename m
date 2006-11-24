Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757497AbWKXBqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757497AbWKXBqA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 20:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755348AbWKXBp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 20:45:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25865 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1757484AbWKXBp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 20:45:58 -0500
Date: Fri, 24 Nov 2006 02:46:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, linux-driver@qlogic.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com
Subject: [-mm patch] make qla2x00_reg_remote_port() static
Message-ID: <20061124014601.GQ3557@stusta.de>
References: <20061123021703.8550e37e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123021703.8550e37e.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 02:17:03AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc5-mm2:
>...
>  git-scsi-misc.patch
>...
>  git trees
>...

qla2x00_reg_remote_port() can now become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/qla2xxx/qla_gbl.h  |    1 
 drivers/scsi/qla2xxx/qla_init.c |   68 ++++++++++++++++----------------
 2 files changed, 34 insertions(+), 35 deletions(-)

--- linux-2.6.19-rc6-mm1/drivers/scsi/qla2xxx/qla_gbl.h.old	2006-11-24 01:18:47.000000000 +0100
+++ linux-2.6.19-rc6-mm1/drivers/scsi/qla2xxx/qla_gbl.h	2006-11-24 01:18:53.000000000 +0100
@@ -45,7 +45,6 @@
 extern int qla2x00_abort_isp(scsi_qla_host_t *);
 
 extern void qla2x00_update_fcport(scsi_qla_host_t *, fc_port_t *);
-extern void qla2x00_reg_remote_port(scsi_qla_host_t *, fc_port_t *);
 
 extern void qla2x00_alloc_fw_dump(scsi_qla_host_t *);
 extern void qla2x00_try_to_stop_firmware(scsi_qla_host_t *);
--- linux-2.6.19-rc6-mm1/drivers/scsi/qla2xxx/qla_init.c.old	2006-11-24 01:19:00.000000000 +0100
+++ linux-2.6.19-rc6-mm1/drivers/scsi/qla2xxx/qla_init.c	2006-11-24 01:20:25.000000000 +0100
@@ -2103,40 +2103,7 @@
 	}
 }
 
-/*
- * qla2x00_update_fcport
- *	Updates device on list.
- *
- * Input:
- *	ha = adapter block pointer.
- *	fcport = port structure pointer.
- *
- * Return:
- *	0  - Success
- *  BIT_0 - error
- *
- * Context:
- *	Kernel context.
- */
-void
-qla2x00_update_fcport(scsi_qla_host_t *ha, fc_port_t *fcport)
-{
-	fcport->ha = ha;
-	fcport->login_retry = 0;
-	fcport->port_login_retry_count = ha->port_down_retry_count *
-	    PORT_RETRY_TIME;
-	atomic_set(&fcport->port_down_timer, ha->port_down_retry_count *
-	    PORT_RETRY_TIME);
-	fcport->flags &= ~FCF_LOGIN_NEEDED;
-
-	qla2x00_iidma_fcport(ha, fcport);
-
-	atomic_set(&fcport->state, FCS_ONLINE);
-
-	qla2x00_reg_remote_port(ha, fcport);
-}
-
-void
+static void
 qla2x00_reg_remote_port(scsi_qla_host_t *ha, fc_port_t *fcport)
 {
 	struct fc_rport_identifiers rport_ids;
@@ -2179,6 +2146,39 @@
 }
 
 /*
+ * qla2x00_update_fcport
+ *	Updates device on list.
+ *
+ * Input:
+ *	ha = adapter block pointer.
+ *	fcport = port structure pointer.
+ *
+ * Return:
+ *	0  - Success
+ *  BIT_0 - error
+ *
+ * Context:
+ *	Kernel context.
+ */
+void
+qla2x00_update_fcport(scsi_qla_host_t *ha, fc_port_t *fcport)
+{
+	fcport->ha = ha;
+	fcport->login_retry = 0;
+	fcport->port_login_retry_count = ha->port_down_retry_count *
+	    PORT_RETRY_TIME;
+	atomic_set(&fcport->port_down_timer, ha->port_down_retry_count *
+	    PORT_RETRY_TIME);
+	fcport->flags &= ~FCF_LOGIN_NEEDED;
+
+	qla2x00_iidma_fcport(ha, fcport);
+
+	atomic_set(&fcport->state, FCS_ONLINE);
+
+	qla2x00_reg_remote_port(ha, fcport);
+}
+
+/*
  * qla2x00_configure_fabric
  *      Setup SNS devices with loop ID's.
  *

