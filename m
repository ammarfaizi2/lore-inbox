Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267542AbRGMVI7>; Fri, 13 Jul 2001 17:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267539AbRGMVIv>; Fri, 13 Jul 2001 17:08:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49425 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267548AbRGMVIb>; Fri, 13 Jul 2001 17:08:31 -0400
Date: Fri, 13 Jul 2001 23:07:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Dan Maas <dmaas@dcine.com>, linux-kernel@vger.kernel.org
Subject: Re: VM Requirement Document - v0.0
Message-ID: <20010713230756.G10017@atrey.karlin.mff.cuni.cz>
In-Reply-To: <fa.jprli0v.qlofoc@ifi.uio.no> <002501c104f4/mnt/sendme701a8c0@morph> <20010709121736.B39@toy.ucw.cz> <0107130146540H.00409@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <0107130146540H.00409@starship>; from phillips@bonn-fries.net on Fri, Jul 13, 2001 at 01:46:54AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Possibly stupid suggestion... Maybe the interactive/GUI programs
> > > should wake up once in a while and touch a couple of their pages?
> > > Go too far with this and you'll just get in the way of performance,
> > > but I don't think it would hurt to have processes waking up every
> > > couple of minutes and touching glibc, libqt, libgtk, etc so they
> > > stay hot in memory... A very slow incremental "caress" of the
> > > address space could eliminate the
> > > "I-just-logged-in-this-morning-and-dammit-everything-has-been-paged
> > >-out" problem.
> >
> > Ugh... Ouch.... Ugly, indeed.
> >
> > What you might want to do is
> >
> > while true; do
> > cat /usr/lib/libc* > /dev/null; sleep 1m
> > cat /usr/lib/qt* > /dev/null; sleep 1m
> > ...
> > done
> >
> > running on your system...
> 
> 90%+ of what you touch that way is likely to be outside your working 
> set, and only the libraries get pre-loaded, not the application code or 
> data.  An approach where the application 'touches itself' has more 
> chance of producing a genuine improvement in response, but is that 
> really what we want application programmers spending their time 
> writing?  Not to mention the extra code bloat and maintainance
> overhead.

Application touching itself would be *evil*. 

You might extend my approach if something like

if ps | grep gimp; then cat /usr/bin/gimp > /dev/null; fi

or something like that. It is definitely less evil than gimp doing it
itself.

> Maybe there are a some applications out there - perhaps a database that 
> for some reason needs to minimize its latency - where the effort is 
> worth it, but they're few and far between.  IMHO, only a generic 

User programs should *never ever* do unneeded work. Touching itself is
unneeded and evil for memory managment.

> This is firmly in the flight-of-fancy category.  What would be real and 
> worth doing right now is for some application developers to profile 
> their wonderful creations and find out why they're touching so darn 
> much memory.  Who hasn't seen their system go into a frenzy as the 
> result of bringing up a simple configuration dialog in KDE?  Or 
> right-clicking one of the window buttons in Gnome?  It's uncalled for, 
> a little effort on that front would make the restart latency problem 
> mostly go away.

Agreed.
								Pavel

-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
