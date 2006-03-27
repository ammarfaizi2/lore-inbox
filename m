Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWC0Rxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWC0Rxy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWC0Rxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:53:54 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25317 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751107AbWC0Rxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:53:54 -0500
Subject: PATCH: Fix interesting use of "extern" and also some bracketing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Mar 2006 19:01:32 +0100
Message-Id: <1143482492.4970.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

Last of the set, just clean up some oddments. Assuming the whole set is
now ok then the remaining differences are the setup of PIO_0 at reset
and the ->data_xfer method.

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1cb9813..18d5239 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2142,9 +2166,9 @@ static int sata_phy_resume(struct ata_po
  *	so makes reset sequence different from the original
  *	->phy_reset implementation and Jeff nervous.  :-P
  */
-extern void ata_std_probeinit(struct ata_port *ap)
+void ata_std_probeinit(struct ata_port *ap)
 {
-	if (ap->flags & ATA_FLAG_SATA && ap->ops->scr_read) {
+	if ((ap->flags & ATA_FLAG_SATA) && ap->ops->scr_read) {
 		sata_phy_resume(ap);
 		if (sata_dev_present(ap))
 			ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);

