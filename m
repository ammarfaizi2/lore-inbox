Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161017AbWHIMJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbWHIMJI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161009AbWHIMJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:09:07 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30358 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161017AbWHIMJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:09:04 -0400
Date: Wed, 9 Aug 2006 14:08:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net,
       linux-pm@osdl.org, ncunningham@linuxmail.org
Subject: Re: swsusp and suspend2 like to overheat my laptop
Message-ID: <20060809120844.GD3747@elf.ucw.cz>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com> <20060808235352.GA4751@elf.ucw.cz> <Pine.LNX.4.58.0608082215090.20396@gandalf.stny.rr.com> <20060809073958.GK4886@elf.ucw.cz> <Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com> <Pine.LNX.4.58.0608090751340.2500@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0608090751340.2500@gandalf.stny.rr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > cat we get contents of /proc/acpi/thermal*/*/* ?
> >
> > I'm running after a poweroff (left it running over night in the hotel, and
> > I'm still in the hotel).
> >
> > $ grep . /proc/acpi/thermal_zone/THRM/*
> > /proc/acpi/thermal_zone/THRM/cooling_mode:<setting not supported>
> > /proc/acpi/thermal_zone/THRM/cooling_mode:cooling mode: passive
> > /proc/acpi/thermal_zone/THRM/polling_frequency:<polling disabled>
> > /proc/acpi/thermal_zone/THRM/state:state:                   ok
> > /proc/acpi/thermal_zone/THRM/temperature:temperature:             48 C
> > /proc/acpi/thermal_zone/THRM/trip_points:critical (S5):           88 C
> > /proc/acpi/thermal_zone/THRM/trip_points:passive:                 81 C: tc1=4 tc2=3 tsp=100 devices=0xcf6c2338
> >
> > Note thermal_zone/THRM was finished with bash tab completion so they are
> > the only things that match the above glob expr.
> >
> 
> Note: I just did a swsusp and resume and here's the same data:
> 
> $ grep . /proc/acpi/thermal_zone/THRM/*
> /proc/acpi/thermal_zone/THRM/cooling_mode:<setting not supported>
> /proc/acpi/thermal_zone/THRM/cooling_mode:cooling mode: passive
> /proc/acpi/thermal_zone/THRM/polling_frequency:<polling disabled>
> /proc/acpi/thermal_zone/THRM/state:state:                   ok
> /proc/acpi/thermal_zone/THRM/temperature:temperature:             60 C
> /proc/acpi/thermal_zone/THRM/trip_points:critical (S5):           88 C
> /proc/acpi/thermal_zone/THRM/trip_points:passive:                 81 C: tc1=4 tc2=3 tsp=100 devices=0xcf6c2338
> 
> 
> And just leaving my system idle for a few minutes:
> 
> $ grep . /proc/acpi/thermal_zone/THRM/temperature
> temperature:             62 C
> 
> and a few more minutes:
> 
> temperature:             64 C
> 
> 
> And a few more:
> 
> temperature:             66 C
> 
> 
> right now after typing this:
> 
> temperature:             69 C
> 
> 
> So this definitely shows somethings not letting the CPU rest.

Okay, run top to see what goes on, and look for
/proc/acpi/processor/*/* -- you are interested in C states before and
after suspend.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
