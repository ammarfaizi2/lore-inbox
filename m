Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267439AbSLLI0T>; Thu, 12 Dec 2002 03:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267440AbSLLI0T>; Thu, 12 Dec 2002 03:26:19 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:57353
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267439AbSLLI0R>; Thu, 12 Dec 2002 03:26:17 -0500
Date: Thu, 12 Dec 2002 00:33:01 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Ted Kaminski <mouschi@wi.rr.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>
Subject: Re: pnp/IDE question- help fixing up a patch
In-Reply-To: <007e01c2a19b$934e9a00$6400a8c0@win01>
Message-ID: <Pine.LNX.4.10.10212120025570.7114-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ted,

Somebody asked me to poke my nose in here, so here goes.

The difference in the two locations has to do with early initalization.
One the issues of concern in the patch, is the usage of "passive".
A stronger position for setup would have a hwif->intq_mode operator.
Regardless if it is a bit field or not.

This would force ide-probe to initialize the hwif_intr properly.
Next the mask of the field would provide a method for poking the
drive_is_ready().

This would remove several issue.

One the config option for share or not interrupts goes away.

The list is short and obvious.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Wed, 11 Dec 2002, Ted Kaminski wrote:

> Hello all,
> 
> I've got an ide, and an idepnp question... (for 2.4)
> 
> I'm working on refining a patch sent previously
> (http://groups.google.com/groups?selm=20021108061020.A14168%40localhost) to
> be less intrusive. I'll be refering to things done in that patch...
> 
> The short of it is, this sb16 pnpide interface apparently cannot use
> ALTSTATUS at a certain point. (I'm no ide whiz, I'm just simplifying the
> code that David Meybohm wrote, so maybe I'm off a bit) at any rate, this
> seems to require a new flag be listed along with the hardware information.
> 
> His solution was to add
> + int  no_passive;  /* no passive status tests */
> to hw_reg_s in ide.h and check that flag in drive_is_ready()
> 
> I *think* it's out of place. It seems to me it'd be more appropriate to add
> + unsigned no_passive : 1;   /* no passive status tests */
> to hwif_s in ide.h.  Right next to a few other bitfields
> 
> Which is better? or is there a different, even better spot?
> 
> As for the idepnp part, he added a "dev = NULL" into the loop, and was
> unsure of whether or not this was a good idea.  I have the same question.
> Or perhaps this smells of a seperate patch?
> 
> I'd rather ask these question in the form of my own patch, but... I'm a bit
> short on time, atm. sorry.
> 
> Thanks in advace,
> -Ted
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

