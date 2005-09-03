Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbVICOJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbVICOJF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 10:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbVICOJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 10:09:04 -0400
Received: from mail.tor.primus.ca ([216.254.136.21]:54422 "EHLO
	smtp-01.primus.ca") by vger.kernel.org with ESMTP id S1751193AbVICOJD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 10:09:03 -0400
Message-ID: <4319AE7B.3010304@dtbb.net>
Date: Sat, 03 Sep 2005 07:08:59 -0700
From: Tyler <pml@dtbb.net>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brett Russ <russb@emc.com>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13] libata: Marvell SATA support (PIO mode)
References: <20050830183625.BEE1520F4C@lns1058.lss.emc.com> <4314C604.4030208@pobox.com> <20050901142754.B93BF27137@lns1058.lss.emc.com>
In-Reply-To: <20050901142754.B93BF27137@lns1058.lss.emc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett Russ wrote:

>Some (non-functional) cleanup modifications since the version 0.10
>driver I sent out 2005-08-30.  Also adding signed-off-by for Jeff's
>upstream push.  This is my libata compatible low level driver for
>the Marvell SATA family.  Currently it successfully runs in PIO mode
>on a 6081 chip.  EDMA support is in the works and should be done
>shortly.  Review, testing (especially on other flavors of Marvell),
>comments welcome.
>
>Thank you,
>BR
>
>Signed-off-by: Brett Russ <russb@emc.com>
>
>  
>
[snip..]

Please find attached patches that add the Adaptec 1420SA controller to 
the PCI ID list in the driver, and a small note in the kernel config 
option to state so.  This is untested as of currently, if anyone has a 
1420SA to try, that would be great..  The one I had access to is now 
gone to a remote location out of reach for testing.  I read in one post 
I found with google, that the 1420SA uses a 6541 chip instead of a 6041, 
but I am not able to verify this, and also don't know if it may still 
work as a 6041.  The card is still a Sata2, PCI-X card, with 4 ports, 
the same as the 6041 based cards.  This patch may or may not be 
useful..  The card comes with a manufacturer ID of 9005 according to a 
linux PCI-ID list, which is a secondary id of Adaptec's known as 
ADAPTEC2, and an actual PCI Id of 0241.

Signed-off-by: Tyler Guthrie <pml@dtbb.net>


--- linux-2.6.13.orig/drivers/scsi/Kconfig      2005-09-03 
06:42:20.000000000 -0700
+++ linux-2.6.13drivers/scsi/Kconfig    2005-09-03 06:44:29.000000000 -0700
@@ -466,6 +466,8 @@
          This option enables support for the Marvell Serial ATA family.
          Currently supports 88SX[56]0[48][01] chips.
 
+         Also Including Adaptec 1420SA Card (using marvell chip pci-id 
0x0241).
+
          If unsure, say N.
 
 config SCSI_SATA_NV

--- linux-2.6.13.orig/drivers/scsi/sata_mv.c    2005-09-03 
06:40:07.000000000 -0700
+++ linux-2.6.13/drivers/scsi/sata_mv.c         2005-09-03 
06:39:47.000000000 -0700
@@ -286,6 +286,7 @@
        {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6041), 0, 0, chip_604x},
        {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6080), 0, 0, chip_608x},
        {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6081), 0, 0, chip_608x},
+       {PCI_DEVICE(PCI_VENDOR_ID_ADAPTEC2, 0x0241), 0, 0, chip_604x},
        {}                      /* terminate list */
 };



Tyler.
