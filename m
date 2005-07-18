Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVGRTX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVGRTX7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 15:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVGRTX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 15:23:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27358 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261545AbVGRTX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 15:23:59 -0400
Date: Mon, 18 Jul 2005 14:23:57 -0500
From: Erik Jacobson <erikj@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] QLA2xxx FW_LOADER Kconfig issue results in undefined symbols
Message-ID: <20050718192357.GA8470@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hit a small problem (first observed in 2.6.13-rc3-mm1) that resulted in
my kernels no longer building because of undefined references to 
request_firmware and release_firmware.

After a little research, I found that the QLA stuff requires CONFIG_FW_LOADER.

I was using the sn2_defconfig as a starting point for my config file. 
This config file compiles some of the QLA2xxx drivers statically.
By default, CONFIG_FW_LOADER is set to "m" and not "y".

So this small change should ensure CONFIG_FW_LOADER is set properly.

Perhaps there are better ways to do this?

Signed-off-by: Erik Jacobson <erikj@sgi.com>

---

 Kconfig |    1 +
 1 files changed, 1 insertion(+)


diff -Naru 2.6-akpm-rc-mm-orig/drivers/scsi/qla2xxx/Kconfig 2.6-akpm-rc-mm/drivers/scsi/qla2xxx/Kconfig
--- 2.6-akpm-rc-mm-orig/drivers/scsi/qla2xxx/Kconfig	2005-07-15 10:58:54.316985000 -0500
+++ 2.6-akpm-rc-mm/drivers/scsi/qla2xxx/Kconfig	2005-07-18 14:03:37.888758336 -0500
@@ -3,6 +3,7 @@
 	default (SCSI && PCI)
 	depends on SCSI && PCI
 	select SCSI_FC_ATTRS
+	select FW_LOADER
 
 config SCSI_QLA21XX
 	tristate "QLogic ISP2100 host adapter family support"

--
Erik Jacobson - Linux System Software - Silicon Graphics - Eagan, Minnesota
