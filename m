Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWAIR5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWAIR5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWAIR5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:57:08 -0500
Received: from pat.qlogic.com ([198.70.193.2]:48568 "EHLO avexch02.qlogic.com")
	by vger.kernel.org with ESMTP id S1030219AbWAIR5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:57:06 -0500
Date: Mon, 9 Jan 2006 09:56:58 -0800
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Adrian Bunk <bunk@stusta.de>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/scsi/qla2xxx/Kconfig: two fixes
Message-ID: <20060109175658.GC545@andrew-vasquezs-powerbook-g4-15.local>
References: <20060106163401.GP12131@stusta.de> <20060106211241.GG13844@andrew-vasquezs-powerbook-g4-15.local> <20060106230935.GC3774@stusta.de> <20060107235009.GH19769@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107235009.GH19769@parisc-linux.org>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 09 Jan 2006 17:56:59.0851 (UTC) FILETIME=[16A601B0:01C61546]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Jan 2006, Matthew Wilcox wrote:

> On Sat, Jan 07, 2006 at 12:09:35AM +0100, Adrian Bunk wrote:
> > Due to the change of SCSI_QLA2XXX to a user-visible option that builds 
> > the driver, this means that suddenly after upgrading the kernel and 
> > running "make oldconfig" a SCSI driver gets built the user never 
> > selected.
> > 
> > Do you have any suggestions for a new name?
> > We could e.g. name it SCSI_QLAXXXX since the driver also supports 
> > 6312/6322, or name it simply SCSI_QLA.
> 
> SCSI_QLOGIC_FC?  Or does this driver handle SAS too?

There will be (shortly, I hope) an iSCSI driver for QLogic's qla4xxx
boards submitted for review...

Here's a composite patch with Adrian's original additions and
help-text with the new Kconfig variable SCSI_QLA_FC.

---

diff --git a/drivers/scsi/qla2xxx/Kconfig b/drivers/scsi/qla2xxx/Kconfig
index 5205c4e..02cc794 100644
--- a/drivers/scsi/qla2xxx/Kconfig
+++ b/drivers/scsi/qla2xxx/Kconfig
@@ -1,4 +1,4 @@
-config SCSI_QLA2XXX
+config SCSI_QLA_FC
 	tristate "QLogic QLA2XXX Fibre Channel Support"
 	depends on PCI && SCSI
 	select SCSI_FC_ATTRS
@@ -28,43 +28,47 @@ config SCSI_QLA2XXX
 
 config SCSI_QLA2XXX_EMBEDDED_FIRMWARE
 	bool "  Use firmware-loader modules (DEPRECATED)"
-	depends on SCSI_QLA2XXX
+	depends on SCSI_QLA_FC
+	help
+	  This option offers you the deprecated firmware-loader
+	  modules that have been obsoleted by the usage of the
+	  Firmware Loader interface in the qla2xxx driver.
 
 config SCSI_QLA21XX
 	tristate "  Build QLogic ISP2100 firmware-module"
-	depends on SCSI_QLA2XXX_EMBEDDED_FIRMWARE
+	depends on SCSI_QLA_FC && SCSI_QLA2XXX_EMBEDDED_FIRMWARE
 	---help---
 	This driver supports the QLogic 21xx (ISP2100) host adapter family.
 
 config SCSI_QLA22XX
 	tristate "  Build QLogic ISP2200 firmware-module"
-	depends on SCSI_QLA2XXX_EMBEDDED_FIRMWARE
+	depends on SCSI_QLA_FC && SCSI_QLA2XXX_EMBEDDED_FIRMWARE
 	---help---
 	This driver supports the QLogic 22xx (ISP2200) host adapter family.
 
 config SCSI_QLA2300
 	tristate "  Build QLogic ISP2300 firmware-module"
-	depends on SCSI_QLA2XXX_EMBEDDED_FIRMWARE
+	depends on SCSI_QLA_FC && SCSI_QLA2XXX_EMBEDDED_FIRMWARE
 	---help---
 	This driver supports the QLogic 2300 (ISP2300 and ISP2312) host
 	adapter family.
 
 config SCSI_QLA2322
 	tristate "  Build QLogic ISP2322 firmware-module"
-	depends on SCSI_QLA2XXX_EMBEDDED_FIRMWARE
+	depends on SCSI_QLA_FC && SCSI_QLA2XXX_EMBEDDED_FIRMWARE
 	---help---
 	This driver supports the QLogic 2322 (ISP2322) host adapter family.
 
 config SCSI_QLA6312
 	tristate "  Build QLogic ISP63xx firmware-module"
-	depends on SCSI_QLA2XXX_EMBEDDED_FIRMWARE
+	depends on SCSI_QLA_FC && SCSI_QLA2XXX_EMBEDDED_FIRMWARE
 	---help---
 	This driver supports the QLogic 63xx (ISP6312 and ISP6322) host
 	adapter family.
 
 config SCSI_QLA24XX
 	tristate "  Build QLogic ISP24xx firmware-module"
-	depends on SCSI_QLA2XXX_EMBEDDED_FIRMWARE
+	depends on SCSI_QLA_FC && SCSI_QLA2XXX_EMBEDDED_FIRMWARE
 	---help---
 	This driver supports the QLogic 24xx (ISP2422 and ISP2432) host
 	adapter family.
diff --git a/drivers/scsi/qla2xxx/Makefile b/drivers/scsi/qla2xxx/Makefile
index 40c0de1..d028bc5 100644
--- a/drivers/scsi/qla2xxx/Makefile
+++ b/drivers/scsi/qla2xxx/Makefile
@@ -3,7 +3,7 @@ EXTRA_CFLAGS += -DUNIQUE_FW_NAME
 qla2xxx-y := qla_os.o qla_init.o qla_mbx.o qla_iocb.o qla_isr.o qla_gs.o \
 		qla_dbg.o qla_sup.o qla_rscn.o qla_attr.o
 
-obj-$(CONFIG_SCSI_QLA2XXX) += qla2xxx.o
+obj-$(CONFIG_SCSI_QLA_FC) += qla2xxx.o
 
 qla2100-y := ql2100.o ql2100_fw.o
 qla2200-y := ql2200.o ql2200_fw.o
