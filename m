Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWCLCZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWCLCZe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 21:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWCLCZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 21:25:33 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:2457 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750840AbWCLCZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 21:25:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=UoS0GMjjMHYYv0aaQQVyrjUlQLgXoYiMx1gGxzAaICG6TRvoN4a4pzdFaRkSvRJ7GfSFPP/0IPS76d63/OR1AkhoG5tYa9wMmhj6CZFQZv/I41RrGzhcGsFNfeKpCwMwY5P0g8ggc2yG8nvntm6/07Xh5yNBRtOG6OeHDEZkjIk=
Date: Sun, 12 Mar 2006 11:25:27 +0900
From: Tejun Heo <htejun@gmail.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ahci: enable prefetching for PACKET commands
Message-ID: <20060312022527.GA29870@htj.dyndns.org>
References: <20060304173505.GA28643@havoc.gtf.org> <20060310043717.GA7510@htj.dyndns.org> <44136C13.4020002@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44136C13.4020002@garzik.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Turn on AHCI_CMD_PREFETCH for PACKET commands.  This hints the
controller that it can prefetch the CDB and the PRD entries.  This
patch is originally from Jeff Garzik.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Jeff, I'll send two flavors of this patch.  The other one will enable
AHCI_CMD_PREFETCH for both ATA and ATAPI devices.  I've tested both
cases on ICH7R.

 ahci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 00dfdef..e97ab3e 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -66,6 +66,7 @@ enum {
 	AHCI_IRQ_ON_SG		= (1 << 31),
 	AHCI_CMD_ATAPI		= (1 << 5),
 	AHCI_CMD_WRITE		= (1 << 6),
+	AHCI_CMD_PREFETCH	= (1 << 7),
 	AHCI_CMD_RESET		= (1 << 8),
 	AHCI_CMD_CLR_BUSY	= (1 << 10),
 
@@ -631,7 +632,7 @@ static void ahci_qc_prep(struct ata_queu
 	if (qc->tf.flags & ATA_TFLAG_WRITE)
 		opts |= AHCI_CMD_WRITE;
 	if (is_atapi)
-		opts |= AHCI_CMD_ATAPI;
+		opts |= AHCI_CMD_ATAPI | AHCI_CMD_PREFETCH;
 
 	ahci_fill_cmd_slot(pp, opts);
 }
