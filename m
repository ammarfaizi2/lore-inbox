Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWBCXcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWBCXcE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 18:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWBCXcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 18:32:04 -0500
Received: from mail0.lsil.com ([147.145.40.20]:35518 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1750842AbWBCXcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 18:32:02 -0500
Subject: [PATCH 1/2] megaraid_sas: register 16 byte CDB capability
From: Sumant Patro <sumantp@lsil.com>
To: hch@lst.de, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com
Cc: sreenib@lsil.com, Neela.kolli@lsil.com, Bo.Yang@lsil.com
Content-Type: multipart/mixed; boundary="=-LGC8Lw2I2foDHVphhwYz"
Date: Fri, 03 Feb 2006 15:34:17 -0800
Message-Id: <1139009657.602.14.camel@dhcp80-31.lsil.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LGC8Lw2I2foDHVphhwYz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello All,

        This patch (originally submitted by Joshua Giles) registers 16 byte CDB capability of the megaraid_sas driver.

        Patch is made against the latest git snapshot of scsi-rc-fixes-2.6 tree.

Thanks,

Sumant Patro

Signed-off-by: Sumant Patro <Sumant.Patro@lsil.com>

diff -uprN linux2.6.16.orig/Documentation/scsi/ChangeLog.megaraid_sas linux2.6.16/Documentation/scsi/ChangeLog.megaraid_sas
--- linux2.6.16.orig/Documentation/scsi/ChangeLog.megaraid_sas	2006-02-03 13:03:26.000000000 -0800
+++ linux2.6.16/Documentation/scsi/ChangeLog.megaraid_sas	2006-02-03 14:18:32.000000000 -0800
@@ -1,3 +1,15 @@
+1 Release Date    : Fri Feb 03 14:16:25 PST 2006 - Sumant Patro 
+							<Sumant.Patro@lsil.com>
+2 Current Version : 00.00.02.04
+3 Older Version   : 00.00.02.02 
+i.	Register 16 byte CDB capability with scsi midlayer 
+
+	"Ths patch properly registers the 16 byte command length capability of the 
+	megaraid_sas controlled hardware with the scsi midlayer. All megaraid_sas 
+	hardware supports 16 byte CDB's."
+
+		-Joshua Giles <joshua_giles@dell.com> 
+
 1 Release Date    : Mon Jan 23 14:09:01 PST 2006 - Sumant Patro <Sumant.Patro@lsil.com>
 2 Current Version : 00.00.02.02
 3 Older Version   : 00.00.02.01 
diff -uprN linux2.6.16.orig/drivers/scsi/megaraid/megaraid_sas.c linux2.6.16/drivers/scsi/megaraid/megaraid_sas.c
--- linux2.6.16.orig/drivers/scsi/megaraid/megaraid_sas.c	2006-02-03 13:02:48.000000000 -0800
+++ linux2.6.16/drivers/scsi/megaraid/megaraid_sas.c	2006-02-03 14:16:05.000000000 -0800
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_sas.c
- * Version	: v00.00.02.02
+ * Version	: v00.00.02.04
  *
  * Authors:
  * 	Sreenivas Bagalkote	<Sreenivas.Bagalkote@lsil.com>
@@ -1983,6 +1983,7 @@ static int megasas_io_attach(struct mega
 	host->max_channel = MEGASAS_MAX_CHANNELS - 1;
 	host->max_id = MEGASAS_MAX_DEV_PER_CHANNEL;
 	host->max_lun = MEGASAS_MAX_LUN;
+	host->max_cmd_len = 16;
 
 	/*
 	 * Notify the mid-layer about the new controller
diff -uprN linux2.6.16.orig/drivers/scsi/megaraid/megaraid_sas.h linux2.6.16/drivers/scsi/megaraid/megaraid_sas.h
--- linux2.6.16.orig/drivers/scsi/megaraid/megaraid_sas.h	2006-02-03 13:02:48.000000000 -0800
+++ linux2.6.16/drivers/scsi/megaraid/megaraid_sas.h	2006-02-03 14:16:51.000000000 -0800
@@ -18,9 +18,9 @@
 /**
  * MegaRAID SAS Driver meta data
  */
-#define MEGASAS_VERSION				"00.00.02.02"
-#define MEGASAS_RELDATE				"Jan 23, 2006"
-#define MEGASAS_EXT_VERSION			"Mon Jan 23 14:09:01 PST 2006"
+#define MEGASAS_VERSION				"00.00.02.04"
+#define MEGASAS_RELDATE				"Feb 03, 2006"
+#define MEGASAS_EXT_VERSION			"Fri Feb 03 14:16:25 PST 2006"
 /*
  * =====================================
  * MegaRAID SAS MFI firmware definitions


--=-LGC8Lw2I2foDHVphhwYz
Content-Disposition: attachment; filename=patch1.patch
Content-Type: text/x-patch; name=patch1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uprN linux2.6.16.orig/Documentation/scsi/ChangeLog.megaraid_sas linux2.6.16/Documentation/scsi/ChangeLog.megaraid_sas
--- linux2.6.16.orig/Documentation/scsi/ChangeLog.megaraid_sas	2006-02-03 13:03:26.000000000 -0800
+++ linux2.6.16/Documentation/scsi/ChangeLog.megaraid_sas	2006-02-03 14:18:32.000000000 -0800
@@ -1,3 +1,15 @@
+1 Release Date    : Fri Feb 03 14:16:25 PST 2006 - Sumant Patro 
+							<Sumant.Patro@lsil.com>
+2 Current Version : 00.00.02.04
+3 Older Version   : 00.00.02.02 
+i.	Register 16 byte CDB capability with scsi midlayer 
+
+	"Ths patch properly registers the 16 byte command length capability of the 
+	megaraid_sas controlled hardware with the scsi midlayer. All megaraid_sas 
+	hardware supports 16 byte CDB's."
+
+		-Joshua Giles <joshua_giles@dell.com> 
+
 1 Release Date    : Mon Jan 23 14:09:01 PST 2006 - Sumant Patro <Sumant.Patro@lsil.com>
 2 Current Version : 00.00.02.02
 3 Older Version   : 00.00.02.01 
diff -uprN linux2.6.16.orig/drivers/scsi/megaraid/megaraid_sas.c linux2.6.16/drivers/scsi/megaraid/megaraid_sas.c
--- linux2.6.16.orig/drivers/scsi/megaraid/megaraid_sas.c	2006-02-03 13:02:48.000000000 -0800
+++ linux2.6.16/drivers/scsi/megaraid/megaraid_sas.c	2006-02-03 14:16:05.000000000 -0800
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_sas.c
- * Version	: v00.00.02.02
+ * Version	: v00.00.02.04
  *
  * Authors:
  * 	Sreenivas Bagalkote	<Sreenivas.Bagalkote@lsil.com>
@@ -1983,6 +1983,7 @@ static int megasas_io_attach(struct mega
 	host->max_channel = MEGASAS_MAX_CHANNELS - 1;
 	host->max_id = MEGASAS_MAX_DEV_PER_CHANNEL;
 	host->max_lun = MEGASAS_MAX_LUN;
+	host->max_cmd_len = 16;
 
 	/*
 	 * Notify the mid-layer about the new controller
diff -uprN linux2.6.16.orig/drivers/scsi/megaraid/megaraid_sas.h linux2.6.16/drivers/scsi/megaraid/megaraid_sas.h
--- linux2.6.16.orig/drivers/scsi/megaraid/megaraid_sas.h	2006-02-03 13:02:48.000000000 -0800
+++ linux2.6.16/drivers/scsi/megaraid/megaraid_sas.h	2006-02-03 14:16:51.000000000 -0800
@@ -18,9 +18,9 @@
 /**
  * MegaRAID SAS Driver meta data
  */
-#define MEGASAS_VERSION				"00.00.02.02"
-#define MEGASAS_RELDATE				"Jan 23, 2006"
-#define MEGASAS_EXT_VERSION			"Mon Jan 23 14:09:01 PST 2006"
+#define MEGASAS_VERSION				"00.00.02.04"
+#define MEGASAS_RELDATE				"Feb 03, 2006"
+#define MEGASAS_EXT_VERSION			"Fri Feb 03 14:16:25 PST 2006"
 /*
  * =====================================
  * MegaRAID SAS MFI firmware definitions

--=-LGC8Lw2I2foDHVphhwYz--

