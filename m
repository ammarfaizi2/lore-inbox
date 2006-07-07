Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWGGNnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWGGNnV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 09:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWGGNnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 09:43:20 -0400
Received: from rtr.ca ([64.26.128.89]:4075 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750957AbWGGNnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 09:43:20 -0400
From: Mark Lord <liml@rtr.ca>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Fri, 7 Jul 2006 09:43:17 -0400
User-Agent: KMail/1.9.3
Cc: Sander <sander@humilis.net>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <200607070908.44751.liml@rtr.ca> <Pine.LNX.4.64.0607070923130.4099@p34.internal.lan>
In-Reply-To: <Pine.LNX.4.64.0607070923130.4099@p34.internal.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607070943.17957.liml@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> 
> had to change
> 
> KERN_WARN -> KERN_WARNING
> 
> then more errors

Eh?  After fixing the KERN_WARN -> KERN_WARNING part,
the patch compiles / links cleanly here on 2.6.17.
(fixed copy below).   Still untested, though.

> do you know who wrote the original patch?

I did.

Cheers

--- linux/drivers/scsi/libata-scsi.c.orig	2006-06-19 10:37:03.000000000 -0400
+++ linux/drivers/scsi/libata-scsi.c	2006-07-07 09:06:57.000000000 -0400
@@ -542,6 +542,7 @@
 	struct ata_taskfile *tf = &qc->tf;
 	unsigned char *sb = cmd->sense_buffer;
 	unsigned char *desc = sb + 8;
+	unsigned char ata_op = tf->command;
 
 	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
 
@@ -558,6 +559,7 @@
 	 * onto sense key, asc & ascq.
 	 */
 	if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
+		printk(KERN_WARNING "ata_gen_ata_desc_sense: failed ata_op=0x%02x\n", ata_op);
 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
 				   &sb[1], &sb[2], &sb[3]);
 		sb[1] &= 0x0f;
