Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272244AbTG3U70 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 16:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272247AbTG3U70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 16:59:26 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:31737 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S272244AbTG3U7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 16:59:24 -0400
Date: Wed, 30 Jul 2003 22:59:20 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k wd33c93 locking
In-Reply-To: <20030728084859.GY7452@lug-owl.de>
Message-ID: <Pine.GSO.4.21.0307302258540.29569-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003, Jan-Benedict Glaw wrote:
> On Sat, 2003-07-26 16:51:29 +0200, Geert Uytterhoeven <geert@linux-m68k.org>
> wrote in message <200307261451.h6QEpT9s002280@callisto.of.borg>:
> > M68k wd33c93: host_lock is a pointer to a spinlock, not a spinlock (from Ralf
> > Bächle)
> 
> > --- linux-2.6.x/drivers/scsi/a3000.c	Fri May  9 10:21:34 2003
> > +++ linux-m68k-2.6.x/drivers/scsi/a3000.c	Fri Jun  6 13:33:13 2003
> > @@ -36,9 +36,9 @@
> >  		return IRQ_NONE;
> >  	if (status & ISTR_INTS)
> >  	{
> > -		spin_lock_irqsave(&a3000_host->host_lock, flags);
> > +		spin_lock_irqsave(a3000_host->host_lock, flags);
> >  		wd33c93_intr (a3000_host);
> > -		spin_unlock_irqrestore(&a3000_host->host_lock, flags);
> > +		spin_unlock_irqrestore(a3000_host->host_lock, flags);
> >  		return IRQ_HANDLED;
> >  	}
> >  	printk("Non-serviced A3000 SCSI-interrupt? ISTR = %02x\n", status);
> 
> Is this the fix to A3000 SCSI? Hmmm... I'd give my box another try these
> days:)

If you're `A3000' means `Amiga 3000': yes, probably.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

