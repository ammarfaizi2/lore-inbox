Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311809AbSCNVoK>; Thu, 14 Mar 2002 16:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311820AbSCNVoA>; Thu, 14 Mar 2002 16:44:00 -0500
Received: from squeaker.ratbox.org ([63.216.218.7]:49425 "EHLO
	squeaker.ratbox.org") by vger.kernel.org with ESMTP
	id <S311809AbSCNVns>; Thu, 14 Mar 2002 16:43:48 -0500
Date: Thu, 14 Mar 2002 16:21:55 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: "David S. Miller" <davem@redhat.com>
Cc: beezly@beezly.org.uk, <linux-kernel@vger.kernel.org>
Subject: Re: Sun GEM card looses TX on x86 32bit PCI
In-Reply-To: <Pine.LNX.4.44.0203141542500.17641-100000@simon.ratbox.org>
Message-ID: <Pine.LNX.4.44.0203141621370.17728-100000@simon.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just an FYI, this does resolve the problem on sparc as well.

Regards,

Aaron

On Thu, 14 Mar 2002, Aaron Sethman wrote:

> I am having the same problem on sparc.  I will try the patch myself and
> let you know if it helps.
>
> Regards,
>
> Aaron
>
> On Tue, 12 Mar 2002, David S. Miller wrote:
>
> >    From: Beezly <beezly@beezly.org.uk>
> >    Date: 11 Mar 2002 22:51:42 +0000
> >
> >    Ok, I've been fiddling around with the driver tonight and have managed
> >    to get a little further by forcing the driver to do a full reset of the
> >    chip when the RX buffer over flows. I achieved this by sticking a return
> >    1; at the top of gem_rxmac_reset().
> >
> >    I'm guessing this isn't an "optimal" reset for the situation but so far
> >    it's having /reasonable/ results (i.e. I don't have to bring the
> >    interface up and down every 30 seconds!).
> >  ...
> >    Hope this helps,
> >
> > I'll follow up on this and figure out why my RX reset code
> > isn't working after I finish up some 2.5.x work.
> >
> > But looking quickly I think I see what is wrong.  Please give
> > this a try (and remember to remove your hacks before testing
> > this :-):
> >
> > --- drivers/net/sungem.c.~1~	Mon Mar 11 04:24:13 2002
> > +++ drivers/net/sungem.c	Tue Mar 12 09:30:38 2002
> > @@ -357,6 +357,7 @@ static int gem_rxmac_reset(struct gem *g
> >
> >  		rxd->status_word = cpu_to_le64(RXDCTRL_FRESH(gp));
> >  	}
> > +	gp->rx_new = gp->rx_old = 0;
> >
> >  	/* Now we must reprogram the rest of RX unit. */
> >  	desc_dma = (u64) gp->gblock_dvma;
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>

