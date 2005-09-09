Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932608AbVIIWj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbVIIWj7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbVIIWj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:39:58 -0400
Received: from magic.adaptec.com ([216.52.22.17]:40834 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932608AbVIIWj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:39:57 -0400
Message-ID: <43220F37.7010003@adaptec.com>
Date: Fri, 09 Sep 2005 18:39:51 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.13-mm2 0/3] scsi: SAS: Makefile and Kconfig
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 22:39:56.0486 (UTC) FILETIME=[671D6E60:01C5B58F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

The following is a patchset of the SAS code as posted
today but it has the suggestions by Nish and Alexey,
and it is against -mm2 tree.

Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>

diff -X linux-2.6.13-mm2/Documentation/dontdiff -Nau linux-2.6.13-mm2-orig/drivers/scsi/Kconfig linux-2.6.13-mm2/drivers/scsi/Kconfig
--- linux-2.6.13-mm2-orig/drivers/scsi/Kconfig	2005-09-09 17:49:57.000000000 -0400
+++ linux-2.6.13-mm2/drivers/scsi/Kconfig	2005-09-09 17:45:35.000000000 -0400
@@ -260,6 +260,16 @@
 
 endmenu
 
+
+menu "SCSI Transport Layers"
+
+depends on SCSI
+
+source "drivers/scsi/sas-class/Kconfig"
+
+endmenu
+
+
 menu "SCSI low-level drivers"
 	depends on SCSI!=n
 
@@ -330,6 +340,8 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called wd7000.
 
+source "drivers/scsi/aic94xx/Kconfig"
+
 config SCSI_ACARD
 	tristate "ACARD SCSI support"
 	depends on PCI && SCSI
diff -X linux-2.6.13-mm2/Documentation/dontdiff -Nau linux-2.6.13-mm2-orig/drivers/scsi/Makefile linux-2.6.13-mm2/drivers/scsi/Makefile
--- linux-2.6.13-mm2-orig/drivers/scsi/Makefile	2005-09-09 17:49:57.000000000 -0400
+++ linux-2.6.13-mm2/drivers/scsi/Makefile	2005-09-09 17:45:35.000000000 -0400
@@ -31,6 +31,7 @@
 obj-$(CONFIG_SCSI_SPI_ATTRS)	+= scsi_transport_spi.o
 obj-$(CONFIG_SCSI_FC_ATTRS) 	+= scsi_transport_fc.o
 obj-$(CONFIG_SCSI_ISCSI_ATTRS)	+= scsi_transport_iscsi.o
+obj-$(CONFIG_SAS_CLASS)		+= sas-class/
 
 obj-$(CONFIG_ISCSI_TCP) 	+= iscsi_tcp.o
 obj-$(CONFIG_SCSI_AMIGA7XX)	+= amiga7xx.o	53c7xx.o
@@ -64,6 +65,7 @@
 obj-$(CONFIG_SCSI_AIC7XXX)	+= aic7xxx/
 obj-$(CONFIG_SCSI_AIC79XX)	+= aic7xxx/
 obj-$(CONFIG_SCSI_AACRAID)	+= aacraid/
+obj-$(CONFIG_SCSI_AIC94XX)	+= aic94xx/
 obj-$(CONFIG_SCSI_AIC7XXX_OLD)	+= aic7xxx_old.o
 obj-$(CONFIG_SCSI_ARCMSR)	+= arcmsr/
 obj-$(CONFIG_SCSI_IPS)		+= ips.o
