Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVHQALJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVHQALJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 20:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVHQALI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 20:11:08 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:2433 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750761AbVHQALH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 20:11:07 -0400
Date: Wed, 17 Aug 2005 02:10:42 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [RFC - 0/13] NTP cleanup work (v. B5)
In-Reply-To: <1124145973.8630.33.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0508162231460.3728@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.61.0508151212000.3728@scrub.home> <1124145973.8630.33.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 15 Aug 2005, john stultz wrote:

> > I think most of this is premature cleanup. As it also changes the logic in 
> > small ways, I'm not even sure it qualifies as a cleanup.
> 
> Please, Roman, I'm spending quite a bit of time breaking this up into
> small chunks specifically to help this discussion. Rather then just
> stating that the logic is changed in small ways, could you please be
> specific and point to where that logic has changed and we can fix or
> discuss it.

Well, part of the problem is that you didn't really explain, why your 
logical are better in any way. You broke them out of your big patch and 
they lose their context.
It's probably better to first to understand and agree on the functional 
changes, moving code around can still be done afterwards.

> > For the rest I can't agree on to move everything that aggressively into 
> > the ntp namespace. The kernel clock is controlled via NTP, but how it 
> > actually works has little to do with "network time". 
> 
> Eh? The adjtimex() interface causes a small adjustment to be added or
> removed from the system time each tick. Why should this code not be put
> behind a clear interface?

I don't mind the clear interface...

> > Some of the 
> > parameters are even private clock variables (e.g. time adjustment, phase), 
> > which don't belong in any common code. (I'll expand on that in the next 
> > mail.)
> 
> Again, I'm not understanding your objection. Its exactly because the
> time_adjust and phase values are NTP specific variables that I'm trying
> to move them from the timer.c code into ntp.c

The point is you're starting at the wrong point, first we need a clean 
clock interface, only then should we change the ntp code to it.
(More again in the next mail.)

bye, Roman
