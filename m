Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSKKUKm>; Mon, 11 Nov 2002 15:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261223AbSKKUKm>; Mon, 11 Nov 2002 15:10:42 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:39609 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261205AbSKKUKk>; Mon, 11 Nov 2002 15:10:40 -0500
Date: Mon, 11 Nov 2002 18:17:17 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Art Haas <ahaas@airmail.net>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] C99 designated initializers for drivers/ide/pci (2 of 2)
Message-ID: <20021111201717.GH12732@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Art Haas <ahaas@airmail.net>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <20021111155945.GK20969@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021111155945.GK20969@debian>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 11, 2002 at 09:59:45AM -0600, Art Haas escreveu:
> Here's the second patch for drivers/ide/pci that switch the header files
> (and two lines in serverworks.c) to use C99 designated initializers. The
> patches are against 2.5.47.

Art, comments below
 
> --- linux-2.5.47/drivers/ide/pci/opti621.h.old	2002-10-07 15:45:28.000000000 -0500
> +++ linux-2.5.47/drivers/ide/pci/opti621.h	2002-11-11 07:22:07.000000000 -0600
> @@ -11,38 +11,38 @@
>  
>  static ide_pci_device_t opti621_chipsets[] __devinitdata = {
>  	{	/* 0 */
> -		vendor:		PCI_VENDOR_ID_OPTI,
> -		device:		PCI_DEVICE_ID_OPTI_82C621,
> -		name:		"OPTI621",
> -		init_setup:	init_setup_opti621,
> -		init_chipset:	NULL,
> -		init_iops:	NULL,
> -		init_hwif:	init_hwif_opti621,
> -		init_dma:	init_dma_opti621,
> -		channels:	2,
> -		autodma:	AUTODMA,
> -		enablebits:	{{0x45,0x80,0x00}, {0x40,0x08,0x00}},
> -		bootable:	ON_BOARD,
> -		extra:		0,
> +		.vendor		= PCI_VENDOR_ID_OPTI,
> +		.device		= PCI_DEVICE_ID_OPTI_82C621,
> +		.name		= "OPTI621",
> +		.init_setup	= init_setup_opti621,
> +		.init_chipset	= NULL,
> +		.init_iops	= NULL,

Those two lines can be removed

> +		.init_hwif	= init_hwif_opti621,
> +		.init_dma	= init_dma_opti621,
> +		.channels	= 2,
> +		.autodma	= AUTODMA,
> +		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
> +		.bootable	= ON_BOARD,
> +		.extra		= 0,

This one as well

>  	},{	/* 1 */
> -		vendor:		PCI_VENDOR_ID_OPTI,
> -		device:		PCI_DEVICE_ID_OPTI_82C825,
> -		name:		"OPTI621X",
> -		init_setup:	init_setup_opti621,
> -		init_chipset:	NULL,
> -		init_iops:	NULL,
> -		init_hwif:	init_hwif_opti621,
> -                init_dma:	init_dma_opti621,
> -		channels:	2,
> -		autodma:	AUTODMA,
> -		enablebits:	{{0x45,0x80,0x00}, {0x40,0x08,0x00}},
> -		bootable:	ON_BOARD,
> -		extra:		0,
> +		.vendor		= PCI_VENDOR_ID_OPTI,
> +		.device		= PCI_DEVICE_ID_OPTI_82C825,
> +		.name		= "OPTI621X",
> +		.init_setup	= init_setup_opti621,
> +		.init_chipset	= NULL,
> +		.init_iops	= NULL,

Ditto

> +		.init_hwif	= init_hwif_opti621,
> +                .init_dma	= init_dma_opti621,
> +		.channels	= 2,
> +		.autodma	= AUTODMA,
> +		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
> +		.bootable	= ON_BOARD,
> +		.extra		= 0,

Ditto

>  	},{
> -		vendor:		0,
> -		device:		0,
> -		channels:	0,
> -		bootable:	EOL,
> +		.vendor		= 0,
> +		.device		= 0,
> +		.channels	= 0,
> +		.bootable	= EOL,
>  	}

Here a { .bootable = EOL, } would do it, no need for the others

Ditto for the other patches that I just snipped

- Arnaldo
