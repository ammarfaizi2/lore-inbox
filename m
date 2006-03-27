Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWC0Rlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWC0Rlw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbWC0Rlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:41:51 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38312 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750973AbWC0Rlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:41:50 -0500
Subject: PATCH: libata - ATA is both ATA and CFA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Mar 2006 18:49:19 +0100
Message-Id: <1143481759.4970.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this is still needed with the new probe code (which btw seems to
be missing docs in upstream ?).

Signed-off-by: Alan Cox <alan@redhat.com>

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1cb9813..18d5239 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1140,7 +1140,7 @@ static int ata_dev_read_id(struct ata_po
 	swap_buf_le16(id, ATA_ID_WORDS);
 
 	/* sanity check */
-	if ((class == ATA_DEV_ATA) != ata_id_is_ata(id)) {
+	if ((class == ATA_DEV_ATA) != (ata_id_is_ata(id) | ata_id_is_cfa(id))) {
 		rc = -EINVAL;
 		reason = "device reports illegal type";
 		goto err_out;

