Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267569AbTACQJq>; Fri, 3 Jan 2003 11:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267568AbTACQIP>; Fri, 3 Jan 2003 11:08:15 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:47770 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267567AbTACQIB>;
	Fri, 3 Jan 2003 11:08:01 -0500
Date: Fri, 3 Jan 2003 17:16:17 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Richard Baverstock <beaver@gto.net>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] AGPGART for VIA vt8235, kernel 2.4.21-pre2
Message-ID: <20030103171617.B4502@ucw.cz>
References: <20030102145346.27a21ed9.beaver@gto.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030102145346.27a21ed9.beaver@gto.net>; from beaver@gto.net on Thu, Jan 02, 2003 at 02:53:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 02:53:46PM -0500, Richard Baverstock wrote:
> Here is a patch that enables AGPGART for the VIA vt8235 chipset on P4X400 motherboards. Rather trivial, adds the pci id, then a few lines in the agp sources to get it identified. I've only been able to test this on my computer, where it works.

The vt8235 is the southbridge chip and that the AGP bridge is
located in the northbridge, which most likely has a different number.

> Rich
> 
> 
> --BEGIN--
> 
> diff -ur linux/drivers/char/agp/agp.h linux-2.4.21-pre2/drivers/char/agp/agp.h
> --- linux/drivers/char/agp/agp.h 2003-01-02 14:36:15.000000000 -0500
> +++ linux-2.4.21-pre2/drivers/char/agp/agp.h 2003-01-02 14:35:02.000000000 -0500
> @@ -157,6 +157,9 @@
> 
>  #define PGE_EMPTY(p) (!(p) || (p) == (unsigned long) agp_bridge.scratch_page)
> 
> +#ifndef PCI_DEVICE_ID_VIA_8235_0
> +#define PCI_DEVICE_ID_VIA_8235_0       0x3168
> +#endif
>  #ifndef PCI_DEVICE_ID_VIA_82C691_0
>  #define PCI_DEVICE_ID_VIA_82C691_0      0x0691
>  #endif
> diff -ur linux/drivers/char/agp/agpgart_be.c linux-2.4.21-pre2/drivers/char/agp/agpgart_be.c
> --- linux/drivers/char/agp/agpgart_be.c   2003-01-02 14:36:15.000000000 -0500
> +++ linux-2.4.21-pre2/drivers/char/agp/agpgart_be.c   2003-01-02 14:35:02.000000000 -0500
> @@ -4640,6 +4640,12 @@
>  #endif /* CONFIG_AGP_SIS */
> 
>  #ifdef CONFIG_AGP_VIA
> +  { PCI_DEVICE_ID_VIA_8235_0,
> +     PCI_VENDOR_ID_VIA,
> +     VIA_P4X400,
> +     "Via",
> +     "P4X400",
> +     via_generic_setup },
>    { PCI_DEVICE_ID_VIA_8501_0,
>       PCI_VENDOR_ID_VIA,
>       VIA_MVP4,
> diff -ur linux/drivers/pci/pci.ids linux-2.4.21-pre2/drivers/pci/pci.ids
> --- linux/drivers/pci/pci.ids 2003-01-02 14:36:16.000000000 -0500
> +++ linux-2.4.21-pre2/drivers/pci/pci.ids 2003-01-02 14:35:02.000000000 -0500
> @@ -2751,6 +2751,7 @@
>    3147  VT8233A ISA Bridge
>    3148  P4M266 Host Bridge
>    3156  P/KN266 Host Bridge
> +  3168  VT8235 [P4X400 AGP]
>    3177  VT8233A ISA Bridge
>       1458 5001 GA-7VAX Mainboard
>    3189  VT8377 [KT400 AGP] Host Bridge
> diff -ur linux/include/linux/agp_backend.h linux-2.4.21-pre2/include/linux/agp_backend.h
> --- linux/include/linux/agp_backend.h  2003-01-02 14:36:17.000000000 -0500
> +++ linux-2.4.21-pre2/include/linux/agp_backend.h  2003-01-02 14:35:02.000000000 -0500
> @@ -54,6 +54,7 @@
>    INTEL_I850,
>    INTEL_I860,
>    VIA_GENERIC,
> +  VIA_P4X400,
>    VIA_VP3,
>    VIA_MVP3,
>    VIA_MVP4,
> 
> --END--
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
