Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161013AbWHIMEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbWHIMEo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161011AbWHIMEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:04:44 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:706 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161013AbWHIMEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:04:43 -0400
Date: Wed, 9 Aug 2006 08:04:22 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Pavel Machek <pavel@suse.cz>
cc: LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net,
       linux-pm@osdl.org, ncunningham@linuxmail.org
Subject: Re: swsusp and suspend2 like to overheat my laptop
In-Reply-To: <Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0608090751340.2500@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
 <20060808235352.GA4751@elf.ucw.cz> <Pine.LNX.4.58.0608082215090.20396@gandalf.stny.rr.com>
 <20060809073958.GK4886@elf.ucw.cz> <Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Aug 2006, Steven Rostedt wrote:

> >
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
>

Note: I just did a swsusp and resume and here's the same data:

$ grep . /proc/acpi/thermal_zone/THRM/*
/proc/acpi/thermal_zone/THRM/cooling_mode:<setting not supported>
/proc/acpi/thermal_zone/THRM/cooling_mode:cooling mode: passive
/proc/acpi/thermal_zone/THRM/polling_frequency:<polling disabled>
/proc/acpi/thermal_zone/THRM/state:state:                   ok
/proc/acpi/thermal_zone/THRM/temperature:temperature:             60 C
/proc/acpi/thermal_zone/THRM/trip_points:critical (S5):           88 C
/proc/acpi/thermal_zone/THRM/trip_points:passive:                 81 C: tc1=4 tc2=3 tsp=100 devices=0xcf6c2338


And just leaving my system idle for a few minutes:

$ grep . /proc/acpi/thermal_zone/THRM/temperature
temperature:             62 C

and a few more minutes:

temperature:             64 C


And a few more:

temperature:             66 C


right now after typing this:

temperature:             69 C


So this definitely shows somethings not letting the CPU rest.

-- Steve


