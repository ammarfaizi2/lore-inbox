Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285986AbRLTDid>; Wed, 19 Dec 2001 22:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285992AbRLTDiO>; Wed, 19 Dec 2001 22:38:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39692 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285986AbRLTDiF>; Wed, 19 Dec 2001 22:38:05 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] PCI updates - 32-bit IO support
Date: 19 Dec 2001 19:37:46 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9vrmea$mef$1@cesium.transmeta.com>
In-Reply-To: <20011218235024.N13126@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011218235024.N13126@flint.arm.linux.org.uk>
By author:    Russell King <rmk@flint.arm.linux.org.uk>
In newsgroup: linux.dev.kernel
>
> I have here a system which requires 32-bit IO addressing on its PCI
> busses.  Currently, Linux zeros the upper IO base/limit registers on
> all PCI bridges, which prevents addresses being forwarded on this
> system.
> 
> The following patch the upper IO base/limit registers to be set
> appropriately by the PCI layer.
> 
> This patch is being sent for review, and is targetted solely at 2.5.
> 
> diff -ur orig/drivers/pci/setup-bus.c linux/drivers/pci/setup-bus.c
> --- orig/drivers/pci/setup-bus.c	Sun Oct 14 20:53:14 2001
> +++ linux/drivers/pci/setup-bus.c	Tue Dec 18 23:20:13 2001
> @@ -148,7 +181,10 @@
>  	pci_write_config_dword(bridge, PCI_IO_BASE, l);
>  
>  	/* Clear upper 16 bits of I/O base/limit. */
> -	pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, 0);
> +	pci_write_config_word(bridge, PCI_IO_BASE_UPPER16,
> +			ranges.io_start >> 16);
> +	pci_write_config_word(bridge, PCI_IO_LIMIT_UPPER16,
> +			ranges.io_end >> 16);
>  

You probably need to verify that 32-bit support is available (both on
the bridge and the peripherals), but if they are, there's no reason
not to use it on non-x86 architectures...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
