Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVGSOIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVGSOIE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 10:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVGSOEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 10:04:53 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55816 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261996AbVGSOEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 10:04:23 -0400
Date: Tue, 19 Jul 2005 16:04:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Erik Jacobson <erikj@sgi.com>
Subject: [-mm patch] SCSI_QLA2ABC options must select FW_LOADER
Message-ID: <20050719140419.GI5031@stusta.de>
References: <20050715013653.36006990.akpm@osdl.org> <20050715102744.GA3569@stusta.de> <20050715144037.GA25648@plap.qlogic.org> <dbbg0k$p8g$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbbg0k$p8g$1@sea.gmane.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ The subject was adapted to linux-kernel spam filters... ]

On Sat, Jul 16, 2005 at 07:26:44PM +0200, Jindrich Makovicka wrote:
> Andrew Vasquez wrote:
> > Yes, quite.  How about the following to correct the intention.
> > 
> > 
> > 
> > Add correct Kconfig option for ISP24xx support.
> > 
> > Signed-off-by: Andrew Vasquez <andrew.vasquez@qlogic.com>
> > ---
> > 
> > diff --git a/drivers/scsi/qla2xxx/Kconfig b/drivers/scsi/qla2xxx/Kconfig
> > --- a/drivers/scsi/qla2xxx/Kconfig
> > +++ b/drivers/scsi/qla2xxx/Kconfig
> > @@ -39,3 +39,11 @@ config SCSI_QLA6312
> >  	---help---
> >  	This driver supports the QLogic 63xx (ISP6312 and ISP6322) host
> >  	adapter family.
> > +
> > +config SCSI_QLA24XX
> > +	tristate "QLogic ISP24xx host adapter family support"
> > +	depends on SCSI_QLA2XXX
> > +        select SCSI_FC_ATTRS
> 
> there should be also "select FW_LOADER", as it uses request_firmware &
> release_firmware
>...

You are right, patch below.

> Jindrich Makovicka

cu
Adrian


<--  snip  -->


qla_init.c now uses code that requires FW_LOADER.

Additionally, this patch removes spaces instead of tabs at the 
SCSI_FC_ATTRS selects.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-full/drivers/scsi/qla2xxx/Kconfig.old	2005-07-17 15:44:26.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/drivers/scsi/qla2xxx/Kconfig	2005-07-17 15:45:45.000000000 +0200
@@ -1,49 +1,55 @@
 config SCSI_QLA2XXX
 	tristate
 	depends on SCSI && PCI
 	default y
 
 config SCSI_QLA21XX
 	tristate "QLogic ISP2100 host adapter family support"
 	depends on SCSI_QLA2XXX
-        select SCSI_FC_ATTRS
+	select SCSI_FC_ATTRS
+	select FW_LOADER
 	---help---
 	This driver supports the QLogic 21xx (ISP2100) host adapter family.
 
 config SCSI_QLA22XX
 	tristate "QLogic ISP2200 host adapter family support"
 	depends on SCSI_QLA2XXX
-        select SCSI_FC_ATTRS
+	select SCSI_FC_ATTRS
+	select FW_LOADER
 	---help---
 	This driver supports the QLogic 22xx (ISP2200) host adapter family.
 
 config SCSI_QLA2300
 	tristate "QLogic ISP2300 host adapter family support"
 	depends on SCSI_QLA2XXX
-        select SCSI_FC_ATTRS
+	select SCSI_FC_ATTRS
+	select FW_LOADER
 	---help---
 	This driver supports the QLogic 2300 (ISP2300 and ISP2312) host
 	adapter family.
 
 config SCSI_QLA2322
 	tristate "QLogic ISP2322 host adapter family support"
 	depends on SCSI_QLA2XXX
-        select SCSI_FC_ATTRS
+	select SCSI_FC_ATTRS
+	select FW_LOADER
 	---help---
 	This driver supports the QLogic 2322 (ISP2322) host adapter family.
 
 config SCSI_QLA6312
 	tristate "QLogic ISP63xx host adapter family support"
 	depends on SCSI_QLA2XXX
-        select SCSI_FC_ATTRS
+	select SCSI_FC_ATTRS
+	select FW_LOADER
 	---help---
 	This driver supports the QLogic 63xx (ISP6312 and ISP6322) host
 	adapter family.
 
 config SCSI_QLA24XX
 	tristate "QLogic ISP24xx host adapter family support"
 	depends on SCSI_QLA2XXX
-        select SCSI_FC_ATTRS
+	select SCSI_FC_ATTRS
+	select FW_LOADER
 	---help---
 	This driver supports the QLogic 24xx (ISP2422 and ISP2432) host
 	adapter family.
