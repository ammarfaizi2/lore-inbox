Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWH3TDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWH3TDV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWH3TDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:03:21 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:29843 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751319AbWH3TDT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:03:19 -0400
Message-ID: <44F5E0F4.5080209@us.ibm.com>
Date: Wed, 30 Aug 2006 12:03:16 -0700
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>,
       Konrad Rzeszutek <konrad@darnok.org>
Subject: Re: [PATCH] aic94xx: Increase can_queue and cmds_per_lun
References: <44F3CF6E.1070000@us.ibm.com> <1156958383.7701.2.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1156958383.7701.2.camel@mulgrave.il.steeleye.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

> This is unnecessary unless you alter it before host alloc (which is
> where it takes the shost values from the template).
> 
> Also, I think if you look at the rest of the driver, it's careful to
> account for the need for required scbs in its internal queueing
> algorithms, so the ASD_FREE_SCBS should be unnecessary.
> 
>> +	shost->can_queue = aic94xx_sht.can_queue;

Ok then, I think it collapses to this short patch:

--D

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 3e25e31..861d67b 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -623,6 +623,8 @@ static int __devinit asd_pci_probe(struc
                   asd_ha->hw_prof.bios.present ? "build " : "not present",
                   asd_ha->hw_prof.bios.bld);

+       shost->can_queue = asd_ha->hw_prof.max_scbs;
+
        if (use_msi)
                pci_enable_msi(asd_ha->pcidev);
