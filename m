Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267696AbSLSXLu>; Thu, 19 Dec 2002 18:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267697AbSLSXLu>; Thu, 19 Dec 2002 18:11:50 -0500
Received: from packet.digeo.com ([12.110.80.53]:49148 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267696AbSLSXLs>;
	Thu, 19 Dec 2002 18:11:48 -0500
Message-ID: <3E0253D9.94961FB@digeo.com>
Date: Thu, 19 Dec 2002 15:18:49 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
References: <200212200850.32886.conman@kolivas.net> <1040337982.2519.45.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Dec 2002 23:19:44.0433 (UTC) FILETIME=[1D6BFA10:01C2A7B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> ...
> Not too sure what to make of it.  It shows the interactivity estimator
> does indeed help... but only if what you consider "important" is what is
> considered "interactive" by the estimator.  Andrew will say that is too
> often not the case.
> 

That is too often not the case.

I can get the desktop machine working about as comfortably
as 2.4.19 with:

# echo 10 > max_timeslice 
# echo 0 > prio_bonus_ratio 

ie: disabling all the fancy new scheduler features :(

Dropping max_timeslice fixes the enormous stalls which happen
when an interactive process gets incorrectly identified as a
cpu hog.  (OK, that's expected)

But when switching virtual desktops some windows still take a
large fraction of a second to redraw themselves.  Disabling the
interactivity estimator fixes that up too.  (Not OK.  That's bad)

hm.  It's actually quite nice.  I'd be prepared to throw away
a few cycles for this.

I don't expect the interactivity/cpuhog estimator will ever work
properly on the desktop, frankly.  There will always be failure
cases when a sudden swing in load causes it to make the wrong
decision.

So it appears that to stem my stream of complaints we need to
merge scheduler_tunables.patch and edit my /etc/rc.local.
