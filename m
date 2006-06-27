Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWF0UVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWF0UVq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWF0UVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:21:44 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:45697 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1030343AbWF0UVd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:21:33 -0400
Message-Id: <20060627201606.534265000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:19 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Albert Lee <albertcc@tw.ibm.com>, Tejun Heo <htejun@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 19/25] libata: minor patch for ATA_DFLAG_PIO
Content-Disposition: inline; filename=libata-minor-patch-for-ata_dflag_pio.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Tejun Heo <htejun@gmail.com>

 - With 2.6.17 libata, some PIO-only devices are given DMA commands.

Changes:
 - Do not clear the ATA_DFLAG_PIO flag in ata_dev_configure().

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/scsi/libata-core.c |    2 +-
 include/linux/libata.h     |    9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

--- linux-2.6.17.1.orig/drivers/scsi/libata-core.c
+++ linux-2.6.17.1/drivers/scsi/libata-core.c
@@ -1229,7 +1229,7 @@ static int ata_dev_configure(struct ata_
 		       id[84], id[85], id[86], id[87], id[88]);
 
 	/* initialize to-be-configured parameters */
-	dev->flags = 0;
+	dev->flags &= ~ATA_DFLAG_CFG_MASK;
 	dev->max_sectors = 0;
 	dev->cdb_len = 0;
 	dev->n_sectors = 0;
--- linux-2.6.17.1.orig/include/linux/libata.h
+++ linux-2.6.17.1/include/linux/libata.h
@@ -120,9 +120,12 @@ enum {
 	ATA_SHT_USE_CLUSTERING	= 1,
 
 	/* struct ata_device stuff */
-	ATA_DFLAG_LBA48		= (1 << 0), /* device supports LBA48 */
-	ATA_DFLAG_PIO		= (1 << 1), /* device currently in PIO mode */
-	ATA_DFLAG_LBA		= (1 << 2), /* device supports LBA */
+	ATA_DFLAG_LBA		= (1 << 0), /* device supports LBA */
+	ATA_DFLAG_LBA48		= (1 << 1), /* device supports LBA48 */
+
+	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
+
+	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */

--
