Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWIALtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWIALtQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 07:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWIALtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 07:49:15 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:2259 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1750871AbWIALtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 07:49:15 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: Patch to make VIA sata board bootable again.
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Johnny Strom <johnny.strom@osp.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44F7EC15.8040800@osp.fi>
References: <44F7EC15.8040800@osp.fi>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 12:49:12 +0100
Message-Id: <1157111352.3491.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Can you give me the information of interrupts 
cat /proc/interrupts 

XT_PIC or IO-APIC-edge/level ?


On Fri, 2006-09-01 at 11:15 +0300, Johnny Strom wrote:
> 
> Hello
> 
> The quirks.c update that went into 2.6.16.17 made an VIA machine here 
> non bootable from an sata drive (via_sata), the error is:
> 
> "ATA1 qc timout"
> "Failed to set xfermode".
> 
> And later kernel panic becouse no sata disk was found.
> I tracked it down to the quirk update in 2.6.16.17. Below is a patch 
> against 2.6.17.11 that reverses the uppdate and makse the system 
> bootable again.
> 
> Another option is to find out the PCI_DEVICE_ID_VIA for the motherboard 
> in question but I could not get that info. Dose someone have an idea how 
> to find that info? then I can provide an patch that adds the right 
> PCI_DEVICE_ID_VIA for my motherboard.
> 
> 
> 
> diff -ur linux-2.6.17.11-org/drivers/pci/quirks.c 
> linux-2.6.17.11/drivers/pci/quirks.c
> --- linux-2.6.17.11-org/drivers/pci/quirks.c	2006-09-01 
> 10:38:31.135747500 +0300
> +++ linux-2.6.17.11/drivers/pci/quirks.c	2006-09-01 10:42:28.870605000 +0300
> @@ -652,13 +652,7 @@
>   		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
>   	}
>   }
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, 
> quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, 
> quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, 
> quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, 
> quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, 
> quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, 
> quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, 
> quirk_via_irq);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
> 
>   /*
>    * VIA VT82C598 has its device ID settable and many BIOSes
> 
> 
> 
> Signed-off-by: johnny.strom@osp.fi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

