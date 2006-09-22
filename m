Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWIVC1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWIVC1y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 22:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWIVC1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 22:27:54 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:14142 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932215AbWIVC1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 22:27:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EeaeGAo+XdfzLGEL//92VA/hHwyxjnRSWzlMHndQbPeorp9QqCj2Jp+wN6hOe1OPGZlb4/dPDCtDadf6ibBunhBS34K5y5pDmwewgucV7PYodEaA9YN+Cz2wX4QtQVjX1sYbokaEXGlo3eRYvmwc/JAtKTrdbkw7bE/TaCG1AqM=
Message-ID: <6d6a94c50609211927rbd2c90k8ba51f7f255b9ea5@mail.gmail.com>
Date: Fri, 22 Sep 2006 10:27:53 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Oleg Verych" <olecom@flower.upol.cz>
Subject: Re: [PATCH 2/4] Blackfin: Serial driver for Blackfin arch on 2.6.18
Cc: linux-kernel@vger.kernel.org, "Luke Yang" <luke.adi@gmail.com>
In-Reply-To: <45134465.8060703@flower.upol.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <489ecd0c0609202033j4dd9a62fye81f99d61bff030d@mail.gmail.com>
	 <45134465.8060703@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/06, Oleg Verych <olecom@flower.upol.cz> wrote:
> Hallo, Luke Yang, who wrote:
> > +static void bfin_serial_mctrl_check(struct bfin_serial_port *uart);
> > +
> > +/*
> > + * interrupts disabled on entry
> > + */
>
> spelling error: _are_ disabled
> please grep && sed all patches
>

Thanks for your comments.
Yeah, the driver is based on an existing driver: sa1100.c, which has
the spelling issue you mentioned too, but I think in the code comment,
It's __OK__.
Anyway, I'll change it and submit a new patch.

> > +static void bfin_serial_stop_tx(struct uart_port *port)
> > +{
> > +    struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
> > +    unsigned short ier;
> > +    ier = UART_GET_IER(uart);
> > +    ier &= ~ETBEI;
> > +    UART_PUT_IER(uart, ier);
> > +#ifdef CONFIG_SERIAL_BFIN_DMA
> > +    disable_dma(uart->tx_dma_channel);
> > +#endif
> > +}
>
> one blank line after local variables; you are using this in some functions, in
> some you are not...

Good suggestion, thanks, I'll fix it.

>
> > +
> > +static void bfin_serial_shutdown(struct uart_port *port)
> > +{
> > +    struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
> > +
>
> yes, one more space will be nicer
>
> > +    free_irq(uart->port.irq+1, uart);
>
> here and the like
>
>
> --
> -o--=O`C
>  #oo'L O  5 years ago TT and WTC7 were assassinated
> <___=E M  learn more how (tm) <http://911research.com>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
