Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVG1FLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVG1FLD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 01:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVG1FLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 01:11:03 -0400
Received: from pat.qlogic.com ([198.70.193.2]:33768 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S261201AbVG1FK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 01:10:59 -0400
Date: Wed, 27 Jul 2005 22:10:59 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linux-SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix up qla2xxx configuration bogosity
Message-ID: <20050728051058.GA567@plap.qlogic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: QLogic Corporation
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 28 Jul 2005 05:10:58.0956 (UTC) FILETIME=[BDA93CC0:01C59332]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

In looking through your latest git-pull and update of the Kconfig
quirks in qla2xxx:

Fix up qla2xxx configuration bogosity
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=e0aa8afd97536a9d94f82a07b4c4b3f05aef6f82;hp=e4ff4d7f9d85a2bc714307eb9113617182e62845


Would you also apply the attached patch which adds the appropriate
FW_LOADER pre-requisite and a separate entry for ISP24xx support.

Thanks to Adrian Bunk and Jesper Juhl for their efforts in fixing this
quirk.

Regards,
Andrew Vasquez

---

diff --git a/drivers/scsi/qla2xxx/Kconfig b/drivers/scsi/qla2xxx/Kconfig
--- a/drivers/scsi/qla2xxx/Kconfig
+++ b/drivers/scsi/qla2xxx/Kconfig
@@ -7,6 +7,7 @@ config SCSI_QLA21XX
 	tristate "QLogic ISP2100 host adapter family support"
 	depends on SCSI_QLA2XXX
         select SCSI_FC_ATTRS
+	select FW_LOADER
 	---help---
 	This driver supports the QLogic 21xx (ISP2100) host adapter family.
 
@@ -14,6 +15,7 @@ config SCSI_QLA22XX
 	tristate "QLogic ISP2200 host adapter family support"
 	depends on SCSI_QLA2XXX
         select SCSI_FC_ATTRS
+	select FW_LOADER
 	---help---
 	This driver supports the QLogic 22xx (ISP2200) host adapter family.
 
@@ -21,6 +23,7 @@ config SCSI_QLA2300
 	tristate "QLogic ISP2300 host adapter family support"
 	depends on SCSI_QLA2XXX
         select SCSI_FC_ATTRS
+	select FW_LOADER
 	---help---
 	This driver supports the QLogic 2300 (ISP2300 and ISP2312) host
 	adapter family.
@@ -29,6 +32,7 @@ config SCSI_QLA2322
 	tristate "QLogic ISP2322 host adapter family support"
 	depends on SCSI_QLA2XXX
         select SCSI_FC_ATTRS
+	select FW_LOADER
 	---help---
 	This driver supports the QLogic 2322 (ISP2322) host adapter family.
 
@@ -36,6 +40,16 @@ config SCSI_QLA6312
 	tristate "QLogic ISP63xx host adapter family support"
 	depends on SCSI_QLA2XXX
         select SCSI_FC_ATTRS
+	select FW_LOADER
 	---help---
 	This driver supports the QLogic 63xx (ISP6312 and ISP6322) host
 	adapter family.
+
+config SCSI_QLA24XX
+	tristate "QLogic ISP24xx host adapter family support"
+	depends on SCSI_QLA2XXX
+	select SCSI_FC_ATTRS
+	select FW_LOADER
+	---help---
+	This driver supports the QLogic 24xx (ISP2422 and ISP2432) host
+	adapter family.
diff --git a/drivers/scsi/qla2xxx/Makefile b/drivers/scsi/qla2xxx/Makefile
--- a/drivers/scsi/qla2xxx/Makefile
+++ b/drivers/scsi/qla2xxx/Makefile
@@ -1,5 +1,4 @@
 EXTRA_CFLAGS += -DUNIQUE_FW_NAME
-EXTRA_CFLAGS += -DCONFIG_SCSI_QLA24XX -DCONFIG_SCSI_QLA24XX_MODULE
 
 qla2xxx-y := qla_os.o qla_init.o qla_mbx.o qla_iocb.o qla_isr.o qla_gs.o \
 		qla_dbg.o qla_sup.o qla_rscn.o qla_attr.o
