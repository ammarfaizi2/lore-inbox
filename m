Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSGXDBn>; Tue, 23 Jul 2002 23:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316797AbSGXDBn>; Tue, 23 Jul 2002 23:01:43 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:7689 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316677AbSGXDBm>; Tue, 23 Jul 2002 23:01:42 -0400
Date: Tue, 23 Jul 2002 19:59:43 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Michal Semler <cijoml@volny.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: workaround for buggy BIOSes and i845 chipsets
In-Reply-To: <E17X9n7-0000SV-00@notas>
Message-ID: <Pine.LNX.4.10.10207231958150.29975-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That only clears the buffered kernel records.
2.4.19-rc3-ac2 has the proper and correct fix to deal with XP BIOS HBA
registration.

Cheers,

On Wed, 24 Jul 2002, Michal Semler wrote:

> Hello,
> Vojtech Pavlik helped me to workaround this issue. This patch is backport 
> from 2.5 to 2.4 and is applicable into 2.4.19-rc3. Maybe somebody will need 
> it too. It works correctly on my system.
> 
> Michal
> 
> Patch:
> 
> --- linux/drivers/pci/quirks.c  Sat Jul 20 11:08:15 2002
> +++ linux/drivers/pci/quirks.c  Tue Jul 23 14:51:43 2002
> @@ -471,6 +471,15 @@
>         r -> end = 0xffffff;
>  }
> 
> +static void __init quirk_ide_trash(struct pci_dev *dev)
> +{
> +        int i;
> +        for(i = 0; i < 4; i++)
> +                dev->resource[i].start = dev->resource[i].end = 
> dev->resource[i].flags = 0;
> +}
> +
> +#define PCI_DEVICE_ID_INTEL_82801DB_9   0x24cb
> +
>  /*
>   *  The main table of quirks.
>   */
> @@ -498,6 +507,9 @@
>         { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    
> PCI_DEVICE_ID_INTEL_82443BX_0,  quirk_natoma },
>         { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    
> PCI_DEVICE_ID_INTEL_82443BX_1,  quirk_natoma },
>         { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    
> PCI_DEVICE_ID_INTEL_82443BX_2,  quirk_natoma },
> +       { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    
> PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_trash },
> +        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    
> PCI_DEVICE_ID_INTEL_82801CA_11, quirk_ide_trash },
> +        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    
> PCI_DEVICE_ID_INTEL_82801DB_9,  quirk_ide_trash },
>         { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_SI,       
> PCI_DEVICE_ID_SI_5597, quirk_nopcipci },
>         { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_SI,       PCI_DEVICE_ID_SI_496, 
>  quirk_nopcipci },
>         { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_VIA,      
> PCI_DEVICE_ID_VIA_8363_0,       quirk_vialatency },
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

