Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265687AbUABVsZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 16:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbUABVrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 16:47:53 -0500
Received: from witte.sonytel.be ([80.88.33.193]:57755 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265687AbUABVrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 16:47:49 -0500
Date: Fri, 2 Jan 2004 22:47:45 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Stan Bubrouski <stan@ccs.neu.edu>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 355] Mac ADB IOP fix
In-Reply-To: <1073025537.1597.0.camel@duergar>
Message-ID: <Pine.GSO.4.58.0401022246050.3062@waterleaf.sonytel.be>
References: <200401012001.i01K1uWh031775@callisto.of.borg>
 <1073025537.1597.0.camel@duergar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jan 2004, Stan Bubrouski wrote:
> On Thu, 2004-01-01 at 15:01, Geert Uytterhoeven wrote:
> > Mac ADB IOP: Fix improperly initialized request struct in the reset code,
> > causing a bogus pointer (from Matthias Urlichs)
> >
> > --- linux-2.6.0/drivers/macintosh/adb-iop.c	Thu Jan  2 12:54:27 2003
> > +++ linux-m68k-2.6.0/drivers/macintosh/adb-iop.c	Mon Oct 20 21:45:56 2003
> > @@ -105,18 +105,19 @@
> >  	struct adb_iopmsg *amsg = (struct adb_iopmsg *) msg->message;
> >  	struct adb_request *req;
> >  	uint flags;
> > +#ifdef DEBUG_ADB_IOP
> > +	int i;
> > +#endif
> >
>
> Why not move this down into the ifdef below?  2 extra lines aren't
> needed.

Because you can't mix variable declarations with statements in `old' C.
The alternative is to add curly braces below, but that's more lines too.

> -sb
>
> >  	local_irq_save(flags);
> >
> >  	req = current_req;
> >
> >  #ifdef DEBUG_ADB_IOP
> > -	printk("adb_iop_listen: rcvd packet, %d bytes: %02X %02X",
> > +	printk("adb_iop_listen %p: rcvd packet, %d bytes: %02X %02X", req,
> >  		(uint) amsg->count + 2, (uint) amsg->flags, (uint) amsg->cmd);
> > -	i = 0;
> > -	while (i < amsg->count) {
> > -		printk(" %02X", (uint) amsg->data[i++]);
> > -	}
> > +	for (i = 0; i < amsg->count; i++)
> > +		printk(" %02X", (uint) amsg->data[i]);
> >  	printk("\n");
> >  #endif
> >

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
