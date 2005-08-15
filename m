Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbVHOWqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbVHOWqS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbVHOWqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:46:18 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:983 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965029AbVHOWqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:46:17 -0400
Subject: Re: [RFC - 0/13] NTP cleanup work (v. B5)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <Pine.LNX.4.61.0508151212000.3728@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508151212000.3728@scrub.home>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 15:46:13 -0700
Message-Id: <1124145973.8630.33.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-16 at 00:12 +0200, Roman Zippel wrote:
> On Wed, 10 Aug 2005, john stultz wrote:
> 
> > 	The goal of this patch set is to isolate the in kernel NTP state
> > machine in the hope of simplifying the current timekeeping code and
> > allowing for optional future changes in the timekeeping subsystem.
> > 
> > I've tried to address some of the complexity concerns for systems that
> > do not have a continuous timesource, preserving the existing behavior
> > while still providing a ppm interface allowing smooth adjustments to
> > continuous timesources. 
> 
> I think most of this is premature cleanup. As it also changes the logic in 
> small ways, I'm not even sure it qualifies as a cleanup.

Please, Roman, I'm spending quite a bit of time breaking this up into
small chunks specifically to help this discussion. Rather then just
stating that the logic is changed in small ways, could you please be
specific and point to where that logic has changed and we can fix or
discuss it.

> The only obvious patch is the PPS code removal, which is fine.

Ok, one down, 12 to go ;)

> For the rest I can't agree on to move everything that aggressively into 
> the ntp namespace. The kernel clock is controlled via NTP, but how it 
> actually works has little to do with "network time". 

Eh? The adjtimex() interface causes a small adjustment to be added or
removed from the system time each tick. Why should this code not be put
behind a clear interface?

> Some of the 
> parameters are even private clock variables (e.g. time adjustment, phase), 
> which don't belong in any common code. (I'll expand on that in the next 
> mail.)

Again, I'm not understanding your objection. Its exactly because the
time_adjust and phase values are NTP specific variables that I'm trying
to move them from the timer.c code into ntp.c

I'm trying to address your concerns, I just need you to be more
explicit.

thanks
-john

