Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWAJMVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWAJMVR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 07:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWAJMVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 07:21:16 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:64230 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750742AbWAJMVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 07:21:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=HarvSSqReRPRlTw0zbKoZpGq2qgLJQyZ9UHcggMxyb2MLoCTqzdAaWvYBUEAJvxpSbAnaNqltHidu4l7hl0bv4t9a1bkUcpOcOxh7oXLFlg9BxXWmr54bqwBBsVu7SWvRDR3AHd2sGQs5sLJqDePAlCvyzKHgPC12wFi2Tq0Qcw=
Message-ID: <81083a450601100421t5f8fcc4am2c0ec666feccc4ca@mail.gmail.com>
Date: Tue, 10 Jan 2006 17:51:15 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       James.Bottomley@steeleye.com, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] scsi/aha1740.c Handle scsi_add_host failure
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_92_15703604.1136895675020"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_92_15703604.1136895675020
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Add scsi_add_host() failure handling for Adaptec aha1740 driver.

Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>

------=_Part_92_15703604.1136895675020
Content-Type: text/plain; name=aha1740.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="aha1740.txt"

diff -Naurp linux-2.6.15-git5-vanilla/drivers/scsi/aha1740.c linux-2.6.15-git5/drivers/scsi/aha1740.c
--- linux-2.6.15-git5-vanilla/drivers/scsi/aha1740.c	2006-01-03 08:51:10.000000000 +0530
+++ linux-2.6.15-git5/drivers/scsi/aha1740.c	2006-01-10 16:22:13.000000000 +0530
@@ -587,7 +587,7 @@ static struct scsi_host_template aha1740
 
 static int aha1740_probe (struct device *dev)
 {
-	int slotbase;
+	int slotbase, retval;
 	unsigned int irq_level, irq_type, translation;
 	struct Scsi_Host *shpnt;
 	struct aha1740_hostdata *host;
@@ -642,7 +642,13 @@ static int aha1740_probe (struct device 
 	}
 
 	eisa_set_drvdata (edev, shpnt);
-	scsi_add_host (shpnt, dev); /* XXX handle failure */
+	retval = scsi_add_host (shpnt, dev);
+	if (retval) {
+		printk(KERN_WARNING "aha1740: scsi_add_host failed\n");
+		scsi_host_put (shpnt);
+		return retval;
+	}
+		
 	scsi_scan_host (shpnt);
 	return 0;
 

------=_Part_92_15703604.1136895675020--
