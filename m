Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVG0Xvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVG0Xvc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 19:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVG0Xtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 19:49:31 -0400
Received: from fmr24.intel.com ([143.183.121.16]:36006 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261177AbVG0Xrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 19:47:31 -0400
Date: Wed, 27 Jul 2005 16:47:14 -0700
From: tony.luck@intel.com
Message-Id: <200507272347.j6RNlENf005209@agluck-lia64.sc.intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Cc: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: [PATCH] qla2xxx: mark dependency on FW_LOADER
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jindrich spotted this 10 days ago, but it seems to have fallen through
the cracks.

qla_init.c uses request_firmware/release_firmware ... so make sure
that our kernel is configured to provide them if qla2xxx is included.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

diff --git a/drivers/scsi/qla2xxx/Kconfig b/drivers/scsi/qla2xxx/Kconfig
--- a/drivers/scsi/qla2xxx/Kconfig
+++ b/drivers/scsi/qla2xxx/Kconfig
@@ -3,6 +3,7 @@ config SCSI_QLA2XXX
 	default (SCSI && PCI)
 	depends on SCSI && PCI
 	select SCSI_FC_ATTRS
+	select FW_LOADER
 
 config SCSI_QLA21XX
 	tristate "QLogic ISP2100 host adapter family support"
