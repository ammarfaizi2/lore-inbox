Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317497AbSGJPGj>; Wed, 10 Jul 2002 11:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317519AbSGJPGi>; Wed, 10 Jul 2002 11:06:38 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64247 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317497AbSGJPGh>; Wed, 10 Jul 2002 11:06:37 -0400
Date: Wed, 10 Jul 2002 17:09:03 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
cc: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>,
       "Holzrichter, Bruce" <bruce.holzrichter@monster.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: (RE:  using 2.5.25 with IDE) On sparc64.....
In-Reply-To: <20020710105734.GI3185@suse.de>
Message-ID: <Pine.SOL.4.30.0207101707500.27918-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While at it Jens, 2.4 code has endianness problems (or already fixed?)
would you mind porting my 2.5 patch?

On Wed, 10 Jul 2002, Jens Axboe wrote:

> On Wed, Jul 10 2002, Richard Zidlicky wrote:
> > On Tue, Jul 09, 2002 at 09:46:10AM -0500, Holzrichter, Bruce wrote:
> >
> > > Patch below to get 2.4 forward port of IDE to compile on Sparc64...
> > > --- linus-2.5/include/asm-sparc64/ide.h	Tue Jul  9 08:53:10 2002
> > > +++ sparctest/include/asm-sparc64/ide.h	Tue Jul  9 09:11:24 2002
> >
> >
> > > @@ -178,6 +182,20 @@
> > >  #endif
> > >  }
> > >
> > > +#define ide_request_irq(irq,hand,flg,dev,id)
> > > request_irq((irq),(hand),(flg),(dev),(id))
> > > +#define ide_free_irq(irq,dev_id)		free_irq((irq), (dev_id))
> > > +#define ide_check_region(from,extent)		check_region((from),
> > > (extent))
> > > +#define ide_request_region(from,extent,name)	request_region((from),
> > > (extent), (name))
> > > +#define ide_release_region(from,extent)
> > > release_region((from), (extent))
> > > +
> > > +/*
> > > + * The following are not needed for the non-m68k ports
> > > + */
> > > +#define ide_ack_intr(hwif)		(1)
> > > +#define ide_fix_driveid(id)		do {} while (0)
> >            ^^^^^^^^^^^^^^^
> >
> > the comment is misleading, this is actually needed on more than m68k
> > so not a big surprise it doesn't work. Cut&paste from 2.4.
>
> Bruce,
>
> I checked in your previous patch already. Care to really forward port
> asm-sparc64/ide.h from 2.4.19-pre10-rc2 and send me an incremental
> patch?
>
> --
> Jens Axboe
>

