Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbWHIL7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbWHIL7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbWHIL7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:59:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25485 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161007AbWHIL7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:59:02 -0400
Date: Wed, 9 Aug 2006 13:58:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net,
       linux-pm@osdl.org, ncunningham@linuxmail.org
Subject: Re: swsusp and suspend2 like to overheat my laptop
Message-ID: <20060809115843.GB3747@elf.ucw.cz>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com> <20060808235352.GA4751@elf.ucw.cz> <Pine.LNX.4.58.0608082215090.20396@gandalf.stny.rr.com> <20060809073958.GK4886@elf.ucw.cz> <Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Okay, can you try to leave it up for a week or two (no suspends, no
> > poweroffs) and see what happens?
> 
> I've had this laptop running for a couple of months without shutting down
> and it doesn't have a problem.  The only time that I do shut it down

Ok.

> > > > P4 has thermal protection, so you are actually safe.
> > >
> > > Yeah, but still, the keyboard gets pretty hot too, and I'm actually more
> > > worried about damaging something that is close by than damaging the CPU
> > > itself.
> >
> > If you damage something, machine was misdesigned in the first place.
> 
> agreed, but you never know ;)  This laptop is currently my lifeline :)

You'd have good reason to get new one.

> > cat we get contents of /proc/acpi/thermal*/*/* ?
> 
> I'm running after a poweroff (left it running over night in the hotel, and
> I'm still in the hotel).
> 
> $ grep . /proc/acpi/thermal_zone/THRM/*
> /proc/acpi/thermal_zone/THRM/cooling_mode:<setting not supported>
> /proc/acpi/thermal_zone/THRM/cooling_mode:cooling mode: passive
> /proc/acpi/thermal_zone/THRM/polling_frequency:<polling disabled>
> /proc/acpi/thermal_zone/THRM/state:state:                   ok
> /proc/acpi/thermal_zone/THRM/temperature:temperature:             48 C
> /proc/acpi/thermal_zone/THRM/trip_points:critical (S5):           88 C
> /proc/acpi/thermal_zone/THRM/trip_points:passive:                 81 C: tc1=4 tc2=3 tsp=100 devices=0xcf6c2338
> 
> Note thermal_zone/THRM was finished with bash tab completion so they are
> the only things that match the above glob expr.

Ok, so it is the bios doing temperature control up-to 81C. At 81C,
linux should start cooling it, and at 88C, linux should shutdown. At
little higher temperature, hardware should emergency shutdown.

> > How s2ram works would be useful info.
> 
> No idea.

Well, try it :-). suspend.sf.net.

> It does look like something isn't setting up the ACPI power properly on
> resume, and that the CPU is probably in a busy loop while the machine is
> idle.  Just a guess.

Fan is not controlled by ACPI. But we may be saving some memory we
should not save, or something like that.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
