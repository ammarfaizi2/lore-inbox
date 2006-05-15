Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbWEOTG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbWEOTG1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWEOTG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:06:27 -0400
Received: from outgoing2.smtp.agnat.pl ([193.239.44.84]:43023 "EHLO
	outgoing2.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S932317AbWEOTG0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:06:26 -0400
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Organization: SelfOrganizing
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Date: Mon, 15 May 2006 21:06:08 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20060515170006.GA29555@havoc.gtf.org> <20060515101831.0e38d131.akpm@osdl.org> <4468C33F.7070905@garzik.org>
In-Reply-To: <4468C33F.7070905@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605152106.08239.arekm@maven.pl>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 May 2006 20:06, Jeff Garzik wrote:

> > http://bugzilla.kernel.org/show_bug.cgi?id=6260
>
> waiting on SATA ACPI merge.
Is this really a case?

The one (layering breaking; discussed already) patch cures the problem and 
nothing sata acpi related is needed, so something else is problematic here I 
guess.

--- 2.6.17-rc2/drivers/scsi/libata-core.c       2006-04-19 09:14:11.000000000 
+0100 
+++ linux/drivers/scsi/libata-core.c    2006-04-21 20:55:48.000000000 +0100 
@@ -4288,6 +4288,7 @@ int ata_device_resume(struct ata_port *a 
 { 
        if (ap->flags & ATA_FLAG_SUSPENDED) { 
                ap->flags &= ~ATA_FLAG_SUSPENDED; 
+               ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT); 
                ata_set_mode(ap); 
        } 
        if (!ata_dev_present(dev))

-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
