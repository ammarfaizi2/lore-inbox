Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264280AbRFTQt4>; Wed, 20 Jun 2001 12:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264288AbRFTQtq>; Wed, 20 Jun 2001 12:49:46 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:22030 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264280AbRFTQth>; Wed, 20 Jun 2001 12:49:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Pavel Machek <pavel@suse.cz>, Rik van Riel <riel@conectiva.com.br>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: spindown
Date: Wed, 20 Jun 2001 18:52:30 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010615152306.B37@toy.ucw.cz> <20010618222131.A26018@paranoidfreak.co.uk> <20010619124627.A202@bug.ucw.cz>
In-Reply-To: <20010619124627.A202@bug.ucw.cz>
MIME-Version: 1.0
Message-Id: <01062018523007.00439@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 June 2001 12:46, Pavel Machek wrote:
> > > > Roger> It does if you are running on a laptop. Then you do not want
> > > > Roger> the pages go out all the time. Disk has gone too sleep, needs
> > > > Roger> to start to write a few pages, stays idle for a while, goes to
> > > > Roger> sleep, a few more pages, ...
> > > > That could be handled by a metric which says if the disk is spun
> > > > down, wait until there is more memory pressure before writing.  But
> > > > if the disk is spinning, we don't care, you should start writing out
> > > > buffers at some low rate to keep the pressure from rising too
> > > > rapidly.
> > >
> > > Notice that write is not free (in terms of power) even if disk is
> > > spinning.  Seeks (etc) also take some power. And think about
> > > flashcards. It certainly is cheaper tha spinning disk up but still not
> > > free.
> >
> > Isn't this why noflushd exists or is this an evil thing that shouldn't
> > ever be used and will eventually eat my disks for breakfast?
>
> It would eat your flash for breakfast. You know, flash memories have
> no spinning parts, so there's nothing to spin down.

Yes, this doesn't make sense for flash, and in fact, it doesn't make sense to 
have just one set of bdflush parameters for the whole system, it's really a 
property of the individual device.  So the thing to do is for me to go kibitz 
on the io layer rewrite projects and figure out how to set up the 
intelligence per-queue, and have the queues per-device, at which point it's 
trivial to do the write^H^H^H^H^H right thing for each kind of device.

BTW, with nominal 100,000 erases you have to write 10 terabytes to your 100 
meg flash disk before you'll see it start to degrade.  These devices are set 
up to avoid continuous hammering on the same same page, and to take failed 
pages out of the pool as soon as they fail to erase.  Also, the 100,000 
figure is nominal - the average number of erases you'll get per page is 
considerably higher.  The extra few sectors we see with the early flush patch 
are just not going to affect the life of your flash to a measurable degree.

--
Daniel
