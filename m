Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbTJDIBs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 04:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbTJDIBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 04:01:48 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:4326 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261940AbTJDIBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 04:01:46 -0400
Date: Sat, 4 Oct 2003 10:01:37 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] input: do not suppress 0 value relative events
Message-ID: <20031004080137.GA3816@ucw.cz>
References: <200310040223.01664.dtor_core@ameritech.net> <20031004073656.GA3756@ucw.cz> <200310040248.27501.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310040248.27501.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 02:48:27AM -0500, Dmitry Torokhov wrote:
> On Saturday 04 October 2003 02:36 am, Vojtech Pavlik wrote:
> > On Sat, Oct 04, 2003 at 02:22:57AM -0500, Dmitry Torokhov wrote:
> > >   Input: input susbsystem should not drop 0 value relative events,
> > >          otherwise unsuspecting programs will loose transitions from
> > >          non-zero to 0 deltas. We should not require userland authors
> > >          to consult with kernel implementation details all the time,
> > >          but follow the principle of least surprise and report
> > >          everything.
> >
> > Certain devices will then generate an endless stream of zero-movement
> > relative events, which is not good.
> >
> > Because 'relative' means that there is no movement when there is no
> > event, where exactly lies the problem? What application has a problem
> > with this? Many mice don't ever report zero values, so that application
> > will probably not work even without the (value==0) check ...
> 
> But the problem is not only repetitive zeros are not reported but also that
> transition from non-zero to zero delta is not reported either.
> 
> OK, since you telling me there are devices which never stop generating 
> events we could go the way absolute events done and suppress repeated data.
> Should I try that? 
> 
> As far as application goes it was my modified version of GPM - pretty much
> every other event is not repeated unless changed so I did not reset the
> internal state and expected get an event telling me the last delta. I am
> OK with data not being repeated but I want to get event for transition
> to 0.

That works for ABSOLUTE events. They're not repeated, and you always
get the value when it changes.

RELATIVE events are very different - if you don't get an event, there
is no movement. If you get one, even repeated, that means there was some
movement and you must process every single (even repeated) event, since
that's what gives the total movement.

Not "repeating" relative data doesn't work, since there is nothing like
"current" value of a relative valuator - if there is any, then it's the
sum of all previous events. Try thinking of relative as of an first
derivative of absolute - and see why you can never get a zero relative
event.

You're trying to treat relative as absolute - why?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
