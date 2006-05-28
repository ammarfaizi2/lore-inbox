Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWE1Vth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWE1Vth (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 17:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWE1Vth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 17:49:37 -0400
Received: from rtr.ca ([64.26.128.89]:20712 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750964AbWE1Vtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 17:49:36 -0400
Message-ID: <447A1AEF.3040900@rtr.ca>
Date: Sun, 28 May 2006 17:49:35 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Paul Dickson <dickson@permanentmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Resume stops working between 2.6.16 and 2.6.17-rc1 on Dell Inspiron
 6000
References: <20060528140238.2c25a805.dickson@permanentmail.com>	<1148850683.3074.72.camel@laptopd505.fenrus.org> <20060528142951.2a7417cb.dickson@permanentmail.com>
In-Reply-To: <20060528142951.2a7417cb.dickson@permanentmail.com>
Content-Type: multipart/mixed;
 boundary="------------020900060209070308070603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020900060209070308070603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

We've just now put out a one-liner patch to libata that fixes
resume on my own Inspiron, and for other machines as well.

Does it fix the problem here too?  (copy of patch is attached)

--------------020900060209070308070603
Content-Type: text/x-patch;
 name="01_libata_resume.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01_libata_resume.patch"

--- linux-2.6.17-rc5/drivers/scsi/libata-core.c
+++ linux/drivers/scsi/libata-core.c
@@ -4296,6 +4296,7 @@ static int ata_start_drive(struct ata_po
  */
 int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
 {
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
+		ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
 		ata_set_mode(ap);

--------------020900060209070308070603--
