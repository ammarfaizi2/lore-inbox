Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbRCEMtT>; Mon, 5 Mar 2001 07:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129232AbRCEMtJ>; Mon, 5 Mar 2001 07:49:09 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:20744 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129227AbRCEMs4>; Mon, 5 Mar 2001 07:48:56 -0500
Date: Mon, 5 Mar 2001 06:48:29 -0600
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Andrey Panin <pazke@orbita.don.sitek.net>
Cc: linux-kernel@vger.kernel.org, tytso@valinux.com
Subject: Re: [PATCH] /drivers/char/serial.c cleanup
Message-ID: <20010305064829.A654@mandrakesoft.mandrakesoft.com>
In-Reply-To: <20010305153704.A20753@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <20010305153704.A20753@debian>; from Andrey Panin on Mon, Mar 05, 2001 at 03:37:04PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2001 at 03:37:04PM +0300, Andrey Panin wrote:
> Attached patch (2.4.2-ac11) makes some changes in serial driver:
> adds ioremap() return code checks, removes panic() calls
> and adds better error handling in start_pci_pnp_board() function.

Did you test it ?

> diff -u /linux.vanilla/drivers/char/serial.c /linux/drivers/char/serial.c
> --- /linux.vanilla/drivers/char/serial.c	Thu Mar  1 20:15:43 2001
> +++ /linux/drivers/char/serial.c	Fri Mar  2 00:10:29 2001
> @@ -3876,7 +3876,10 @@
>  		return 0;
>  	}
>  	req->io_type = SERIAL_IO_MEM;
> -	req->iomem_base = ioremap(port, board->uart_offset);
> +	if ((req->iomem_base = ioremap(port, board->uart_offset))) {
> +		printk(KERN_ERR "serial: Couldn's remap IO memory at %#lx\n", port);
> +		return 1;
> +	}

This seems wrong.  ioremap returns NULL in case of failure.
