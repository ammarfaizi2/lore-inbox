Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264061AbRFKKB4>; Mon, 11 Jun 2001 06:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264060AbRFKKBq>; Mon, 11 Jun 2001 06:01:46 -0400
Received: from m606-mp1-cvx1b.col.ntl.com ([213.104.74.94]:46215 "EHLO
	[213.104.74.94]") by vger.kernel.org with ESMTP id <S264058AbRFKKBb>;
	Mon, 11 Jun 2001 06:01:31 -0400
To: Michael Johnson <johnsom@home.com>
Cc: John Fremlin <vii@users.sourceforge.net>, Jens Axboe <axboe@suse.de>,
        <Andries.Brouwer@cwi.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Changes to ide-cd for 2.4.1 are broken?
In-Reply-To: <001801c09e3a$4a189270$653b090a@sulaco>
	<m27l29tj87.fsf@boreas.yi.org.> <m28zj05j7y.fsf@boreas.yi.org.>
	<008401c0f20f$4458dec0$643b090a@sulaco>
From: John Fremlin <vii@users.sourceforge.net>
Date: 11 Jun 2001 11:01:17 +0100
In-Reply-To: <008401c0f20f$4458dec0$643b090a@sulaco> ("Michael Johnson"'s message of "Sun, 10 Jun 2001 17:41:34 -0700")
Message-ID: <m2iti3l4ia.fsf@boreas.yi.org.>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Johnson" <johnsom@home.com> writes:

> So, the patch you are proposing will always consider the tray open, even if
> it is closed.  Why do you need this behavior?
> 
> Why is checking CDS_TRAY_OPEN, to see if the tray is open, broken?

You broke it (I think it was you).

> The code in cdrom.c looks fine to me.

Yes but you changed ide-cd.c to report CDS_NO_DISC if the tray might
be open or there is no disc. I complained about this at the time, you
may recall.

> ----- Original Message -----
> From: "John Fremlin" <vii@users.sourceforge.net>
> To: "Michael Johnson" <johnsom@home.com>
> Cc: "Jens Axboe" <axboe@suse.de>; <Andries.Brouwer@cwi.nl>; "Alan Cox"
> <alan@lxorguk.ukuu.org.uk>; <linux-kernel@vger.kernel.org>
> Sent: Sunday, June 10, 2001 10:37 AM
> Subject: Re: Changes to ide-cd for 2.4.1 are broken?
> 
> 
> >
> > Hi all, this is an old thread. It was started because the return value
> > from cd info was changed in 2.4.1 in the case when the tray might be
> > open or there simply be no disc in the drive for an IDE
> > CD-ROM.
> >
> > John Fremlin <chief@bandits.org> writes:
> >
> > > "Michael Johnson" <johnsom@home.com> writes:
> >
> > [...]
> >
> > > > >Right, old ATAPI has 3a/02 as the only possible condition, so we
> > > > >can't really tell between no disc and tray open. I guess the safest
> > > > >is to just keep the old behaviour for !ascq and report open.
> > >
> > > > I don't understand why the current(2.4.1) behavior is a problem...
> >
> > Unfortunately changing the return code means that the generic cdrom.c
> > code is broekn, in particular wrt to having the cdrom drive open
> > automatically when umounted, and to close when attempted to be
> > mounted.
> >
> > (You can set this mode with "cdd auto" if you have my asm-toys installed
> >         http://ape.n3.net/programs/linux/asm-toys
> > )
> >
> > The following patch fixes that. I also attempted to fix up similar
> > problems (where checking CDS_TRAY_OPEN is used to see if the tray is
> > open, which is obviously broekn).
> >
> >
> 
> 
> ----------------------------------------------------------------------------
> ----
> 
> 
> >
> > --
> >
> > http://ape.n3.net
> >
> 

-- 

	http://ape.n3.net
