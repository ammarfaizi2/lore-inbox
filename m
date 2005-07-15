Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263314AbVGOOmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263314AbVGOOmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 10:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbVGOOms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 10:42:48 -0400
Received: from pat.qlogic.com ([198.70.193.2]:49481 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S263311AbVGOOkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 10:40:41 -0400
Date: Fri, 15 Jul 2005 07:40:37 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Re: 2.6.13-rc3-mm1: horribly drivers/scsi/qla2xxx/Makefile
Message-ID: <20050715144037.GA25648@plap.qlogic.org>
References: <20050715013653.36006990.akpm@osdl.org> <20050715102744.GA3569@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050715102744.GA3569@stusta.de>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 15 Jul 2005 14:40:37.0940 (UTC) FILETIME=[2A8D8F40:01C5894B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005, Adrian Bunk wrote:

> On Fri, Jul 15, 2005 at 01:36:53AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.13-rc2-mm2:
> >...
> >  git-scsi-misc.patch
> >...
> >  Subsystem trees
> >...
> 
...
> +obj-$(CONFIG_SCSI_QLA24XX) += qla2xxx.o
> 
> 
> I don't know what exactly you want to achieve, but this is so horribly 
> wrong.


Yes, quite.  How about the following to correct the intention.



Add correct Kconfig option for ISP24xx support.

Signed-off-by: Andrew Vasquez <andrew.vasquez@qlogic.com>
---

diff --git a/drivers/scsi/qla2xxx/Kconfig b/drivers/scsi/qla2xxx/Kconfig
--- a/drivers/scsi/qla2xxx/Kconfig
+++ b/drivers/scsi/qla2xxx/Kconfig
@@ -39,3 +39,11 @@ config SCSI_QLA6312
 	---help---
 	This driver supports the QLogic 63xx (ISP6312 and ISP6322) host
 	adapter family.
+
+config SCSI_QLA24XX
+	tristate "QLogic ISP24xx host adapter family support"
+	depends on SCSI_QLA2XXX
+        select SCSI_FC_ATTRS
+	---help---
+	This driver supports the QLogic 24xx (ISP2422 and ISP2432) host
+	adapter family.
diff --git a/drivers/scsi/qla2xxx/Makefile b/drivers/scsi/qla2xxx/Makefile
--- a/drivers/scsi/qla2xxx/Makefile
+++ b/drivers/scsi/qla2xxx/Makefile
@@ -1,6 +1,4 @@
 EXTRA_CFLAGS += -DUNIQUE_FW_NAME
-CONFIG_SCSI_QLA24XX=m
-EXTRA_CFLAGS += -DCONFIG_SCSI_QLA24XX -DCONFIG_SCSI_QLA24XX_MODULE
 
 qla2xxx-y := qla_os.o qla_init.o qla_mbx.o qla_iocb.o qla_isr.o qla_gs.o \
 		qla_dbg.o qla_sup.o qla_rscn.o qla_attr.o

