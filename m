Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262622AbRFQTVs>; Sun, 17 Jun 2001 15:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262660AbRFQTVi>; Sun, 17 Jun 2001 15:21:38 -0400
Received: from hood.tvd.be ([195.162.196.21]:26193 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S262622AbRFQTVX>;
	Sun, 17 Jun 2001 15:21:23 -0400
Date: Sun, 17 Jun 2001 21:18:23 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: David Flynn <Dave@keston.u-net.com>,
        Daniel Phillips <phillips@bonn-fries.net>, rjd@xyzzy.clara.co.uk,
        Bill Pringlemeir <bpringle@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: Newbie idiotic questions.
In-Reply-To: <3B2CD29E.948D6BF2@mandrakesoft.com>
Message-ID: <Pine.LNX.4.05.10106172115110.12465-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jun 2001, Jeff Garzik wrote:
> David Flynn wrote:
> > > Daniel Phillips wrote:
> > > > Yep, the only thing left to resolve is whether Jeff had coffee or not.
> > ;-)
> > > >
> > > > -       if ((card->mpuout = kmalloc(sizeof(struct emu10k1_mpuout),
> > GFP_KERNEL))
> > > > +       if ((card->mpuout = kmalloc(sizeof(*card->mpuout), GFP_KERNEL))
> > >
> > > Yeah, this is fine.  The original posted omitted the '*' which was not
> > > fine :)
> > 
> > The only other thing left to ask, is which is easier to read when glancing
> > through the code, and which is easier to read when maintaining the code.
> > imho, ist the former for reading the code, i dont know about maintaing the
> > code since i dont do that, however in my own projects i prefere the former
> > when maintaing the code.
> 
> It's the preference of the maintainer.  It's a tossup:  using the type
> in the kmalloc makes the type being allocated obvious.  But using
> sizeof(*var) is a tiny bit more resistant to change.
> 
> Neither one sufficiently affects long term maintenance AFAICS, so it's
> personal preference, not any sort of kernel standard one way or the
> other...

The first one can be made a bit safer against changes by creating a `knew'
macro that behaves like `new' in C++:

| #define knew(type, flags)	(type *)kmalloc(sizeof(type), (flags))

If the types in the assignment don't match, gcc will tell you.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

