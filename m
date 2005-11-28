Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbVK1Lmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVK1Lmq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 06:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVK1Lmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 06:42:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:11164 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751254AbVK1Lmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 06:42:45 -0500
Subject: Re: uart_match_port() question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051128113020.GA30298@flint.arm.linux.org.uk>
References: <1133050906.7768.66.camel@gaston>
	 <20051128113020.GA30298@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 22:36:14 +1100
Message-Id: <1133177775.7768.187.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-28 at 11:30 +0000, Russell King wrote:
> On Sun, Nov 27, 2005 at 11:21:46AM +1100, Benjamin Herrenschmidt wrote:
> > Hi Russel, would you accept a patch like that:

My deepest appologies ! :)

> s/l,/l&/
> 
> > Index: linux-work/drivers/serial/serial_core.c
> > ===================================================================
> > --- linux-work.orig/drivers/serial/serial_core.c	2005-11-14 20:32:16.000000000 +1100
> > +++ linux-work/drivers/serial/serial_core.c	2005-11-27 11:13:54.000000000 +1100
> > @@ -2307,7 +2307,8 @@
> >  		return (port1->iobase == port2->iobase) &&
> >  		       (port1->hub6   == port2->hub6);
> >  	case UPIO_MEM:
> > -		return (port1->membase == port2->membase);
> > +		return (port1->membase == port2->membase) ||
> > +			(port1->mapbase && port1->mapbase == port2->mapbase);
> >  	}
> >  	return 0;
> >  }
> 
> I don't think so.  (see below)

Heh, Ok.

> Looking at this deeper, I think we should _only_ use mapbase in this
> case

Totally agreed.

> .  membase is really a indeterminant cookie which bears no real
> relationship to whether two ports are identical - in fact, if we are
> going to compare two of these cookies, I think arch code should be
> involved.
> 
> So how about:
> 
> -             return (port1->membase == port2->membase);
> +             return (port1->mapbase == port2->mapbase);

Yup, indeed. I did it the above way in case you had good reasons of
comparing membase too, but indeed, comparing mapbase only makes the most
sense.

I'll send a proper patch tomorrow.

Ben.

