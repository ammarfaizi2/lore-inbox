Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTL0TCS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 14:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbTL0TCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 14:02:18 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:11180 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264536AbTL0TCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 14:02:17 -0500
Date: Sat, 27 Dec 2003 20:01:38 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, GCS <gcs@lsc.hu>,
       linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>
Subject: Re: Synaptics problems in -mm1
Message-ID: <20031227190138.GE10491@louise.pinerecords.com>
References: <20031224095921.GA8147@lsc.hu> <200312271323.22252.dtor_core@ameritech.net> <20031227183704.GD10491@louise.pinerecords.com> <200312271345.41679.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312271345.41679.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > > mice: PS/2 mouse device common for all mice
> > > > input: PC Speaker
> > > > synaptics reset failed
> > > > synaptics reset failed
> > > > synaptics reset failed
> > >
> > > Ok, are you running with cpufreq?
> >
> > Yes, but
> > 	1) I've been on AC all the time.
> > 	2) 2.6.0 works.
> >
> 
> Well, I have a daemon that monitors load and dynamically switches
> between high and low frequency... 

Sure, I've got one, too, but configured it to always go full throttle
when on AC.

> > > I think it ACPI PM timer if you have it activated - I am having
> > > problems with it myself but didn't have time to look closer.  Could
> > > you try booting with clock=tsc or clock=pit and see if it fixes the
> > > touchpad.
> >
> > clock=tsc		appears to fix the problem.
> > clock=pit		no change.
> 
> Ok, good. So it is the timer funkiness. I would suggest not using ACPI
> PM timer for now then. And yes, timer_pit does not have cpufreq hooks
> either so it probably not the best timesource with cpufreq either,
> so stick with TSC.

Stupid me, I absolutely forgot that I had enabled CONFIG_X86_PM_TIMER
(nonexistent in 2.6.0 stock) which indeed seems to be the culprit.
Please accept my apologies.  -mm1 with that config option unset won't
lose the stick, either.

Thanks!

-- 
Tomas Szepe <szepe@pinerecords.com>
