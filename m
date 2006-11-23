Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933752AbWKWOLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933752AbWKWOLL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 09:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933753AbWKWOLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 09:11:11 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:51273 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S933752AbWKWOLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 09:11:09 -0500
Date: Thu, 23 Nov 2006 15:11:06 +0100
From: Patrick vd Lageweg <patrick@BitWizard.nl>
To: Willy Tarreau <w@1wt.eu>
Cc: R.E.Wolff@BitWizard.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rio: typo in bitwise AND expression.
Message-ID: <20061123141106.GA19143@abra2.bitwizard.nl>
References: <20061122225856.GB10758@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061122225856.GB10758@1wt.eu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 11:58:56PM +0100, Willy Tarreau wrote:

Seems ok.

Signed-off-by: Patrick vd Lageweg <patrick@BitWizard.nl>

	Patrick

> Hi Rogier,
> 
> here's a patch to fix a typo in rio_linux which affects both
> kernel 2.4 and 2.6. It's not big deal it seems as it only
> affects the irq-less path.
> 
> I found this one like that :
> 
>  $ grep -r '[^&]&[^&]*![^=]' drivers/char/
> 
> I'm sure others will find more efficient rules to catch such
> errors.
> 
> Regards,
> Willy
> 
> From 4fb85842b76ad28893ea2aeaeb6dbc4e3f5a2dee Mon Sep 17 00:00:00 2001
> From: Willy Tarreau <w@1wt.eu>
> Date: Wed, 22 Nov 2006 23:54:48 +0100
> Subject: [PATCH] rio: typo in bitwise AND expression.
> 
> The line :
> 
>     hp->Mode &= !RIO_PCI_INT_ENABLE;
> 
> is obviously wrong as RIO_PCI_INT_ENABLE=0x04 and is used as a bitmask
> 2 lines before. Getting no IRQ would not disable RIO_PCI_INT_ENABLE
> but rather RIO_PCI_BOOT_FROM_RAM which equals 0x01.
> 
> Obvious fix is to change ! for ~.
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  drivers/char/rio/rio_linux.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/char/rio/rio_linux.c b/drivers/char/rio/rio_linux.c
> index 7ac68cb..3228fad 100644
> --- a/drivers/char/rio/rio_linux.c
> +++ b/drivers/char/rio/rio_linux.c
> @@ -1143,7 +1143,7 @@ #endif				/* PCI */
>  				rio_dprintk(RIO_DEBUG_INIT, "Enabling interrupts on rio card.\n");
>  				hp->Mode |= RIO_PCI_INT_ENABLE;
>  			} else
> -				hp->Mode &= !RIO_PCI_INT_ENABLE;
> +				hp->Mode &= ~RIO_PCI_INT_ENABLE;
>  			rio_dprintk(RIO_DEBUG_INIT, "New Mode: %x\n", hp->Mode);
>  			rio_start_card_running(hp);
>  		}
> -- 
> 1.4.2.4
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
