Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278381AbRK1Re1>; Wed, 28 Nov 2001 12:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278685AbRK1ReS>; Wed, 28 Nov 2001 12:34:18 -0500
Received: from femail37.sdc1.sfba.home.com ([24.254.60.31]:50103 "EHLO
	femail37.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S278381AbRK1ReA>; Wed, 28 Nov 2001 12:34:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Andreas Bombe <bombe@informatik.tu-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Date: Wed, 28 Nov 2001 09:32:52 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <200111270123.BAA02056@mauve.demon.co.uk> <0111261919540W.02001@localhost.localdomain> <20011128003518.A3895@storm.local>
In-Reply-To: <20011128003518.A3895@storm.local>
MIME-Version: 1.0
Message-Id: <01112809325201.00669@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 November 2001 18:35, Andreas Bombe wrote:
> On Mon, Nov 26, 2001 at 07:19:54PM -0500, Rob Landley wrote:
> > Now a journal track that's next to where the head parks could combine the
> > "park" sweep with that one seek, and presumably be spring powered and
> > hence save capacitor power.  But I'm not 100% certain it would be worth
> > it.
>
> When time if of essence it should be worth it (drive makers will use the
> smallest possible capacitor, of course).  Given that current 7200 RPM
> disks have marketed seek times of 8 or 9 ms worst case seeks can be much
> longer.
>
> That 8ms is average and likely read seeks are weighted higher than write

Sure.  The time to seek halfway across the disk, probably.

> seeks.  Writes have to be exact, but reads can be seeked sloppier
> (without waiting for the head to stop oscillating after braking) and
> error correction will take care of the rest.  This would gives us what
> in worst case?  15ms (just a guess)?

I'd been thinking more like 20, but it really depends on the manufacturer.  
(And fun little detail, faster seeks can take MORE power, driving the coil 
thingy harder...)

> A journal track could be near parking track and have directly adjacent
> tracks left free to allow for slightly sloppier/faster seeking.  An
> expert could probably tell us whether this is complete BS or even
> feasible.
>
> > (Are
> > normal with-power-on seeks towards the park area powered by the spring,
> > or the... I keep wanting to say "stepper motor" but I don't think those
> > are what drives use anymore, are they?  Sigh...)
>
> A simple spring is too slow, I guess.  Also, it should not be so hard
> that it would slow down seeks against the spring.

I.E. they've already dealt with this problem in existing designs that use 
some variant of a spring to park, this is Not Our Problem.

No, the "not worth it" above, in addition to the extra logic to unjournal the 
stuff on the next boot (and possibly lose power again during bootup and 
hopefully not wind up with a brick) , is that the platter slows down if you 
don't keep it spinning.  If the spring is seeking slowly, the capacitor has 
to keep the platter spinning longer, which could easily eat the power you're 
trying to avoid seeking with.  Add in the extra complexity and it doesn't 
seem worth it, but that's for the lab guys to decide with measurements...

Oh, and one other fun detail.  One reason I don't like the "battery backed up 
SRAM cache", apart from being another way the disk dies of old age, is that 
it doesn't fix the "we lost power in the middle of writing a sector, so we 
just created a CRC error on the disk" problem, which is what started this 
thread.

If you're going to fix THAT (which you seem to need a capacitor to do 
anyway), then you might as well do it right.

Rob
