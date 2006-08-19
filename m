Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751682AbWHSJe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbWHSJe1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 05:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbWHSJe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 05:34:27 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:26479 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751666AbWHSJe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 05:34:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oN5qLXXB8+e6SomYryux6PgNOI9nwF75o9oWgOxAzJ8aJhOn2haglpp4UrtKx/4eQ2ChCjoxWxjSTUiETRe1FKL/kncyjFRpDIvsY7cPK2oxjhh80gsTpolEwVdLKzWSCyJaM7SIVQZnXiTCQYFAIMGayaLvjp1sVAEXC3OI4S4=
Message-ID: <acd2a5930608190234y4b4bee8dqfc17d109f86d4318@mail.gmail.com>
Date: Sat, 19 Aug 2006 13:34:26 +0400
From: "Vitaly Wool" <vitalywool@gmail.com>
To: "Vitaly Wool" <vitalywool@gmail.com>, jean-paul.saman@philips.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] UART driver for PNX8550/8950 revised
In-Reply-To: <20060819090427.GB25767@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060819122600.000017e6.vitalywool@gmail.com>
	 <20060819090427.GB25767@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russell,

> serial_pnx8xxx.h just contains structure and register definitions for
> this driver - wouldn't it make more sense for it to be in drivers/serial
> along side this driver?

Well it's used in arch/mips/philips/... so I doubt it's a right thing
to move it to drivers/serial.
I'd rather put it into include/asm-mips/mach-pnx8550 but it's gonna be
shared between this and other similar SoCs (when/if they are submitted
into mainline) so I'm not sure about that either.

> > +
> > +#include <asm/io.h>
> > +#include <asm/irq.h>
> > +
> > +#include <uart.h>
>
> What is uart.h?  It isn't in this patch, neither is it part of mainline.
I guess it's include/asm-mips/arch-pnx8550/uart.h, but it is not
needed and will be removed in the next version :)


> Still not using read_status_mask here, as detailed in my previous review.
>
>                         status &= sport->port.read_status_mask;
>
> is what's missing.

Oh, got it now, thanks.

> > +     /*
> > +      * Disable all interrupts, port and break condition.
> > +      */
> > +     serial_out(sport, PNX8XXX_IEN, 0);
>
> This comment's not correct - where is the break condition disabled?
> I thought it might be in the next serial_out() but it seems to be
> missing from there as well?

I don't think you're right here - break condition is also disabled
unsetting the corresponding bit in  IEN register for this particular
UART.

> > +     if (termios->c_iflag & IGNBRK) {
> > +             sport->port.ignore_status_mask |=
> > +                     ISTAT_TO_SM(PNX8XXX_UART_INT_BREAK);
> > +             /*
> > +              * If we're ignoring parity and break indicators,
> > +              * ignore overruns too (for real raw support).
> > +              */
> > +             if (termios->c_iflag & IGNPAR)
> > +                     sport->port.ignore_status_mask |=
> > +                             ISTAT_TO_SM(PNX8XXX_UART_INT_RXOVRN);
> > +     }
>
> How about CREAD support?

I'll add it to the new version.

Vitaly
