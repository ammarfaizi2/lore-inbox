Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263497AbUJ2WZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263497AbUJ2WZE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbUJ2WXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:23:02 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18955 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263609AbUJ2WC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 18:02:26 -0400
Date: Sat, 30 Oct 2004 00:01:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Jes Sorensen <jes@wildopensource.com>,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel list <linux-kernel@vger.kernel.org>,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [2.6 patch] SCSI_QLOGIC_1280_1040 dependencies
Message-ID: <20041029220153.GZ6677@stusta.de>
References: <4179BA08.3080902@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4179BA08.3080902@eyal.emu.id.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 11:55:20AM +1000, Eyal Lebedinsky wrote:

> Should the second line be indented?
> 
> Qlogic QLA 1240/1x80/1x160 SCSI support (SCSI_QLOGIC_1280) [M/n/?] m
> Qlogic QLA 1020/1040 SCSI support (SCSI_QLOGIC_1280_1040) [N/y/?] (NEW) y

Correct, SCSI_QLOGIC_1280_1040 should depend on SCSI_QLOGIC_1280.

The patch below does this.

Additionally, it prevents the case that both drivers are built 
statically and both support the 1020/1040.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/drivers/scsi/Kconfig.old	2004-10-29 23:51:39.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/drivers/scsi/Kconfig	2004-10-29 23:56:42.000000000 +0200
@@ -1288,6 +1288,7 @@
 
 config SCSI_QLOGIC_1280_1040
 	bool "Qlogic QLA 1020/1040 SCSI support"
+	depends on SCSI_QLOGIC_1280 && SCSI_QLOGIC_ISP!=y
 	help
 	  Say Y here if you have a QLogic ISP1020/1040 SCSI host adapter and
 	  do not want to use the old driver.  This option enables support in

