Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbUCQW4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 17:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUCQW4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 17:56:30 -0500
Received: from root.org ([67.118.192.226]:47113 "HELO root.org")
	by vger.kernel.org with SMTP id S262112AbUCQW41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 17:56:27 -0500
Date: Wed, 17 Mar 2004 14:56:27 -0800 (PST)
From: Nate Lawson <nate@root.org>
To: Dominik Brodowski <linux@dominikbrodowski.de>
cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Peter Chubb <peter@chubb.wattle.id.au>,
       Karol Kozimor <sziwan@hell.org.pl>, john stultz <johnstul@us.ibm.com>,
       acpi-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] X86_PM_TIMER: /proc/cpuinfo doesn't get updated
In-Reply-To: <20040317095314.GB14983@dominikbrodowski.de>
Message-ID: <20040317145312.X3595@root.org>
References: <16471.43776.178128.198317@wombat.chubb.wattle.id.au>
 <200403162340.57546.dtor_core@ameritech.net> <20040317095314.GB14983@dominikbrodowski.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2004, Dominik Brodowski wrote:
> On Tue, Mar 16, 2004 at 11:40:57PM -0500, Dmitry Torokhov wrote:
> > On Tuesday 16 March 2004 08:33 pm, Peter Chubb wrote:
> > > >>>>> "Dmitry" == Dmitry Torokhov <dtor_core@ameritech.net> writes:
> > >
> > > Dmitry> On Tuesday 16 March 2004 07:13 pm, Karol Kozimor wrote:
> > > >> Thus wrote john stultz: > Hmm. This is untested, but I think this
> > > >> should do the trick.
> > > >>
> > > >> Hmm... without the patch, neither cpu MHz nor bogomips are updated,
> > > >> with the patch cpu MHz value seems correct (both using acpi.ko and
> > > >> speedstep-ich.ko, but the bogomips is still at its initial value.
> > > >> Best regards,
> > > >>
> > >
> > > Dmitry> Karol, do you have a P4? AFAIK P4's TSC is stable even if core
> > > Dmitry> frequence changes so loop_per_juffy (== bogomips) need not be
> > > Dmitry> updated.
> > >
> > > The TSC is variable rate for Pentium-IV if you're using clock
> > > modulation.
> > >
> > > Peter C
> > >
> >
> > I understand that by clock modulation you mean throttling as opposed to
> > true SpeedStep... OK, that means that for P4+ we somehow need to figure
> > out whether the CPU is throttled or not to correctly calculate delays.
> > Is there a clean way to get this data?
>
> Hm, will have one patch to test it ready later today -- and a basic patch to
> do this distinction is in the hiding of my notebook's harddisk already...
> who's willing to do some testing on his SpeedStep-capable Pentium 4 - Mobile.

Instead of all this gymnastics, how about:

1. If using Px states, state is unknown until first "set" event.

2. Implement priorities for time source selection and a generic timer API.
This gets around the need to get the clock rate correct to have system
timers work.  On FreeBSD, this is /sys/kern/kern_tc.c

-Nate
