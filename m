Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVECQHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVECQHt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 12:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVECQHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 12:07:49 -0400
Received: from firewall.miltope.com ([208.12.184.221]:37511 "EHLO
	smtp.miltope.com") by vger.kernel.org with ESMTP id S261810AbVECQHY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 12:07:24 -0400
Content-class: urn:content-classes:message
Subject: RE: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Tue, 3 May 2005 11:07:53 -0500
Message-ID: <66F9227F7417874C8DB3CEB05772741704514D@MILEX0.Miltope.local>
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
Thread-Index: AcVP+YmCkqvkllbcTbyNxMNE6sJ4xQAAGDww
From: "Drew Winstel" <DWinstel@Miltope.com>
To: "Oskar Liljeblad" <oskar@osk.mine.nu>
Cc: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hm, I patched the kernel with 2.6.11-libata-dev1, compiled it with

># CONFIG_BLK_DEV_PDC202XX_NEW is not set
>CONFIG_BLK_DEV_VIA82CXXX=y   (for the motherboard IDE)
>CONFIG_SCSI=y
>CONFIG_SCSI_SATA=y
>CONFIG_SCSI_PATA_PDC2027X=y

>and rebooted. SCSI is initialized and the pata_pdc2027x driver is
>loaded, but it doesn't seem to find any devices. Or maybe it doesn't
>look for devices at all. I can tell that it's loaded by the existence
>of /sys/bus/pci/drivers/pata_pdc2027x (a directory which is empty).

>/proc/scsi/scsi is also empty besides the "Attached devices:" line.
>During startup the kernel does say "Probing IDE interface ide0"
>through "ide5" (finding only devices on ide0). I also tried compiling
>pata_pdc2027x as a module, with same result.

>What's wrong here?

I think I know what the problem is.

In include/linux/libata.h, make sure the preprocessor declarations are as 
follows.  I think the defaults have ATA_ENABLE_PATA undefined.

#define ATA_ENABLE_ATAPI        /* undefine to disable ATAPI support */
#define ATA_ENABLE_PATA          /* define to enable PATA support in some
                                 * low-level drivers */

Sorry I forgot to mention this earlier.  

Drew
