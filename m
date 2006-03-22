Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932806AbWCVVpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932806AbWCVVpF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932804AbWCVVpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:45:05 -0500
Received: from xenotime.net ([66.160.160.81]:19659 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751232AbWCVVpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:45:02 -0500
Date: Wed, 22 Mar 2006 13:47:10 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: [PATCH] SCSI: link scsi_debug later (updated)
Message-Id: <20060322134710.2de9e19d.rdunlap@xenotime.net>
In-Reply-To: <1143055627.3629.1.camel@mulgrave.il.steeleye.com>
References: <1142956795.4377.19.camel@mulgrave.il.steeleye.com>
	<20060322083647.cc0ccdd4.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0603221048210.26286@g5.osdl.org>
	<1143055627.3629.1.camel@mulgrave.il.steeleye.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Changing CONFIG_SCSI_DEBUG from =n or =m to =y can cause the enumeration
of the SATA devices to change.

Fix that by linking the scsi_debug driver after the SATA drivers.
Leave scsi_debug at the bottom of the list of low-level drivers so
that this problem doesn't happen again.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Douglas Gilbert <dougg@torque.net>
---
 drivers/scsi/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2616-rc6.orig/drivers/scsi/Makefile
+++ linux-2616-rc6/drivers/scsi/Makefile
@@ -117,7 +117,6 @@ obj-$(CONFIG_SCSI_PPA)		+= ppa.o
 obj-$(CONFIG_SCSI_IMM)		+= imm.o
 obj-$(CONFIG_JAZZ_ESP)		+= NCR53C9x.o	jazz_esp.o
 obj-$(CONFIG_SUN3X_ESP)		+= NCR53C9x.o	sun3x_esp.o
-obj-$(CONFIG_SCSI_DEBUG)	+= scsi_debug.o
 obj-$(CONFIG_SCSI_FCAL)		+= fcal.o
 obj-$(CONFIG_SCSI_LASI700)	+= 53c700.o lasi700.o
 obj-$(CONFIG_SCSI_NSP32)	+= nsp32.o
@@ -140,6 +139,7 @@ obj-$(CONFIG_SCSI_SATA_MV)	+= libata.o s
 obj-$(CONFIG_SCSI_PDC_ADMA)	+= libata.o pdc_adma.o
 
 obj-$(CONFIG_ARM)		+= arm/
+obj-$(CONFIG_SCSI_DEBUG)	+= scsi_debug.o
 
 obj-$(CONFIG_CHR_DEV_ST)	+= st.o
 obj-$(CONFIG_CHR_DEV_OSST)	+= osst.o



---
