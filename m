Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWF0Mff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWF0Mff (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWF0Mff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:35:35 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:11488 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932196AbWF0Mff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:35:35 -0400
Date: Tue, 27 Jun 2006 14:35:33 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 1/2] [Suspend2] Disable load updating during suspending.
Message-ID: <20060627123533.GA28033@rhlx01.fht-esslingen.de>
References: <20060626163850.10345.13807.stgit@nigel.suspend2.net> <20060626163852.10345.788.stgit@nigel.suspend2.net> <20060627120740.GA3019@elf.ucw.cz> <200606272216.07960.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606272216.07960.nigel@suspend2.net>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 27, 2006 at 10:16:03PM +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Tuesday 27 June 2006 22:07, Pavel Machek wrote:
> > Hi!
> >
> > > Suspend2 uses the cpu very intensively, with the result that the load
> > > average can be quite high when a cycle has just completed. This in turn
> > > can cause problems with mail delivery and other activities that suspend
> > > activities when the load average gets too high. To avoid this, we suspend
> > > updates of the load average while the freezer is on.
> >
> > If we want to do this at all... why not simply set load average to
> > zero when resume is done?
> >
> > After all, system probably was completely idle for quite a while :-).
> 
> Yeah, that's a possibility. Neither seems inherently better to me. Maybe 
> others will come up with an argument for one or the other?

I don't know, why would *any* of the processes running on this system
be concerned with how much time this system has been suspended, thrown in
the fridge, shipped overseas and back and then finally resumed?
The current load average, OTOH, seems to be much more important than the time
spent sitting idle gathering dust, since those processes are still running
(after resume, that is) and caring about what other processes do and
what they thus should or shouldn't do based on the activity of others.

OK, some processes might do a time-based and not load-average-based
evaluation (thus there would be a change in time behaviour after resume),
but OTOH many processes *continue* their running state so the load average
should reflect a *continued* state, not a very drastic change to zero
(and then sharply climbing back up from zeroed state).

BTW, thanks a lot for this incredible patch activity now, Nigel!
(and thanks to all for such a nice functionality!)

Andreas Mohr
