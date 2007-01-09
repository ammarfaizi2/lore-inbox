Return-Path: <linux-kernel-owner+w=401wt.eu-S1751375AbXAIMs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbXAIMs4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 07:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbXAIMs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 07:48:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:59226 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbXAIMsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 07:48:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ftPyfSQSbaEDHwfOX5Cg59nilGsgWNSU3Fos1RhPaAe9qFuCllU6YHOs30birGwT230F4RZeW4qk24bJOH+u9GuLxGMWxRB+RaAwtm6zYZ4dAGSV1JdCgdLW++ZV96M4Fi6+dQnJXVX3K/Zj8pRm+kSLoRv3C8nSCopOKj+PbDU=
Message-ID: <5767b9100701090448h1d9dc37erc9bbf9c3202f7389@mail.gmail.com>
Date: Tue, 9 Jan 2007 20:48:53 +0800
From: "Conke Hu" <conke.hu@gmail.com>
To: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] atiixp.c: sb600 ide only has one channel
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Greg KH" <greg@kroah.com>,
       linux-ide@vger.kernel.org
In-Reply-To: <58cb370e0701061814g7d37578cj6edab7f15e630348@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5767b9100701060414j2e2385a8xcbab477bedca34b3@mail.gmail.com>
	 <58cb370e0701061814g7d37578cj6edab7f15e630348@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/07, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On 1/6/07, Conke Hu <conke.hu@gmail.com> wrote:
> > AMD/ATI SB600 IDE/PATA controller only has one channel.
> >
> > Signed-off-by: Conke Hu <conke.hu@amd.com>
>
> Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>
> [ but the patch is line wrapped ]
>

Hi Bart,
    Thank you!
    I've re-created the patch based on 2.6.20-rc4, pls see below.
    I've sent out 3 patches for the same file atiixp.c, pls apply it
after the [patch 1/3] :)
-------------------
--- linux-2.6.20-rc4/drivers/ide/pci/atiixp.c.2	2007-01-09
15:21:29.000000000 +0800
+++ linux-2.6.20-rc4/drivers/ide/pci/atiixp.c	2007-01-09
15:25:15.000000000 +0800
@@ -328,7 +328,14 @@ static ide_pci_device_t atiixp_pci_info[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x48,0x01,0x00}, {0x48,0x08,0x00}},
 		.bootable	= ON_BOARD,
-	},
+	},{	/* 1 */
+		.name		= "SB600_PATA",
+		.init_hwif	= init_hwif_atiixp,
+		.channels	= 1,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x48,0x01,0x00}, {0x00,0x00,0x00}},
+ 		.bootable	= ON_BOARD,
+ 	},
 };

 /**
@@ -349,7 +356,7 @@ static struct pci_device_id atiixp_pci_t
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP200_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 1},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);
