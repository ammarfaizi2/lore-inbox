Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAJFIM>; Wed, 10 Jan 2001 00:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131794AbRAJFIC>; Wed, 10 Jan 2001 00:08:02 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:64261
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129431AbRAJFHr>; Wed, 10 Jan 2001 00:07:47 -0500
Date: Tue, 9 Jan 2001 21:07:10 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide-features.c: unchecked kmalloc
In-Reply-To: <20010109160524.B24523@conectiva.com.br>
Message-ID: <Pine.LNX.4.10.10101092106130.22537-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please name a time or event when you would cal a setfeaturers command
without having a IDENTIFY page filled?



On Tue, 9 Jan 2001, Arnaldo Carvalho de Melo wrote:

> Hi,
> 
> 	Please consider applying.
> 
> - Arnaldo
> 
> --- linux-2.4.0-ac4/drivers/ide/ide-features.c	Mon Jan  8 20:39:17 2001
> +++ linux-2.4.0-ac4.acme/drivers/ide/ide-features.c	Tue Jan  9 16:02:11 2001
> @@ -189,6 +189,10 @@
>  	__cli();		/* local CPU only; some systems need this */
>  	SELECT_MASK(HWIF(drive), drive, 0);
>  	id = kmalloc(SECTOR_WORDS*4, GFP_ATOMIC);
> +	if (!id) {
> +		__restore_flags(flags);	/* local CPU only */
> +		return 0;
> +	}
>  	ide_input_data(drive, id, SECTOR_WORDS);
>  	(void) GET_STAT();	/* clear drive IRQ */
>  	ide__sti();		/* local CPU only */
> 

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
