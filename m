Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287751AbSA3Atd>; Tue, 29 Jan 2002 19:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287596AbSA3AtT>; Tue, 29 Jan 2002 19:49:19 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:57869 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S287552AbSA3As4>; Tue, 29 Jan 2002 19:48:56 -0500
Message-Id: <200201300048.g0U0mrI59231@aslan.scsiguy.com>
To: andersen@codepoet.org
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec 1480b SlimSCSI vs hotplug 
In-Reply-To: Your message of "Tue, 29 Jan 2002 16:26:29 MST."
             <20020129232629.GB937@codepoet.org> 
Date: Tue, 29 Jan 2002 17:48:53 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Does this look agreeable?

The only thing you've really changed is the class_mask.  I don't
understand why testing against *more bits* of the class allows your
card to be detected.  Can you explain why the old code fail?

>--- linux-2.4.18-pre7.orig/drivers/scsi/aic7xxx/aic7xxx_linux_pci.c	Tue Jan
> 29 05:20:08 2002
>+++ linux/drivers/scsi/aic7xxx/aic7xxx_linux_pci.c	Tue Jan 29 05:20:08 200
>2
>@@ -62,12 +62,12 @@
> /* We do our own ID filtering.  So, grab all SCSI storage class devices. */
> static struct pci_device_id ahc_linux_pci_id_table[] = {
> 	{
>-		0x9004, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>-		PCI_CLASS_STORAGE_SCSI << 8, 0xFFFF00, 0
>+		PCI_VENDOR_ID_ADAPTEC, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>+		((PCI_CLASS_STORAGE_SCSI << 8) | 0x00), ~0, 0
> 	},
> 	{
>-		0x9005, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>-		PCI_CLASS_STORAGE_SCSI << 8, 0xFFFF00, 0
>+		PCI_VENDOR_ID_ADAPTEC2, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>+		((PCI_CLASS_STORAGE_SCSI << 8) | 0x00), ~0, 0
> 	},
> 	{ 0 }
> };
>
> -Erik

--
Justin
