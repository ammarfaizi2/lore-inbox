Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293544AbSBZIh6>; Tue, 26 Feb 2002 03:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293543AbSBZIht>; Tue, 26 Feb 2002 03:37:49 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:47879
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S293540AbSBZIhd>; Tue, 26 Feb 2002 03:37:33 -0500
Date: Tue, 26 Feb 2002 00:24:44 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Daniel Quinlan <quinlan@transmeta.com>
cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Dave Bogdanoff <bog@transmeta.com>
Subject: Re: [PATCH] Linux Secondary Slave IDE timings
In-Reply-To: <200202260820.AAA03790@sodium.transmeta.com>
Message-ID: <Pine.LNX.4.10.10202260021200.14807-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is a valid and correct fix.
There must have been a bug or something in an odd compiler, but the reason
for the <> | order problem escapes me now.
The verification came from a commumication I had with the author of the
Intel programmer docs.

I hope my comments do not kill the patch.

Regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

On Tue, 26 Feb 2002, Daniel Quinlan wrote:

> This fix is from Dave Bogdanoff <bog@transmeta.com>.
> 
> Linux incorrectly sets up IDE timings for secondary slave drives on PC
> systems that use Intel PIIX Southbridges.
> 
> This will correctly shift IDE slave PCI timings for register 44h so
> that:
> 
>  - secondary slave (drive1) uses bits 4-7
>  - primary slave   (drive1) uses bits 0-3
> 
> (The addition of the parentheses is needed so the shift will take
> place after the bitwise-or.  Without the parentheses, the shift will
> incorrectly always take place before the bitwise-or.)
> 
> --- linux/drivers/ide/piix.c.orig	Tue Jan 29 23:26:55 2002
> +++ linux/drivers/ide/piix.c	Tue Jan 29 23:27:33 2002
> @@ -258,8 +258,8 @@
>  			master_data = master_data | 0x0070;
>  		pci_read_config_byte(HWIF(drive)->pci_dev, slave_port, &slave_data);
>  		slave_data = slave_data & (HWIF(drive)->index ? 0x0f : 0xf0);
> -		slave_data = slave_data | ((timings[pio][0] << 2) | (timings[pio][1]
> -					   << (HWIF(drive)->index ? 4 : 0)));
> +		slave_data = slave_data | (((timings[pio][0] << 2) | timings[pio][1])
> +					   << (HWIF(drive)->index ? 4 : 0));
>  	} else {
>  		master_data = master_data & 0xccf8;
>  		if (pio > 1)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

