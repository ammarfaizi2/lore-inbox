Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWGLH1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWGLH1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 03:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWGLH1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 03:27:54 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:12519 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750784AbWGLH1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 03:27:53 -0400
Message-ID: <44B4A4C7.3040207@manoweb.com>
Date: Wed, 12 Jul 2006 09:29:11 +0200
From: Alessio Sangalli <alesan@manoweb.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Daniel Ritz <daniel.ritz-ml@swissonline.ch>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cardbus: revert IO window limit
References: <200607010003.31324.daniel.ritz-ml@swissonline.ch> <Pine.LNX.4.64.0606301516140.12404@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606301516140.12404@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:98b9443de46bd48dbf34b16449aa5d76
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Alessio has PCI ID 8086:7194, which is not the 82443MX_3, so you'd need 
> something like this instead (but yes, it might indeed be the standard 
> PIIX4 quirks).

Linus, this patch *does not* work, while Daniel's is ok. It's
puzzling... same kernel, just checked out from the git repository.


> ---
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4364d79..0c073b4 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -401,6 +401,7 @@ static void __devinit quirk_piix4_acpi(s
>  	piix4_io_quirk(dev, "PIIX4 devres J", 0x7c, 1 << 20);
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	quirk_piix4_acpi );
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82440MX_0,	quirk_piix4_acpi );
>  
>  /*
>   * ICH4, ICH4-M, ICH5, ICH5-M ACPI: Three IO regions pointed to by longwords at
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 9ae6b1a..889d4da 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2205,6 +2205,7 @@ #define PCI_DEVICE_ID_INTEL_82443LX_1	0x
>  #define PCI_DEVICE_ID_INTEL_82443BX_0	0x7190
>  #define PCI_DEVICE_ID_INTEL_82443BX_1	0x7191
>  #define PCI_DEVICE_ID_INTEL_82443BX_2	0x7192
> +#define PCI_DEVICE_ID_INTEL_82440MX_0	0x7194
>  #define PCI_DEVICE_ID_INTEL_440MX	0x7195
>  #define PCI_DEVICE_ID_INTEL_440MX_6	0x7196
>  #define PCI_DEVICE_ID_INTEL_82443MX_0	0x7198

