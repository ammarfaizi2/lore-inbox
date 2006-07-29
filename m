Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWG2WwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWG2WwH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 18:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWG2WwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 18:52:07 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:24241
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1750739AbWG2WwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 18:52:05 -0400
Date: Sat, 29 Jul 2006 15:51:38 -0700
To: Edgar Toernig <froese@gmx.de>
Cc: Neil Horman <nhorman@tuxdriver.com>, Jim Gettys <jg@laptop.org>,
       "H. Peter Anvin" <hpa@zytor.com>, Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org,
       Keith Packard <keithp@keithp.com>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: itimer again (Re: [PATCH] RTC: Add mmap method to rtc character driver)
Message-ID: <20060729225138.GA22390@gnuppy.monkey.org>
References: <20060725204736.GK4608@hmsreliant.homelinux.net> <1153861094.1230.20.camel@localhost.localdomain> <44C6875F.4090300@zytor.com> <1153862087.1230.38.camel@localhost.localdomain> <44C68AA8.6080702@zytor.com> <1153863542.1230.41.camel@localhost.localdomain> <20060729042820.GA16133@gnuppy.monkey.org> <20060729125427.GA6669@localhost.localdomain> <20060729204107.GA20890@gnuppy.monkey.org> <20060729234948.0768dbf4.froese@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060729234948.0768dbf4.froese@gmx.de>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 11:49:48PM +0200, Edgar Toernig wrote:
> Bill Huey (hui) wrote:
> > Well, this points out a serious problem with doing an mmap extension to
> > /dev/rtc. It would be better to have a page mapped by another device like
> > /dev/jiffy_counter, or something like that rather than to overload the
> > /dev/rtc with that functionality.
> 
> You mean something like this, /dev/itimer?
> 
>     http://marc.theaimsgroup.com/?m=115412412427996

[CCing Steve and Ingo on this thread]

It's a different topic than what Keith needs, but this is useful for another
set of purposes. It's something that's really useful in the RT patch since
there isn't a decent API to get at high resolution timers in userspace. What
you've written is something that I articulated to Steve Rostedt over a dinner
at OLS and is badly needed in the -rt patches IMO. I suggest targeting that
for some kind of inclusion to Ingo Molnar's patchset.

If itimer can be abstracted a bit so it serves more generically as a bidirection
communication pipe, not just to a timer (although it's good for now), but
possibly to bandwidth scheduler policies as a backend, then you have the
possibility of this driver being a real winner. The blocking read can be a
yield to get information on soft overruns for that allocation cycle and the
write can be an intelligent yield for when scheduling wheel wraps around to
soft skip a cycle or something. It'll depend on the semantics of the scheduling
policy.

Your driver can be used, extended, for many things that Linux userspace doesn't
have at this moment for proper RT programming and I suggest that you open up
a discussion with Ingo and friends at about it.

bill

