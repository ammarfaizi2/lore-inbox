Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbTL0Spu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 13:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbTL0Spu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 13:45:50 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:48001 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264540AbTL0Sps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 13:45:48 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Tomas Szepe <szepe@pinerecords.com>
Subject: Re: Synaptics problems in -mm1
Date: Sat, 27 Dec 2003 13:45:41 -0500
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, GCS <gcs@lsc.hu>,
       linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>
References: <20031224095921.GA8147@lsc.hu> <200312271323.22252.dtor_core@ameritech.net> <20031227183704.GD10491@louise.pinerecords.com>
In-Reply-To: <20031227183704.GD10491@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312271345.41679.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 December 2003 01:37 pm, Tomas Szepe wrote:
> On Dec-27 2003, Sat, 13:23 -0500
>
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > mice: PS/2 mouse device common for all mice
> > > input: PC Speaker
> > > synaptics reset failed
> > > synaptics reset failed
> > > synaptics reset failed
> >
> > Ok, are you running with cpufreq?
>
> Yes, but
> 	1) I've been on AC all the time.
> 	2) 2.6.0 works.
>

Well, I have a daemon that monitors load and dynamically switches
between high and low frequency... 

> > I think it ACPI PM timer if you have it activated - I am having
> > problems with it myself but didn't have time to look closer.  Could
> > you try booting with clock=tsc or clock=pit and see if it fixes the
> > touchpad.
>
> clock=tsc		appears to fix the problem.
> clock=pit		no change.

Ok, good. So it is the timer funkiness. I would suggest not using ACPI
PM timer for now then. And yes, timer_pit does not have cpufreq hooks
either so it probably not the best timesource with cpufreq either,
so stick with TSC.

Dmitry
