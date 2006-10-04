Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030749AbWJDIVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030749AbWJDIVi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 04:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030751AbWJDIVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 04:21:38 -0400
Received: from server6.greatnet.de ([83.133.96.26]:11738 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1030748AbWJDIVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 04:21:37 -0400
Message-ID: <45236F31.3070602@nachtwindheim.de>
Date: Wed, 04 Oct 2006 10:22:09 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: remove hosts.h
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the obsolete hosts.h file under drivers/scsi.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

 b/drivers/scsi/dpt_i2o.c       |    2 +-
 b/drivers/scsi/dpti.h          |    2 +-
 b/drivers/scsi/ips.c           |    6 ------
 b/drivers/scsi/pcmcia/nsp_cs.c |    1 -
 drivers/scsi/hosts.h           |    2 --
 5 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index 7b3bd34..b20b376 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -2212,7 +2212,7 @@ static s32 adpt_scsi_register(adpt_hba* 
 	 */
 	host->io_port = 0;
 	host->n_io_port = 0;
-				/* see comments in hosts.h */
+				/* see comments in scsi_host.h */
 	host->max_id = 16;
 	host->max_lun = 256;
 	host->max_channel = pHba->top_scsi_channel + 1;
diff --git a/drivers/scsi/dpti.h b/drivers/scsi/dpti.h
index 2ad2a89..2899832 100644
--- a/drivers/scsi/dpti.h
+++ b/drivers/scsi/dpti.h
@@ -44,7 +44,7 @@ static int adpt_device_reset(struct scsi
 
 
 /*
- * struct scsi_host_template (see hosts.h)
+ * struct scsi_host_template (see scsi/scsi_host.h)
  */
 
 #define DPT_DRIVER_NAME	"Adaptec I2O RAID"
diff --git a/drivers/scsi/hosts.h b/drivers/scsi/hosts.h
deleted file mode 100644
index c27264b..0000000
--- a/drivers/scsi/hosts.h
+++ /dev/null
@@ -1,2 +0,0 @@
-#warning "This file is obsolete, please use <scsi/scsi_host.h> instead"
-#include <scsi/scsi_host.h>
diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index 3c63928..ea03dd7 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -182,14 +182,8 @@ #include <linux/types.h>
 #include <linux/dma-mapping.h>
 
 #include <scsi/sg.h>
-
 #include "scsi.h"
-
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,0)
-#include "hosts.h"
-#else
 #include <scsi/scsi_host.h>
-#endif
 
 #include "ips.h"
 
diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index 0d4c04e..053303d 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -80,7 +80,6 @@ static int       free_ports = 0;
 module_param(free_ports, bool, 0);
 MODULE_PARM_DESC(free_ports, "Release IO ports after configuration? (default: 0 (=no))");
 
-/* /usr/src/linux/drivers/scsi/hosts.h */
 static struct scsi_host_template nsp_driver_template = {
 	.proc_name	         = "nsp_cs",
 	.proc_info		 = nsp_proc_info,


