Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319214AbSHNFqG>; Wed, 14 Aug 2002 01:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319215AbSHNFqG>; Wed, 14 Aug 2002 01:46:06 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:12682 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S319214AbSHNFqF>; Wed, 14 Aug 2002 01:46:05 -0400
Date: Wed, 14 Aug 2002 00:49:45 -0500
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Greg Banks <gnb@alphalink.com.au>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] kernel config 3/N - move sound into drivers/media
Message-ID: <20020814054945.GO761@cadcamlab.org>
References: <20020814043558.GN761@cadcamlab.org> <Pine.LNX.4.44.0208132342560.32010-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208132342560.32010-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [I wrote]
> > Here's another one - this should fix the forward dependency
> > between CONFIG_SOUND and CONFIG_SOUND_ACI_MIXER, by moving the
> > sound config into the "Multimedia" menu - where I think it belongs
> > anyway.

[Kai Germaschewski]
> Hmmh, makes sense to me, but there will probably be people
> complaining "sound config has disappeared for me" ;)

You are probably right.  I still think it's the right thing to do. (:
I do *not* like the recent proliferation of toplevel menu entries.

> Well, I think that's okay, but you should check back with _rmk_.

True.  The trouble with this sort of work is that you *have* to touch
all the architectures, and sometimes change the behavior somewhat.
That can mean stepping on toes now and then.

> What I like about that patch is that it actually removes duplicated
> code.  I think that's exactly where this effort should start. For
> example, the SCSI patch didn't do this, though AFAICS it would be
> nicely possible to unconditionally source drivers/scsi/Config.in and
> then have the if in there.

I thought about that - but didn't want to re-indent the whole file.  I
hate doing that. (:

Also, there's a *reason* every arch has a separate config.in file -
for maximum flexibility without putting lots of ifdefs in common code.
To a certain extent I agree with you and I wish it were possible to
eliminate the arch/*/config.in entirely, but it's not.  ESR tried it
with CML2 and was slapped down by Linus himself, as I recall.

I don't want my humble efforts to end up the same way CML2 did.  For
that reason I'm trying very hard to make only small, incremental,
obvious changes.  Perhaps I'm a bit *too* timid.

> It comes of the cost of testing for the architecture, since
> e.g. s390 does not want to include most of drivers/*, but that means
> we'd actually collect this knowledge at a centralized place.

What we need is an easy way to check for any arch.  CONFIG_ARCH_S390
is the right idea (though s390x sets it as well, not sure if that's
good or bad).  Then again, such checks polluting the common code is
exactly what the current system (with all its cut/paste code in
arch/*/config.in) is supposed to prevent.  Perhaps The Powers That Be
like the status quo.

> Introducing drivers/Config.in could be done nicely piecemeal as
> well, without any change in behavior which is always good. It would
> also provide a possibility to not lose the ARM knowledge.

Hmmmm ... I didn't see any clean way to keep the arm test.  Thinking
about it some more, I suppose one could do

  if [ "$CONFIG_ARM" = "y" ]; then
    if [ ... ]; then
      tristate CONFIG_SOUND
    fi
  else
    tristate CONFIG_SOUND
  fi

It's still not pretty, but should work.  I think I'll put that in
drivers/media/Config.in.

> By the way, if you do these kind of changes, also check Config.help,
> you may be able to remove duplicated entries there as well ;)

I'd been avoiding Config.help - I was afraid if I looked in it I would
find entries I would have to move from one dir to another. (:

> I have no strong opinion either way, but I'd certainly like a
> drivers/Config.in.

Agreed.

> Oh, what I don't like about your patches: You don't include them
> inline, so I cannot easily (R)eply to them and have them quoted ;)

Sorry about that - I agree.  I only attached patches when I had more
than one for a single mail, and then I forgot to switch back.  Must
recompile self with -finline-patches....

Peter
