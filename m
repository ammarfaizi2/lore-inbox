Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265296AbUBIREo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 12:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265303AbUBIREo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 12:04:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:47265 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265296AbUBIREm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 12:04:42 -0500
Date: Mon, 9 Feb 2004 08:58:17 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, jejb <james.bottomley@steeleye.com>,
       gibbs@scsiguy.com
Subject: Re: 2.6.3 CONFIG_SCSI_AIC7 X X X Kconfig bug
Message-Id: <20040209085817.055e1419.rddunlap@osdl.org>
In-Reply-To: <20040207162054.GA25651@suse.de>
References: <20040207162054.GA25651@suse.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Feb 2004 17:20:54 +0100 Olaf Hering <olh@suse.de> wrote:

| 
| who made that 'XXX in subject' reject? That is bug one.

Yeah, I just use xyz instead...


| another bug:
| 
| scsi is a module, but aic7xxx doesnt get build because it is set to yes.
| plain 2.6.3-rc1, happend also with 2.6.2.
| 
| grep SCSI .config | grep =
| CONFIG_BLK_DEV_IDESCSI=m
| CONFIG_SCSI=m
| CONFIG_SCSI_MULTI_LUN=y
| CONFIG_SCSI_REPORT_LUNS=y
| CONFIG_SCSI_CONSTANTS=y
| CONFIG_SCSI_LOGGING=y
| CONFIG_SCSI_AIC7XXX=y
| CONFIG_SCSI_QLA2XXX_CONFIG=m
| CONFIG_SCSI_DEBUG=m
| CONFIG_USB_HPUSBSCSI=m
| 
| I can not set CONFIG_SCSI_DEBUG to y, this is handled correctly.

Missing SCSI in "depends".  Patch is below.

--
~Randy



product_versions: linux-262-pv
description:	make Adaptec AIC7xyx drivers depend on SCSI tristate

diffstat:=
 drivers/scsi/aic7xxx/Kconfig.aic79xx |    2 +-
 drivers/scsi/aic7xxx/Kconfig.aic7xxx |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./drivers/scsi/aic7xxx/Kconfig.aic7xxx~depends ./drivers/scsi/aic7xxx/Kconfig.aic7xxx
--- ./drivers/scsi/aic7xxx/Kconfig.aic7xxx~depends	2004-02-03 19:43:42.000000000 -0800
+++ ./drivers/scsi/aic7xxx/Kconfig.aic7xxx	2004-02-09 09:04:01.000000000 -0800
@@ -4,7 +4,7 @@
 #
 config SCSI_AIC7XXX
 	tristate "Adaptec AIC7xxx Fast -> U160 support (New Driver)"
-	depends on PCI || EISA
+	depends on (PCI || EISA) && SCSI
 	---help---
 	This driver supports all of Adaptec's Fast through Ultra 160 PCI
 	based SCSI controllers as well as the aic7770 based EISA and VLB
diff -Naurp ./drivers/scsi/aic7xxx/Kconfig.aic79xx~depends ./drivers/scsi/aic7xxx/Kconfig.aic79xx
--- ./drivers/scsi/aic7xxx/Kconfig.aic79xx~depends	2004-02-03 19:43:43.000000000 -0800
+++ ./drivers/scsi/aic7xxx/Kconfig.aic79xx	2004-02-09 09:03:52.000000000 -0800
@@ -4,7 +4,7 @@
 #
 config SCSI_AIC79XX
 	tristate "Adaptec AIC79xx U320 support"
-	depends on PCI
+	depends on PCI && SCSI
 	help
 	This driver supports all of Adaptec's Ultra 320 PCI-X
 	based SCSI controllers.
