Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWHIMQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWHIMQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWHIMQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:16:27 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:224 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750703AbWHIMQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:16:27 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp and suspend2 like to overheat my laptop
Date: Wed, 9 Aug 2006 14:15:51 +0200
User-Agent: KMail/1.9.3
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Suspend2-devel@lists.suspend2.net, linux-pm@osdl.org,
       ncunningham@linuxmail.org
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com> <Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com> <20060809115843.GB3747@elf.ucw.cz>
In-Reply-To: <20060809115843.GB3747@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608091415.51226.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 13:58, Pavel Machek wrote:
> Hi!
> 
> > > Okay, can you try to leave it up for a week or two (no suspends, no
> > > poweroffs) and see what happens?
> > 
> > I've had this laptop running for a couple of months without shutting down
> > and it doesn't have a problem.  The only time that I do shut it down
> 
> Ok.
> 
> > > > > P4 has thermal protection, so you are actually safe.
> > > >
> > > > Yeah, but still, the keyboard gets pretty hot too, and I'm actually more
> > > > worried about damaging something that is close by than damaging the CPU
> > > > itself.
> > >
> > > If you damage something, machine was misdesigned in the first place.
> > 
> > agreed, but you never know ;)  This laptop is currently my lifeline :)
> 
> You'd have good reason to get new one.
> 
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
> 
> Ok, so it is the bios doing temperature control up-to 81C. At 81C,
> linux should start cooling it, and at 88C, linux should shutdown. At
> little higher temperature, hardware should emergency shutdown.
> 
> > > How s2ram works would be useful info.
> > 
> > No idea.
> 
> Well, try it :-). suspend.sf.net.
> 
> > It does look like something isn't setting up the ACPI power properly on
> > resume, and that the CPU is probably in a busy loop while the machine is
> > idle.  Just a guess.
> 
> Fan is not controlled by ACPI. But we may be saving some memory we
> should not save, or something like that.

If it's a P4, we rather don't, because the ACPI tables should be above the
last pfn in the normal zone.  Still, Steven please send your dmesg after a
fresh boot.

Rafael
