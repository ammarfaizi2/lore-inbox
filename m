Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266609AbTA1Cmq>; Mon, 27 Jan 2003 21:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267129AbTA1Cmq>; Mon, 27 Jan 2003 21:42:46 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:14859
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S266609AbTA1Cmp>; Mon, 27 Jan 2003 21:42:45 -0500
Date: Mon, 27 Jan 2003 18:46:50 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Ross Biro <rossb@google.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: [2.4.18+] IDE Race Condition
In-Reply-To: <3E356DAA.6090108@google.com>
Message-ID: <Pine.LNX.4.10.10301271846120.9272-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay, how do you reproduce it to see the effects?

On Mon, 27 Jan 2003, Ross Biro wrote:

> The net effect of this race condition and the other one I spotted is 
> that you may see some interesting messages in your log file and you can 
> detect the race condition if you look for it hard enough.  I don't 
> currently see any bad effects.
> 
>     Ross
> 
> Ross Biro wrote:
> 
> >
> > There is at least one more IDE race condition in 2.4.18 and 
> > 2.4.21-pre3. Basically the interrupt for the controller being serviced 
> > is left on while setting up the next command.  I'm not sure how much 
> > trouble it can cause but it does lead to some interesting stack traces.
> >
> > The condition
> > if (masked_irq && hwif->irq != masked_irq)
> > in ide_do_request should be replaced with
> > if (!masked_irq || hwif->irq != masked_irq)
> > in two places.
> >
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

