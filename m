Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161228AbWI2A22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161228AbWI2A22 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbWI2A21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:28:27 -0400
Received: from havoc.gtf.org ([69.61.125.42]:32391 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161223AbWI2A2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:28:23 -0400
Date: Thu, 28 Sep 2006 20:28:22 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-ide@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] libata: Print out Status register
Message-ID: <20060929002822.GD7458@havoc.gtf.org>
References: <20060929002601.GA7397@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929002601.GA7397@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


commit 35aa7a436c0901fd6f352eff347f58448c141a25
Author: Jeff Garzik <jeff@garzik.org>
Date:   Thu Sep 28 06:50:24 2006 -0400

    [libata] Print out Status register, if a BSY-sleep takes too long

    We have the info stored in an ata_busy_sleep() variable, so might as
    well print it, and provide some additional diagnostic info.

    Signed-off-by: Jeff Garzik <jeff@garzik.org>

 drivers/ata/libata-core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

35aa7a436c0901fd6f352eff347f58448c141a25
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 72644bd..7ab45f4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2340,7 +2340,8 @@ unsigned int ata_busy_sleep (struct ata_
 
 	if (status & ATA_BUSY)
 		ata_port_printk(ap, KERN_WARNING,
-				"port is slow to respond, please be patient\n");
+				"port is slow to respond, please be patient "
+				"(Status 0x%x)\n", status);
 
 	timeout = timer_start + tmout;
 	while ((status & ATA_BUSY) && (time_before(jiffies, timeout))) {
@@ -2350,7 +2351,8 @@ unsigned int ata_busy_sleep (struct ata_
 
 	if (status & ATA_BUSY) {
 		ata_port_printk(ap, KERN_ERR, "port failed to respond "
-				"(%lu secs)\n", tmout / HZ);
+				"(%lu secs, Status 0x%x)\n",
+				tmout / HZ, status);
 		return 1;
 	}
 
