Return-Path: <linux-kernel-owner+w=401wt.eu-S1751245AbXAIL2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbXAIL2n (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 06:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbXAIL2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 06:28:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:8282 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbXAIL2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 06:28:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kt6K2qN/6CFP39tAr+VjN3EFFrgquOY91Ycn0LKbncMTyOloZvCE6mw/46dWDWpJvsVbi1eBkyGC2zcNW2i34EUkoNpVzTpjgJ3P9eIoyboy2JTMZcuAAD0dpjyhBFmI5TGev/5KQF9XmzfPraWAA62JYapCysvFV4mGwNt0gSM=
Message-ID: <5767b9100701090328o4b78fd4x2b18a42a996608d9@mail.gmail.com>
Date: Tue, 9 Jan 2007 19:28:40 +0800
From: "Conke Hu" <conke.hu@gmail.com>
To: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 1/3] atiixp.c: remove unused code
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Greg KH" <greg@kroah.com>,
       linux-ide@vger.kernel.org
In-Reply-To: <58cb370e0701061812s49c4b1f5p5c5e99e5eea3bb89@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5767b9100701060411h13324086uf6552a5166641534@mail.gmail.com>
	 <58cb370e0701061812s49c4b1f5p5c5e99e5eea3bb89@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/07, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On 1/6/07, Conke Hu <conke.hu@gmail.com> wrote:
> > A previous patch to atiixp.c was removed but some code has not been
>
> This one?
>
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=ab17443a3df35abe4b7529e83511a591aa7384f3
>
> Doesn't it break existing setups without giving ANY warning?
>
> theoretical (I don't have hardware in question) scenario:
> - user uses atiixp and has modular libata/ahci (or no libata/ahci et all)
> - user does kernel upgrade
> - boot fails
> - ...
>
> If this is true please add something like
>
> printk(KERN_WARNING "PCI: setting SB600 SATA to AHCI mode"
> " (please use ahci driver instead of atiixp)\n");
>
> to quirk_sb600_sata() so people will at least know what is wrong...
>
> > cleaned. Now we remove these code sine they are no use any longer.
>
> Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>
> [ but the patch is line wrapped and unfortunately doesn't apply ]
>
> PS: please always cc: linux-ide@vger.kernel.org on PATA/SATA patches
>
> Thanks,
> Bart
>


Hi Bart,
    I've tried to access the following link to make sure which it is,
but failed. The internet here   is almost broken.
    http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=ab17443a3df35abe4b7529e83511a591aa7384f3

   I sent out 2 patches for the same SB600 legacy IDE issue. the later
(sb600 pci qurik) is better so we should clean the previous patch
which was applied to atiixp.c. -- that is what this patch does.

    BTW, I re-create and re-send the patch (see below) based on
2.6.20-rc4, in last patch I fogot to rename atiixp.c.1 to atiixp.c
which may lead to patch fail, nothing else different.
    And maybe no need to re-ACK if last one is accepted:)
    Thanks!

--------------------
--- linux-2.6.20-rc4/drivers/ide/pci/atiixp.c.1	2007-01-09
15:19:05.000000000 +0800
+++ linux-2.6.20-rc4/drivers/ide/pci/atiixp.c	2007-01-09
15:17:54.000000000 +0800
@@ -320,20 +320,6 @@ static void __devinit init_hwif_atiixp(i
 	hwif->drives[0].autodma = hwif->autodma;
 }

-static void __devinit init_hwif_sb600_legacy(ide_hwif_t *hwif)
-{
-
-	hwif->atapi_dma = 1;
-	hwif->ultra_mask = 0x7f;
-	hwif->mwdma_mask = 0x07;
-	hwif->swdma_mask = 0x07;
-
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
-}
-
 static ide_pci_device_t atiixp_pci_info[] __devinitdata = {
 	{	/* 0 */
 		.name		= "ATIIXP",
@@ -342,13 +328,7 @@ static ide_pci_device_t atiixp_pci_info[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x48,0x01,0x00}, {0x48,0x08,0x00}},
 		.bootable	= ON_BOARD,
-	},{	/* 1 */
-		.name		= "ATI SB600 SATA Legacy IDE",
-		.init_hwif	= init_hwif_sb600_legacy,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	}
+	},
 };

 /**
